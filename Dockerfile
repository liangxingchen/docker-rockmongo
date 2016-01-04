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

# USEAGE
# docker run -it --rm -p 8080:80 -v /path/to/config.php:/rockmongo/config.php maichong/rockmongo
# docker run -it --rm -p 8080:80 -e "ADMIN_USER=admin" -e "ADMIN_PASS=password" maichong/rockmongo
# docker run -it --rm -p 8080:80 -e "ADMIN_USER=admin" -e "ADMIN_PASS=password" maichong/rockmongo php -d upload_max_filesize=100M -d post_max_size=100M -S 0.0.0.0:80
