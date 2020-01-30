## Статическая и динамическая маршрутизация

### Домашнее задание
OSPF
- Поднять три виртуалки
- Объединить их разными vlan
1. Поднять OSPF между машинами на базе Quagga
2. Изобразить ассиметричный роутинг
3. Сделать один из линков "дорогим", но что бы при этом роутинг был симметричным

#### Часть 1.Поднять OSPF между машинами на базе Quagga. 
Для проверки ДЗ выполнить команду  ``` vagrant up && ansible-playbook playbook.yml```  В и тооге поднимится стенд из трех ВМ с настроенным OSPF.

![Image OSPF stand](https://github.com/redbull05689/Linux-OTUS/20-OSPF/blob/master/OSPS_part1.png)


#### Часть 2. Изобразить ассиметричный роутинг
Для проверки этой части выполнить команду  ``` ansible-playbook playbook_asymmetric_routing.yml```, это приведет к увеличению стоимости интерфейса смотрящего в vlan30 на R1

![Image OSPF asymm](https://github.com/redbull05689/Linux-OTUS/20-OSPF/blob/master/OSPS_part2.png)

#### Часть 3. 
Для проверки этой части выполнить команду  ``` ansible-playbook palybook_summetric_routing_with_cost.yml```, это приведет к увеличению стоимости интерфейса смотрящего в vlan30 на R1 и на R3, в итоге vlan30 станет дорогим линком.

![Image OSPF symm](https://github.com/redbull05689/Linux-OTUS/20-OSPF/blob/master/OSPS_part3.png)
