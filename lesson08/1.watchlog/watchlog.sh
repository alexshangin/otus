#!/usr/bin/env bash
#watchlog timer every 30 sec
#create config
printf 'WORD=\"ALERT\"\nLOG=/var/log/watchlog.log\n' >> /etc/sysconfig/watchlog

#create log
cat << EOF > /var/log/watchlog.log
Tell everyone you know, tell everybody now
If you get infected, you’ll wish you had never been born
So before it emails your grandmother all of your porn
Turn off your computer and make sure it powers down
Drop it in a forty-three-foot hole in the ground
Bury it completely; rocks and boulders should be fine
Then burn all the clothes you may have worn any time you were alive!
Virus ALERT!
Delete immediately before someone gets hurt!
Forward this message on to everybody
Warn all your friends, send this to everybody
Tell everyone you know, tell everybody now
What are you waiting for?
Just hurry up and forward this to every single person that you know!
Hit send right now!
EOF

#create watchlog script
printf '#!/bin/bash\nWORD=$1\nLOG=$2\nDATE=`date`\nif grep $WORD $LOG &> /dev/null\nthen\n    logger \"$DATE: I found word, Master!\"\nelse\n    exit 0\nfi' >> /opt/watchlog.sh

#chmod
chmod +x /opt/watchlog.sh

#create unit for service
printf '[Unit]\nDescription=My watchlog service\n\n[Service]\nType=notify\nEnvironmentFile=/etc/sysconfig/watchlog\nExecStart=/opt/watchlog.sh $WORD $LOG\n' >> /etc/systemd/system/watchlog.service

#create unit for timer
printf '[Unit]\nDescription=Run watchlog script every 30 second\n\n[Timer]\n# Run every 30 second\nOnUnitActiveSec=30\nUnit=watchlog.service\n[Install]\nWantedBy=multi-user.target' >> /etc/systemd/system/watchlog.timer

systemctl start watchlog.timer
