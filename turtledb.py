
import os
import sys
import types
import re

PYTHON2 = (2 == sys.version_info.major)
PYTHON3 = (3 == sys.version_info.major)
WINDOWS = ('nt' == os.name)

if PYTHON2:
    from exceptions import Exception, ValueError, TypeError

import getpass
# for the addSampleData method
import random

# to render data sets
import xml.dom.minidom
import json

import csv

if PYTHON2:
    import MySQLdb as mysql
    """
    There is also the mysql python/connector here:
    http://dev.mysql.com/doc/connector-python/en/connector-python-example-connecting.html 
    """
    import StringIO

elif PYTHON3:
    import pymysql as mysql
    import io



DEFAULT_SERVER = "localhost"
if WINDOWS:
    DEFAULT_PORT = 3306
else:
    DEFAULT_PORT = 3307

DEFAULT_SCHEMA = "turtle"

class TurtleDb:
    TABLES = [ 
        "array_data", 
        "array_meas",
        "test_history",
        "station_properties",
        "station",
        "dut_properties",
        "dut",
        "part_properties", 
        "product_properties", 
        "part_number",
        "product",
        "test_node_children",
        "test_suite",
        "test_node",
        "measurement", 
        "operator"
        ]
    def __init__(self, strServer=DEFAULT_SERVER, nPort=DEFAULT_PORT, strSchema=DEFAULT_SCHEMA):
        self.__strServer = strServer
        self.__nPort = nPort
        self.__strSchema = strSchema

        self.__strUser = None
        self.__strPassword = None

        self.__connection = None

        self.__blnPrintSQL = False

        self.__measRegex = None

        # use this class when returning data sets
        self._dataset = CursorDataset

    def close(self):
        if self.__connection is None:
            return 

        self.__connection.close()

        self.__connection = None

    def connection(self):
        if self.__connection is None:
            self.__connection = self.connect()

        return self.__connection

    def server(self, strServer=None):
        if strServer is None:
            return self.__strServer
        else:
            self.__strServer = strServer

    def port( self, nPort=None ):
        if nPort is None:
            return self.__nPort
        else:
            self.__nPort = nPort

    def _getInput(self, strPrompt):
        if PYTHON2:
            return raw_input(strPrompt)
        else:
            return input(strPrompt)


    def _getCred(self):
        # prompt the operator for username/password
        strUser = self._getInput( "Please enter user name: " )
        strPassword = getpass.getpass( "please enter password for %s: " % strUser )

        self.__strUser = strUser
        self.__strPassword = strPassword

    def connect(self):
        # check to see if we need to get the credentials from the user

        if None in [ self.__strUser, self.__strPassword ]:
            # ask for the credentials
            self._getCred()

        if PYTHON2:
            cn = mysql.connect(host=self.__strServer, port=self.__nPort, \
                db=self.__strSchema, user=self.__strUser, passwd=self.__strPassword)

        else:
            if WINDOWS:
                cn = mysql.connect(host=self.__strServer, port=self.__nPort, \
                    db=self.__strSchema, user=self.__strUser, passwd=self.__strPassword)

            else:
                cn = mysql.connect(host=self.__strServer, port=self.__nPort, \
                    db=self.__strSchema, user=self.__strUser, passwd=self.__strPassword, \
                    unix_socket='/var/run/mysqld/mysqld.sock')
            
        cn.autocommit(1)

        return cn

    def printSQL(self, blnPrint):
        self.__blnPrintSQL = blnPrint

    def _execStoredProc( self, strProcName, *args ):
        # generate the sql statement.
        # other databases microsoft T-SQL will have a slightly diffent syntax.
        # so I want to isolate the differences here so that I can easily 
        # deal with them later

        strPrefix = "call" 
        lstArgs = []

        for arg in args:
            if isinstance(arg, str):
                strArg = "'%s'" % arg

            elif isinstance(arg, float) or isinstance(arg, int) or isLong(arg) or isUnicode(arg):
                strArg = str(arg)
            elif arg is None:
                strArg = "NULL"

            else:
                raise TypeError("UNHANDLED ARG TYPE: %s" % str(type(arg)))
                        

            lstArgs.append( strArg )

        strSql = "%s %s(%s);" % ( strPrefix, strProcName, ", ".join( lstArgs ) )
        if self.__blnPrintSQL:
            print(strSql)

        # now execute the SQL statement and return the cursor
        return self.queryCursor( strSql )


    def setCredentials(self, strUser, strPassword):
        self.__strUser = strUser
        self.__strPassword = strPassword

    def query( self ):
        pass

    def readMaxPacketSize(self):
        return int(self._readVar("max_allowed_packet"))

    def _readVar(self, strVarName):
        strSql = "SHOW VARIABLES LIKE '%s';" % strVarName

        cursor = self.queryCursor(strSql)

        rows = cursor.fetchall()

        # one row, should look like this:
        # (('max_allowed_packet', '16777216'),)
        return rows[0][1]

    def queryCursor(self, strSql):
        return self._queryCursor(strSql)

    def _queryCursor( self, strSql ):
        # get a cursor
        cn = self.connection()

        # the ping should reconnect if the connection has
        # timed out.
        cn.ping()
        cursor = cn.cursor()

        nResult = cursor.execute( strSql )

        return cursor

    def deleteDut(self, strPartNumber, strSerialNumber):
        return self._checkResult(self._execStoredProc("deleteDut", strPartNumber, strSerialNumber))

    def deleteAll(self):
        # delete from these tables...


        for strTable in self.TABLES:
            strCmd = "DELETE FROM %s;" % strTable
            c = self.queryCursor( strCmd )
            c.close()

    def configAutoGenMeasurement(self, autoGen=True):
        return self._checkResult(self._execStoredProc("insertConfigInt", "AUTOGEN_MEASUREMENT", 1))

    ##
    # @brief truncate ALL tables in the list
    #
    # NOTE: this is NOT working because you apparently 
    #   cannot truncate tables w/ foreign key 
    #   relationships
    def truncateAll(self):
        # first kill the product properties

        for strTable in self.TABLES:
            strCmd =  "TRUNCATE %s;" % strTable 
            c = self.queryCursor( strCmd )
            c.close()

    def _checkResult( self, cursor ):
        nSuccess, strMsg = cursor.fetchone()

        cursor.close()

        if nSuccess >= 0:
            return nSuccess

        else:
            raise Exception( 
                "OPERATION FAILED.  RESULT CODE %d, MESSAGE %s" % \
                (nSuccess, strMsg ) )

    ### STORED PROCEDURE API ###

    # PART NUMBERS/PRODUCTS #
    def getPartNumbers( self, strProduct=None ):
        return self._dataset( self._execStoredProc( "getPartNumbers", strProduct ) )

    def getProducts(self):
        ds = self._dataset( self._execStoredProc( "getProducts" ) )
        # this is only a single column, turn this into a list
        return ds.getCol(0)

    def getProductProperties(self, strProduct):
        return self._dataset(
            self._execStoredProc( "getProductProperties", strProduct ) )
    
    def getProductProperty(self, strProduct, strProperty):
        return self._dataset(
            self._execStoredProc(
                "getProductProperty", strProduct, strProperty )
                )

    def getPartProperties(self, strPartNumber):
        return self._dataset(
            self._execStoredProc( "getPartProperties", strPartNumber ) )

    def getPartProperty(self, strPartNumber, strProperty):
        return self._dataset(
            self._execStoredProc(
                "getPartProperty", strPartNumber, strProperty )
                )

    def insertProduct(self, strProduct):
        cursor = self._execStoredProc("insertProduct", strProduct)

        # expect a scalar result
        return self._checkResult(cursor)

    def insertPartNumber( self, strPartNumber, strProduct ):
        cursor = self._execStoredProc( "insertPartNumber", strPartNumber, strProduct )

        # expect a scalar result
        return self._checkResult(cursor)

    
    def insertProductProperty(self, strProduct, strPropName, propVal):
        cursor = self._execStoredProc(\
            "insertProductProperty", \
            strProduct, 
            strPropName, 
            str(propVal) )

        # expect a scalar result
        return self._checkResult(cursor)

    def insertPartProperty(self, strPartNumber, strPropName, propVal):
        cursor = self._execStoredProc(\
            "insertPartProperty", \
            strPartNumber, 
            strPropName, 
            str(propVal) )

        # expect a scalar result
        return self._checkResult(cursor)

        
    # OPERATORS #
    def insertOperator(self, strLogin, strFirstName, strLastName):
        cursor = self._execStoredProc("insertOperator", strLogin, \
            strFirstName, strLastName)

        # expect a scalar result
        return self._checkResult(cursor)

    # DUTS #
    def insertDut(self, strPartNumber, strSerialNumber ):
        cursor = self._execStoredProc("insertDut", strPartNumber, strSerialNumber )

        # expect a scalar result
        return self._checkResult(cursor)
    
    def getDuts(self, strPartNumber=None):
        return self._dataset(self._execStoredProc("getDuts", strPartNumber))

    def getDutLabels(self, strPartNumber=None):
        return self._dataset(self._execStoredProc("getDutLabels", strPartNumber))

    def insertDutProperty(self, strPartNumber, strSerialNumber, strPropName, strPropVal):
        cursor = self._execStoredProc("insertDutProperty", \
            strPartNumber, strSerialNumber, strPropName, strPropVal)

        # expect a scalar result
        return self._checkResult(cursor)

    def getDutProperties(self, strPartNumber, strSerialNumber):
        return self._dataset(self._execStoredProc("getDutProperties", \
            strPartNumber, strSerialNumber))

    ##
    # This is intended to fix a history record that had the wrong dut recorded.
    # Give it the history id w/ the bad dut and the correct part number/serial number
    # and the test history record will be updated/corrected.
    # returns the new dut id
    def fixHistoryDut(self, nHistoryId, strPartNumber, strSerialNumber):
        cursor = self._execStoredProc("fixHistoryDut", nHistoryId, strPartNumber, strSerialNumber)
        # expect a scalar result
        return self._checkResult(cursor)

    # STATIONS #
    def insertStation(self, strStationName):
        cursor = self._execStoredProc( "insertStation", strStationName )

        # expect a scalar result
        return self._checkResult(cursor)
    
    def getStations(self):
        return self._dataset( self._execStoredProc("getStations") )

    def insertStationProperty(self, strStation, strPropName, strPropVal):
        cursor = self._execStoredProc("insertStationProperty", \
            strStation, strPropName, strPropVal)

        # expect a scalar result
        return self._checkResult(cursor)

    def getStationProperties(self, strStation):
        return self._dataset(self._execStoredProc("getStationProperties", strStation))

    # TEST NODES #
    def insertTestNode(self, strName, strVersion):
        cursor = self._execStoredProc("insertTestNode", strName, strVersion)

        # expect a scalar result
        return self._checkResult(cursor)

    def getTestNodes(self):
        return self._dataset(self._execStoredProc("getTestNodes"))

    def insertTestCondition(self, nHistoryId, strName, strValue):
        cursor = self._execStoredProc("insertTestCondition", nHistoryId, strName, strValue)

        # expect a scalar result
        return self._checkResult(cursor)

    def getTestConditions(self, nHistoryId):
        return self._dataset( self._execStoredProc("getTestConditions", nHistoryId) )

    def getTestCondition(self, nHistoryId, strConditionName):
        return self._dataset( self._execStoredProc("getTestCondition", nHistoryId, strConditionName) ).row(0)[0]

    # MEASUREMENTS #
    def insertMeasurement(self, strName, strUnits):
        # check the inputs
        # expect both to be strings.
        if not (isString(strName) and isString(strUnits)):
            raise TypeError( "EXPECTED STRING FOR NAME AND UNITS" )

        cursor = self._execStoredProc("insertMeasurement", strName, strUnits)

        # expect a scalar result
        return self._checkResult(cursor)

    def getMeasurements(self):
        return self._dataset( self._execStoredProc("getMeasurements") )


    def getArrayData(self, nArrayId):
        return self._dataset(self._execStoredProc("getArrayData", nArrayId))

    def getArrays(self, nHistoryId, strGroupName = None):
        return self._dataset( self._execStoredProc("getArrays", nHistoryId, strGroupName) )

    ##
    # get a python list of all array group names
    def getArrayGroupNames(self, nHistoryId):
        ds = self._dataset(self._execStoredProc("getArrayGroupNames", nHistoryId))
        return ds.getCol(0)

    def getArrayGroup(self, nHistoryId, strGroupName):
        # get all of the arrays of this group
        meas = self.getArrays(nHistoryId, strGroupName)

        # now many arrays do I have?
        nArrayCount = meas.rowCount()

        if 0 == nArrayCount:
            return

        lstHeader = []
        # for each array, figure out the header entry
        for nArrayIdx in range(meas.rowCount()):
            lstHeader.append( "%s (%s)" % (meas.getVal(nArrayIdx, "name"), meas.getVal(nArrayIdx, "units")) )

        lstArrays = []

        for nArrayIdx in range(meas.rowCount()):
            lstArrays.append(self.getArrayData( meas.getVal(nArrayIdx, "id") ))

            if 0 == nArrayIdx:
                nArrayLength = lstArrays[-1].rowCount()

            else:
                if nArrayLength != lstArrays[-1].rowCount():
                    # raise an exception
                    raise Exception("DIFFERING ARRAY LENGTHS!")


        # all of the array lengths match.  build out my data set.
        lstDataSet = []
        for nRowIdx in range(nArrayLength):
            lstRow = []
            for nArrayIdx in range(nArrayCount):
                lstRow.append(lstArrays[nArrayIdx].getVal(nRowIdx, "val"))

            lstDataSet.append(tuple(lstRow))

        
        # Assign all of this to a new dataset.
        return ManualDataset(lstHeader, tuple(lstDataSet))

    def _parseMeas(self, strInput):

        # It's more efficient to compile the regex string
        # and keep it around for a while.
        # Do the lazy instantiation here, don't compile until required.
        if self.__measRegex is None:
            self.__measRegex = re.compile("^(.*)\((.*)\)$")

        match = self.__measRegex.match(strInput)

        if match is None:
            raise Exception('FAILED TO PARSE MEASUREMENT/UNITS "%s"' % strInput)

        return [ x.strip() for x in match.groups() ]

    # given a header in a list/tuple sequence, this method will 
    # parse into a (MeasurementName,MeasurementUnits) pair.
    def _parseHeader(self, header, strSeparator=' '):
        lstPairs = []

        for strElement in header:
            pair = self._parseMeas(strElement)

            nLength = len(pair)

            if nLength == 1:
                pair = [pair[0], None]
            elif nLength != 2:
                raise Exception("INVALID HEADER FIELD: %s" % strElement)

            lstPairs.append(pair)

        return lstPairs

            
    def insertArrayGroup(self, nHistoryId, header, arrays, strGroupName=None):
        # the header must be in a format that can be parsed to measurement name/measurement units
        # make sure that the number of fields in the header matches the number of fields in the header
        # matches the number of arrays
        nCount = len(header)

        if len(arrays) != nCount:
            raise Exception("ERROR: HEADER HAS %d FIELDS BUT THERE ARE %d ARRAYS" % (nCount, len(header)))

        lstPairs = self._parseHeader(header)

        # insert the arrays one by one
        for i in range(nCount):
            strMeasName, strMeasUnits = lstPairs[i]
            r = self.insertArray(nHistoryId, strMeasName, strMeasUnits, arrays[i], strMeasGroup=strGroupName)

        return r

    def insertArray(self, nHistoryId, strMeasName, strUnits, lstValues, \
        dtMeasTime = None, strMeasGroup = None):

        # convert the array of float data to a string type.
        # max TEXT size is 65536 characters
        # note: a potential optimization would be to remove all leading 0s from 
        # values.  For example, 0.123456 could be trimmed to .123456
        lstStrings = [ str(x) for x in lstValues ]
        strAllVals = ",".join(lstStrings)

        # TODO: 
        # check to make sure that strAllVals is < 65536
        # if it is, I will need to spilt apart the string and support
        # more than one array.  The returned values will contain the 
        # array id 

        cursor = self._execStoredProc("insertArray", nHistoryId, \
            strMeasName, strUnits, strAllVals, dtMeasTime, strMeasGroup)
            
        # expect a scalar result
        return self._checkResult(cursor)


    def insertSpec(self, strTestName, strTestVersion, strMeasName, strMeasUnits, \
                strSpecType, lsl=None, usl=None):
        cursor = self._execStoredProc('insertSpec', strTestName, strTestVersion, \
                strMeasName, strMeasUnits, strSpecType, lsl, usl)

        # expect a scalar result
        return self._checkResult(cursor)

    def insertScalar(self, nHistoryId, strMeasName, strUnits, val, dtMeasTime=None):

        if isFloat(val) or isInt(val) or isLong(val):
            strStoredProc = "insertScalarFloat"

        elif isString(val):
            strStoredProc = "insertScalarString"

        else:
            raise TypeError("EXPECTED FLOAT, INT, OR STRING FOR VALUE")

        # SANITIZE THE ARGUMENTS
        if not (isInt(nHistoryId) or isLong(nHistoryId)):
            raise TypeError("EXPECTED HISTORY ID INTEGER")
        elif nHistoryId <= 0:
            raise ValueError("EXPECTED HISTORY ID >= 0")


        cursor = self._execStoredProc(strStoredProc, nHistoryId,  \
            strMeasName, strUnits, val, dtMeasTime)

        # expect a scalar result
        return self._checkResult(cursor)

    def getScalarMetrics(self, nHistoryId):
        return self._dataset(self._execStoredProc("getTestMetrics", nHistoryId))

    # TEST HISTORY #
    def insertTestHistory(self, strDutPartNumber, strDutSerialNumber, \
        strTestName, strTestVersion, strStation, strOperator, \
        dtStart=None, dtStop=None, nResult=None):
        cursor = self._execStoredProc("insertHistory", \
            strDutPartNumber, strDutSerialNumber, 
            strTestName, strTestVersion, 
            strStation, strOperator, \
            dtStart, dtStop, nResult)

        # expect a scalar result
        return self._checkResult(cursor)
        
    def closeTest(self, nHistoryId, nResult=None, dtStop=None):
        cursor = self._execStoredProc("testComplete", nHistoryId, nResult, dtStop)

        # expect a scalar result
        return self._checkResult(cursor)

    def deleteTest(self, nHistoryId):
        cursor = self._execStoredProc("deleteTestHistory", nHistoryId)

        # expect a scalar result
        return self._checkResult(cursor)

    
    ##
    # @brief insert using ids
    #
    # NOTE: NOT YET IMPLEMENTED
    def insertTestHistoryByIds(self, test_node, station, serial_number, part_number, \
         operator, start_time=None, stop_time=None):

         #cursor = self._execStoredProc( "insertHistory", \
        pass 

    def getFilteredHistory(self, strDutLabel, strTestName=None, strTestVersion=None, strTestCondition=None):
        return self._dataset(self._execStoredProc(\
                "getFilteredHistory", \
                strDutLabel, \
                strTestName, \
                strTestVersion, \
                strTestCondition))


    def getDutHistory(self, strPartNumber, strSerialNumber):
        return self._dataset( self._execStoredProc("getDutHistory", \
            strPartNumber, strSerialNumber) )
        
    def getNewTestRecord(self):
        return TestRecord(self)

