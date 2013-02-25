#!/bin/bash

moddata="dn: uid=$1,ou=People,dc=cws,dc=net
changetype: modify
replace: loginShell
loginShell: /bin/bash
"

ldapmodify -H ldaps://ldap.cws.net -W -D cn=admin,dc=cws,dc=net -W << EOF
$moddata
EOF
