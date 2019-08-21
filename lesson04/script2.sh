#!/bin/bash
#в лог добавляем:
#-ipaddr
#-httpaddr
#-allerr
#-code
#-timestart
#-timeend

top_10_ip () {
awk '{print $1}' access.log | sort | uniq -c | sort -nr
}
error () {
cat access.log | cut -d '"' -f3 | cut -d ' ' -f2 | sort | uniq -c | sort -rn
#awk '{print $9}' access.log | sort | uniq -c | sort -rn
}
url_err () {
awk '($9 ~ /302/)' access.log | awk '{print $7}' | sort | uniq -c | sort -rn
}








#проверяем на наличие старого файла:
ll=script_last.log
al=script_all.log
if [ -e $ll ]
then
    if [[ $( tail -1 $ll) == END ]]
    then
    echo "it's ok!"
    cat $ll >> $al
    ./script.sh
    else
    echo "last run script isn't end!"
    fi
else
echo "create new file log"
touch $ll
fi