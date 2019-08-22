#!/usr/bin/env bash

# переменные
## лог последнего запуска скрипта
ll=last.log
## общий лог запуска, ведется добавлением последнего лога в этот
al=all.log
## путь к логу nginx
log=access.log

sorter(){
sort \
| uniq -c \
| sort -nr
}

top10(){
head -10
}

top_10_ip(){
awk '{print $1}' $log | sorter | top10
}

top_request(){
cut -d '"' -f3 $log | cut -d ' ' -f2 | sorter | top10
}

url_err(){
awk '{print $9}' $log | awk -F '.-' '$1 <= 599 && $1 >= 400' | sorter
}

top_10_domain(){
awk '{print $13}' $log | grep http | awk 'BEGIN { FS = "/" } ; { print $3 }' | awk 'BEGIN { FS = "\"" } ; { print $1 }' | sorter | top10
}

date_end_str(){
awk '{print $4}' $log | tail -1 | sed 's/\[//g'
}

get_date_end(){
#cat $ll | grep timeend | sed 's/timeend//g'
grep timeend $ll | sed 's/timeend//g'
}

start_str(){
awk '{print $4}' $log | grep -nr get_date_end | cut -d : -f 2
}

end_str(){
wc -l $log | awk '{print $1}'
}

range(){
sed -n '$start_str,$end_str_file' $log
}

## основная функция
main(){
### получим номер последней строки
end_str_file=$(end_str)
### извлекаем из нее дату и добавим в память для записи в лог как time_end
time_end=$(date_end_str)
### обнуляем лог скрипта
:> $ll
### стартуем обработку
echo "top 10 ip adresses" >> $ll
echo range | top_10_ip >> $ll
echo "top 10 requests" >> $ll
echo range | top_request >> $ll
echo "top 10 domains" >> $ll
echo range | top_10_domain >> $ll
echo "all errors" >> $ll
echo range | url_err >> $ll
### добавляем последнюю дату как первую для запуска в лог
echo "timestart$time_start" >> $ll
### дописываем дату окончания
echo "timeend $time_end" >> $ll
### дописываем контрольный END
echo "END" >> $ll
}

### проверяем на наличие старого файла лога работы скрипта, если есть
if [ -e $ll ]
then
    ### если последняя стока лога скрипта END
    if [[ $( tail -1 $ll) == END ]]
    then
    ### скрипт завершился корректно
    echo "it's ok!"
    ### дописываем лог в общий
    cat $ll >> $al
	### проверяем строкe timeend, если есть
        if [[ $( grep timeend $ll | awk '{print $1}' ) == timeend ]]
        then
        ### берем дату последнего запуска и добавим в память для записи в лог как time_start
        time_start=$(get_date_end)
        ### получаем номер строки для начала обработки
        start_str_file=$(start_str)
	### работа основной функции
	main
        else
        ### присваиваем начальный номер строки 1 с которого ведется обработка лога nginx
	start_str_file=1
	### работа основной функции
	main
        fi
    else
    ### сообщение - скрипт не завершился
    echo "last run script isn't end!"
    fi
else
### сообщение
echo "create new file log"
### создаем файл лога скрипта
touch $ll
### присваиваем начальный номер строки 1 с которого ведется обработка лога nginx
start_str_file=1
### работа основной функции
main
fi

## отправим письмо
cat $ll | mail -s "Last hour log" master@otus.ru