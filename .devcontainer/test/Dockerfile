FROM odoo:18.0

COPY ./home/* /home/odoo/
COPY ./config/* /mnt/repo/config/

COPY ./.vscode/* /mnt/repo/.vscode/
COPY ./.env /mnt/repo/.env
COPY ./postcreate.sh /mnt/repo/postcreate.sh



ENV PATH="/opt/odoo/venv/bin:$PATH"
USER root

RUN chown -R odoo:odoo /mnt/repo
RUN rm -rf /usr/lib/python3/dist-packages/odoo/addons/*

# activate shell for odoo user
RUN chsh -s /bin/bash odoo

# change the odoo user password 
RUN echo "odoo:odoo" | chpasswd

# dev environment tasks
RUN apt-get update \
    && apt-get install -y sshpass git pip pipx pre-commit python3-debugpy chromium-browser python3-jose wget python3-pypandoc python3-websocket sudo \
    && mkdir -p -m 755 /etc/apt/keyrings \
    && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt update \
    && apt install gh -y \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - \
    && sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list' \
    && apt-get update \
    && apt-get install google-chrome-stable -y \    
    && python3 -m venv /opt/odoo/venv \
    && source /opt/odoo/venv/bin/activate



RUN usermod -aG sudo odoo

RUN git config --system --add safe.directory '*' 

RUN /opt/odoo/venv/bin/pip install oca-port copier

COPY ./startup.sh /    



RUN chmod +x /startup.sh


ENTRYPOINT ["/startup.sh"]


