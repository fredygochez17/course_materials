

# import bs4 libraries
from bs4 import BeautifulSoup

# write and html string
html = "<html><body><h1>Visca Barca</h1></body></html>"

# use bs4 method to parse through
soup = BeautifulSoup(html, "html.parser")

# print text
print(soup.h1.text)