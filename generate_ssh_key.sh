#!/bin/bash

check_and_set_keys_location() {
    ssh_key_dir="SSHKEY"
    if [ "$CURRENT_LOCATION" != "$EXPECTED_LOC" ]; then
        #following: read only 1 character
        read -r -n 1 -p "Switch to expected $EXPECTED_LOC :[Y|n]?" SHOULD_SWITCH

        if [ -z "$SHOULD_SWITCH" ] || [ "$SHOULD_SWITCH" = "y" ] || [ "$SHOULD_SWITCH" = "Y" ]; then
            cd "$EXPECTED_LOC" || echo "Unable to change directory"
            echo -e "\nCurrently in : $PWD"
        else
            echo -e "\nGenerating in current folder: $PWD"
            mkdir -p "$PWD"/"$ssh_key_dir"
            cd "$ssh_key_dir" || echo "Unable to change directory"
        fi
    fi
}

generate_key_ed25519() {
    echo -E "Proceeding to generate key ...."
    read -rp "Enter the desired file name without any extension " FILE_NAME
    echo "Confirming the file name is: $FILE_NAME"
    read -rp "Enter the comment [email address|identifying host] " COMMENT
    read -rs -p "Enter the desired password: " PASSWORD
    echo "Generating the key [default cipher ed25519].."
    ssh-keygen -t ed25519 -N "$PASSWORD" -C "$COMMENT" -f "$FILE_NAME"
}

main() {
    echo "Welcome to ssh-key generation"

    CURRENT_LOCATION=$PWD
    echo "You are currently in: $CURRENT_LOCATION"

    EXPECTED_LOC=$HOME/.ssh
    echo "Default Location of keys: $EXPECTED_LOC"
    check_and_set_keys_location
    generate_key_ed25519
}

# entry point to  script
main
