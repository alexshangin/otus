#!/bin/bash
#в лог добавляем:

#-ipaddr
#-httpaddr
#-allerr
#-code
#-timestart
#-timeend

#переменные
ll=script_last.log
al=script_all.log
log=access.log

top_10_ip(){
awk '{print $1}' $log | sort | uniq -c | sort -nr | head -10
}

top_request(){
cat $log | cut -d '"' -f3 | cut -d ' ' -f2 | sort | uniq -c | sort -rn
}

url_err(){
cat $log | awk '{print $9}' | awk -F '.-' '$1 <= 599 && $1 >= 400' | sort | uniq -c | sort -rn
}

top_10_domain(){
awk '{print $13}' $log | grep http | awk 'BEGIN { FS = "/" } ; { print $3 }' | awk 'BEGIN { FS = "\"" } ; { print $1 }' | sort | uniq -c | sort -rn | head -10
}

date_end_str(){
$date_end = awk '{print $4}' $log | tail -1 | sed 's/\[//g'
}

get_date_end(){
grep timeend $ll | sed 's/timeend//g'
}

start_str(){
if [ cat $log |at $log | awk '{print $4}' | grep -nr $date_end | cut -d : -f 2 ]
then
return $nsrt
else
$nstr = 1
fi
}

#проверяем на наличие старого файла:
if [ -e $ll ]
then
    #если последняя стока лога скрипта END
    if [[ $( tail -1 $ll) == END ]]
    then
    #скрипт завершился корректно
    echo "it's ok!"
    #дописываем лог в общий
    cat $ll >> $al
    #берем дату последнего запуска
    get_date_end
    #обнуляем лог
    :> $ll
    #добавляем последнюю дату как первую для запуска в лог
    echo "timestart" $date_end >> $ll
    #получаем номер строки для начала
    start_str
    #дописываем дату окончания
    echo "timeend" start_str >> $ll
    
    
    
    #дописываем контрольный END
    echo "END" >> $ll
    else
    #
    echo "last run script isn't end!"
    fi
else
echo "create new file log"
touch $ll
fi