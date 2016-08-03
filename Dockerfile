FROM centos:latest
MAINTAINER adrianp@stindustries.net

# wget - command line utility (installed via. RPM)
#
# https://www.cvedetails.com/cve/CVE-2014-4877/
#
RUN yum -y install deltarpm && yum -y update
RUN curl -O http://vault.centos.org/7.0.1406/os/x86_64/Packages/wget-1.14-10.el7.x86_64.rpm
RUN yum -y install wget-1.14-10.el7.x86_64.rpm

# wget - command line utility (manual install)
#
# https://www.cvedetails.com/cve/CVE-2014-4877/
#
RUN yum -y install gnutls-devel gcc libidn-devel
RUN curl -O http://ftp.gnu.org/gnu/wget/wget-1.15.tar.gz
RUN tar zxf wget-1.15.tar.gz
RUN cd wget-1.15 && ./configure --prefix=/opt/wget && make && make install

# p7zip - command line utility (manual install)
#
# https://www.cvedetails.com/cve/CVE-2015-1038/
#
RUN yum -y install gcc-c++ bzip2
RUN curl -LO https://sourceforge.net/projects/p7zip/files/p7zip/9.20.1/p7zip_9.20.1_src_all.tar.bz2
RUN bzcat p7zip_9.20.1_src_all.tar.bz2 | tar x
RUN cd p7zip_9.20.1 && cp install.sh install.sh.orig
RUN cd p7zip_9.20.1 && cat install.sh.orig | sed -e 's|DEST_HOME=/usr/local|DEST_HOME=/opt/p7zip|g' > install.sh
RUN cd p7zip_9.20.1 && make && ./install.sh

# drupal - PHP application (manual install)
#
# http://www.cvedetails.com/vulnerability-list/vendor_id-1367/product_id-2387/version_id-192973/Drupal-Drupal-7.42.html
#
RUN curl -O https://ftp.drupal.org/files/projects/drupal-7.42.tar.gz
RUN tar zxf drupal-7.42.tar.gz && mkdir /opt/drupal
RUN cd drupal-7.42 && cp -R . /opt/drupal

# tomcat - Java application (manual install)
#
# https://www.cvedetails.com/cve/CVE-2016-3092/
#
RUN curl -O http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.tar.gz
RUN tar zxf apache-tomcat-7.0.69.tar.gz && mkdir /opt/tomcat
RUN cd apache-tomcat-7.0.69 && cp -R . /opt/tomcat

# tomcat - Java application (RPM install)
#
# CVE-2013-4590, CVE-2014-0119, CVE-2014-0099, CVE-2014-0096, CVE-2014-0075
#
RUN curl -O http://vault.centos.org/7.0.1406/os/x86_64/Packages/tomcat-7.0.42-4.el7.noarch.rpm
RUN curl -O http://vault.centos.org/7.0.1406/os/x86_64/Packages/tomcat-el-2.2-api-7.0.42-4.el7.noarch.rpm
RUN curl -O http://vault.centos.org/7.0.1406/os/x86_64/Packages/tomcat-jsp-2.2-api-7.0.42-4.el7.noarch.rpm
RUN curl -O http://vault.centos.org/7.0.1406/os/x86_64/Packages/tomcat-lib-7.0.42-4.el7.noarch.rpm
RUN curl -O http://vault.centos.org/7.0.1406/os/x86_64/Packages/tomcat-servlet-3.0-api-7.0.42-4.el7.noarch.rpm
RUN yum -y install yum install tomcat-7.0.42-4.el7.noarch.rpm tomcat-lib-7.0.42-4.el7.noarch.rpm tomcat-servlet-3.0-api-7.0.42-4.el7.noarch.rpm tomcat-el-2.2-api-7.0.42-4.el7.noarch.rpm tomcat-jsp-2.2-api-7.0.42-4.el7.noarch.rpm

# nodejs - Javascript (installed manually)
#
# https://www.cvedetails.com/vulnerability-list/vendor_id-12113/product_id-30764/version_id-192848/Nodejs-Node.js-0.10.41.html
#
RUN curl -O https://nodejs.org/dist/v0.10.41/node-v0.10.41-linux-x64.tar.gz
RUN tar zxf node-v0.10.41-linux-x64.tar.gz && mkdir /opt/nodejs
RUN cd node-v0.10.41-linux-x64 && cp -R . /opt/nodejs

# bash - command line utility (installed manually)
#
# https://www.cvedetails.com/vulnerability-list/vendor_id-72/product_id-21050/version_id-172000/GNU-Bash-4.3.html
#
RUN yum -y install bison
RUN curl -O http://ftp.gnu.org/gnu/bash/bash-4.3.tar.gz
RUN tar zxf bash-4.3.tar.gz && mkdir /opt/bash
RUN cd bash-4.3 && ./configure --prefix=/opt/bash && make && make install

# clean up
#
RUN rm -rf apache-tomcat-7.0.69 drupal-7.42 node-v0.10.41-linux-x64 p7zip_9.20.1 wget-1.15 bash-4.3
RUN rm -f /*.tar.gz && rm -f /*.rpm && rm -f /*.tar.bz2
