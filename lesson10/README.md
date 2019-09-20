### Домашнее задание
#### PAM

1. Запретить всем пользователям, кроме группы admin логин в выходные(суббота и воскресенье), без учета праздников
2. Дать конкретному пользователю права рута

### Домашняя работа
#### Закрепить знания по PAM linux


sudo useradd day && sudo useradd night && sudo useradd friday
echo "Otus2019" | passwd --stdin day && echo "Otus2019" | passwd --stdin night && echo "Otus2019" | passwd --stdin friday

bash -c "sed -i
's/^PasswordAuthentication.*$/PasswordAuthentication yes/'
/etc/ssh/sshd_config && systemctl restart sshd.service"

bash -c "sed -i 's/^PasswordAuthentication.*$/PasswordAuthentication yes/' /etc/ssh/sshd_config && systemctl restart sshd.service"

echo "*;*;day;Al0800-2000" >> /etc/security/time.conf
echo '*;*;day;Al0800-2000' >> /etc/security/time.conf
echo '*;*;friday;Fr' >> /etc/security/time.conf

cat /etc/passwd | grep bash | cut -d\: -f3 | sed -s '/ \n/\|/s'

cat /etc/passwd | grep bash | cut -d\: -f1 | xargs | sed s/' '/\|/g | sed s/root/\!root/g

getent group admin
getent group root

usermod -G root day
getent group root
usermod -G root root
getent group root
getent group wheel
