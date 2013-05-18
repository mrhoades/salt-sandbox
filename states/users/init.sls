
{% for user in pillar['users'] %}
{{ user }}:
  user.present:
    - shell: /bin/bash

{{ pillar['users'][user] }}:
  ssh_auth:
    - present
    - user: {{ user }}
    - enc: ssh-rsa
{% endfor %}
