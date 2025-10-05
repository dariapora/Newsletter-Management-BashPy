#!/bin/bash
if [ $# -gt 0 ]
then echo -e "Lista: argument error">&2
echo "usage: agenda">&2
exit 1
fi
BASE="$HOME/newsletter/subscribers.txt"
while :
do
echo -e "
/////////////////////
FILE=$BASE
---------------------
========MENU=========
---------------------
ADAUGA   Abonat (a)
STERGE   Abonat (d)
EDITEAZA Abonat (e)
CAUTA    Abonat (s)
AFISEAZA Abonatii (v)
EXIT     <ENTER>
---------------------
TASTEAZA a/d/e/s/v SAU <ENTER>: \c
/////////////////////

"
read answ
case $answ in
"") return 0;;
a|A) echo -e "Introdu numele:\c"
read name
if [ $name = "" ]
then continue
fi
echo -e "Introdu prenumele:\c"
read prenume
echo -e "Introdu email:\c"
read email
echo "$name" >> $BASE
echo "$prenume" >> $BASE
echo "$email" >> $BASE

;;
d|D) echo -e "Introdu numele abonatului care trebuie sters (<ENTER> to exit):\c"
read name
if [ $name = "" ]
then continue
fi
sed "/^$name$/ {
N
N
d
}" $BASE > $BASE.new
mv $BASE.new $BASE
;;
e|E) pico $BASE;;
s|S) echo -e "\n Introdu numele abonatului cautat:\c"
read name
found=$(awk -v n="$name" '
BEGIN { found=0 }
/^.*$/ {
  if ($0 == n) {
    print
    getline
    print
    getline
    print
    found = 1
  }
}
END {
  if (found == 0)
    print "Abonatul nu a fost gasit!!"
}
' "$BASE")
echo -e "\n--------------------"
echo "$found"
echo -e "\n--------------------"
;;
v|V) echo -e "\n\t Abonati\n\t-----------"
more $BASE
echo -e "\n Hit <ENTER>\c"
read answ
;;
*) echo -e "Comanda nevalida!"
;;
esac
done
