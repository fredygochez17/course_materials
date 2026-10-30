# this script finds the <span> tags in html file, pulls the numbers and sums them

from urllib.request import urlopen
from bs4 import BeautifulSoup
import ssl

# Ignore SSL certificate errors
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = input('Enter - ')
html = urlopen(url, context=ctx).read()     # "context = ctx" : important for ignoring SSL certificate errors
soup = BeautifulSoup(html, "html.parser")

# Retrieve all of the anchor tags
tags = soup('span')
nums = list()
for tag in tags:
    # Look at the parts of a tag
    #print('TAG:', tag)
    #print('URL:', tag.get('href', None))
    #print('Attrs:', tag.attrs)
    
    nums.append(int(tag.contents[0]))
    #print('Contents:', tag.contents[0])
    
print('Sum', sum(nums))