fname = ""
if len(fname) < 1:
    fname = "mbox-short.txt"

fh = open(fname)
count = 0
for line in fh:

    line_list = line.split()
    
    # Guarding for edge cases
    if len(line_list) < 3 or line_list[0] != "From":
        continue
    print(line_list[1])
    
    count = count + 1

print("There were", count, "lines in the file with From as the first word")
