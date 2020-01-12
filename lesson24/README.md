## Домашнее задание
### развернуть базу из дампа и настроить репликацию
  В материалах приложены ссылки на вагрант для репликации и дамп базы bet.dmp. базу развернуть на мастере и настроить чтобы реплицировались таблицы:
| bookmaker |
| competition |
| market |
| odds |
| outcome

* Настроить GTID репликацию

варианты которые принимаются к сдаче
- рабочий вагрантафайл
- скрины или логи SHOW TABLES
* конфиги
* пример в логе изменения строки и появления строки на реплике

## Домашняя работа
  Написаны роли для развертывания master/slave Percona.
  На мастере добавляем данные в таблицу  и проверяем, включена ли GTID репликация.
```bash
[root@master vagrant]# mysql -uroot -p
Your MySQL connection id is 8
Server version: 5.7.28-31-log Percona Server (GPL), Release 31, Revision d14ef86

mysql> USE bet;
mysql> INSERT INTO bookmaker (id,bookmaker_name) VALUES(1,'1xbet');
mysql> SELECT * FROM bookmaker;
+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  1 | 1xbet          |
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
|  3 | unibet         |
+----+----------------+

mysql> SHOW VARIABLES LIKE 'gtid_mode';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| gtid_mode     | ON    |
+---------------+-------+
```
  Проверяем на слейве.
```bash
[root@slave vagrant]# mysql -uroot -p
Your MySQL connection id is 8
Server version: 5.7.28-31-log Percona Server (GPL), Release 31, Revision d14ef86

mysql> SHOW VARIABLES LIKE 'gtid_mode';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| gtid_mode     | ON    |
+---------------+-------+

mysql> USE bet;
mysql> SHOW TABLES;
+---------------+
| Tables_in_bet |
+---------------+
| bookmaker     |
| competition   |
| market        |
| odds          |
| outcome       |
+---------------+
mysql> SELECT * FROM bookmaker;
+----+----------------+
| id | bookmaker_name |
+----+----------------+
|  1 | 1xbet          |
|  4 | betway         |
|  5 | bwin           |
|  6 | ladbrokes      |
|  3 | unibet         |
+----+----------------+

mysql> SHOW SLAVE STATUS\G
*************************** 1. row ***************************
               Slave_IO_State: Waiting for master to send event
                  Master_Host: 192.168.11.150
                  Master_User: repl
                  Master_Port: 3306
                Connect_Retry: 60
              Master_Log_File: mysql-bin.000003
          Read_Master_Log_Pos: 119794
               Relay_Log_File: slave-relay-bin.000003
                Relay_Log_Pos: 120007
        Relay_Master_Log_File: mysql-bin.000003
             Slave_IO_Running: Yes
            Slave_SQL_Running: Yes
              Replicate_Do_DB:
          Replicate_Ignore_DB:
           Replicate_Do_Table:
       Replicate_Ignore_Table: bet.events_on_demand,bet.v_same_event
      Replicate_Wild_Do_Table:
  Replicate_Wild_Ignore_Table:
                   Last_Errno: 0
                   Last_Error:
                 Skip_Counter: 0
          Exec_Master_Log_Pos: 119794
              Relay_Log_Space: 120985
              Until_Condition: None
               Until_Log_File:
                Until_Log_Pos: 0
           Master_SSL_Allowed: No
           Master_SSL_CA_File:
           Master_SSL_CA_Path:
              Master_SSL_Cert:
            Master_SSL_Cipher:
               Master_SSL_Key:
        Seconds_Behind_Master: 0
Master_SSL_Verify_Server_Cert: No
                Last_IO_Errno: 0
                Last_IO_Error:
               Last_SQL_Errno: 0
               Last_SQL_Error:
  Replicate_Ignore_Server_Ids:
             Master_Server_Id: 1
                  Master_UUID: c0066161-34d9-11ea-aa93-5254008afee6
             Master_Info_File: /var/lib/mysql/master.info
                    SQL_Delay: 0
          SQL_Remaining_Delay: NULL
      Slave_SQL_Running_State: Slave has read all relay log; waiting for more updates
           Master_Retry_Count: 86400
                  Master_Bind:
      Last_IO_Error_Timestamp:
     Last_SQL_Error_Timestamp:
               Master_SSL_Crl:
           Master_SSL_Crlpath:
           Retrieved_Gtid_Set: c0066161-34d9-11ea-aa93-5254008afee6:1-42
            Executed_Gtid_Set: 1335b797-34da-11ea-ac6f-5254008afee6:1-3,
c0066161-34d9-11ea-aa93-5254008afee6:1-42
                Auto_Position: 1
         Replicate_Rewrite_DB:
                 Channel_Name:
           Master_TLS_Version:
```
**BinaryLogsMaster**
```bash
[root@master mysql]# mysqlbinlog mysql-bin.000003 | tail -17
/*!\C latin1 *//*!*/;
SET @@session.character_set_client=8,@@session.collation_connection=8,@@session.collation_server=8/*!*/;
BEGIN
/*!*/;
# at 119636
#200112  1:31:27 server id 1  end_log_pos 119763 CRC32 0xbad2e9f9 	Query	thread_id=8	exec_time=0	error_code=0
SET TIMESTAMP=1578792687/*!*/;
INSERT INTO bookmaker (id,bookmaker_name) VALUES(1,'1xbet')
/*!*/;
# at 119763
#200112  1:31:27 server id 1  end_log_pos 119794 CRC32 0xabbb4a95 	Xid = 150
COMMIT/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
```
**BinaryLogsSlave**
```bash
[root@slave mysql]# mysqlbinlog mysql-bin.000003 | tail -17
/*!\C latin1 *//*!*/;
SET @@session.character_set_client=8,@@session.collation_connection=8,@@session.collation_server=8/*!*/;
BEGIN
/*!*/;
# at 114598
#200112  1:31:27 server id 1  end_log_pos 114725 CRC32 0x5bc6501f 	Query	thread_id=8	exec_time=0	error_code=0
SET TIMESTAMP=1578792687/*!*/;
INSERT INTO bookmaker (id,bookmaker_name) VALUES(1,'1xbet')
/*!*/;
# at 114725
#200112  1:31:27 server id 1  end_log_pos 114756 CRC32 0x85369bbb 	Xid = 61
COMMIT/*!*/;
SET @@SESSION.GTID_NEXT= 'AUTOMATIC' /* added by mysqlbinlog */ /*!*/;
DELIMITER ;
# End of log file
/*!50003 SET COMPLETION_TYPE=@OLD_COMPLETION_TYPE*/;
/*!50530 SET @@SESSION.PSEUDO_SLAVE_MODE=0*/;
```
