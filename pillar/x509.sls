{%- import_yaml 'ca.sls' as _ with context -%}
{%- set ca = _.get('ca').get('lookup', {}) %}

x509_signing_policies:
  root_ca:
    - minions: 'ca.*'
    - signing_private_key: {{ ca.pki_dir }}/CA.key
    - signing_cert: {{ ca.pki_dir }}/CA.crt
    - basicConstraints: "critical, CA:TRUE, pathlen:0"
    - keyUsage: "critical, cRLSign, keyCertSign"
    - copypath: {{ ca.pki_dir }}/{{ ca.issued_certs_dir }}/
  subordinate_ca:
    - minions: 'ca.*'
    - signing_private_key: {{ ca.pki_dir }}/SubCA.key
    - signing_cert: {{ ca.pki_dir }}/SubCA.crt
    - basicConstraints: "critical, CA:FALSE"
    - keyUsage: "critical, digitalSignature, keyEncipherment"
    - copypath: {{ ca.pki_dir }}/{{ ca.issued_certs_dir }}/

