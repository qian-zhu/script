#!/usr/bin/python
import socket
import pynotify

srvsock = socket.socket(socket.AF_INET,socket.SOCK_STREAM)
srvsock.bind(('',9999))
srvsock.listen(5)
pynotify.init("Basic")

while 1:
    clisock,(remhost,remport) = srvsock.accept()
    str = clisock.recv(1000);
    if str[0] == 'e':#error
        notice = pynotify.Notification("Error!",str[1:]) 
        notice.show()
    elif str[0] == 's':#success
        notice = pynotify.Notification("Done!",str[1:]) 
        notice.show()
    clisock.close()
