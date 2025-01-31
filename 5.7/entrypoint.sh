#!/bin/bash

set -euo pipefail

echo "[PICKWARE] MySQL Initialization"

mysqld --sql-mode= --character-set-server=utf8 --collation-server=utf8_general_ci --daemonize --user root
sleep 2s
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY ${MYSQL_ROOT_PASSWORD}';SHUTDOWN";

mysqld --sql-mode= --character-set-server=utf8 --collation-server=utf8_general_ci --user root
