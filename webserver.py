#!/usr/bin/python
#
# author: Amos Zhu(qzhu@sonicwall.com)
#
# A simple one-thread http server
# URL is : http://<Your server's ip>/ubuntu-9.10-dvd-i386.iso
# You should start this server with root authority
#
# In future, I will add multi-thread support in this simple http server
#
#
#

import string,cgi,time
from os import curdir, sep
from BaseHTTPServer import BaseHTTPRequestHandler, HTTPServer

class MyHandler(BaseHTTPRequestHandler):

    def do_GET(self):
        try:
            # List files in index.html
            if self.path.endswith(".html"):
                f = open(curdir + sep + self.path) #self.path has /test.html
                print "curdir is %s" %(curdir)
                print "sep is %s" %(sep)
                print "self.path is %s" %(self.path)
                # curdir is    : .
                # sep is       : /
                # self.path is : /index.html

                self.send_response(200)
                self.send_header('Content-type',	'text/html')
                self.end_headers()
                self.wfile.write(f.read())
                f.close()
                return
            # dynamic page. Test
            if self.path.endswith(".esp"):   #our dynamic content
                self.send_response(200)
                self.send_header('Content-type',	'text/html')
                self.end_headers()
                self.wfile.write("hey, today is the" + str(time.localtime()[7]))
                self.wfile.write(" day in the year " + str(time.localtime()[0]))
                return
                
            # Return application
            if self.path.endswith(".iso"):
                f = open("/home/ftp/ftp/test/ubuntu-9.10-dvd-i386.iso",'rb')
                self.send_response(200)
                self.send_header('Content-type','application/iso')  
                self.end_headers()
                
                buffersize = 4*1024*1024
                while True:
                  buff = f.read(buffersize)
                  self.wfile.write(buff)
                  if len(buff) != buffersize:
                    break;

                f.close()
                return
                
        except IOError:
            print "curdir is %s" %(curdir)
            print "sep is %s" %(sep)
            print "self.path is %s" %(self.path)
            self.send_error(404,'File Not Found: %s' % self.path)
     
  # handle POST request
#    def do_POST(self):
#        try:
#            ctype, pdict = cgi.parse_header(self.headers.getheader('content-type'))
#            if ctype == 'multipart/form-data':
#                query=cgi.parse_multipart(self.rfile, pdict)
#            self.send_response(301)
#            
#            self.end_headers()
#            upfilecontent = query.get('upfile')
#            print "filecontent", upfilecontent[0]
#            self.wfile.write("<HTML>POST OK.<BR><BR>");
#            self.wfile.write(upfilecontent[0]);
#            
#        except :
#            pass

def main():
    try:
        server = HTTPServer(('', 80), MyHandler)
        print 'started httpserver...'
        server.serve_forever()
    except KeyboardInterrupt:
        print '^C received, shutting down server'
        server.socket.close()

if __name__ == '__main__':
    main()