class TestRecord(object):
    def __init__(self, db, **args):
        self._db = db
        self._strDutPartNumber = args.get("dut_part_number")
        self._strDutSerialNumber = args.get("dut_serial_number")
        self._strTestName = args.get("test_name")
        self._strTestVersion = args.get("test_version", "0.0.0")
        self._strStation = args.get("station")
        self._strOperator = args.get("operator")
        self._dtStart = args.get("start_time")
        self._dtStop = args.get("stop_time")
        self._nResult = args.get("result")

        self._nHistoryId = None

        self._blnClosed = False

        # TODO: sanitize the arguments
        self._checkInputs()

    # property getters/setters

    def testName(self, strName=None):
        if strName is None:
            return self._strTestName
        else:
            self._strTestName = strName

    def testVersion(self, strVersion=None):
        if strVersion is None:
            return self._strTestVersion
        else:
            self._strTestVersion = strVersion
    
    def dutSerialNumber(self, strSN=None):
        if strSN is None:
            return self._strDutSerialNumber
        else:
            self._strDutSerialNumber = strSN

    def dutPartNumber(self, strPN=None):
        if strPN is None:
            return self._strDutPartNumber 
        else:
            self._strDutPartNumber  = strPN

    def station(self, strStation=None):
        if strStation is None:
            return self._strStation
        else:
            self._strStation = strStation

    def operator(self, strOperator=None):
        if strOperator is None:
            return self._strOperator
        else:
            self._strOperator = strOperator

    def result(self, nResult=None):
        if nResult is None:
            return self._nResult
        else:
            self._nResult = nResult

    # start/stop
    def startTime(self, dtStart=None):
        if dtStart is None:
            return self._dtStart
        else:
            self._dtStart = dtStart

    def stopTime(self, dtStop=None):
        if dtStop is None:
            return self._dtStop
        else:
            self._dtStop = dtStop

    # verbs
    def create(self):
        if self._nHistoryId is not None:
            raise Exception("TEST RECORD HAS ALREADY BEEN CREATED")

        self._nHistoryId = self._db.insertTestHistory(
            self._strDutPartNumber, \
            self._strDutSerialNumber, \
            self._strTestName, \
            self._strTestVersion, \
            self._strStation, \
            self._strOperator, \
            self._dtStart, \
            self._dtStop,   \
            self._nResult)

        return self._nHistoryId

    def historyId(self):
        return self._nHistoryId

    def insertTestCondition(self, strName, strValue):
        self._checkCreated()
        return self._db.insertTestCondition(self._nHistoryId, strName, strValue)
    
    def insertScalar(self, strMeasName, strUnits, val, dtMeasTime=None):
        self._checkCreated()

        return self._db.insertScalar(self._nHistoryId, strMeasName, strUnits, val, dtMeasTime)

    def insertArray(self, strMeasName, strUnits, lstValues, dtMeasTime=None, strMeasGroup=None):
        self._checkCreated()

        return self._db.insertArray(self._nHistoryId, strMeasName, strUnits, lstValues, dtMeasTime, strMeasGroup)

    def insertArrayGroup(self, lstHeader, lstArrays, strMeasGroupName):
        self._checkCreated()

        return self._db.insertArrayGroup(self._nHistoryId, lstHeader, lstArrays, strGroupName=strMeasGroupName)

    def close(self, nResult=None, dtStop=None):
        self._checkCreated()
        
        if self._blnClosed:
            return

        self._db.closeTest(self._nHistoryId, nResult=nResult, dtStop=dtStop)

        self._blnClosed = True

    def _checkCreated(self):
        if self._nHistoryId is None:
            raise Exception("TEST RECORD HAS NOT BEEN CREATED")

    def _checkInputs(self):
        if self._dtStart is not None:
            if not isinstance(self._dtStart, datetime.datetime):
                raise TypeError("start_date MUST BE datetime.datetime")

        if self._dtStop is not None:
            if not isinstance(self._dtStop, datetime.datetime):
                raise TypeError("start_date MUST BE datetime.datetime")



