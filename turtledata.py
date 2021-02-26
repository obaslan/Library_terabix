#! /usr/bin/python

import os
import sys
import random
import time
import math

import turtledb

PYTHON2 = (2 == sys.version_info.major)
PYTHON3 = (3 == sys.version_info.major)

if PYTHON2:
    from exceptions import Exception, ValueError, TypeError


TANK_ROBOT = "TANK-ROBOT"
WALKING_ROBOT = "WALKING-ROBOT"

TANK_ASSY_STATION = "TANK-ASSY-001"
TANK_CAL_STATION = "TANK-CAL-001"

WALKING_ASSY_STATION = "WLK-ASSY-001"
WALKING_CAL_STATION = "WLK-CAL-001"

TRQ_WR_15_SN = "TRQ-WRENCH-15-SN"
TRQ_WR_15_LAST_CAL = "TRQ-WRENCH-15-LAST-CAL"
TRQ_WR_10_SN = "TRQ-WRENCH-10-SN"
TRQ_WR_10_LAST_CAL = "TRQ-WRENCH-10-LAST-CAL"

class SampleData(object):

    def __init__(self):
        self.db = turtledb.TurtleDb()
        self.random = random.Random()
        self.random.seed(time.time())

        # part numbers for walking robot and tank robot
        self.WR_PN = "WR1000-02"
        self.TR_PN = "TR2000-04"

        self.nWalkingCount = 10
        self.nTankCount = 12
        self.lstWRSn = [ "WR%04d" % (x + 1) for x in range(self.nWalkingCount)]
        self.lstTRSn = [ "TR%04d" % (x + 1) for x in range(self.nTankCount)]

        self.lstTankAssyStations = [ "TANK-ASSY-%03d" % (i + 1) \
            for i in range(3) ]
        
        self.lstTankCalStations = [ "TANK-CAL-%03d" % (i + 1) \
            for i in range(3) ]

        self.lstWalkingAssyStations = [ "WLK-ASSY-%03d" % (i + 1) \
            for i in range(3) ]

        self.lstWalkingCalStations = [ "WLK-CAL-%03d" % ( i + 1 ) \
            for i in range(3) ]

        self.lstTankAssyTechs = [ ("bobt", "Bob", "Tung"), \
                ("tomb", "Tom", "Basil")]

        self.lstTankCalTechs = [ ("noahg", "Noah", "Grassser"), 
                ("albertm", "Albert", "Mattlis") ]

        self.lstWalkingAssyTechs = [ ("johnd", "John", "Denver"), 
                ("wesleys", "Wesley", "Sneed") ]

        self.lstWalkingCalTechs = [("waltert", "Walter", "Tasker"), 
                ("kevinr", "Kevin", "Rinnart") ]

        self.lstTankAssemblySteps = [ "AssembleTreads", "IntegrateTreads", "InstallArms", "ArmFrictionTest" ]
        self.lstTankAssemblyVer = [ "1.4.2", "1.0.0", "3.2.0", "2.3.8" ]

    def _randomFloat(self, fltTarget, fltSpan):
        return self.random.random() * fltSpan + fltTarget - ( fltSpan / 2 )
        
    def _randomFloatArray(self, fltTarget, fltSpan, nLength):
        lstReturn = []
        for i in range(nLength):
            lstReturn.append(self._randomFloat(fltTarget, fltSpan))

        return lstReturn

    def _createStations(self):
        for strTankAssyStation in self.lstTankAssyStations:
            self.db.insertStation( strTankAssyStation )

            self.db.insertStationProperty(strTankAssyStation, \
                TRQ_WR_15_SN, "TR%02d" % self.random.randint(0,99) )

            self.db.insertStationProperty( strTankAssyStation, TRQ_WR_15_LAST_CAL, \
                "2015-09-15 %d:23:59" % self.random.randint(0,23) )

        for strTankCalStation in self.lstTankCalStations:
            self.db.insertStation( strTankCalStation )

            self.db.insertStationProperty(strTankCalStation, "DMM-SN", \
                    "DMM%06d" % self.random.randint(0,99999))


        for strWalkingAssyStation in self.lstWalkingAssyStations:
            self.db.insertStation( strWalkingAssyStation )

            self.db.insertStationProperty(strWalkingAssyStation, \
                    TRQ_WR_10_SN, "TR%02d" % self.random.randint(0,99))

            self.db.insertStationProperty( strWalkingAssyStation, TRQ_WR_15_LAST_CAL, \
                "2015-09-15 %d:23:59" % self.random.randint(0,23) )


        for strWalkingCalStation in self.lstWalkingCalStations:
            self.db.insertStation( strWalkingCalStation )

            self.db.insertStationProperty(strTankCalStation, "DMM-SN", \
                    "DMM%06d" % self.random.randint(0,99999))

    def _addOperators(self):
        for o in self.lstTankAssyTechs:
            self.db.insertOperator( o[0], o[1], o[2] )

        for o in self.lstTankCalTechs:
            self.db.insertOperator( o[0], o[1], o[2] )

        for o in self.lstWalkingAssyTechs: 
            self.db.insertOperator( o[0], o[1], o[2] )

        for o in self.lstWalkingCalTechs: 
            self.db.insertOperator( o[0], o[1], o[2] )

    def go(self):
        self.db.deleteAll()

        self.db.configAutoGenMeasurement()

        self.db.insertPartNumber( self.WR_PN, WALKING_ROBOT )
        self.db.insertPartNumber( self.TR_PN, TANK_ROBOT )

        # insert the serial numbers
        for strWalkingSn in self.lstWRSn:
            self.db.insertDut(self.WR_PN, strWalkingSn)

        for strTankSn in self.lstTRSn:
            self.db.insertDut(self.TR_PN, strTankSn)

        # create the stations
        self._createStations()

        self._addOperators()

        # write some assembly steps

        for i in range(len(self.lstTankAssemblySteps)):
            self.db.insertTestNode(self.lstTankAssemblySteps[i], self.lstTankAssemblyVer[i])

        strTankSn = self.lstTRSn[0]
        strStation = self.lstTankAssyStations[0]

        strOperator = self.lstTankAssyTechs[0][0] 
        nHistoryId = self.db.insertTestHistory( self.TR_PN, strTankSn, 
            self.lstTankAssemblySteps[0], self.lstTankAssemblyVer[0], 
            strStation, strOperator)

        # insert some test metrics

        lstTorque = self._randomFloatArray(15.0, 2.0, 25)

        self.db.insertScalar( nHistoryId, "AvgTreadTrq", "Nm", math.fsum(lstTorque)/len(lstTorque))
        self.db.insertScalar( nHistoryId, "MinTreadTrq", "Nm", min(lstTorque))
        self.db.insertScalar( nHistoryId, "MaxTreadTrq", "Nm", max(lstTorque))

        self.db.insertArray( nHistoryId, "TreadTrq", "Nm", lstTorque)

        # close out the test
        self.db.closeTest(nHistoryId)

        # Run the friction test
        self._runFrictionTest()

    def _runFrictionTest(self, strTankRobotSN=None):
        if strTankRobotSN is None:
            strTankRobotSN = self.lstTRSn[-1]

        testRecord = self.db.getNewTestRecord()
        testRecord.dutPartNumber(self.TR_PN)
        testRecord.dutSerialNumber(strTankRobotSN)
        testRecord.testName(self.lstTankAssemblySteps[-1])
        testRecord.testVersion(self.lstTankAssemblyVer[-1])
        testRecord.operator(self.lstTankAssyTechs[0][0])

        nHistoryId = testRecord.create()
        testRecord.insertTestCondition('Temperature', '25C')

        nArrayLength = 75
        lstVelocity = frange(0.0, 0.5, 25) + [0.5] * 25 + frange(0.5, 0, 25)
        lstTime = frange(0.0, 30.0, nArrayLength)

        # add an array for torque
        lstNoise = self._randomFloatArray(0.0, 0.02, nArrayLength)
        lstTorque = [ x*2 for x in lstVelocity]

        lstPosition = []

        x = 0.0
        for idx in range(nArrayLength):
            x = x + lstTime[idx] * lstVelocity[idx]
            lstPosition.append(x)

            lstTorque[idx] += lstNoise[idx]

        # array group name is friction
        strGroup = 'friction'
        # to test long array group names
        #strGroup = generateLongGroupName()

        TEST_MULTIPLE_ARRAYS = True

        if TEST_MULTIPLE_ARRAYS:
            lstHeader = ["Sample Time (s)", "Velocity (m/s)", "Position (m)"]
            lstArrays = [ lstTime, lstVelocity, lstPosition ]
            testRecord.insertArrayGroup(lstHeader, lstArrays, strMeasGroupName=strGroup)
        else:
            testRecord.insertArray( "Time", "s", lstTime, strMeasGroup=strGroup)
            testRecord.insertArray( "Velocity", "m/s", lstVelocity, strMeasGroup=strGroup)
            testRecord.insertArray( "Position", "m", lstPosition, strMeasGroup=strGroup)
        
        # add another array that does NOT have a associated array group
        # maybe positions at which we had envelope/following error warnings
        lstWarningPos = [ 1.345, 57.9875, 100.34, 32.8976]
        testRecord.insertArray("EnvelopeWarning", "m", lstWarningPos)


        # add some scalar measurements
        testRecord.insertScalar("AvgTorque", "Nm", sum(lstTorque)/float(nArrayLength))
        testRecord.insertScalar("MaxTorque", "Nm", max(lstTorque))
        testRecord.insertScalar("TotalDistance", "m", max(lstPosition) - min(lstPosition))

        testRecord.close(0)

def vectorAdd(*args):
    # check for lengths
    nLength = len(args[0])
    for v in args[1:]:
        if nLength != len(v):
            raise ValueError("vectorAdd expects all args the same length")

    if isinstance(args[0], tuple):
        result = (0,) * nLength
    else:
        result = [0] * nLength

    # now add them up
    for vectorIdx in range(len(args)):
        for elementIdx in range(nLength):
            result[elementIdx] += args[vectorIdx][elementIdx]

    return result



def frange(fltMin, fltMax, nCount):
    fltStep = (fltMax - fltMin) / float(nCount - 1)
    lstResult = []

    for i in range(nCount):
        lstResult.append( fltMin + (float(i) * fltStep) )
    
    return lstResult
    
def generateLongGroupName(nMinLength=100):
        # just start concatenating numbers

        strName = ""
        idx = 0
        while True:
            if len(strName) >= nMinLength:
                return strName
            strName += "%d-" % idx
            idx += 1

if __name__ == "__main__":
    # check the arguments
    print(sys.argv)
    if "--install-data" in sys.argv:
        sampleData = SampleData()
        sampleData.go()
    else:
        print("I only recognize the --install-data arg")
    

