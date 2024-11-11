#!/bin/bash

# Check if a URL is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <url>"
  exit 1
fi

# Fetch and strip HTML tags to get plain text
url=$1
echo "Fetching and converting content from $url..."
curl -s "$url" | sed 's/<[^>]*>//g'