##
# @brief My own abstraction on cursor result data
#
class BaseDataset(object):
    def __init__(self):
        self._data = ()
        self._nRowCount = 0
        self._nColCount = 0
        self._header = []

    def __del__(self):
        self.close()

    def __toString(self):
        return str( self._data )

    def __repr__(self):
        return self.__toString()

    def prettyHeader(self, strHeader):
        lstWords = [x.capitalize() for x in strHeader.split("_")]

        return " ".join(lstWords)

    def toCsv(self, strFile=None):
        try:
            f = None

            if strFile is not None:
                f = open(strFile, 'w')
            else:
                # use the stringio thing
                f = getStringIO()

            wr = csv.writer(f)

            # write out the header
            wr.writerow(self._header)

            for nRowIdx in range(self.rowCount()):

                row = self.row(nRowIdx)

                if 0 == nRowIdx:

                    lstConvFcn = []

                    for nCol, val in enumerate(row):
                        if isString(nCol) or isInt(nCol) or isLong(nCol):
                            lstConvFcn.append( lambda x: str(x) )

                        elif isinstance(val, datetime.datetime):
                            lstConvFcn.append( lambda x: x.strftime("%Y-%m-%d %H:%M:%S") )


                lstRow = []
                for nCol, val in enumerate(row):

                    lstRow.append( lstConvFcn[nCol](val) )

                wr.writerow( lstRow )

            # finished writing everything to the file-like object...
            # I need to return text if there was no actual filename.
            if strFile is None:
                return f.getvalue()

        finally:
            # clean up
            if f is not None:
                f.close()



    def toDictList(self):
        # this returns one python dictionary per row of data.
        lstRows = []

        for nRow in range(self.rowCount()):
            dctRow = {}
            row = self.row(nRow)

            for nCol, val in enumerate(row):
                dctRow[self._header[nCol]] = val

            lstRows.append(dctRow)

        return lstRows

    def toDict(self, blnPrettyHeaders=False):
        dctDataSet = {}

        if blnPrettyHeaders:
            dctDataSet["header"] = [ self.prettyHeader(x) for x in self.header() ]
        else:
            dctDataSet["header"] = self.header()

        dctDataSet["rows"] = self._data[:]

        lstRows = []
        for nRow in range(self.rowCount()):
            row = self.row(nRow)

            if 0 == nRow:
                lstConvFcn = []

                for nCol, val in enumerate(row):
                    if isString(nCol) or isInt(nCol) or isLong(nCol):
                        lstConvFcn.append( lambda x: str(x) )

                    elif isinstance(val, datetime.datetime):
                        lstConvFcn.append( lambda x: x.strftime("%Y-%m-%d %H:%M:%S") )

            lstRow = []
            for nCol, val in enumerate(row):
                lstRow.append(lstConvFcn[nCol](val))

            lstRows.append(lstRow)


        dctDataSet["rows"] = lstRows

        return dctDataSet

    def toJson(self):

        e = json.JSONEncoder()

        return e.encode(self.toDict())
        
    ##
    # @brief render as html-compatible xml table (xhtml table)
    #
    def toXml(self):
        doc = xml.dom.minidom.Document()
        elmTable = doc.appendChild( doc.createElement( "table") )
        elmHead = elmTable.appendChild( doc.createElement( "thead") )
        elmHeader = elmHead.appendChild(doc.createElement("tr"))
        elmBody = elmTable.appendChild( doc.createElement( "tbody") )

        lstHeader = self.header()

        for strField in lstHeader:
            elm = elmHeader.appendChild(doc.createElement("th"))
            elm.appendChild(doc.createTextNode(strField))

        
        for nRow in range(self.rowCount()):
            elmRow = elmBody.appendChild(doc.createElement("tr"))
            row = self.row(nRow)

            if 0 == nRow:
                
                lstConvFcn = []
                for nCol, val in enumerate(row):
                    if isString(nCol) or isInt(nCol) or isLong(nCol):
                        lstConvFcn.append( lambda x: str(x) )

                    elif isinstance(val, datetime.datetime):
                        lstConvFcn.append( lambda x: x.strftime("%Y-%m-%d %H:%M:%S") )




            for nCol, val in enumerate(row):
                elmRow.appendChild(doc.createElement("td")).appendChild(\
                    doc.createTextNode(lstConvFcn[nCol](val)))


        return doc.toprettyxml()

        
    def header(self):
        return self._header

    
    def rowCount(self):
        return self._nRowCount

    def colCount(self):
        return self._nColCount

    ##
    # @brief returns a tuple of row data
    #
    def row(self,nIdx):
        return self._data[nIdx]

    
    ##
    # @brief return a tuple of the entire column
    #
    #
    def getColumn(self, col):
        nCol = self._colToIdx(col)

        return [ self._data[nRow][nCol] for nRow in range(self._nRowCount) ]
        
    getCol = getColumn

    ##
    # @brief return all of the columns as lists in one larger list.
    def columns(self):
        # initialize empty lists for each column
        cols =[  [] for c in range(self._nColCount) ]

        for nRow in range(self._nRowCount):
            for nCol in range(self._nColCount):
                cols[nCol].append( self._data[nRow][nCol] )
    
        return cols

    def getVal(self, nRow, col):
        nCol = self._colToIdx(col)

        if nRow >= self._nRowCount:
            print( "CANNOT GET ROW %d of data %s" % \
                ( nRow, str(self._data) ) )

            raise ValueError( \
                "ROW %d IS OUT OF RANGE.  THERE ARE %d ROWS" % \
                    (nRow, self._nRowCount ) )

        if nCol >= len(self._data[nRow]):
            raise ValueError( \
                "COL %d IS OUT OF RANGE.  THERE ARE %d COLS" % \
                    (nCol, self._nColCount) )

        return self._data[nRow][nCol]

    # alias
    getField = getVal

    def _colToIdx(self, col):
        if isinstance(col, str):
            if col in self.header():
                return self._header.index(col)
            else:
                raise ValueError( "COULD NOT FIND COLUMN %s" % col )

        elif isInt(col) or isLong(col):
            return col
        else:
            raise TypeError("EXPECTED A STRING OR AN INT FOR COLUMN")

