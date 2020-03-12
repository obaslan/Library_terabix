
import pandaturtle
import turtledata

frange = turtledata.frange

import pandas


class PandaTest(turtledata.SampleData):
    def __init__(self):
        turtledata.SampleData.__init__(self)
        self.db = pandaturtle.PandaTurtle()

    def runFrictionTest(self):
        testRecord = pandaturtle.PandaTestRecord(self.db)

        testRecord.dutPartNumber(self.TR_PN)
        testRecord.dutSerialNumber(self.lstTRSn[-1])
        testRecord.testName(self.lstTankAssemblySteps[-1])
        testRecord.testVersion(self.lstTankAssemblyVer[-1])
        testRecord.operator(self.lstTankAssyTechs[0][0])

        testRecord.create()

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

        lstHeader = ["Sample Time (s)", "Velocity (m/s)", "Position (m)"]
        dctDataFrame = { \
                "SampleTime (s)" : lstTime, \
                "Velocity (m/s)" : lstVelocity, \
                "Position (m)" : lstPosition, \
                "Torque (Nm)" : lstTorque}

        df = pandas.DataFrame(dctDataFrame)
        testRecord.insertDataFrame(df, 'friction')
        
        # add some scalar measurements
        testRecord.insertScalar("AvgTorque", "Nm", sum(lstTorque)/float(nArrayLength))
        testRecord.insertScalar("MaxTorque", "Nm", max(lstTorque))
        testRecord.insertScalar("TotalDistance", "m", max(lstPosition) - min(lstPosition))
        testRecord.close(0)

        return df

def testDataFrame():
    pt = PandaTest()
    return pt.runFrictionTest()
    

