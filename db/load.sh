#!/bin/sh

BASE_DIR=$(dirname $(readlink -f "$0"))
if [ "$1" != "test" ]; then
    psql -h localhost -U registroanimal -d registroanimal < $BASE_DIR/registroanimal.sql
fi
psql -h localhost -U registroanimal -d registroanimal_test < $BASE_DIR/registroanimal.sql
