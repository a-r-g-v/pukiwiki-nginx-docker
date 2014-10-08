FROM debian:wheezy
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y apt-utils wget 
ADD nginx.list /etc/apt/source.list.d/sources-nginx.list

RUN wget -O - http://nginx.org/keys/nginx_signing.key | apt-key add - &&\
    apt-get update && apt-get install -y nginx && \
    update-rc.d nginx defaults

WORKDIR /etc/nginx
EXPOSE 80

CMD ["/sbin/init"]



