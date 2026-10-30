# this program outputs a grade based on score input
# score range must be between 0.0 an 1.0
# if score is out of range it prints an error
score = float(input("Enter score:\n"))
print(score)
if score > 1.0 :
    print('Error: input of out range')
elif score >= 0.9 :
    print('A')
elif score >= 0.8 :
    print('B')
elif score >= 0.7 :
    print('C')
elif score >= 0.6 :
    print('D')
elif score < 0.6 and score > 0.0: 
    print('F')
elif score < 0.0 :
    print("Error: input is out of Range")