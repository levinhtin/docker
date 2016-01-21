FROM ubuntu:latest

RUN apt-get install -y vim
RUN apt-get update && apt-get install -y openssh-server supervisor
RUN mkdir -p /var/run/sshd /var/log/supervisor

COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 80 22 3306

CMD ["/usr/bin/supervisord"]
