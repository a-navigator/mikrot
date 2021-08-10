/ip firewall filter print;
:local listName "banned_users";
:local ruleName [/ip firewall filter find src-address-list=$listName && chain=input && action=drop];
#:log info "Checking filter rule...";
:if ([:len $ruleName]=0)  do={
#log info "Rule banned_users not exist, adding...";
/ip firewall filter add chain=input place-before=1 action=drop src-address-list=$listName;}
