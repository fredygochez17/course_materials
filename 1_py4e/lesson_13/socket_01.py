# This program in a nutshell:
# 1. open socket
# 2. send command
# 3. retreive data

#    [protocol][  host/domain  ][document]
#       http://www.dr_chuck.com/page1.html 

import socket

# 1. open socket
# create a stream-based socket but don't associate anything to it
mysock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)

# make the "phone-call" with the phone extension
#                [ host address] [port number]
mysock.connect( ('data.pr4e.org',     80      ) )

# 2. send command
cmd = 'GET http://https://data.pr4e.org/intro-short.txt HTTP/1.0\r\n\r\n'.encode()
mysock.send(cmd)

# 3. retrieve data
while True:
    data = mysock.recv(512)     # recieve 512 chars at a time
    if (len(data) < 1): break   # if no data comes back, end of file, stop
    print(data.decode())        # print recieved data decode first
    
mysock.close()