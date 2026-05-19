#!/bin/bash

#kontrollera att det är root som kör scriptet
if [ "$EUID" -ne 0 ]; then
    echo "Error: Must be run as root!"
    exit 1
fi

#Skapa for loop för användare
for user in "$@"; do
    #Skapa en ny användare
    useradd -m "$user"

    #Skapa mappar
    mkdir -p "/home/$user/Documents"
    mkdir -p "/home/$user/Downloads"
    mkdir -p "/home/$user/Work"

    #Ge rättigheter 
    chmod 700 "/home/$user/Documents"
    chmod 700 "/home/$user/Downloads"
    chmod 700 "/home/$user/Work"

    #Skapa välkomstmeddelande
    echo "Välkommen $user" > "/home/$user/welcome.txt"

    #Skriva i alla användare till welcome.txt
    cut -d: -f1 /etc/passwd | grep -v "^$user$" >> "/home/$user/welcome.txt"

    #Kontrollera att ny användare äger de skapade filarna
    chown -R "$user:$user" "/home/$user"
    
done

    
