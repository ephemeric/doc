# SSH

## LPF

```
Host rocky9.ephemeric.lan
    User robertg
    Hostname 192.168.0.102
    #IdentityFile ~/.ssh/id_rsa
    # Option '-L'.
    LocalForward 127.0.0.1:8080 127.0.0.1:8080
    ServerAliveCountMax 3
    ServerAliveInterval 15
    ExitOnForwardFailure yes
    # Option '-f'.
    #ForkAfterAuthentication yes
    # Option '-N'.
    #SessionType none
```
    
## SOCKS

```
export http_proxy=socks5[h]://127.0.0.1:8080 https_proxy=socks5[h]://127.0.0.1:8080
```

```
Host socks.ephemeric.lan socks
    Hostname 192.168.0.3
    ForkAfterAuthentication yes
    DynamicForward localhost:8080
    SessionType none
```

## AutoSSH

### Server: /etc/ssh/sshd_config.

```
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
```

### Client: /etc/ssh/sshd_config.

```
ClientAliveInterval 20
ClientAliveCountMax 3
AllowUsers c2@127.0.0.1
```

Crontab.

```
MAILTO=""
* * * * * (ssh -p 443 -fNR 127.0.0.1:4450:127.0.0.1:22 c2@197.15.100.245 &>/dev/null &)  
```

## SSH Agent Attacks

- ssh-agent remote host session hijacking (/tmp/ssh-agent/...)
- ssh-agent attacks?
- ProxyJump => sshd, localhost => sshd => TCP forward
- compromised host and /usr/sbin/sshd?
