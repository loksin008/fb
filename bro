#!/bin/bash

# Default homepage
HOMEPAGE="https://www.example.com"

# Detect available text browser
if command -v w3m &> /dev/null; then
    BROWSER="w3m"
elif command -v lynx &> /dev/null; then
    BROWSER="lynx"
elif command -v links &> /dev/null; then
    BROWSER="links"
else
    echo "Error: No text-based browser (w3m, lynx, or links) found."
    exit 1
fi

# Function to display help
display_help() {
    echo "Usage: $0 [option] [url]"
    echo "Options:"
    echo "  -u <url>    Open a specific URL"
    echo "  -h          Display this help message"
    echo "  -m          Open the homepage ($HOMEPAGE)"
    echo "  -r          Reload the last opened URL"
}

# Variables
url=""
reload="false"

# Parse command-line options
while getopts ":u:hmr" opt; do
    case ${opt} in
        u ) # Open a specific URL
            url="$OPTARG"
            ;;
        h ) # Display help
            display_help
            exit 0
            ;;
        m ) # Open homepage
            url="$HOMEPAGE"
            ;;
        r ) # Reload
            reload="true"
            ;;
        \? ) # Invalid option
            echo "Invalid option: -$OPTARG" >&2
            display_help
            exit 1
            ;;
        : ) # Missing argument
            echo "Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
    esac
done

# Save last opened URL
LAST_URL_FILE="$HOME/.bash_browser_last_url"

# Determine which URL to open
if [ -z "$url" ]; then
    # If reload flag is set, load the last opened URL
    if [ "$reload" = "true" ]; then
        if [ -f "$LAST_URL_FILE" ]; then
            url=$(cat "$LAST_URL_FILE")
        else
            echo "No previously loaded URL found."
            exit 1
        fi
    else
        # Default to homepage if no URL is specified
        url="$HOMEPAGE"
    fi
fi

# Save the URL to the last opened file
echo "$url" > "$LAST_URL_FILE"

# Open the URL with the chosen browser
echo "Opening $url with $BROWSER..."
$BROWSER "$url"
