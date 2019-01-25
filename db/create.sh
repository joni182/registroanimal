#!/bin/sh

if [ "$1" = "travis" ]; then
    psql -U postgres -c "CREATE DATABASE registroanimal_test;"
    psql -U postgres -c "CREATE USER registroanimal PASSWORD 'registroanimal' SUPERUSER;"
else
    sudo -u postgres dropdb --if-exists registroanimal
    sudo -u postgres dropdb --if-exists registroanimal_test
    sudo -u postgres dropuser --if-exists registroanimal
    sudo -u postgres psql -c "CREATE USER registroanimal PASSWORD 'registroanimal' SUPERUSER;"
    sudo -u postgres createdb -O registroanimal registroanimal
    sudo -u postgres psql -d registroanimal -c "CREATE EXTENSION pgcrypto;" 2>/dev/null
    sudo -u postgres createdb -O registroanimal registroanimal_test
    sudo -u postgres psql -d registroanimal_test -c "CREATE EXTENSION pgcrypto;" 2>/dev/null
    LINE="localhost:5432:*:registroanimal:registroanimal"
    FILE=~/.pgpass
    if [ ! -f $FILE ]; then
        touch $FILE
        chmod 600 $FILE
    fi
    if ! grep -qsF "$LINE" $FILE; then
        echo "$LINE" >> $FILE
    fi
fi
