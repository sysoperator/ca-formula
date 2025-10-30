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

{%- set ca_path = ca.pki_dir + '/CA.crt' -%}

{%- for subCA in ca.sub_ca %}
  {%- set file_path = ca.pki_dir + '/' + subCA['name'] %}

{{ certificate_private_key(subCA['name'], file_path + '.key', subCA['algo']|default('ec'), subCA['keysize']|default(384)) }}

{{ cacertificate(subCA['name'], file_path + '.crt', file_path + '.key', 'subCA', 'root_ca', subCA['digest']|default('sha256'), subCA['days_valid']|default(1095), subCA['CN'], subCA['O']|default('', true), append_certs=[ca_path]) }}

{%- endfor %}
