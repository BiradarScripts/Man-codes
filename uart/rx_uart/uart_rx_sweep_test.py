import serial           # import the module
import struct
import time

ComPort = serial.Serial('COM8') # open COM24

ComPort.baudrate = 115200 # set Baud rate to 9600
ComPort.bytesize = 8    # Number of data bits = 8
ComPort.parity   = 'N'  # No parity
ComPort.stopbits = 1    # Number of Stop bits = 1

print("Enter an 8-bit number")
print("Press 'q' to exit infinite loop")

x = 0

while True:
    x= x+1
    if x == 256:
        break
    else:
        ot = ComPort.write(struct.pack('>B', int(x)))    #for sending data to FPGA
        print(f"Sent {x} over UART")

    time.sleep(0.2)

ComPort.close()         # Close the Com port
