# playground to practice and conceptualize the use of DICTIONARIES in PYTHON





####################################################

# goals = dict()

# goals["Lewandowski"]    = 50
# goals["Lamine"]         = 18
# goals["Raphinha"]       = 23
# goals["Ferran"]         = 12

# goals["Lamine"] = goals["Lamine"] + 3

# print("Pedri" in goals)

#################################################### 


# word_counts = dict()
# words = ['the', 'is', 'you', 'you', 'the', 'the', 'is', 'went', 'turn', 'is', 'the', 'you']

# # put word list into a dictionary with word,count pairs
# for word in words:
#     word_counts[word] = word_counts.get(word, 0) + 1
    
# # loop through dictionary to process
# count_max  = None
# count_word = None    
# for word_key,word_value in word_counts.items():
#     if count_max is None or word_value > count_max:
#         count_max = word_value
#         count_word = word_key
#     print(word_key, "\t", word_value)

# print()
# print("The word with the highest count was:", count_word)
# print("It appeared a total of", count_max, "times.")

# print()
# print(word_counts.items())

player_dict = dict()

player_dict['pedri'] = 0
player_dict['raphinha'] = 13
print(player_dict)