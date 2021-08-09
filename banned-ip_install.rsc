/ip firewall filter print;

:local listName "banned_users";
:local ruleName [/ip firewall filter find src-address-list=$listName && chain=input && action=drop];
:local sheduleName [/system scheduler find name=$listName && on-event=$listName];
:local scriptName [/system script find name=$listName];


/tool fetch url="sftp://192.168.14.25/home/a.bogdanov/ansible/files/banned-ip_check.rsc" user=a.bogdanov password=Aa123456Aa dst-path=banned-ip_check.rsc;
:delay 10s;


/system script add name=$listName source=[/file get banned-ip_check.rsc contents];
/system scheduler add name=$listName on-event=$listName interval=1d;



/system script run $listName
