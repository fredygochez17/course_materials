import sqlite3

#open sqlite and create data base file
conn = sqlite3.connect('domain_db.sqlite')
cur = conn.cursor()

# if a table named 'Counts' already exists, delete it
cur.execute('DROP TABLE IF EXISTS Counts')

# create a table named 'Counts' in domain_db.sqlite
cur.execute('''
CREATE TABLE Counts (org TEXT, count INTEGER)''')

# have user input name of a text file containing email history
fname = input('Enter file name: ')
if (len(fname) < 1): fname = 'mbox-short.txt'   #default file to read

# loop though each line of text file
fh = open(fname)
for line in fh:
    # only lines that start with "From:"
    if not line.startswith('From: '): continue
    
    # retrieve domain from the current line
    line = line.strip()
    pieces = line.split('@')
    domain = pieces[1]
    
    # Count the number of times the domain has appeared through the email history
    
    #select row with the current domain
    cur.execute('SELECT count FROM Counts WHERE org = ? ', (domain,))  
    row = cur.fetchone()    #grab the first item
    
    # if row does not exist yet, add a row and set the domain count to 1
    if row is None:
        cur.execute('INSERT INTO Counts (org, count) VALUES (?, 1)', (domain,))
        
    # if row does exist, increase the count for that domain by 1
    else:
        cur.execute('UPDATE Counts SET count = count + 1 WHERE org = ?', (domain,))
        
conn.commit()
    
# print out the first 10 rows of Counts table in descending order
sqlstr = 'SELECT org, count FROM Counts ORDER BY count DESC LIMIT 10'
for row in cur.execute(sqlstr):
    print(str(row[0]), row[1])

cur.close()