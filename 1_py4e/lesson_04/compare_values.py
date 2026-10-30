# this python script asks for two numbers as inputs from the user.
# this script lets the user know which input is larger or if equal


# prompt user to input two numbers
num1 = input('input first value:\t')
num2 = input('input second value:\t')

try:
    # convert to floating point type
    num1 = float(num1)
    num2 = float(num2)
except:
    # output error if user does not input a numeric value
    print('ERROR: please input a numeric value')
    quit()

# compare values
if num1 > num2:
    print('the first value is greater')
elif num2 > num1:
    print('the second value is greater')
else:
    print('the values are equal')
