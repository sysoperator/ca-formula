{%- set tplroot = tpldir.split('/')[0] -%}
{%- from tplroot ~ "/map.jinja" import ca with context -%}
{%- from tplroot ~ "/vars.jinja" import
    ca_issued_certs_dir
with context -%}

{{ ca.pki_dir }}:
  file.directory:
    - mode: 755

{{ ca_issued_certs_dir }}:
  file.directory:
    - mode: 755
    - require:
      - file: {{ ca.pki_dir }}
