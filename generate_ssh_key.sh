#!/bin/bash

echo "Welcome to ssh-key generation"
CURRENT_LOCATION=$PWD
echo "You are currently in: $CURRENT_LOCATION"
EXPECTED_LOC=$HOME/.ssh
if test "$CURRENT_LOCATION" != "$EXPECTED_LOC"; then
    echo "You need to be in: $EXPECTED_LOC"
    exit
fi

echo "Proceeding further...."
#ssh-keygen -t ed25519 -N "" -C "your_email@example.com" -f n -q
echo "Enter the desired file name without any extension "
read FILE_NAME
echo "Confirming the file name is: $FILE_NAME"
echo "Enter the comment [email address] "
read COMMENT
echo "Enter the desired password: "
read PASSWORD
echo "Generating the key..."
ssh-keygen -q -t ed25519 -N "$PASSWORD" -C "$COMMENT" -f "$FILE_NAME"
