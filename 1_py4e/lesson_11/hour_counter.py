# open the file
file_handle = open("mbox-short.txt")

# iterate through each line to build dictionary object
tmp_count = 0
hour_stamp_counts = dict()
for line in file_handle: 
    words = line.split()
    
    # find line that starts with 'From'
    if len(words) > 0 and words[0] == 'From':
        
        # extract the hour of the time email was sent
        time_stamp = words[5].split(':')
        hour_stamp = time_stamp[0]
        
        # count the times each hour appears
        hour_stamp_counts[hour_stamp] = hour_stamp_counts.get(hour_stamp, 0) + 1
        



# sort hour stamp count in the dictionary by hour
sorted_hour_counts = sorted(hour_stamp_counts.items())

# print out sorted hour,count pairs
for hour,count in sorted_hour_counts:
    print(hour, count)
    