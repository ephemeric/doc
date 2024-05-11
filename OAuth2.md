# Start
https://wiki.archlinux.org/title/Isync#Using_XOAUTH2

# Python Script
https://github.com/muttmua/mutt/blob/master/contrib/mutt_oauth2.py.README

# Provision.

```
./.local/bin/oauth2.py --verbose --authorize --authflow localhostauthcode .neomutt/oauth2
```

# Test

```
./.local/bin/oauth2.py --verbose --test .neomutt/oauth2
```

