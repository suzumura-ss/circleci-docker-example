#!/bin/bash

LOGS="/var/log/nginx/access.log /var/log/nginx/error.log"
touch $LOGS
/usr/sbin/nginx
tail -f $LOGS
