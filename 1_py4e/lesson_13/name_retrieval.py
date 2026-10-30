# this program retrieves a name by following links on a webpage 

import urllib.request, urllib.parse, urllib.error
from bs4 import BeautifulSoup
import ssl # defaults to certificate verification and most secure protocol (now TLS)

# Ignore SSL/TLS certificate errors
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

# prompt user for inputs
url = input('Enter URL: ')
count_input = int(input('Enter Count: '))
pos_input   = int(input('Enter Position: '))


html = urllib.request.urlopen(url, context=ctx).read()
soup = BeautifulSoup(html, 'html.parser')

# Retrieve all of the anchor tags
tags = soup('a')
print('Retrieving: ', url)
print('Retrieving: ', tags[pos_input - 1].get('href', None))


count = 0
while count < count_input - 1 :
    url = tags[pos_input - 1].get('href', None)
    html = urllib.request.urlopen(url, context=ctx).read()
    soup = BeautifulSoup(html, 'html.parser')
    tags = soup('a')
    print('Retrieving: ', tags[pos_input - 1].get('href', None))
    count += 1