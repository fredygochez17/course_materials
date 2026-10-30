# this python script asks for two numbers as inputs from the user.
# this script lets the user know which input is larger or if equal


# prompt user to input two numbers
num1 = input('input first value:\t')
num2 = input('input second value:\t')










#####################Functions###########################################
def check_inputs(a,b):
    try:
        # convert to floating point type
        a = float(a)
        b = float(b)
    except:
        # output error if user does not input a numeric value
        print('ERROR: please input a numeric value')
        quit()


def compare_values(value1, value2):
    # compare values
    if value1 > value2:
        print('the first value is greater')
    elif value2 > value1:
        print('the second value is greater')
    else:
        print('the values are equal')

    return
########################################################################














check_inputs(num1,num2)
compare_values(num1, num2)