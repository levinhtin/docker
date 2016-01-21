FROM nginx

#VOLUME ["/deploy/apdative/src"]
RUN mkdir -p /var/www/youlook-apdative
COPY nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]