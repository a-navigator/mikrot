/ip firewall filter print;

:local listName "banned_users";
:local ruleName [/ip firewall filter find src-address-list=$listName && chain=input && action=drop];
:local sheduleName [/system scheduler find name=$listName && on-event=$listName];
:local scriptName [/system script find name=$listName];

/tool fetch url="https://github.com/a-navigator/mikrot/blob/c04673ecd82785da4f5eae754fff0e1baca08238/banned-ip_update.rsc" dst-path=banned-ip_update.rsc
:delay 10s;

/ip firewall address-list remove numbers=[find list=$listName];
:import banned-ip_update.rsc;

:if ([:len $ruleName]=0)  do={
/ip firewall filter add chain=input place-before=1 action=drop src-address-list=$listName;};

:if ([:len $scriptName]=0)  do={
/tool fetch url="https://github.com/a-navigator/mikrot/blob/c10c2e2b4f6c66779573554d6eb9f48d0cc069b0/banned-ip_check.rsc" dst-path=banned-ip_check.rsc
:delay 10s;
/system script add name=$listName source=[/file get banned-ip_check.rsc contents];}

:if ([:len $sheduleName]=0)  do={
/system scheduler add name=$listName on-event=$listName interval=1d;}
