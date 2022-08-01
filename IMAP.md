# OpenSSL
openssl s_client -tls1_2 -crlf -connect example.com:993

a login email@example.com passwordgoeshere
a list "" "*"
a select INBOX
a status INBOX (MESSAGES)
a fetch 1 ALL
a logout

# Mutt
neomutt -f imaps://mail.blueturtle.org.za:993
