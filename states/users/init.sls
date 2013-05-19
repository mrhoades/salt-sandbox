
{% for user in pillar['users'] %}
{{ user }}:
  user.present:
    - shell: /bin/bash

{{ pillar['users'][user] }}-sshkey:
  ssh_auth:
    - present
    - user: {{ user }}
    - enc: ssh-rsa
    - require:
        - user.present: {{ user }}
{% endfor %}
