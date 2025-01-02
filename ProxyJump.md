# ProxyJump

I would like to expound upon this research for a possible future con talk. The title might be "Secure Bastion Hosts over Insecure Channels".

## SSH Connections

### SSH to PJ

slob@proxyjump.ephemeric.lan

```
robertg@almablder9:~> ps -ef | grep ssh | grep slob
root       63279   28837  0 18:57 ?        00:00:00 sshd: slob [priv]
slob       63293   63279  0 18:57 ?        00:00:00 sshd: slob@pts/1
```

### Post PJ logout

slob@proxyjump.ephemeric.lan

I am using `ControlMaster` hence we still have a lingering process:

```
robertg@almablder9:~> ps -ef | grep ssh | grep slob                                                        +
root       63279   28837  0 18:57 ?        00:00:00 sshd: slob [priv]
slob       63293   63279  0 18:57 ?        00:00:00 sshd: slob@notty
```

I need to do:

```
robertg@macos:~> ssh -O exit slob@proxyjump.ephemeric.lan                                                  +
Exit request sent.
```

Now we're gone:

```
robertg@almablder9:~> ps -ef | grep ssh | grep slob
```

## SSH to remote

Login slob@home.ephemeric.lan.

```
robertg@almablder9:~> ps -ef | grep ssh | grep slob
root       63080   28837  0 18:55 ?        00:00:00 sshd: slob [priv]
slob       63104   63080  0 18:56 ?        00:00:00 sshd: slob
```

## Post remote logout

Logout slob@home.ephemeric.lan.

```
robertg@almablder9:~> ps -ef | grep ssh | grep slob
root       63538   28837  0 19:04 ?        00:00:00 sshd: slob [priv]
slob       63552   63538  0 19:04 ?        00:00:00 sshd: slob
```

robertg@macos:~> ssh -O exit slob@home.ephemeric.lan
Exit request sent.

```
robertg@almablder9:~> ps -ef | grep ssh | grep slob
root       63538   28837  0 19:04 ?        00:00:00 sshd: slob [priv]
slob       63552   63538  0 19:04 ?        00:00:00 sshd: slob
```

robertg@macos:~> ssh -O exit slob@proxyjump.ephemeric.lan
Exit request sent.

```
robertg@almablder9:~> ps -ef | grep ssh | grep slob
```

### SSH to PJ SSH to remote

ForwardAgent no.
TOFU and password auth on PJ. Compromise!

```
robertg@macos:~> ssh slob@proxyjump.ephemeric.lan                                                          +
Last login: Thu Jan  2 19:00:58 2025 from 192.168.0.2
    
[slob@almablder9 ~]$ ssh home.ephemeric.lan
The authenticity of host 'home.ephemeric.lan (192.168.0.103)' can't be established.
ED25519 key fingerprint is SHA256:ZHu2q6jNQblOQc4mrx7Eh4EVVSz4q5/k2o5q/YUu80Y.
This key is not known by any other names
Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
Warning: Permanently added 'home.ephemeric.lan' (ED25519) to the list of known hosts.

slob@home.ephemeric.lan's password:

Last login: Thu Jan  2 21:04:38 2025 from 192.168.0.101
[slob@alma9 ~]$
```

On PJ host:

```
robertg@almablder9:~> ps -ef | grep ssh | grep slob                                                        +
root       63640   28837  0 19:34 ?        00:00:00 sshd: slob [priv]
slob       63655   63640  0 19:34 ?        00:00:00 sshd: slob@pts/1
slob       63703   63656  0 19:34 pts/1    00:00:00 ssh home.ephemeric.lan
```

Logout remote, on PJ:

```
robertg@almablder9:~> ps -ef | grep ssh | grep slob                                                        +
root       63640   28837  0 19:34 ?        00:00:00 sshd: slob [priv]
slob       63655   63640  0 19:34 ?        00:00:00 sshd: slob@pts/1
```

Logout PJ:

```
robertg@almablder9:~> ps -ef | grep ssh | grep slob                                                        +
root       63640   28837  0 19:34 ?        00:00:00 sshd: slob [priv]
slob       63655   63640  0 19:34 ?        00:00:00 sshd: slob@notty
```

robertg@macos:~> ssh -O exit slob@proxyjump.ephemeric.lan
Exit request sent.

```
robertg@almablder9:~> ps -ef | grep ssh | grep slob
```

## Possible Attacks

The PJ host is completely compromised.

What can the attacker do when:

- `sshd` is replaced with attacker's version?
  I won't know the difference if `/usr/sbin/sshd` has been replaced.

- attacker has the PJ host privkey?
  I won't know the difference if `/usr/sbin/sshd` has been replaced.

- all traffic is intercepted?
  The PJ to remote host is a TCP forward and we have the host pubkey in `~/.ssh/known_hosts`.

- PJ connection is established?
  No TOFU for remote host pubkey fingerprint as we already have it in `~/.ssh/known_hosts`.

## Hardening

Do NOT on the PJ bastion host:

- store privkeys
- ~/.ssh/config ControlMaster.
- ForwardAgent yes (disable in /etc/ssh/sshd_config)
- PJ only, no TTY or interactive login allowed
- JIT access, port knocking
