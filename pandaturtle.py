
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
    lstIndex = list(range(6))
    lstPosition = [0.0, 1.1, 2.3, 2.9, 3.1, 3.4] 
    lstTorque = [1.0, 2.3, 4.5, 4.2, 4.0, 3.9]

    df = pandas.DataFrame( {'Index': lstIndex, 'position': lstPosition, 'torque': lstTorque})

    return df
