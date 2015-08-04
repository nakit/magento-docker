FROM debian:jessie
MAINTAINER Nakit.com.br <odoo@nakit.com.br>

# Install nginx and php-fpm
RUN set -x; \
    apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
      bzr \
      ca-certificates \
      nginx \
      php5-curl \
      php5-fpm \
      php5-gd \
      php5-mcrypt \
      php5-mysql

# Configure nginx and php-fpm
COPY php-fpm.conf /etc/php5/fpm/php-fpm.conf
COPY nginx.conf   /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Install Magento
ENV MAGENTO_VERSION=1.9.2.1
ENV MAGENTO_PACKAGE=magento-${MAGENTO_VERSION}-2015-08-03-06-35-45.tar.gz
# wget -O /tmp/magento-1.9.2.1-2015-08-03-06-35-45.tar.gz "https://raw.githubusercontent.com/nakit/magento-docker/master/magento-1.9.2.1-2015-08-03-06-35-45.tar.gz"
COPY ${MAGENTO_PACKAGE} /tmp/${MAGENTO_PACKAGE}
RUN set -x; \
    tar -zxvf /tmp/${MAGENTO_PACKAGE} -C /var/lib && \
    rm -f /tmp/${MAGENTO_PACKAGE}

# Configure memcached
COPY mage-cache.xml /var/lib/magento/app/etc/mage-cache.xml
RUN set -x; \
    sed -e  '/<\/admin>/ r /var/lib/magento/app/etc/mage-cache.xml' \
        -i /var/lib/magento/app/etc/local.xml.template

# Install odoo connector
RUN set -x; \
    bzr branch lp:magentoerpconnect/magento-module-oerp6.x-stable /var/lib/magento-module && \
    ln -fs /var/lib/magento-module/Openlabs_OpenERPConnector-1.1.0/Openlabs /var/lib/magento/app/code/community/ && \
    ln -fs /var/lib/magento-module/Openlabs_OpenERPConnector-1.1.0/app/etc/modules/Openlabs_OpenERPConnector.xml /var/lib/magento/app/etc/modules

VOLUME ["/var/lib/magento", "/var/lib/magento-module"]

COPY start.sh /start.sh

ENTRYPOINT ["/start.sh"]
