# Code: https://www.py4e.com/code3/xml2.py

import xml.etree.ElementTree as ET

input = '''
<stuff>
  <users>
    <user x="2">
      <id>001</id>
      <name>Chuck</name>
    </user>
    <user x="7">
      <id>009</id>
      <name>Brent</name>
    </user>
  </users>
</stuff>'''

data = ET.fromstring(input)

lst = data.findall('users/user') # find every "user" in "users"
print('User count:', len(lst))
print(lst)
print()

lst2 = data.find('users/user')
print('List 2 User Count:', len(lst2))
print(lst2)
print()

for item in lst:
    print('Name', item.find('name').text)
    print('Id', item.find('id').text)
    print('Attribute', item.get('x'))