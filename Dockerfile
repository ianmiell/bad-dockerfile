FROM centos:centos7.2.1511
MAINTAINER adrianp@stindustries.net

# Prep environment
#
RUN yum -y install deltarpm && yum -y update

# Install build utils
#
RUN touch /var/lib/rpm/* && \
    yum -y install bison gnutls-devel gcc libidn-devel gcc-c++ bzip2 && \
    yum clean all

# wget - command line utility (installed via. RPM)
#
# https://www.cvedetails.com/cve/CVE-2014-4877/
#
RUN curl -O http://vault.centos.org/7.0.1406/os/x86_64/Packages/wget-1.14-10.el7.x86_64.rpm && \
    yum -y install wget-1.14-10.el7.x86_64.rpm && \
    rm *.rpm

# wget - command line utility (manual install)
#
# https://www.cvedetails.com/cve/CVE-2014-4877/
#
RUN curl -O http://www.mirrorservice.org/sites/ftp.gnu.org/gnu/wget/wget-1.15.tar.gz && \
    tar zxf wget-1.15.tar.gz && \
    cd wget-1.15 && \
    ./configure --prefix=/opt/wget && \
    make && \
    make install && \
    cd .. && \
    rm -rf wget-1.15 && \
    rm *.tar.gz

# p7zip - command line utility (manual install)
#
# https://www.cvedetails.com/cve/CVE-2015-1038/
#
RUN curl -LO https://sourceforge.net/projects/p7zip/files/p7zip/9.20.1/p7zip_9.20.1_src_all.tar.bz2 && \
    bzcat p7zip_9.20.1_src_all.tar.bz2 | tar x && \
    cd p7zip_9.20.1 && \
    cp install.sh install.sh.orig && \
    cat install.sh.orig | sed -e 's|DEST_HOME=/usr/local|DEST_HOME=/opt/p7zip|g' > install.sh && \
    make && \
    ./install.sh && \
    cd - && \
    rm -rf p7zip_9.20.1 && \
    rm *.tar.bz2

# drupal - PHP application (manual install)
#
# http://www.cvedetails.com/vulnerability-list/vendor_id-1367/product_id-2387/version_id-192973/Drupal-Drupal-7.42.html
#
RUN curl -O https://ftp.drupal.org/files/projects/drupal-7.42.tar.gz && \
    tar zxf drupal-7.42.tar.gz && \
    mkdir /opt/drupal && \
    cd drupal-7.42 && \
    cp -R . /opt/drupal && \
    cd - && \
    rm -rf drupal-7.42 && \
    rm -f *.tar.gz

# tomcat - Java application (manual install)
#
# https://www.cvedetails.com/cve/CVE-2016-3092/
#
RUN curl -O http://archive.apache.org/dist/tomcat/tomcat-7/v7.0.69/bin/apache-tomcat-7.0.69.tar.gz && \
    tar zxf apache-tomcat-7.0.69.tar.gz && \
    mkdir /opt/tomcat && \
    cd apache-tomcat-7.0.69 && \
    cp -R . /opt/tomcat && \
    cd - && \
    rm -rf apache-tomcat-7.0.69 && \
    rm -f *.tar.gz

# OpenJDK - Java (RPM install)
#
#
RUN curl -O http://mirror.centos.org/centos/7/updates/x86_64/Packages/java-1.8.0-openjdk-1.8.0.91-0.b14.el7_2.x86_64.rpm && \
    curl -O http://mirror.centos.org/centos/7/updates/x86_64/Packages/java-1.8.0-openjdk-headless-1.8.0.91-0.b14.el7_2.x86_64.rpm && \
    touch /var/lib/rpm/* && \
    yum -y install java-1.8.0-openjdk-1.8.0.91-0.b14.el7_2.x86_64.rpm java-1.8.0-openjdk-headless-1.8.0.91-0.b14.el7_2.x86_64.rpm && \
    rm -f *.rpm && \
    echo "exclude=java-1.8.0-openjdk java-1.8.0-openjdk-headless"  >> /etc/yum.conf

# tomcat - Java application (RPM install)
#
# CVE-2013-4590, CVE-2014-0119, CVE-2014-0099, CVE-2014-0096, CVE-2014-0075
#
RUN curl -O http://vault.centos.org/7.0.1406/os/x86_64/Packages/tomcat-7.0.42-4.el7.noarch.rpm && \
    curl -O http://vault.centos.org/7.0.1406/os/x86_64/Packages/tomcat-el-2.2-api-7.0.42-4.el7.noarch.rpm && \
    curl -O http://vault.centos.org/7.0.1406/os/x86_64/Packages/tomcat-jsp-2.2-api-7.0.42-4.el7.noarch.rpm && \
    curl -O http://vault.centos.org/7.0.1406/os/x86_64/Packages/tomcat-lib-7.0.42-4.el7.noarch.rpm && \
    curl -O http://vault.centos.org/7.0.1406/os/x86_64/Packages/tomcat-servlet-3.0-api-7.0.42-4.el7.noarch.rpm && \
    touch /var/lib/rpm/* && \
    yum -y install yum install tomcat-7.0.42-4.el7.noarch.rpm tomcat-lib-7.0.42-4.el7.noarch.rpm tomcat-servlet-3.0-api-7.0.42-4.el7.noarch.rpm tomcat-el-2.2-api-7.0.42-4.el7.noarch.rpm tomcat-jsp-2.2-api-7.0.42-4.el7.noarch.rpm && \
    rm -f *.rpm

# nodejs - Javascript (installed manually)
#
# https://www.cvedetails.com/vulnerability-list/vendor_id-12113/product_id-30764/version_id-192848/Nodejs-Node.js-0.10.41.html
#
RUN curl -O https://nodejs.org/dist/v0.10.41/node-v0.10.41-linux-x64.tar.gz && \
    tar zxf node-v0.10.41-linux-x64.tar.gz && \
    mkdir /opt/nodejs && \
    cd node-v0.10.41-linux-x64 && \
    cp -R . /opt/nodejs && \
    cd - && \
    rm -rf node-v0.10.41-linux-x64 && \
    rm -rf *.tar.gz

# bash - command line utility (installed manually)
#
# https://www.cvedetails.com/vulnerability-list/vendor_id-72/product_id-21050/version_id-172000/GNU-Bash-4.3.html
#
RUN curl -O https://ftp.heanet.ie/mirrors/gnu/bash/bash-4.3.tar.gz && \
    tar zxf bash-4.3.tar.gz && \
    mkdir /opt/bash && cd bash-4.3 && \
    ./configure --prefix=/opt/bash && \
    make && \
    make install && \
    cd .. && \
    rm -rf bash-4.3 && \
    rm -rf *.tar.gz

# rpmsquirt
#
RUN touch /var/lib/rpm/* && \
    yum -y install rpm-build redhat-rpm-config rpmdevtools
COPY rpmsquirt.sh /rpmsquirt.sh
COPY rpmsquirt.dat /
RUN /rpmsquirt.sh 

# Precautionary failure with messages
#
CMD echo 'Vulnerable image' && /bin/false