class ManualDataset(BaseDataset):
    def __init__(self, header, data):
        BaseDataset.__init__(self)

        self._header = header[:]

        self._data = data[:]

        self._nRowCount = len(self._data)

        self._nColCount = len(self._header)

    def close(self):
        pass

class CursorDataset(BaseDataset):
    def __init__(self, cursor):
        BaseDataset.__init__(self)

        self._cursor = cursor

        # later I could possibly have a "lazy" fetch that did this on demand

        self._data = self._cursor.fetchall()

        self._nRowCount = self._cursor.rowcount

        self._nColCount = len(self._cursor.description)

        self._header =  [ x[0] for x in self._cursor.description ]

        cursor.close()

    def cursor(self):
        return self._cursor

    def close(self):
        # the cursor won't care if I close it more than once
        self._cursor.close()

# alias the class
DataSet = CursorDataset

def addSampleData():
    db = TurtleDb()

    db.deleteAll()

    TANK_ROBOT = "TANK-ROBOT"
    WALKING_ROBOT = "WALKING-ROBOT"

    WR_PN = "WR1000-02"
    TR_PN = "TR2000-04"

    db.insertPartNumber( WR_PN, WALKING_ROBOT )
    db.insertPartNumber( TR_PN, TANK_ROBOT )

    nWalkingCount = 10
    nTankCount = 12
    lstWSn = [ "WR%04d" % (x + 1) for x in range(nWalkingCount ) ]
    lstTSn = [ "TR%04d" % (x + 1) for x in range(1, nTankCount) ]


    # insert the serial numbers
    for strWalkingSn in lstWSn:
        db.insertDut(WR_PN, strWalkingSn)

    for strTankSn in lstTSn:
        db.insertDut(TR_PN, strTankSn)


    # create some stations
    TANK_ASSY_STATION = "TANK-ASSY-001"
    TANK_CAL_STATION = "TANK-CAL-001"

    WALKING_ASSY_STATION = "WLK-ASSY-001"
    WALKING_CAL_STATION = "WLK-CAL-001"

    db.insertStation( TANK_ASSY_STATION )
    db.insertStation( TANK_CAL_STATION )
    db.insertStation( WALKING_ASSY_STATION )
    db.insertStation( WALKING_CAL_STATION )

    # insert some station properties for the assy stations
    TRQ_WR_15_SN = "TRQ-WRENCH-15-SN"
    TRQ_WR_15_LAST_CAL = "TRQ-WRENCH-15-LAST-CAL"
    TRQ_WR_10_SN = "TRQ-WRENCH-10-SN"
    TRQ_WR_10_LAST_CAL = "TRQ-WRENCH-10-LAST-CAL"

    db.insertStationProperty( TANK_ASSY_STATION, TRQ_WR_15_SN, "TW15001" )
    db.insertStationProperty( TANK_ASSY_STATION, TRQ_WR_15_LAST_CAL, \
        "2015-09-15 15:23:59" )

    # write some assembly steps
    lstTankAssemblySteps = [ "AssembleTreads", "IntegrateTreads", "InstallArms" ]
    lstTankAssemblyVer = [ "1.4.2", "1.0.0", "3.2.0" ]

    TANK_ASSY_TECH = "bobt"
    TANK_CAL_TECH = "johnd"
    WLK_ASSY_TECH = "wesleyd"
    WLK_CAL_TECH = "waltert"

    
    strTankSn = lstTSn[0]
    nHistoryId = db.insertTestHistory( TR_PN, strTankSn, 
        lstTankAssemblySteps[0], lstTankAssemblyVer[0], 
        TANK_ASSY_STATION, TANK_ASSY_TECH )

    # insert some test metrics
    db.insertScalar( nHistoryId, "AvgTreadTrq", "Nm", 15.2 )
    db.insertScalar( nHistoryId, "MinTreadTrq", "Nm", 12.3 )
    db.insertScalar( nHistoryId, "MaxTreadTrq", "Nm", 17.567 )

    # close out the test

    nHistoryId = db.insertTestHistory( TR_PN, strTankSn, 
        lstTankAssemblySteps[1], lstTankAssemblyVer[1], 
        TANK_ASSY_STATION, TANK_ASSY_TECH )

def isString(arg):
    return isinstance(arg, str)

def isInt(arg):
    return isinstance(arg, int)

def isFloat(arg):
    return isinstance(arg, float)

def isUnicode(arg):
    if PYTHON2:
        return isinstance(arg, unicode)
    else:
        return False

def isLong(arg):
    if PYTHON2:
        return isinstance(arg, long)
    else:
        return False


def testds():
    ds = (('my-test-station', 0), ('another-test-station',0) )

def getStringIO():
    if PYTHON2:
        return StringIO.String()
    elif PYTHON3:
        return  io.StringIO()

def test():
    tdb = TurtleDb()

    ds = tdb.getFilteredHistory('TR2000-04 TR0012', 'ArmFrictionTest', '2.3.8', 'Temperature=25C')

    return ds
	
