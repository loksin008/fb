#!/bin/bash

# Default homepage
HOMEPAGE="https://www.wikipedia.org"

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

# Initialize URL history array
declare -a URL_HISTORY=()
CURRENT_URL=$HOMEPAGE

# Function to display help
display_help() {
    echo "Commands:"
    echo "  [o]pen <url>   - Enter a new URL to visit"
    echo "  [h]ome         - Go to the homepage"
    echo "  [b]ack         - Go back to the previous page"
    echo "  [r]eload       - Reload the current page"
    echo "  [e]xit         - Exit the browser"
    echo "  [help]         - Show this help message"
}

# Main browser loop
while true; do
    # Save the current URL to the history file
    echo "$CURRENT_URL" > "$HOME/.bash_browser_last_url"
    URL_HISTORY+=("$CURRENT_URL")

    # Open the URL with the chosen browser
    echo "Opening $CURRENT_URL with $BROWSER..."
    $BROWSER "$CURRENT_URL"

    # Prompt user for next action
    echo
    echo "Enter a command ([h]ome, [o]pen <url>, [b]ack, [r]eload, [e]xit, [help]): "
    read -r command args

    case $command in
        # Open a new URL
        o|open)
            if [ -z "$args" ]; then
                echo "Please provide a URL to open."
            else
                CURRENT_URL="$args"
            fi
            ;;
        
        # Go to the homepage
        h|home)
            CURRENT_URL=$HOMEPAGE
            ;;

        # Go back to the previous page
        b|back)
            if [ ${#URL_HISTORY[@]} -gt 1 ]; then
                unset 'URL_HISTORY[-1]'  # Remove the current page from history
                CURRENT_URL="${URL_HISTORY[-1]}"  # Go to the last URL in history
                unset 'URL_HISTORY[-1]'  # Remove the "back" page to avoid revisiting
            else
                echo "No previous page in history."
            fi
            ;;

        # Reload the current page
        r|reload)
            # Do nothing, CURRENT_URL remains the same
            ;;
        
        # Exit the browser
        e|exit)
            echo "Exiting the browser."
            break
            ;;
        
        # Display help
        help)
            display_help
            ;;

        # Unrecognized command
        *)
            echo "Unrecognized command. Type 'help' for a list of commands."
            ;;
    esac
done
