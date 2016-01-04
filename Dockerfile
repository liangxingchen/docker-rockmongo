FROM alpine
MAINTAINER Liang Xingchen <liang@maichong.it>
RUN apk upgrade --update && \
    apk add php-cli php-dev php-pear autoconf openssl-dev g++ make && \
    pear update-channels && \
    php /usr/share/pear/peclcmd.php install -f mongo && \
    echo "extension=mongo.so" >> /etc/php/php.ini && \
    apk del --purge php-dev php-pear autoconf openssl-dev g++ make
ADD . /rockmongo
WORKDIR /rockmongo
EXPOSE 80
CMD ["php","-S","0.0.0.0:80"]
