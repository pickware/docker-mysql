#!/bin/bash

set -euo pipefail

echo "[PICKWARE] MySQL Set initial password"

mysqld --sql-mode= --character-set-server=utf8 --collation-server=utf8_general_ci --daemonize --user root --verbose
sleep 2s
mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'pckwr-tmp-password';GRANT ALL ON *.* TO 'root'@'localhost' WITH GRANT OPTION;SHUTDOWN";
