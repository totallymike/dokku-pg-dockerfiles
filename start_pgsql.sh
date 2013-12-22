#!/bin/bash

if [[ ! -z "$1" ]]; then
    mkdir -p /opt/postgresql
    cp -a /var/lib/postgresql/* /opt/postgresql/
    chown -R postgres:postgres /opt/postgresql
    su postgres sh -c "/usr/lib/postgresql/9.2/bin/postgres --single  -D  /var/lib/postgresql/9.2/main  -c config_file=/etc/postgresql/9.2/main/postgresql.conf" <<< "CREATE USER root WITH SUPERUSER PASSWORD '$1';"
    su postgres sh -c "/usr/lib/postgresql/9.2/bin/postgres --single  -D  /var/lib/postgresql/9.2/main  -c config_file=/etc/postgresql/9.2/main/postgresql.conf" <<< "CREATE DATABASE db;"
fi
su postgres sh -c "/usr/lib/postgresql/9.2/bin/postgres           -D  /var/lib/postgresql/9.2/main  -c config_file=/etc/postgresql/9.2/main/postgresql.conf  -c listen_addresses=*"
