# Yubikey

https://github.com/drduh/YubiKey-Guide

Resident:

```
$> ssh-keygen -t ed25519-sk -O resident -O application=ssh:YourTextHere -O verify-required
```

To install on a device:

```
$> ssh-add -K
```

If `verify-required`, agent will load key but refuse:

```
sign_and_send_pubkey: signing failed for ED25519-SK "ssh:Resident" from agent: agent refused operation
```

## Notes

### FIDO2 PIN blocked

Seems there is a user PIN (123456), admin PIN (12345678) and FIDO2 PIN (unset).

`Enter NEW PIN` if unset or `Enter your current PIN`:

```
ykman fido access change-pin
```

```
ykman fido access verify-pin
```
