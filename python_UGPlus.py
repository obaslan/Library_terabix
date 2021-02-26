import ctypes
import time
from time import sleep
import os
if os.path.exists("C:\Program Files (x86)")==True:
	UGPluslib = ctypes.CDLL("C:\Program Files (x86)\LQElectronics\UGPlus\UGPlusAPI\LQUGPlus_c.dll")
else:
	UGPluslib = ctypes.CDLL("C:\Program Files\LQElectronics\UGPlus\UGPlusAPI\LQUGPlus_c.dll")

UGPluslib.Gwrite.restype = ctypes.c_int
UGPluslib.Gread.restype = ctypes.c_char_p

GPIBaddress=11 		#GPIB address for each GPIB equipment

GPIBcommand="*IDN?" 	#GPIB command to equipment  
UGPluslib.Gwrite(GPIBaddress,GPIBcommand)	#write GPIB command to equipment
print UGPluslib.Gread(GPIBaddress)	#read data from equipment

GPIBcommand="CONF:VOLT:AC"	#GPIB command to equipment 
UGPluslib.Gwrite(GPIBaddress,GPIBcommand)
GPIBcommand="MEAS:VOLT:AC?"	
UGPluslib.Gwrite(GPIBaddress,GPIBcommand)
sleep(0.8) 	# when read data from GPIB equipment, sometimes you have 
		# to wait for the equipment to prepare return data
print UGPluslib.Gread(GPIBaddress)

GPIBcommand="CONF:VOLT:DC"	#GPIB command to equipment 
UGPluslib.Gwrite(GPIBaddress,GPIBcommand) 
GPIBcommand="MEAS:VOLT:DC?"	
UGPluslib.Gwrite(GPIBaddress,GPIBcommand) 
sleep(0.2)
print UGPluslib.Gread(GPIBaddress)
