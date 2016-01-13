# Pull base image.
FROM ubuntu:latest

# Install Nginx.
RUN \
  DEBIAN_FRONTEND=noninteractive \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  apt-get install -y nginx && \
  apt-get install -y openssh-server &&\
  chown -R www-data:www-data /var/lib/nginx && \
  echo "daemon off;" >> /etc/nginx/nginx.conf && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir /var/run/sshd && \
  add-apt-repository -y ppa:nginx/stable

  #rm -rf /var/lib/apt/lists/* && \
  #echo "\ndaemon off;" >> /etc/nginx/nginx.conf && \
  #chown -R www-data:www-data /var/lib/nginx


#RUN mkdir -p /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# Define mountable directories.
VOLUME ["/var/cache/nginx", "/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/log/nginx", "/var/www/html"]

# Define working directory.
WORKDIR /root

# Expose ports.
EXPOSE 22
EXPOSE 80
EXPOSE 443

ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf


# Define default command.
CMD ["nginx"]
#CMD ["/usr/bin/supervisord"]