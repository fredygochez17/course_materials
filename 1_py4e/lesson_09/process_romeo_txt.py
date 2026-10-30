fname = input("Enter file name: ")
fh = open(fname)

lst = list()
for line in fh:
    line = line.rstrip()
    word_list = line.split()
    for word in word_list:
        if word not in lst:
            lst.append(word)
            
lst.sort()
print(lst)