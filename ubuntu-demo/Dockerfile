# Pull base image.
FROM ubuntu:latest
# Install software

RUN \
apt-get update && \
apt-get install -y software-properties-common && \
apt-get install -y curl git htop man unzip vim wget nano && \
apt-get install -y openssh-server && supervisor && nginx

RUN rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/sshd /var/log/supervisor
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Define working directory.
WORKDIR /

# Expose ports.
EXPOSE 22 80

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Define default command.
CMD ["/usr/bin/supervisord"]