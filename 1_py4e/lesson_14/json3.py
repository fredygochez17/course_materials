import urllib.request
import json

url = input('Enter location: ')
if len(url) < 1 : 
    url = 'http://py4e-data.dr-chuck.net/comments_42.json'

print('Retrieving', url)
uh = urllib.request.urlopen(url)    # handle of OPENED URL
data = uh.read()                    # read string from handle into data object
print('Retrieved',len(data),'characters')

data = json.loads(data)
counts = list()


for item in data['comments']:
    counts.append(item['count']) 

print('Count:', len(data['comments']))  
print('Sum:', sum(counts))    