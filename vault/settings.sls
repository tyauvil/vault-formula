{% set p    = pillar.get('vault', {}) %}
{% set pc   = p.get('config', {}) %}
{% set g    = grains.get('vault', {}) %}
{% set gc   = g.get('config', {}) %}


{%- set vault = {} %}
{%- do vault.update({
  'statsd_address'          : pc.get('statsd_address'),
  'consul_address'          : pc.get('consul_address')

  }) %}
