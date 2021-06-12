# base image
FROM centos:7.4.1708

# install php7.1 and extensions
RUN yum install epel-release -y \
    && rpm -ivh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm \
    && yum install -y php71w php71w-fpm php71w-cli php71w-common php71w-devel php71w-gd php71w-pdo php71w-mysql php71w-mbstring php71w-bcmath php71w-pecl-redis php71w-ldap php71w-mcrypt php71w-soap \
    && yum install -y https://vault.centos.org/7.4.1708/os/x86_64/Packages/LibRaw-0.14.8-5.el7.20120830git98d925.x86_64.rpm \
    && yum install -y http://ftp.pbone.net/mirror/rpms.remirepo.net/enterprise/7/safe/x86_64/ImageMagick6-libs-6.9.9.26-1.el7.remi.x86_64.rpm \
    && yum install -y https://vault.centos.org/7.4.1708/os/x86_64/Packages/ImageMagick-6.7.8.9-15.el7_2.x86_64.rpm \
    && yum install -y php71w-pecl-imagick

# install wkhtmltopdf, for testing, run: wkhtmltopdf http://www.baidu.com/ website1.pdf
RUN yum install -y wkhtmltopdf \
    && yum install -y urw-fonts libXext wqy-microhei-fonts \
    &&  yum -y install xorg-x11-server-Xvfb \
    && mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf2 \
    && echo "xvfb-run -a --server-args=\"-screen 0, 1024x768x24\" /usr/bin/wkhtmltopdf2 --javascript-delay 10000 -q \$*" > /usr/bin/wkhtmltopdf \
    && chmod a+x /usr/bin/wkhtmltopdf

# install python3 and extensions
RUN yum install -y python3 python3-devel mysql-devel gcc \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && pip install pymysql==0.9.3 \
    && pip install xlwt==1.3.0 \
    && pip install parse==1.12.0 \
    && pip install xlrd==1.2.0 \
    && pip install numpy==1.16.3 \
    && pip install pdfkit==0.6.1 \
    && pip install threadpool==1.3.2 \
    && pip install pillow==6.0.0 \
    && pip install pillow \
    && pip install pinyin \
    && pip install mysqlclient==1.3.13

# install nginx
RUN yum install -y nginx

# run php-fpm by default on startup
CMD [ "/bin/bash", "-c", "/usr/sbin/php-fpm && /usr/sbin/nginx -g 'daemon off;'" ]

EXPOSE 80


