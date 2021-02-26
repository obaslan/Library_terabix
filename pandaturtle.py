
import turtledb

import pandas

class PandaTurtle(turtledb.TurtleDb):
    def __init__(self, strServer=turtledb.DEFAULT_SERVER, nPort=turtledb.DEFAULT_PORT):         
        turtledb.TurtleDb.__init__(self, strServer, nPort)

        self._dataset = PandaCursorDataset

    def insertDataFrame(self, nHistoryId, dfData, strGroupName=None):
        lstHeader = list(dfData.columns)
        lstMeasUnitPairs = self._parseHeader(lstHeader)

        nCount = len(lstHeader)

        for i in range(nCount):
            strMeasName, strMeasUnits = lstMeasUnitPairs[i] 

            r = self.insertArray(nHistoryId, strMeasName, strMeasUnits, dfData[lstHeader[i]], strMeasGroup=strGroupName)

        return r

    def getArrayGroup(self, nHistoryId, strGroupName):
        ds = super().getArrayGroup(nHistoryId, strGroupName)

        # translate it to a PandaCursorDataset
        return PandaCursorDataset(None, header=ds._header, data=ds._data)

    def getNewTestRecord(self):
        return PandaTestRecord(self)

    def getRichFilteredHistory(self, strDutLabel, strTestName=None, strTestVersion=None, strTestCondition=None):
        ds = self.getFilteredHistory(strDutLabel, strTestName, strTestVersion, strTestCondition)

        lstRows = ds.toDictList()
        # for each row, go through and do more querying to get all of the scalar metrics and arrays.

        for dctRow in lstRows:
            nHistoryId = dctRow['id']
            # query scalars
            lstScalarMetrics = self.getScalarMetrics(nHistoryId).toDictList()
            dctRow['scalar_metrics'] = lstScalarMetrics


            # now the arrays that do not belong in a data frame (single column data frames)
            lstNoGroupArrays = []
            lstArrayGroupNames = []
            lstArrays = self.getArrays(nHistoryId).toDictList()
            dctRow['arrays'] = {}
            for dctArray in lstArrays:
                if dctArray['group_name'] is None:
                    # I need to grab the data for this array
                    # getArrayData?
                    nArrayId = dctArray['id']
                    strArrayName = "%s (%s)" % (dctArray['name'], dctArray['units'])
                    dctRow['arrays'][strArrayName] = self.getArrayData(nArrayId).getCol('val')
                    dsArrayData = self.getArrayData(nArrayId)
                else:
                    if dctArray['group_name'] not in lstArrayGroupNames:
                        lstArrayGroupNames.append(dctArray['group_name'])

            # now the array groups
            lstDataFrames = []
            for strArrayGroupName in lstArrayGroupNames:
                ds = self.getArrayGroup(nHistoryId, strArrayGroupName)
                lstDataFrames.append({strArrayGroupName : ds.toDataFrame()})

            dctRow["data_frames"] = lstDataFrames
            
        return lstRows

class PandaCursorDataset(turtledb.CursorDataset):
    def __init__(self, cursor=None, header=None, data=None):
        
        if cursor is not None:
            turtledb.CursorDataset.__init__(self, cursor)
        else:
            self._cursor = None
            if (header is None) or (data is None):
                raise Exception("if cursor arg is None, you must supply both header and data")
            # populate from header/data
            self._header = header[:]
            self._data = data[:]

        self._nRowCount = len(self._data)

        self._nColCount = len(self._header)
    
    def close(self):
        if self._cursor is not None:
            self._cursor.close()

    def toDataFrame(self, blnPrettyHeaders=False):
        lstHeader = self.header()
        if blnPrettyHeaders:
            lstHeader = [self.prettyHeader(x) for x in self.header() ]

        dct = {}
        for strCol in lstHeader:
            dct[strCol] = self.getColumn(strCol)
        return pandas.DataFrame(dct)

class PandaTestRecord(turtledb.TestRecord):
    def __init__(self, db, **args):
        turtledb.TestRecord.__init__(self, db, **args)

    def insertDataFrame(self, df, strGroupName=None):
        self._checkCreated()
        self._db.insertDataFrame(self._nHistoryId, df, strGroupName)

def test():
    pt = PandaTurtle()

    lstRows = pt.getRichFilteredHistory('TR2000-04 TR0012', 'ArmFrictionTest', '2.3.8', 'Temperature=25C')
    return lstRows
