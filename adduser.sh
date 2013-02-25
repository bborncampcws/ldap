#!/bin/bash
username=$1
home=$2
echo "Creating account for $username with home dir in $home ."
read -p "Account password: " pass
pass=`echo $pass|xargs slappasswd -s `

uid=`ldapsearch -x -H ldaps://ldap.cws.net -b ou=people,dc=cws,dc=net |grep uidNumber |awk '{print $2}' |sort -n |uniq |grep -v 655..|tail -n1`
uid=`echo $uid"+1"|bc`
echo $uid $pass $username $home
acctdata="
# $username, People, cws.net
dn: uid=$username,ou=People,dc=cws,dc=net
uid: $username
cn: $username
objectClass: account
objectClass: posixAccount
objectClass: top
objectClass: shadowAccount
shadowMax: 99999
shadowWarning: 7
loginShell: /bin/bash
userPassword: $pass
uidNumber: $uid
gidNumber: $uid
homeDirectory: $home


# $username, Group, cws.net
dn: cn=$username,ou=Group,dc=cws,dc=net
objectClass: posixGroup
objectClass: top
cn: $username
gidNumber: $uid

"

ldapadd -H ldaps://ldap.cws.net -W -D cn=admin,dc=cws,dc=net -W << EOF
$acctdata
EOF
