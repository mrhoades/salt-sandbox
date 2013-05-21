
include:
  - os.nova

dnsmasq:
  pkg.installed

dnsmasq-utils:
  pkg.installed

ebtables:
  pkg.installed

libvirt-bin:
  pkg.installed

python-libvirt:
  pkg.installed

kvm:
  pkg.installed

pm-utils:
  pkg.installed

/etc/init/nova-compute.conf:
  file:
    - managed
    - source: salt://os/nova/etc/nova-compute.upstart

/etc/init/nova-api-metadata.conf:
  file:
    - managed
    - source: salt://os/nova/etc/nova-api-metadata.upstart

nova-compute-service:
  service:
    - name: nova-compute
    - running
    - watch:
      - file: /etc/nova/nova.conf

nova-api-metadata-service:
  service:
    - name: nova-api-metadata
    - running
    - watch:
      - file: /etc/nova/nova.conf

usermod -a -G libvirtd nova:
  cmd.run:
    - requires:
      - user: nova
      - pkg: libvirt-bin
