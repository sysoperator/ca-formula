ca-formula
==========

Local CA formula

## Configuration

Create the file `/etc/salt/master.d/peer.conf` with the following content:

```
peer:
  .*:
    - x509.sign_remote_certificate
```

and restart the `salt-master` service.

Adjust the pillar data to suit your needs then reference these files in `top.sls`, e.g.:

```
base:
  (..)
  'roles:ca':
    - match: grain
    - ca
    - x509
```
