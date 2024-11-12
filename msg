#!/bin/bash

# Recipient's phone number and carrier
PHONE_NUMBER="$1"
CARRIER="$2"
MESSAGE="$3"

# Carrier email-to-SMS gateways
declare -A carrier_gateways=(
  ["verizon"]="vtext.com"
  ["att"]="txt.att.net"
  ["tmobile"]="tmomail.net"
  ["sprint"]="messaging.sprintpcs.com"
)

# Check if carrier is supported
if [[ -z "${carrier_gateways[$CARRIER]}" ]]; then
  echo "Unsupported carrier. Supported carriers are: ${!carrier_gateways[@]}"
  exit 1
fi

# Create the email address for the SMS
SMS_EMAIL="$PHONE_NUMBER@${carrier_gateways[$CARRIER]}"

# Send email using `mail` (ensure `mail` is installed on your system)
echo "$MESSAGE" | mail -s "SMS" "$SMS_EMAIL"

echo "Message sent to $PHONE_NUMBER via $CARRIER"
