{%- set tplroot = tpldir.split('/')[0] -%}
{%- from tplroot ~ "/map.jinja" import ca with context -%}
{%- from tplroot ~ "/vars.jinja" import
    ca_issued_certs_dir
with context -%}
{%- from tplroot ~ "/macros.jinja" import
    certificate_private_key, cacertificate
with context -%}

include:
  - ca/dirs

{{ certificate_private_key('CA', ca.pki_dir + '/CA.key', ca.root_ca.key_algo|default('rsa'), ca.root_ca.keysize|default(4096)) }}

{{ cacertificate('CA', ca.pki_dir + '/CA.crt', ca.pki_dir + '/CA.key', 'CA', None, 'sha256', 1825, ca.root_ca.CN) }}
