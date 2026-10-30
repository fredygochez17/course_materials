


# check for correct file path to run on console and debugger
try:
    file_handle = open("lesson_10/mbox-short.txt")
except:
    file_handle = open("mbox-short.txt")

# create a dictionary, key pairs: email, number of times email appears in "From" line
email_counts = dict()

# loop through each line of the file and build dictionary
for line in file_handle:
    line_list = line.split()
    #check for empty lines
    if len(line_list) < 1:
        continue
    
    #check for lines that start with 'From'
    if line_list[0] == 'From':
        # if the email is not a key word yet, add the key word, make it's value 0, and add 1 to the value
        # otherwise, just add 1 to the value
        email_counts[line_list[1]] = email_counts.get(line_list[1], 0) + 1

max_count       = None
max_count_email = None   
for email,count in email_counts.items():
    if max_count_email is None or count > max_count:
        max_count_email = email
        max_count       = count
        
print(max_count_email, max_count)