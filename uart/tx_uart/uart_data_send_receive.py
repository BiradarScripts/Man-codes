import serial           # import the module
import struct

ComPort = serial.Serial('COM8') # open COM24

ComPort.baudrate = 115200 # set Baud rate to 9600
ComPort.bytesize = 8    # Number of data bits = 8
ComPort.parity   = 'N'  # No parity
ComPort.stopbits = 1    # Number of Stop bits = 1

N_RECEIVED_BYTES = 1

while True:
	print("Enter data 1 or Press 'q' to exit")
	data1 = input()
	if data1 == 'q':
		break
	print("Enter data 2")
	data2 = input()
	
	ot = ComPort.write(struct.pack('>B', int(data1)))
	ot = ComPort.write(struct.pack('>B', int(data2)))

	print("Both data's are sent")

	it = ComPort.read(N_RECEIVED_BYTES)
	print(f"Received data: {int.from_bytes(it, byteorder='big')}")

ComPort.close()
