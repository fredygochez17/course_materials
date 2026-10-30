# this program computes the average confidence of text files

# Use the file name mbox-short.txt as the file name
fname = input("Enter file name: ")

try :
    fh = open(fname)
except : 
    print("Error: file not found")
    quit()

count = 0
spam_conf = 0
for line in fh:
    if line.startswith("X-DSPAM-Confidence:"):
        line = line.rstrip()
        index = line.find(' ')
        conf_value = line[index + 1: ]
        conf_value = float(conf_value)
        spam_conf = conf_value + spam_conf
        count = count + 1
        # print(line)
        # print(conf_value)
        # print(sum_spam_conf)
        # break

avg_spam_conf = spam_conf / count
print("Average spam confidence:", avg_spam_conf)