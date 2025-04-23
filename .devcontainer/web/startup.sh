#!/bin/bash

set -e

echo "Startup starting"

ln -sf /src/config/odoo.conf /etc/odoo/odoo.conf
chown odoo:odoo /etc/odoo/odoo.conf

/usr/bin/python3 /tmp/debugpy --listen 0.0.0.0:8888 /src/odoo/odoo-bin --db_user=$db_user --db_host=$db_host --db_password=$db_password --dev=xml,reload -c /etc/odoo/odoo.conf

exit 1
