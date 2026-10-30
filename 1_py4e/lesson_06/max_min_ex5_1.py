# this program prompts user for integer numbers until they enter num and outputs the min and max of those inputs

largest = None
smallest = None
while True:
    num = input("Enter a number: ")

    if num != "done" :
        try :
            num = int(num)
        except : 
            print("Invalid Input")
            continue


    if num == "done":
        break

    if largest is None :
        largest = num 
    elif largest < num :
        largest = num

    if smallest is None : 
        smallest = num
    elif smallest > num :
        smallest = num


print("Maximum is", largest)
print("Minimum is", smallest)