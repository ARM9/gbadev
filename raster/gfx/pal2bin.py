#!/usr/bin/python
# Convert CSV 24bit RGB palette to GBA palette
# Format:
#255,0,0    
#0,255,0
#0,0,255
import sys
import io
import struct

def Usage():
    print "python pal2bin.py file1 file2 ..."

def main(argv):
    if len(argv) < 1:
        Usage()
        return
    
    for file in argv:
        #filename = file.rsplit('.', 1)[0].rsplit('/', 1)[-1]
        with open(file.rsplit('.', 1)[0] + '.pal.bin', 'wb') as ofile:
            with open(file, 'r') as f:
                for line in f:
                    r, g, b = line.split(',')
                    #print r + ' ' + g + ' ' + b
                    color = ((int(b)/8) << 10) | ((int(g)/8) << 5) | (int(r)/8)
                    #print hex(color)
                    ofile.write(struct.pack('<h', color))

if __name__=='__main__':
    main(sys.argv[1:])

