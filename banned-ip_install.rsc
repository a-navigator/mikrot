/ip firewall filter print;

:local listName "banned_users";
:local ruleName [/ip firewall filter find src-address-list=$listName && chain=input && action=drop];

if ([:len $ruleName]=0)  do={
#log info "Rule banned_users not exist, adding...";
/ip firewall filter add chain=input place-before=1 action=drop src-address-list=$listName;}

/tool fetch url="https://github.com/a-navigator/mikrot/blob/1c3e9e7335e5ddf5214c26a151b5f1492f3b99b0/banned-ip_update.rsc" dst-path=banned-ip_update.rsc;
