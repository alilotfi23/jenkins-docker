# Use a specific version of CentOS for reproducibility
FROM centos:7

# Set a maintainer label instead of MAINTAINER (deprecated)
LABEL maintainer="ali.lotfi.linux@gmail.com"

# Install necessary packages in a single RUN command to reduce layers
RUN yum install -y httpd zip unzip && \
    yum clean all && \
    rm -rf /var/cache/yum

# Download and extract the template in one step to minimize layers
RUN curl -L -o /tmp/hostit.zip https://www.free-css.com/assets/files/free-css-templates/download/page293/hostit.zip && \
    unzip /tmp/hostit.zip -d /var/www/html/ && \
    rm /tmp/hostit.zip

# Set the working directory
WORKDIR /var/www/html/hostit-html

# Move the extracted files to the web root and clean up
RUN cp -rvf * /var/www/html/ && \
    rm -rf /var/www/html/hostit-html

# Expose port 80 for the web server
EXPOSE 80

# Use exec form for CMD to ensure proper signal handling
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
