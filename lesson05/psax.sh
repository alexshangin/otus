#!/usr/bin/env bash

get_pid(){
awk '{ print $1 }' /proc/$i/stat
}

get_tty(){
if [[ $( awk '{print $7}' /proc/$i/stat ) = 0 ]]
then
echo "?"
else
ls -l /proc/$i/fd | grep -E 'tty|pts' | cut -d\/ -f3,4 | uniq | head -1
fi
}

get_command(){
if [[ $( cat /proc/$i/cmdline ) != '' ]]
then
cat /proc/$i/cmdline
#cut -c1-86 /proc/$i/cmdline
else
echo "[$( cat /proc/$i/comm )]"
fi
}

get_stat(){
grep State /proc/$i/status | awk '{ print $2 }'
}

main(){
PID=$*
for i in $PID
do
if [[ -e /proc/$i/stat ]]
then
echo "$(get_pid)	$(get_tty)	$(get_stat)	$(get_command)"
fi
done
}

PID=$( ls /proc | grep [[:digit:]] | sort -n | xargs )
echo "  PID TTY      STAT   COMMAND"
main $PID
