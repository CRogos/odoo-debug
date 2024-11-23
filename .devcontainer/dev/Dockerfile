FROM odoo:18.0

USER root

COPY ./startup.sh /
RUN chmod +x /startup.sh

RUN rm -rf /usr/lib/python3/dist-packages/odoo/addons/*

# activate shell for odoo user
RUN chsh -s /bin/sh odoo

# change the odoo user password 
RUN echo "odoo:odoo" | chpasswd

# dev environment tasks
RUN apt-get update
RUN apt-get install -y sshpass git pip pipx pre-commit python3-debugpy chromium-browser python3-jose wget python3-pypandoc

RUN mkdir -p -m 755 /etc/apt/keyrings && wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null \
    && chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg \
    && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | tee /etc/apt/sources.list.d/github-cli.list > /dev/null \
    && apt update \
    && apt install gh -y

RUN git config --system --add safe.directory '*' 

RUN pipx install oca-maintainers-tools@git+https://github.com/c4a8-odoo/helper-maintainer-tools.git@production
RUN pipx install copier@git+https://github.com/copier-org/copier.git@v9.4.1
RUN pipx install oca-port@git+https://github.com/OCA/oca-port.git@main
RUN pipx ensurepath

USER odoo

ENTRYPOINT ["/startup.sh"]


