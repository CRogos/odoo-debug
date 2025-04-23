FROM odoo:18.0

COPY ./startup.sh /

USER root

RUN pip3 install -U debugpy -t /tmp

RUN apt-get update
RUN apt-get install -y python3-jose
RUN rm -rf /usr/lib/python3/dist-packages/odoo/addons/*
RUN chmod +x /startup.sh
RUN chown odoo:odoo /etc/odoo/

USER odoo

EXPOSE 8888

ENTRYPOINT ["/startup.sh"]
