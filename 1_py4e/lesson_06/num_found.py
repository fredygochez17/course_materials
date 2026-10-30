# this program let's you know if the number you asked for exists in the array

num = 2
isFound = False
count = 0
num_list = [66, 20, 62, 72, 2, 64, 65, 44, 27, 86, 2, 72]

for num_list in num_list:
    if num_list == num :
        num = num_list
        isFound = True
        count = count + 1


print(isFound, count)
    