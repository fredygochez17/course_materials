text = "X-DSPAM-Confidence:    0.8475"
i_whitespace = text.find(' ') #find the first instance of white space
num_text = text[i_whitespace:len(text)]
num_text = num_text.strip() # strip away whitespace
num_text = float(num_text)  # convert number string to float
print(num_text)
#print(text.upper())