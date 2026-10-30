
# this python scripts returns all the hyperlinks on a webpage
# note: for some sites you may need to ignore SSL certificate errors

# import libraries
import urllib.request, urllib.parse, urllib.error
from bs4 import BeautifulSoup

# ask for a URL
url = input('Enter - ')

# open URL & read the whole thing
html = urllib.request.urlopen(url).read() # returns HTML byte array
#print('\nhtml:\n', html)

# bs4 takes html object and gives back a 'soup' object that is 'usable'
soup = BeautifulSoup(html, 'html.parser') 
#print('\n\nsoup:\n', soup)
print('\n')

# Retrieve all of the HTML anchor tags
tags = soup('a')
for tag in tags:
    # retrieve the href attribute
    print(tag.get('href', None))