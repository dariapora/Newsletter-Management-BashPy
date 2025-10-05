#!/bin/bash

key=$(head -n 1 .parola)
parola=$(whiptail --passwordbox "Introdu parola: " 10 40 3>&1 1>&2 2>&3)
while [[ "$parola" != "$key" ]]; do
    whiptail --infobox "Parola gresita." 10 50
    parola=$(whiptail --passwordbox "Introdu parola: " 10 40 3>&1 1>&2 2>&3)
    exitstatus=$?
if [ $exitstatus -ne 0 ]; then
        return 0
fi
done

while true; do
    optiune=$(whiptail --title "SETARI ADMIN" --menu "Selecteaza o optiune:" 20 60 10 \
    "1" "Schimba Parola" \
    "2" "Modifica Script" \
    "0" "Iesire" 3>&1 1>&2 2>&3)

    exitstatus=$?
    if [ $exitstatus -ne 0 ]; then
        clear
        cowthink "Made by Yvonne & Daria"
        exit 0
    fi
case "$optiune" in
        "1")
            parola=$(whiptail --passwordbox "Introdu parola noua: " 10 40 3>&1 1>&2 2>&3)
            echo "$parola" > .parola
            ;;
        "2")
            director="./"
            optiuni=""
            i=1
            for file in "$director"/*.sh; do
            [ -f "$file" ] || continue
            script=$(basename "$file")
            optiuni="$optiuni $script $i"
            i=$((i + 1))
            done
            fisier=$(whiptail --title "Selectează un fișier .sh" --menu "Fișiere disponibile:" 20 60 10 $optiuni 3>&1 1>&2 2>&3)
            if [ $? -eq 0 ]; then
             pico $fisier
            else
             whiptail --msgbox "Ai anulat." 10 40
            fi
            ;;
        "0")
            return 0
            ;;
        *)
            whiptail --msgbox "Optiune invalida!" 10 50
            ;;
    esac
done
