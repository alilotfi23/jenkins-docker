FROM  centos:7
MAINTAINER ali.lotfi.linux@gmail.com
RUN yum install -y httpd \
 zip\
 unzip
ADD https://www.free-css.com/assets/files/free-css-templates/download/page295/edgecut.zip /var/www/html/
WORKDIR /var/www/html/
RUN unzip edgecut.zip
RUN cp -rvf edgecut/* .
RUN rm -rf edgecut edgecut.zip
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
EXPOSE 80

