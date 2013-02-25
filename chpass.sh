#!/bin/bash
echo changing passwd for $1

ldappasswd -H ldaps://ldap.cws.net  -W -D cn=admin,dc=cws,dc=net -x  -S uid=$1,ou=People,dc=cws,dc=net
