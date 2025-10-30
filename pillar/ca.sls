ca:
  lookup:
    ca_server: salt-master
    root_ca:
      CN: Internal Root CA
    sub_ca:
      - name: SubCA
        CN: subordinate-ca
        O: Subordinate CA
    certs:
     - name: server
       output_dir: /tmp
       signing_policy: subordinate_ca
       CN: server
       O: ACME
    pki_dir: /etc/ssl/localcerts
    issued_certs_dir: newcerts
