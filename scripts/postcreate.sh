#!/bin/bash

echo "Running postcreate.sh script"

# Change owner and rights of ssh keys
chown root:root ~/.ssh/*
chmod 0600 ~/.ssh/*

if ! test -d /src/.vscode; then
    echo "Creating /src directory"
    ln -s /repo/.vscode /src/.vscode
    mkdir /src/screenshots
fi
cp /repo/.env /src/.env

if ! test -d /src/user; then
    echo "Cloning git repositories"
    cd /src
    git clone -b 18.0 --single-branch https://github.com/odoo/odoo.git odoo
    
    # replace this repository with your own project
    git clone -b 18.0 https://github.com/crogos/odoo-sample-project.git user

    # requires ssh key to checkout submodules with ssh protocol
    cd /src/user
    git submodule update --init
    git submodule update

    # install pre-commit
    git submodule foreach '[ "$(echo $path | grep -o "modules/oca")" ] && pre-commit install || true'

else
    echo "Git repositories already cloned"
fi

echo "Running postcreate.sh finished"