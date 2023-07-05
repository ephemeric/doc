```
find remote-systems/ -printf "%m %p" -type f -exec ls -ltr {} +
```

find /etc/ -type f -mtime -3 -print0 | tar -cvzpf "$(hostname)".tgz --exclude="/etc/oath/users" --exclude="/etc/ansible/ssh-ca/ca" --exclude="/etc/passwd" --null -T -
