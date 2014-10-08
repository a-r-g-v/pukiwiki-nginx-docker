FROM debian:wheezy
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y apt-utils wget unzip 
ADD nginx.list /etc/apt/source.list.d/sources-nginx.list

RUN wget -O - http://nginx.org/keys/nginx_signing.key | apt-key add - &&\
    apt-get update && apt-get install -y nginx php5-fpm php5&& \
    update-rc.d nginx defaults && \
    update-rc.d php5-fpm defaults

ADD pukiwiki.conf /etc/nginx/sites-available/pukiwiki.conf
RUN ln -s /etc/nginx/sites-available/pukiwiki.conf /etc/nginx/sites-enabled &&\
    rm /etc/nginx/sites-enabled/default

ADD pukiwiki-1_5_0_utf8.zip /pukiwiki.zip

RUN unzip /pukiwiki.zip  && \
     mv pukiwiki-1_5_0_utf8/ pukiwiki/ && \
     chown -R www-data:www-data /pukiwiki && \

WORKDIR /etc/nginx
EXPOSE 80

CMD ["/sbin/init"]



