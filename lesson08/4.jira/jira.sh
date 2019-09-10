#!/usr/bin/env bash
yum install -y wget
mkdir /opt/atlassian
cd /opt/atlassian/
wget https://product-downloads.atlassian.com/software/jira/downloads/atlassian-jira-software-8.4.0-x64.bin
sudo chmod +x atlassian-jira-software-8.4.0-x64.bin
