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

If `verify-required` (PIN), agent will load key but refuse:

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

### GPG

Install pubkey from YubiKey::

gpg --card-edit -> admin -> fetch
 
Export all:

gpg --export --armor 85E71FD30DF5BA98 >public.key
gpg --export-secret-keys --armor 85E71FD30DF5BA98 >secret.key
gpg --export-secret-subkeys --armor 85E71FD30DF5BA98 >subkeys.key
gpg --export-ownertrust >ownertrust.txt

Pubkeys only?

gpg --export-options backup --export -o keyring.gpg
gpg --import-options restore --import keyring.gpg

ykman openpgp keys set-touch aut off
ykman openpgp keys set-touch sig on
ykman openpgp keys set-touch enc on

Test:

echo "\ntest message string" | gpg --encrypt --armor --recipient $KEYID --output encrypted.txt

### Git

git config --global user.signingkey 0x9D062837
