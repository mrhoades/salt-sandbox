
secrets:
  admin_token: foobar
  admin_password: kilgore
  demo_password: phooey
  service_password: blarg
  db_password: CHANGE_ME
  rabbit_password: guest

endpoints:
  db: 10.4.64.31
  nova: 10.4.64.31
  glance: 10.4.64.31
  quantum: 10.4.64.31
  keystone: 10.4.64.31
  rabbit: 10.4.64.31

nova:
  libvirt_type: qemu
  compute_driver: nova.virt.libvirt.LibvirtDriver

glance:
  default_images:
    cirros: "https://launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img"
    quantal: "http://cloud-images.ubuntu.com/quantal/current/quantal-server-cloudimg-amd64-disk1.img"

network:
  interfaces:
    control: TODO - needed by quantum
