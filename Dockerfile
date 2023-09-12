FROM  centos:7
MAINTAINER ali.lotfi.linux@gmail.com
RUN yum install -y httpd \
 zip\
 unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page294/namari.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip namari.zip
RUN cp -rvf namari/* .
RUN rm -rf namari namari.zip
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80
