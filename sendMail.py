import datetime
import smtplib
from datetime import datetime
from email.mime.text import MIMEText
from collections import namedtuple

subscriber = namedtuple("subscriber", ["name", "surname", "mail"])

admin = "proiectso25@gmail.com"
password = "ghgu fgwk upnw yvnr"

with open("subscribers.txt") as f:
     lines = [line.strip() for line in f if line.strip()]

lunaIndex = datetime.now().month
luni = ["Ianuarie", "Februarie", "Martie", "Aprilie", "Mai", "Iunie", "Iulie", "August", "Septembrie", "Octombrie", "Noiembrie", "Decembrie"]
with open("message.txt", "r") as g:
    msgBody = g.read().strip()

subscribers = []
for i in range(0, len(lines), 3):
     name = lines[i + 1].capitalize()
     surname = lines[i].capitalize()
     mail = lines[i + 2]
     subscribers.append(subscriber(name, surname, mail))

for sub in subscribers:
     to = sub.mail
     subject = "{}! Good Morning CSIE editia {} este aici.".format(sub.name, luni[lunaIndex-1].lower())
     body = msgBody

     msg = MIMEText(body)
     msg["Subject"] = subject
     msg["From"] = admin
     msg["To"] = to

     try:
         server = smtplib.SMTP("smtp.gmail.com", 587)
         server.ehlo()
         server.starttls()
         server.login(admin, password)
         server.sendmail(admin, [to], msg.as_string())
         server.quit()
         print "Trimis catre %s" %sub.mail
     except Exception as e:
         print "Eroare la %s:" %sub.mail
