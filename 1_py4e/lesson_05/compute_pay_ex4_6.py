# this program prompts the user to enter hours and payrate [$/hour] to compute gross pay

hours = input('how many hours did you work?\n')
rate = input('what is your payrate? \n')


#ERROR CHECKING FOR INPUTS
############################################################################
try:
    hours = float(hours)
    rate = float(rate)
except:
    print('error: inputs must only contain numbers')
    quit()

if hours < 0 or rate < 0:
    print('error: inputs must be positive numbers')
    quit()
############################################################################


#FUNCTION
############################################################################
def computepay(h, r):
    if h > 40 :
        grossPay = (h-40)*(r)*1.5 + 40*r
    else :  
        grossPay = h * r

    return grossPay
############################################################################


pay = computepay(hours, rate)

print("Pay", pay)