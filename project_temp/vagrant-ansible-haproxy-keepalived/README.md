# VRRP + HAproxy
## How to run
```
vagrant up
```

## Ansible Playbooks

```
cd provision
ansible-playbook playbooks/environment.yml
```

### Hosts

- [lb] 
    -haproxy1 (10.0.26.201)
    -haproxy2 (10.0.26.202)
- [webapp]
    - web1 (10.0.26.101)
    - web2 (10.0.26.102)


#Web-pages access

### VIP access
http://10.0.26.81
http://10.0.26.81:8080/stats

###Web servers
web1: http://10.0.26.201

web2: http://10.0.26.202

###Load balancer server
lb1: http://10.0.26.101
lb2: http://10.0.26.102

####LB Statistic page
http://127.0.0.1:8080/stats

    username: stat
    password: statpass
