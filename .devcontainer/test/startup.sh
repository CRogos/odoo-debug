#!/bin/bash

set -e

echo "Testing starting"

mkdir -p /var/lib/odoo/.local/bin
chown odoo:odoo /var/lib/odoo

chown odoo:odoo /src
chown -R odoo:odoo /var/lib/odoo/.local

# mount files into volume
ln -sf /mnt/repo/.vscode /src/.vscode
ln -sf /mnt/repo /src/repo

if ! test -f /src/config/odoo.conf; then
    cp /mnt/repo/.env /src/.env
    mkdir -p /src/config
    cp /mnt/repo/config/empty.odoo.conf /src/config/odoo.conf
    chown -R odoo:odoo /src
else
    echo "Config file already exists"
fi


ln -sf /src/config/odoo.conf /etc/odoo/odoo.conf

chown odoo:odoo /etc/odoo/odoo.conf
chmod g+w /src/config/odoo.conf



tail -f /dev/null
