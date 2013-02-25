#!/bin/bash

moddata="dn: uid=$1,ou=People,dc=cws,dc=net
changetype: modify
replace: uidNumber
uidNumber: $2
-
replace: gidNumber
gidNumber: $2
"

ldapmodify -H ldaps://ldap.cws.net -W -D cn=admin,dc=cws,dc=net -W << EOF
$moddata
EOF
