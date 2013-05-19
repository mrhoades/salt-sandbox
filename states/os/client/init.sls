
pip install git+https://github.com/openstack/python-novaclient.git:
  cmd.run
pip install git+https://github.com/openstack/python-glanceclient.git:
  cmd.run
pip install git+https://github.com/openstack/python-keystoneclient.git:
  cmd.run
pip install git+https://github.com/openstack/python-quantumclient.git:
  cmd.run

/root/stackrc:
  file:
    - managed
    - source: salt://os/client/stackrc
    - template: jinja
    - context:
        endpoints: {{ pillar['endpoints'] }}
        secrets: {{ pillar['secrets'] }}
