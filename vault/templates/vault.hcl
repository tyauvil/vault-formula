
{% if consul_address != 'None' %}
backend "consul" {
  address = "{{ consul_address }}:8500"
  path = "vault"
}
{% else %}
backend "file" {
  path = "/data/vault"
}
{% endif %}

listener "tcp" {
  address = "0.0.0.0:8200"
  tls_disable = 1
}

{% if statsd_address != 'None' %}
telemetry {
  statsd_address = "{{ statsd_address }}:8125"
}
{% endif %}
