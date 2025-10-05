#!/bin/bash

while true; do

    optiune=$(whiptail --title "MAIL" --menu "Selecteaza o optiune:" 20 60 10 \
    "1" "Trimite Mail" \
    "2" "Editeaza Mail" \
    "0" "Iesire" 3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ $exitstatus -ne 0 ]; then
        source ./main.sh
    fi

    case "$optiune" in
        "1")
            python ./sendMail.py
            if [ $? -eq 0 ]; then 
		whiptail --msgbox "Newsletter-ul a fost trimis cu succes!" 10 50
	    else
		whiptail --msgbox "Eroare la trimitere!" 10 50
            fi
	    source ./newsletter.sh
            ;;
        "2")
            pico ./message.txt
            source ./newsletter.sh
            ;;
        "0")
	    source ./main.sh
	    ;;
        *)
            whiptail --msgbox "Optiune invalida!" 10 50
            ;;
    esac
done
