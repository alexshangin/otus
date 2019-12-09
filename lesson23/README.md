## Домашнее задание
### Установка почтового сервера
1. Установить в виртуалке postfix+dovecot для приёма почты на виртуальный домен любым обсужденным на семинаре способом
2. Отправить почту телнетом с хоста на виртуалку
3. Принять почту на хост почтовым клиентом

### Результат
1. Полученное письмо со всеми заголовками
2. Конфиги postfix и dovecot

## Домашняя работа
### Установка почтового сервера.

1. Для развертывания почтового сервера написана ansible-роль. Конфиги находятся в папке roles/post/templates.
2. Отправка почты через telnet:
```bash
alexsius@acerhome:~$ telnet 192.168.11.11 25
Trying 192.168.11.11...
Connected to 192.168.11.11.
Escape character is '^]'.
220 mail.otus.lan ESMTP
EHLO mail.otus.lan
250-mail.otus.lan
250-PIPELINING
250-SIZE 8192000
250-ETRN
250-STARTTLS
250-ENHANCEDSTATUSCODES
250-8BITMIME
250 DSN
mail from:<alex_shangin@mail.ru>
250 2.1.0 Ok
rcpt to:<alex@otus.lan>
250 2.1.5 Ok
DATA
354 End data with <CR><LF>.<CR><LF>
From: Alex Shangin <alex_shangin@mail.ru>
To: Alex <alex@otus.lan>            
Subject: Test subject
Content-Type: text/plain

Hi!

Bye
.
250 2.0.0 Ok: queued as 2E64C8E343
quit
221 2.0.0 Bye
Connection closed by foreign host.
```
3. Для локального приёма почты использовался клиент Mozilla Thunderbird. Исходный текст письма:
```bash
X-Account-Key: account1
X-UIDL: 000000015ded91d3
X-Mozilla-Status: 0001
X-Mozilla-Status2: 00000000
X-Mozilla-Keys:                                                                                 
Return-Path: <alex_shangin@mail.ru>
Delivered-To: alex@otus.lan
Received: from mail.otus.lan
	by postserver with LMTP id 2ITKLf+R7V2bGwAAIsrdAQ
	for <alex@otus.lan>; Mon, 09 Dec 2019 00:14:55 +0000
Received: from mail.otus.lan (unknown [192.168.11.1])
	by mail.otus.lan (Postfix) with ESMTP id 9F9E18E354
	for <alex@otus.lan>; Mon,  9 Dec 2019 00:14:37 +0000 (UTC)
From: Alex Shangin <alex_shangin@mail.ru>
To: Alex <alex@otus.lan>            
Subject: Test subject
Content-Type: text/plain

Hi!

Bye
```
