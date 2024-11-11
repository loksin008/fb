#!/bin/bash

# Check if a URL is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <url>"
  exit 1
fi

# Fetch the content of the URL
url=$1
echo "Fetching content from $url..."
curl -s "$url" | html2text
