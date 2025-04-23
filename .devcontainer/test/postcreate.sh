#!/bin/bash

echo "Running postcreate.sh script"


if ! test -d /src/user; then

    if ssh git@github.com -T 2>&1 | grep -q 'successfully authenticated'; then
        echo "SSH key is working"
    else
        echo "SSH key is not working"
    fi

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
