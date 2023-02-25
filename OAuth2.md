# Start
https://wiki.archlinux.org/title/Isync#Using_XOAUTH2

# Python Script
https://github.com/muttmua/mutt/blob/master/contrib/mutt_oauth2.py.README

# Test
./.local/bin/oauth2.py --verbose --test .neomutt/oauth2

```
NOTICE: Invalid or expired access token; using refresh token to obtain new access token.
NOTICE: Obtained new access token, expires 2023-02-08T11:47:02.499801.
Access Token: eyJ0eXAiOiJKV1QiLCJub25jZSI6IjFBM3BfR0puT3lxSDJQYlZha1I2cW1oVFBuQ2ktRE9iQjNlbk9VRFl2VmMiLCJhbGciOiJSUzI1NiIsIng1dCI6Ii1LSTNROW5OUjdiUm9meG1lWm9YcWJIWkdldyIsImtpZCI6Ii1LSTNROW5OUjdiUm9meG1lWm9YcWJIWkdldyJ9.eyJhdWQiOiJodHRwczovL291dGxvb2sub2ZmaWNlLmNvbSIsImlzcyI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0LzdjYWU4ZGYxLTAzNTYtNGEzYS05OTA0LTQ2ZTZmYzMyZWNjMi8iLCJpYXQiOjE2NzU4NDQ2NjQsIm5iZiI6MTY3NTg0NDY2NCwiZXhwIjoxNjc1ODQ5NjIzLCJhY2N0IjowLCJhY3IiOiIxIiwiYWlvIjoiQVZRQXEvOFRBQUFBaXorTnpQdlFtTGNqdTVBYlZYaWlodmpFQmFMbDZsNmlwbXBjdFZkZDhPaHAvODNHdzlVRGFlZVRpeTEzTXpKYVpCQTNCclRaaitCZnFpaFBOb0pBWCtkRHlnNENKYzZpNENoK2t2eStIc289IiwiYW1yIjpbInB3ZCIsIm1mYSJdLCJhcHBfZGlzcGxheW5hbWUiOiJUaHVuZGVyYmlyZCIsImFwcGlkIjoiMDgxNjJmN2MtMGZkMi00MjAwLWE4NGEtZjI1YTRkYjBiNTg0IiwiYXBwaWRhY3IiOiIxIiwiZW5mcG9saWRzIjpbXSwiZmFtaWx5X25hbWUiOiJHYWJyaWVsIiwiZ2l2ZW5fbmFtZSI6IlJvYmVydCIsImlwYWRkciI6IjE5Mi4xNDMuMjQ3LjI0IiwibmFtZSI6IlJvYmVydCBHYWJyaWVsIiwib2lkIjoiOWIwNzgwZDUtYTViMy00MDg2LWJmNzgtMGVhODdiNTI1YzZmIiwib25wcmVtX3NpZCI6IlMtMS01LTIxLTIwODMwMzk5MTItMTI3MTcwMjE2OC0xOTM3NzE3MTMzLTQ2ODgiLCJwdWlkIjoiMTAwMzIwMDE3ODMwM0U2MiIsInJoIjoiMC5BVEFBOFkydWZGWURPa3FaQkVibV9ETHN3Z0lBQUFBQUFQRVB6Z0FBQUFBQUFBQXdBSTQuIiwic2NwIjoiSU1BUC5BY2Nlc3NBc1VzZXIuQWxsIFBPUC5BY2Nlc3NBc1VzZXIuQWxsIFNNVFAuU2VuZCIsInNpZCI6IjE4M2M2MGQ0LTk1NmQtNGMyYy1hN2Y0LWE2MGE5MWQ2ODc4ZSIsInN1YiI6InBIenUtZVYtRlktWEkydFZtbHZwYXpydEgwakRZSWtFVm5VeFJxT0F0NlkiLCJ0aWQiOiI3Y2FlOGRmMS0wMzU2LTRhM2EtOTkwNC00NmU2ZmMzMmVjYzIiLCJ1bmlxdWVfbmFtZSI6IlJvYmVydEdAYmx1ZXR1cnRsZS5jby56YSIsInVwbiI6IlJvYmVydEdAYmx1ZXR1cnRsZS5jby56YSIsInV0aSI6InJxclh2cmY0V1U2TmZPMjZ6a04tQUEiLCJ2ZXIiOiIxLjAiLCJ3aWRzIjpbImI3OWZiZjRkLTNlZjktNDY4OS04MTQzLTc2YjE5NGU4NTUwOSJdfQ.s3AqnQIJGWhf5kYcCfzVgMusrsIswCe6a1STetR_HTwFgL68RI0jM48NN7f6luUMG0vWYXVrs5_-24SS3Q0j8eELwP9RIx69w3JFwHAvZnKHOznuV8kcar9AbGHnxmA9Q0rJP3yoTlXFGb8T31ZYwNG2i8k7oJO0ppb4yRrRgyZdpIACtYi4C4Mp8LH2y_3axDJH2VSrYcuuA-R5l-zgrPnYIH2GBcLQJPom4Gmg6PHr7um6rDlSoHxnE7PYHmlcTnlyZWg6cpUVvngkaqUeWxwZeq7Gc63jmOrK53YrsK6A_2tolg6HH01N4OHkD1fsQi3Ba96nF5NrTGJDkWFzPA
IMAP authentication succeeded
POP authentication succeeded
SMTP authentication FAILED: (535, b'5.7.139 Authentication unsuccessful, SmtpClientAuthentication is disabled for the Tenant. Visit https://aka.ms/smtp_auth_disabled for more information. [ZR0P278CA0118.CHEP278.PROD.OUTLOOK.COM 2023-02-08T08:29:45.060Z 08DB094735E76833]')
```

