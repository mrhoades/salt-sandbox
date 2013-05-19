
include:
  - os.nova

dnsmasq:
  pkg.installed

dnsmasq-utils:
  pkg.installed

ebtables:
  pkg.installed

libvirt:
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

nova-compute-service:
  service:
    - name: nova-compute
    - running
    - watch:
      - file: /etc/nova/nova.conf
