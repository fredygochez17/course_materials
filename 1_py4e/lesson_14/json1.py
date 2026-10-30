import json
data = '''
{
    "users": 
    [
        {
            "status": 
            {
                "text": "@jazzychad I just bought one .__."
            },
            "location": "San Francisco, California",
            "screen_name": "leahculver",
            "name": "Leah Culver"
        },
        {
            "status": 
            {
                "text": "@jazzychad wassup .__."
            },
            "location": "Los Angeles, California",
            "screen_name": "fredygochez",
            "name": "Fredy Gochez"
        }  
    ]
}'''

info = json.loads(data)
print(info['users'][1]['name'])
print(info['users'][1]['status']['text'])


