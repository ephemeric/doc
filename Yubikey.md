# Yubikey

## Unsupported

Algo:

```
ssh-keygen -t ed25519-sk
```

Resident:

```
ssh-keygen -t ecdsa-sk -O resident -O application=ssh:YourTextHere -O verify-required
ssh-add -K
```

## Notes

### FIDO2 PIN blocked

```
ykman fido reset
```

`Enter NEW PIN` if unset or `Enter your current PIN`:

```
ykman fido access change-pin
```

```
ykman fido access verify-pin
```
