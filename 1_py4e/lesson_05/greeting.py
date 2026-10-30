# this program aks user what language they speak and returns a greeting in their language. 

language = input('what language do you speak?\n')

def greet(language):
    if language == 'spanish':
        return 'hola'
    elif language == 'french':
        return 'bonjour'
    else :
        return 'hello'
    
greeting = greet(language)
print(greeting)