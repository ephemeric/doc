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

Host rocky9.ephemeric.lan
    
#export http_proxy=socks5[h]://127.0.0.1:8080 https_proxy=socks5[h]://127.0.0.1:8080
