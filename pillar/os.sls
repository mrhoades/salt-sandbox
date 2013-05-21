
secrets:
  admin_token: foobar
  admin_password: kilgore
  demo_password: phooey
  service_password: blarg
  db_password: CHANGE_ME
  rabbit_password: guest

endpoints:
  db: 10.4.87.215
  nova: 10.4.87.215
  glance: 10.4.87.215
  quantum: 10.4.87.215
  keystone: 10.4.87.215
  rabbit: 10.4.87.215

nova:
  libvirt_type: qemu
  compute_driver: nova.virt.libvirt.LibvirtDriver

glance:
  default_images:
    cirros: "https://launchpad.net/cirros/trunk/0.3.0/+download/cirros-0.3.0-x86_64-disk.img"
    quantal: "http://cloud-images.ubuntu.com/quantal/current/quantal-server-cloudimg-amd64-disk1.img"

quantum:
  public_interface: eth1
  physical_bridge: br-ctlplane
  physical_network: ctlplane
  fixed_range: "192.0.2.32/29"
  ovs_range: "192.0.2.0/24"
