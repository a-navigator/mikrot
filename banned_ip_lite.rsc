/ip firewall filter print;
:local listName "banned_users";
:local ruleName [/ip firewall filter find src-address-list=$listName && chain=input && action=drop];
:if ([:len $ruleName]=0)  do={
/ip firewall filter add chain=input place-before=1 action=drop src-address-list=$listName;};
