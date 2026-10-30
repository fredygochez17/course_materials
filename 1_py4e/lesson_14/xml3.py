import urllib.request
import xml.etree.ElementTree as ET

url = input('Enter location: ')
if len(url) < 1 : 
    url = 'http://py4e-data.dr-chuck.net/comments_42.xml'

print('Retrieving', url)
uh = urllib.request.urlopen(url)    # handle of OPENED URL
data = uh.read()                    # read string from handle into data object
print('Retrieved',len(data),'characters')
tree = ET.fromstring(data)          # parse string from data object into a tree object

counts = tree.findall('.//count')
nums = list()
for result in counts:
    # Debug print the data :)
    nums.append(int(result.text))
    # print(result.text)

print('Count:', len(nums))
print('Sum:', sum(nums))
