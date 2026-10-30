# URL Libs essentially makes URLs function like local files
import urllib.request, urllib.parse, urllib.error

# open a URL, read through and print it
fhand = urllib.request.urlopen('http://data.pr4e.org/romeo.txt')
for line in fhand:
    
    # REMEMEBR: decode has to still be done manually
    print(line.decode().strip()) 

# content = fhand.read().decode()
# print(content)
