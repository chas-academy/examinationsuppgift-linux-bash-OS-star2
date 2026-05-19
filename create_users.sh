#!/bin/bash

#kontrollera att det är root som kör scriptet
if [ "$EUID" -ne 0 ]; then
    echo "Error: Run as root!"
    exit 1
fi

#Skapa for loop för användare
for user in "$@"; do
    #Skapa en ny användare
    useradd -m -s /bin/bash "$user"

    #Skapa katalogstruktur
    mkdir -p "/home/$user/documents"
    mkdir -p "/home/$user/downloads"
    mkdir -p "/home/$user/work"

    #Ge rättigheter 
    chmod 700 "/home/$user/documents"
    chmod 700 "/home/$user/downloads"
    chmod 700 "/home/$user/work"

    #Skapa välkomstmeddelande
    echo "Välkommen $user" > "/home/$user/welcome.txt"

    #Skriva i alla användare till welcome.txt
    cut -d: -f1 /etc/passwd >> "/home/$user/welcome.txt"

    #Kontrollera att ny användare äger de skapade filarna
    chown -R "$user:$user" "/home/$user"
    
done

    
