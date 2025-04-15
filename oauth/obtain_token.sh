#!/usr/bin/env bash

# Function to decode a JWT payload
decode_jwt_payload() {
  local token="$1"
  local encoded_payload=$(echo "$token" | cut -d'.' -f2 | tr -d '\r\n' | sed 's/_/-/g; s/\+/\//g')

  # Add padding if necessary
  while [[ $((${#encoded_payload} % 4)) -ne 0 ]]; do
    encoded_payload+="="
  done

  # Decode the payload
  local decoded_payload=$(echo "$encoded_payload" | base64 --decode)
  echo "$decoded_payload"
}

# Function to check if a JWT needs renewal
check_jwt_renewal() {
  local token="$1"
  local grace_period_seconds="${2:-300}" # Default grace period of 5 minutes

  # Extract the expiration time from the decoded payload
  local decoded_payload=$(decode_jwt_payload "$token")
  local expiration_time=$(echo "$decoded_payload" | jq -r '.exp')

  # Check if 'exp' claim exists
  if [[ -z "$expiration_time" ]]; then
    echo "Error: 'exp' claim not found in JWT payload."
    return 1
  fi

  # Get current time in seconds since epoch
  local current_time=$(date +%s)

  # Calculate the time until expiration
  local time_until_expiration=$((expiration_time - current_time))

  # Check if the token is expired or within the grace period
  if [[ "$time_until_expiration" -gt "$grace_period_seconds" ]]; then
    echo "Token is valid for renewal. Time until expiration: $time_until_expiration seconds."
    source ./obtain_token.sh
    return 0
  elif [[ "$time_until_expiration" -gt 0 ]]; then
     echo "Token is within grace period. Time until expiration: $time_until_expiration seconds."
     return 1
  else
    echo "Token has expired."
    return 2
  fi
}

# Check JWT renewal status - Token and grace in seconds
check_jwt_renewal "$TOKEN" 3600