schtasks /delete /tn "AutoHotKeys"
schtasks /create /xml "AutoHotKeys.xml" /tn "AutoHotKeys" /ru "%USERNAME%"