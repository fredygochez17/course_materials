# this program prompts the user for hours and payrate to compute gross pay
payRate = float(input("Input your payrate (dollars per hour):\t"))                  # [$/hour]
hours = float(input("Input the hours you have worked:\t"))                          # [hour]
grossPay = hours * payRate
print("Gross Payout:", grossPay, "dollars")                                         # [$]