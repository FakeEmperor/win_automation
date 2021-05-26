schtasks /delete /tn "SecureAutoMount"
schtasks /create /xml "SecureAutoMount.xml" /tn "SecureAutoMount" /ru "%USERNAME%"