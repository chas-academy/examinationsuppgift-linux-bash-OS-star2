#!/bin/bash

#kontrollera att det är root som kör scriptet
if [ "$UID" -ne 0 ]; then
    echo "Error! Run as root!"
    exit
fi

#Skapa for loop för användare
for user in "$@"; do
    #Skapa en ny användare
    useradd -m "$user"

    #Skapa katalogstruktur
    mkdir /home/$user/Documents
    mkdir /home/$user/Downloads
    mkdir /home/$user/Work

    #Ge rättigheter 
    chmod 700 /home/$user/Documents 
    chmod 700 /home/$user/Downloads
    chmod 700 /home/$user/Work

    #Skapa välkomstmeddelande
    echo "Välkommen $user!" > /home/$user/welcome.txt

    #Skriva i alla användare till welcome.txt
    cut -d: -f1 /etc/passwd >> /home/$user/welcome.txt

    #Kontrollera att ny användare äger de skapade filarna
    chown -R $user:$user /home/$user

done

    
