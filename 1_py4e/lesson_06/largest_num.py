# this program finds the largest number in the array

num = -1
num_list = [66, 20, 62, 72, 64, 65, 44, 27, 86]
biggest_num = max(num_list)
for num_list in num_list:
    if num_list > num :
        num = num_list
    
print(num)
print(biggest_num)