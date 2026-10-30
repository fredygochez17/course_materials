# Lesson 12 - Ch 11: Regular Expressions

# write "import re" at the top of script to use regular expressions. 
# Ex line of code: if re.search('^From:', line) :

import re

random_string = 'My 3 favorite numbers are 7, 17, and -3.'
numbers = re.findall('[0-9]+', random_string)
print(numbers)

lin = 'From stephen.marquard@uct.ac.za Sat Jan  5 09:14:16 2008'
y = re.findall('@([^ ]*)', lin)
print(y)

print(int('1') + int('1'))