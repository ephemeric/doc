# XRDP

## Arch Host

yay -S xrdp

yay -S xorgxrdp

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

apt-get install xrdp

/etc/X11/Xwrapper.config:allowed_users=anybody

root@ubdesk2204:~# ll /etc/xrdp/key.pem
lrwxrwxrwx 1 root root 38 Jun 27 11:12 /etc/xrdp/key.pem -> /etc/ssl/private/ssl-cert-snakeoil.key

/etc/group: ssl-cert:x:114:xrdp

systemctl --now disable gdm

tail -f /var/log/xrdp*
