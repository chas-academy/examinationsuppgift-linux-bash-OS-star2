#!/bin/bash

#kontrollera att det är root som kör scriptet
if [ "$EUID" -ne 0 ]; then
    echo "Error: Must be run as root!"
    exit 1
fi

#Skapa for loop för användare
for user in "$@"; do
    #Skapa en ny användare
    useradd -m -s /bin/bash "$user" 2>/dev/null

    HOME="/home/$user"
    
    #Skapa katalogstruktur
    mkdir -p "$HOME/Documents"
    mkdir -p "$HOME/Downloads"
    mkdir -p "$HOME/Work"

    #Ge rättigheter 
    chmod 700 "$HOME/Documents"
    chmod 700 "$HOME/Downloads"
    chmod 700 "$HOME/Work"

    #Skapa välkomstmeddelande
    echo "Välkommen $user" > "$HOME/welcome.txt"

    #Skriva i alla användare till welcome.txt
    cut -d: -f1 /etc/passwd >> "$HOME/welcome.txt"

    #Kontrollera att ny användare äger de skapade filarna
    chown -R "$user:$user" "$HOME" 2>dev/null
    
done

    
