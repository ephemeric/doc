# XRDP

## Arch Host

yay -S xrdp xorgxrdp

pacman -S x11-nouveu

/etc/X11/Xwrapper.config:allowed_users=anybody

jasmine :: ~ % ll /etc/xrdp/key.pem                                                                        +
-rw------- 1 root root 1.7K May 11 18:46 /etc/xrdp/key.pem

jasmine :: ~ % ps -ef | grep -i xrdp                                                                       +
root         812       1  0 Jun25 ?        00:00:00 /usr/bin/xrdp-sesman
root         837       1  0 Jun25 ?        00:00:00 /usr/bin/xrdp

No need for group edits.

tail -f /var/log/xrdp*

## Ubuntu Desktop 22.04 Guest

apt-get install xrdp xorgxrdp # !!!

/etc/X11/Xwrapper.config:allowed_users=anybody

root@ubdesk2204:~# ll /etc/xrdp/key.pem

No perms for xdrp.

[20240108-13:28:04] [ERROR] Cannot read private key file /etc/xrdp/key.pem: Permission denied

lrwxrwxrwx 1 root root 38 Jun 27 11:12 /etc/xrdp/key.pem -> /etc/ssl/private/ssl-cert-snakeoil.key

/etc/group: ssl-cert:x:114:xrdp

/var/log/xrdp-sesman.log

[20240108-13:36:10] [ERROR] A fatal error has occured attempting to start the window manager on display 10, aborting connection

~/.xorgxrdp.10.log
(EE) errors...

systemctl --now disable gdm

tail -f /var/log/xrdp*
