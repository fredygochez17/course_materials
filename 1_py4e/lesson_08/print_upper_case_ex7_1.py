# this program prints the contents of a text file in UPPER CASE


# promopt user to enter file name
file_name = input('Enter a file name: ')

# create file handle
try:
    fhand = open(file_name)
except:
    print('Error: file not found')
    quit()
# print(fhand)

count = 1
for line in fhand :
    line = line.rstrip()
    line = line.upper()
    print(line)
    
    count = count + 1
    if count > 5 :
        break
