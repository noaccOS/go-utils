#!/bin/sh

function go_vers() {
    echo '{'
    git ls-remote --tags --refs https://github.com/golang/go.git 'go*' |
        sort -V -u -r -k2 |
        sed -r 's/^(\w+)\s+(refs\/tags\/go(([0-9]+)(\.([0-9]+))?.*))$/"\3":{"rev":"\1","ref":"\2","version":"\3","major":"\4","minor":"\6"}/' |
        paste -sd ','
    echo '}'
}
go_vers | jq > go-lock.json
