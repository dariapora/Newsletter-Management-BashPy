#!/bin/bash

text="Made by Yvonne & Daria"

while true; do

    optiune=$(whiptail --title "MENIU PRINCIPAL" --menu "Selecteaza o optiune:" 20 60 10 \
    "1" "Management Abonati" \
    "2" "Trimitere/Editare Mail" \
    "3" "Setari Admin" \
    "0" "Iesire" 3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ $exitstatus -ne 0 ]; then
        clear
        cowthink "$text"
        exit 0
    fi

    case "$optiune" in
        "1")
            source ./abonati.sh
            ;;
        "2")
            source ./newsletter.sh
            ;;
        "3")
            source ./admin.sh
	    ;;
        "0")
            clear
            cowthink "$text"
            exit 0
            ;;
        *)
            whiptail --msgbox "Optiune invalida!" 10 50
            ;;
    esac
done
