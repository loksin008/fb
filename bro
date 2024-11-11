#!/bin/bash

# Check if a URL is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <url>"
  exit 1
fi

# Fetch and display the content of the URL using lynx
url=$1
echo "Fetching content from $url..."
lynx -dump "$url"
