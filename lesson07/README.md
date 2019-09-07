### Домашнее задание
#### Работа с загрузчиком
##### Цель:
  Зайти в систему без пароля рута - базовая задача сисадмина ( ну и одно из заданий на любой линуксовой сертификации). Так же нужно уметь управлять поведением загрузчика. Это и будем учиться делать в ДЗ.

1. Попасть в систему без пароля несколькими способами
2. Установить систему с LVM, после чего переименовать VG
3. Добавить модуль в initrd
4. *Сконфигурировать систему без отдельного раздела с /boot, а только с LVM. Репозиторий с пропатченым [grub](https://yum.rumyantsev.com/centos/7/x86_64/). PV необходимо инициализировать с параметром --bootloaderareasize 1m

### Домашняя работа rename&dracut

1. **[/root/README.md](https://github.com/alexshangin/otus/blob/master/lesson07/root/README.md)** - проверенные способы входа в систему без пароля. Для каждого добавлен спосбоб изменения пароля root.

2,3. **[/rename&dracut/README.md](https://github.com/alexshangin/otus/blob/master/lesson07/rename&dracut/README.md)** - описание процесса переименования группы и добавления модуля в initrd.
    [**/rename&dracut/dracut.png**](https://github.com/alexshangin/otus/blob/master/lesson07/rename&dracut/dracut.png) - скрин загрузки.

4.  **[/lvmboot/lvmboot.sh](https://github.com/alexshangin/otus/blob/master/lesson07/lvmboot/lvmboot.sh)** - скрипт автоматического переноса системы на том без раздела /boot.
    **[/lvmboot/Vagrantfile](https://github.com/alexshangin/otus/blob/master/lesson07/lvmboot/Vagrantfile)** - вагрант файл от работы по изучению lvm с добавлением только одного диска.