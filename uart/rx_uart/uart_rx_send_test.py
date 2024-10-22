import serial           # import the module
import struct
import time


#For linux users
#dmesg | grep tty
#ComPort = serial.Serial('/dev/ttyUSB1') # for linux users
#sudo chmod a+rw /dev/ttyUSB1
ComPort = serial.Serial('COM8') # for windows users- check from device manager

ComPort.baudrate = 115200 # set Baud rate to 9600
ComPort.bytesize = 8    # Number of data bits = 8
ComPort.parity   = 'N'  # No parity
ComPort.stopbits = 1    # Number of Stop bits = 1

print("Enter an 8-bit number")
print("Press 'q' to exit infinite loop")

while True:
    x= input()
    if x == 'q':
        break
    else:
        ot = ComPort.write(struct.pack('>B', int(x)))    #for sending data to FPGA
        print(f"Sent {x} over UART")

    time.sleep(0.3)

ComPort.close()         # Close the Com port