# Production

```
./.local/bin/oauth2.py --verbose --authorize --authflow localhostauthcode .neomutt/oauth2
```

Available app and endpoint registrations: google microsoft
OAuth2 registration: microsoft
Preferred OAuth2 flow ("authcode" or "localhostauthcode" or "devicecode"):
Account e-mail address: robert@caeg.co.za
https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=08162f7c-0fd2-4200-a84a-f25a4db0b584&tenant=common&scope=offline_access%20https%3A%2F%2Foutlook.office.com%2FIMAP.AccessAsUser.All%20https%3A%2F%2Foutlook.office.com%2FPOP.AccessAsUser.All%20https%3A%2F%2Foutlook.office.com%2FSMTP.Send&login_hint=robert%40caeg.co.za&response_type=code&redirect_uri=http%3A%2F%2Flocalhost%3A49390%2F&code_challenge=ba5SAEfH0YCpxIDHGK_zzvW1HEvq8YG6CEt6TrhhFm0&code_challenge_method=S256
Visit displayed URL to authorize this application. Waiting...127.0.0.1 - - [15/Feb/2023 14:39:40] "GET /?code=0.AXkApQcVtxrMwESLgQ1nbr7jYnwvFgjSDwBCqEryWk2wtYR5AFw.AgABAAIAAAD--DLA3VO7QrddgJg7WevrAgDs_wUA9P94I67l_YFMug7eTMZfVBNsFAnu9EdAb0op-VMxqukITy8rdS-2lZUWmw9zqT67INVU-oJIr9WzUHKs0KW1wQNFEkCrpfHaSEi-huzRAmYIr3C9LxcLL8iRqFc5SF0tJ_5tXzsO8YwOW05v2ySoDzHlQIGRDTOJXvxU7ydTB4Jn6s72vrwNmjUzEtA-CYsRoFKdd-n-8epOFW7alnKL4qAv0v-mrek1zz0ruHS5kEr08BNhlfYmpM8STogZtRrTcLKymz13-7YmXBCB2infera-CJdrlPmpl1Yi-Ws6cpxnA3nxnNmgcR_7EkPcmQOp92hCQtFqQx8jNpEQL2nloS2WyQThZJJdbMD6RO6MLjHOefaNtFy7edItBd-y1HVSFgh1thywIvBQGDdL79bdx6a_MdSpd9m6V9_nPjIQb8gd_cvam74XNxTdZqGFtftQZ4V_a5WpAK-nme7fqfxbYhIVDEZd4rdT8QtCrVH9HTOxO0w58q9s_EhwU0B66bMM76LP4yrphqHTs7m7WkcYIEvpsm1mUjh0Adf44lpJO43LY65W9dzz0Cpb1lAs706mE92M1ko4wIDkFizGu_uiFQ8WXKmXfgvMy3r7snsIVl-K4xS9uptJGBcvG7mgKir6yKzFeW-ANk740GYy6_K1AhZnyNL08r-BjDcJ9gdMO7tItLRP10sD10T03zVYHBnnEHzMLvqbBueED1A-vu4Zu_rBjrY4CMPUv_m8d5ZAV6tcSOjA9lBwuwZcj82QcEYneUUE88iGNKi7AnDL88y0vU7ZnP2nNxvdI2S2abAaPhf7OdU3FQ&session_state=81a9a898-9b01-4578-ae98-16df92f3773c HTTP/1.1" 200 -
NOTICE: Obtained new access token, expires 2023-02-15T15:50:27.868847.
Access Token: eyJ0eXAiOiJKV1QiLCJub25jZSI6ImkxWVVMbG5JQkFKLWtKMnBJQXVIZ1BYVThqQ3JYTEY2TlNsVm90cmJvT0kiLCJhbGciOiJSUzI1NiIsIng1dCI6Ii1LSTNROW5OUjdiUm9meG1lWm9YcWJIWkdldyIsImtpZCI6Ii1LSTNROW5OUjdiUm9meG1lWm9YcWJIWkdldyJ9.eyJhdWQiOiJodHRwczovL291dGxvb2sub2ZmaWNlLmNvbSIsImlzcyI6Imh0dHBzOi8vc3RzLndpbmRvd3MubmV0L2I3MTUwN2E1LWNjMWEtNDRjMC04YjgxLTBkNjc2ZWJlZTM2Mi8iLCJpYXQiOjE2NzY0NjQ0ODIsIm5iZiI6MTY3NjQ2NDQ4MiwiZXhwIjoxNjc2NDY5MDI5LCJhY2N0IjowLCJhY3IiOiIxIiwiYWlvIjoiQVRRQXkvOFRBQUFBRlFQS0tza3JzdHFOWlA3VG9LV25WY2FVaEhJVnhSVHg1OEx2R1BueVUvZkdNdUhJc0tyQXVsb2tybTdITWRwVyIsImFtciI6WyJwd2QiXSwiYXBwX2Rpc3BsYXluYW1lIjoiVGh1bmRlcmJpcmQiLCJhcHBpZCI6IjA4MTYyZjdjLTBmZDItNDIwMC1hODRhLWYyNWE0ZGIwYjU4NCIsImFwcGlkYWNyIjoiMSIsImVuZnBvbGlkcyI6W10sImZhbWlseV9uYW1lIjoiR2FicmllbCIsImdpdmVuX25hbWUiOiJSb2JlcnQiLCJpcGFkZHIiOiIxOTIuMTQzLjIzNC4yMzEiLCJuYW1lIjoiUm9iZXJ0IEdhYnJpZWwiLCJvaWQiOiJiZDczOGZiMi1hZTVlLTRiMzMtYjYxZS1mZjI0YWIyNjg0MGIiLCJwdWlkIjoiMTAwMzIwMDI3NEMwRUE3RiIsInJoIjoiMC5BWGtBcFFjVnR4ck13RVNMZ1ExbmJyN2pZZ0lBQUFBQUFQRVB6Z0FBQUFBQUFBQjVBRncuIiwic2NwIjoiSU1BUC5BY2Nlc3NBc1VzZXIuQWxsIFBPUC5BY2Nlc3NBc1VzZXIuQWxsIFNNVFAuU2VuZCIsInNpZCI6IjgxYTlhODk4LTliMDEtNDU3OC1hZTk4LTE2ZGY5MmYzNzczYyIsInNpZ25pbl9zdGF0ZSI6WyJrbXNpIl0sInN1YiI6ImFpTGVkX0tsNlRJV1hBdklrSThkdGliaXBiNklwOGNkQkRBekluR0pMX2ciLCJ0aWQiOiJiNzE1MDdhNS1jYzFhLTQ0YzAtOGI4MS0wZDY3NmViZWUzNjIiLCJ1bmlxdWVfbmFtZSI6InJvYmVydEBjYWVnLmNvLnphIiwidXBuIjoicm9iZXJ0QGNhZWcuY28uemEiLCJ1dGkiOiJKZDdUc0MzdjIwaUxQd0pPQmxJUUFBIiwidmVyIjoiMS4wIiwid2lkcyI6WyJiNzlmYmY0ZC0zZWY5LTQ2ODktODE0My03NmIxOTRlODU1MDkiXX0.ff92YX6RCGSz0c_eJWvATj1EAvMRhoX8S4D_f4ZYbnK1Ki7GurOmYzYUO9ijkU7Z9Ny1F4jXOPWuqfZKdKq_99ZJKQMQu009YozBJt5mbNqgmb6MS3JmDxoKTten6CXrSCH8dCVdTlE42SMXY7ZtvEvCdh_ZFrXx3iSYog2q_Y79PI7sQLUIPTbyehoNIJRjtPZqVgmztzBub0662MqIBnmrgBpO4420wGbPwij0HGnfKEAKNzo0GFdGGh_Hfr0M3vQk-TKKXxOv4YEAkkDkNQPnFyB2wS8B2fljArXh4VVF6xBlChy19g_hKdovYaz2kQFGNj8i8OLw4OiR78U3nQ