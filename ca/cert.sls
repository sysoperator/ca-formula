{%- set tplroot = tpldir.split('/')[0] -%}
{%- from tplroot ~ "/map.jinja" import ca with context -%}
{%- from tplroot ~ "/vars.jinja" import
    ca_issued_certs_dir
with context -%}
{%- from tplroot ~ "/macros.jinja" import
    valid_certificate, certificate_private_key, certificate
with context -%}

include:
  - ca/dirs

{%- for cert in ca.certs %}
  {%- set file_path = cert['output_dir']|default(ca.pki_dir) + '/' + cert['name'] %}

{{ certificate_private_key(cert['name'], file_path + '.key', cert['algo']|default('ec'), cert['keysize']|default(256)) }}

{{ certificate(cert['name'], file_path + '.crt', file_path + '.key', cert['signing_policy']|default('root_ca'), 'sha384', cert['extendedKeyUsage']|default('clientAuth'), cert['days_valid']|default(365), cert['days_remaining']|default(30), cert['CN'], cert['O']|default('', true), cert['subjectAltName']|default('', true), False, False) }}

{%- endfor %}
