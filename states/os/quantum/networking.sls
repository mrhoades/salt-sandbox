
# TODO: don't run again if it's already done - it does `service networking restart`
salt://scripts/init-networking:
  - cmd.run
