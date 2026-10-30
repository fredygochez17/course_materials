#this program finds the smallest number in a list

smallest_num = None
print(smallest_num)
num_list = [66, 20, 62, 72, 64, 65, 44, 27, 86, 72, 10, 73, 89, 4, 11, 2]

for num in num_list :
    if smallest_num is None :
        smallest_num = num
        print(smallest_num)
    elif smallest_num > num :
        smallest_num = num
        print(smallest_num)