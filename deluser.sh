#!/bin/bash
username=$1
echo "Deleting Account $username"

read -p "Press enter to continue..." confirm

data="
cn=$username,ou=Group,dc=cws,dc=net
uid=$username,ou=People,dc=cws,dc=net
"

ldapdelete -H ldaps://ldap.cws.net -W -D cn=admin,dc=cws,dc=net -W << EOF
$data
EOF
