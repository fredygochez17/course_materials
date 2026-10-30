import sqlite3

# open sqlite and create data base file
conn = sqlite3.connect('emaildb.sqlite')
cur = conn.cursor()

# if a table named 'Counts' already exists, delete it
cur.execute('DROP TABLE IF EXISTS Counts')

# create a table named 'Counts' in emaildb.sqlite
cur.execute('''
CREATE TABLE Counts (email TEXT, count INTEGER)''')

# have user input name of a text file containing email history
fname = input('Enter file name: ')
if (len(fname) < 1): fname = 'mbox-short.txt'   #default file to read

# loop though each line of text file
fh = open(fname)
for line in fh:
    # only lines that start with "From:"
    if not line.startswith('From: '): continue
    
    # retrieve email from line
    pieces = line.split()
    email = pieces[1]
    
    # count the number of times the email has appeared through the email history
    cur.execute('SELECT count FROM Counts WHERE email = ? ', (email,))  #select row with the current email
    row = cur.fetchone()    #grab the first item
    
    # if row does not exist yet, add a row and set the email count to 1
    if row is None:
        cur.execute('''INSERT INTO Counts (email, count)
                    VALUES (?, 1)''', (email,))
    # if row does exist already, increase the count for that email by 1
    else:
        cur.execute('UPDATE Counts SET count = count + 1 WHERE email = ?',
                    (email,))
    conn.commit()

# https://www.sqlite.org/lang_select.html

# print out the first 10 rows of our table in descending order
sqlstr = 'SELECT email, count FROM Counts ORDER BY count DESC LIMIT 10'
for row in cur.execute(sqlstr):
    print(str(row[0]), row[1])

cur.close()