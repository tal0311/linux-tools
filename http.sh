#!/bin/bash

# Function to perform a curl GET request and write the output to a file
curl_get() {
  URL=$1
  OUTPUT_FILE=$2

  if [[ -z "$URL" ]]; then
    echo "Error: No URL provided."
    echo "Usage: $0 --get <URL> [output_file]"
    exit 1
  fi

  if [[ -z "$OUTPUT_FILE" ]]; then
    curl -X GET "$URL"
  else
    curl -X GET "$URL" -o "$OUTPUT_FILE"
  fi
}

# Function to perform a curl POST request with application/json content type
curl_post() {
  URL=$1
  JSON_DATA=$2
  OUTPUT_FILE=$3

  if [[ -z "$URL" || -z "$JSON_DATA" ]]; then
    echo "Error: No URL or JSON data provided."
    echo "Usage: $0 --post <URL> '<json_data>' [output_file]"
    exit 1
  fi

  if [[ -z "$OUTPUT_FILE" ]]; then
    curl -X POST -H "Content-Type: application/json" -d "$JSON_DATA" "$URL"
  else
    curl -X POST -H "Content-Type: application/json" -d "$JSON_DATA" "$URL" -o "$OUTPUT_FILE"
  fi
}

# Function to perform a curl DELETE request with optional parameters
curl_delete() {
  URL=$1
  PARAMETERS=$2
  OUTPUT_FILE=$3

  if [[ -z "$URL" ]]; then
    echo "Error: No URL provided."
    echo "Usage: $0 --delete <URL> [parameters] [output_file]"
    exit 1
  fi

  if [[ -z "$OUTPUT_FILE" ]]; then
    curl -X DELETE "$URL" $PARAMETERS
  else
    curl -X DELETE "$URL" $PARAMETERS -o "$OUTPUT_FILE"
  fi
}

# Main script logic
case "$1" in
  --get)
    curl_get "$2" "$3"
    ;;
  --post)
    curl_post "$2" "$3" "$4"
    ;;
  --delete)
    curl_delete "$2" "$3" "$4"
    ;;
  *)
    echo "Usage: $0 --get <URL> [output_file]"
    echo "       $0 --post <URL> '<json_data>' [output_file]"
    echo "       $0 --delete <URL> [parameters] [output_file]"
    exit 1
    ;;
esac
