#!/bin/bash Mida ma tööle ei saanudki


URL="https://kmetsa.webhosting.tptlive.ee/KMWP/wp-json/wp/v2/posts"


USERNAME=""
PASSWORD=""


while IFS=, read -r post_title post_content post_category
do

    post='{"title": "'"$post_title"'", "content": "'"$post_content"'", "categories": ['"$post_category"']}'
    response=$(curl --silent --user $USERNAME:$PASSWORD --header 'Content-Type: application/json' --request POST --data "$post" $URL)

    if [[ "$response" == *"\"created\":true"* ]]; then
        echo "Post created successfully!"
    else
        echo "Error creating post: $response"
    fi
done < MyData.csv
