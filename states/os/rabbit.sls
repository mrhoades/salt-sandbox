
rabbitmq-server:
  pkg.installed

rabbitmq-service:
  service:
    - name: rabbitmq-server
    - running
