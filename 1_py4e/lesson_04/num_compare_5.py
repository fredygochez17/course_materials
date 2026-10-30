userInput = float(input("enter a number between 1 & 10:\n"))
compareVal = 5
if userInput < compareVal :
    print(userInput, "is less than", compareVal)
elif userInput > compareVal :
    print(userInput, "is greater than", compareVal)
else :
    print(userInput, "is the same as", userInput)