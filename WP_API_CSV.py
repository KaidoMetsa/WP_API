import requests
import csv


url = "https://kmetsa.webhosting.tptlive.ee/KMWP/wp-json/wp/v2/posts"


username = ""
password = ""


with open('MyData.csv', newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    
    
    for row in reader:
        
        post = {
            "title": row['post_title'],
            "content": row['post_content'],
            "categories": [int(row['post_category'])],
            "status": "publish"  
        }
        
        response = requests.post(url, auth=(username, password), json=post)
        
        
        if response.status_code == 201:
            print("Post created successfully!")
        else:
            print("Error creating post: ", response.content)
