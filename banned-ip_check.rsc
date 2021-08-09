/ip firewall filter print;

:local listName "banned_users";
:local ruleName [/ip firewall filter find src-address-list=$listName && chain=input && action=drop];
:local sheduleName [/system scheduler find name=$listName && on-event=$listName];
:local scriptName [/system script find name=$listName];

/tool fetch url="sftp://192.168.14.25/home/a.bogdanov/ansible/files/banned-ip_update.rsc" user=a.bogdanov password=Aa123456Aa dst-path=banned-ip_update.rsc
:delay 10s;

/ip firewall address-list remove numbers=[find list=$listName];
:import banned-ip_update.rsc;

:if ([:len $ruleName]=0)  do={
/ip firewall filter add chain=input place-before=1 action=drop src-address-list=$listName;};

:if ([:len $scriptName]=0)  do={
/tool fetch url="sftp://192.168.14.25/home/a.bogdanov/ansible/files/banned-ip_check.rsc" user=a.bogdanov password=Aa123456Aa dst-path=banned-ip_check.rsc
:delay 10s;
/system script add name=$listName source=[/file get banned-ip_check.rsc contents];}

:if ([:len $sheduleName]=0)  do={
/system scheduler add name=$listName on-event=$listName interval=1d;}
