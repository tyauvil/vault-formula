{%- from 'vault/settings.sls' import vault with context %}

unzip:
  pkg.installed

vault-installer:
  archive.extracted:
    - name: /usr/local/bin/
    - source: https://releases.hashicorp.com/vault/0.5.2/vault_0.5.2_linux_amd64.zip
    - source_hash: sha256=7517b21d2c709e661914fbae1f6bf3622d9347b0fe9fc3334d78a01d1e1b4ec2
    - archive_format: zip
    - user: root
    - group: root
    - if_missing: /usr/local/bin/vault
    - require:
      - pkg: unzip

/etc/vault/config.hcl:
  file.managed:
    - source: salt://vault/templates/vault.hcl
    - template: jinja
    - user: root
    - group: root
    - makedirs: True
    - context:
        statsd_address: {{ vault.statsd_address }}
        consul_address: {{ vault.consul_address }}

{% if not vault.consul_address %}
/data/vault:
  file.directory:
    - makedirs: True
{% endif %}

/etc/init/vault.conf:
  file.managed:
    - source: salt://vault/files/upstart.conf
    - user: root
    - password: root

vault:
  service.running:
    - enable: True
    - watch:
      - file: /etc/vault/config.hcl
      - file: /etc/init/vault.conf
    - require:
      - file: /etc/init/vault.conf
      - file: /etc/vault/config.hcl
      - archive: vault-installer
