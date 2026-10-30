# this program computes pay and accounts for overtime (hours above 40)

# input hours worked
hours = input('enter hours worked:\n')
# input payrate 
payRate = input('enter pay rate (dollars per hour):\n')

# check for numeric inputs
try:
    hours = float(hours)
    payRate = float(payRate)
except:
    print("error: please enter a numeric value")
    quit()

# determine if overtime was worked and then calculate gross pay
if hours > 40 :
    grossPay = (hours-40)*(payRate)*1.5 + 40*payRate
else :  
    grossPay = hours * payRate

print(grossPay)