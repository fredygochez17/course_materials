

y = (7, 4, 8)
print(y)        #prints (7, 4, 8)
print(y[1])

# Tuples are like non-modifiable lists
# y[2] = 6    # traceback error
# print(y)


(x, y) = (3, 'fred')
print(x)
print(y)

d = dict()
d['csev'] = 2
d['cwen'] = 4
print(d)
for(k,v) in d.items():
    print(k,v)
    
tups = d.items()
print(tups)


# sort  a dictionary
d = {'a':10, 'c':22, 'b':1}
print('unsorted:', d)

t = sorted(d.items())
print('sorted:', t)

for k,v in sorted(d.items()):
    print(k,v)
print()

for k,v in t:
    print(k,v)

# take a dictionary and sort them in decending order by value
c = {'a':10, 'b':1, 'c':22} #dictionary
print(sorted([(v,k) for k,v in c.items()], reverse=True))
