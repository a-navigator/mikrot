/ip firewall filter print;
:local listName "banned_users";
:local ruleName [/ip firewall filter find src-address-list=$listName && chain=input && action=drop];
#:log info "Checking filter rule...";
:if ([:len $ruleName]=0)  do={
#log info "Rule banned_users not exist, adding...";
/ip firewall filter add chain=input place-before=1 action=drop src-address-list=$listName;}

/tool fetch url="https://github.com/a-navigator/mikrot/blob/8edb96752fb7c7ffd6d208cd63181d54847a38e4/banned-ip_update.rsc" dst-path=banned-ip_update.rsc
:delay 4s;
:import banned-ip_update.rsc;
