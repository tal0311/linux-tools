#!/bin/bash

# Function to generate a random key
generate_random_key() {
    local keyfile=$1
    openssl rand -hex 32 > "$keyfile.key"
    echo "Random key generated and saved to: $keyfile.key"
}

# Function to encrypt a file
encrypt_file() {
    local inputfile=$1
    local outputfile=$2
    local passwordfile=$3
    openssl enc -aes-256-ecb -salt -pbkdf2 -in "$inputfile" -out "$outputfile" -pass file:"$passwordfile"
    echo "File encrypted successfully: $outputfile"
}

# Function to decrypt a file
decrypt_file() {
    local inputfile=$1
    local outputfile=$2
    local passwordfile=$3
    openssl enc -aes-256-ecb -d -pbkdf2 -in "$inputfile" -out "$outputfile" -pass file:"$passwordfile"
    echo "File decrypted successfully: $outputfile"
}

# Main script logic
echo "Choose an option:"
echo "1. Encrypt a file"
echo "2. Decrypt a file"
echo "3. Generate a random key"
read -p "Enter your choice (1, 2, or 3): " choice

case $choice in
    1)
        read -p "Enter the input file to encrypt: " inputfile
        read -p "Enter the output encrypted file: " outputfile
        read -p "Enter the password file: " passwordfile
        encrypt_file "$inputfile" "$outputfile" "$passwordfile"
        ;;
    2)
        read -p "Enter the input file to decrypt: " inputfile
        read -p "Enter the output decrypted file: " outputfile
        read -p "Enter the password file: " passwordfile
        decrypt_file "$inputfile" "$outputfile" "$passwordfile"
        ;;
    3)
        read -p "Enter the file to save the random key: " keyfile
        generate_random_key "$keyfile"
        ;;
    *)
        echo "Invalid choice. Please run the script again and select either 1, 2, or 3."
        ;;
esac
