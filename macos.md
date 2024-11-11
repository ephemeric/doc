# MacOS

## Switch User

### Vimari

```
"bindings": {
      "hintToggle": "shift+f",
      "newTabHintToggle": "f",
```

### iTerm2

General > Settings > Export All Settings and Data...

See below Homebrew font copy.

### Dotfiles

Copy and substitute username for new username:

- .zshrc
- .gitconfig
- .ssh/config

Straight copy:

.oh-my-zsh
.vimrc
.zshenv

### YubiKey

- resident SSH key application text `ssh:[company]`.

### SSH

`ssh-keygen` ed25519...

### Networking

sudo networksetup -setdhcp Home; sudo networksetup -setdnsservers Home empty; sudo networksetup -setsearchdomains Home empty

Add routes:

sudo networksetup -setadditionalroutes "Home" 192.168.235.0 255.255.255.0 192.168.0.3

sudo networksetup -getadditionalroutes "Home"                                                 +

192.168.235.0 255.255.255.0 192.168.0.3

Remove routes:

sudo networksetup -setadditionalroutes "Home"

sudo networksetup -getadditionalroutes "Home"                                                 +

There are no additional IPv4 routes on Home.

### DNS

sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder

### Homebrew

Multi user? No.

https://www.codejam.info/2021/11/homebrew-multi-user.html

https://docs.brew.sh/FAQ#why-does-homebrew-say-sudo-is-bad

Copy ~Library/Fonts/* to new user.

### Trackpad

- secondary click: bottom left corner

### Touchbar

- show fn keys only

### Dock

- size
- position
