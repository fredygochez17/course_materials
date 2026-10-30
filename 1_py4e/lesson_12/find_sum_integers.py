# import regular expression library
import re

# open file
file = open("regex_sum_2412753.txt")
num_list = list()

# iterate through each line
count = 0
for line in file:
    line = line.rstrip() # remove new line character at end of line
    
    # extract the number string(s)
    num_list_line = re.findall('[0-9]+', line)
    
    # check for empty string
    if len(num_list_line) < 1: continue
    
    # convert each number string to integer and append it to number list
    for num in num_list_line:
        num_list.append(int(num))
    
    
# sum integers & print result
print(sum(num_list))