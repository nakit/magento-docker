#! /bin/bash

set -o nounset
set -o errexit
set -o xtrace

if [ ! -e "${HOME}/firstrun" ]; then
  sed -e "s/<host>localhost/<host>db/g" \
      -e "s/<username\/>/<username>${DB_ENV_MYSQL_USER}<\/username>/" \
      -e "s/<password\/>/<password>${DB_ENV_MYSQL_PASSWORD}<\/password>/g" \
      -i /var/lib/magento/app/etc/config.xml

#   php -f /var/lib/magento/install.php -- \
#       --license_agreement_accepted yes \
#       --locale "${MAGENTO_LOCALE:-pt_BR}" \
#       --timezone "${MAGENTO_TIMEZONE:-America/Sao_Paulo}" \
#       --default_currency "${MAGENTO_CURRENCY:-BRL}" \
#       --db_host "db" \
#       --db_name "${DB_ENV_MYSQL_DATABASE:-magento}" \
#       --db_user "${DB_ENV_MYSQL_USER}" \
#       --db_pass "${DB_ENV_MYSQL_PASSWORD}" \
#       --url "${MAGENTO_URL}" \
#       --skip_url_validation \
#       --use_rewrites no \
#       --use_secure no \
#       --secure_base_url "" \
#       --use_secure_admin no \
#       --admin_username "${MAGENTO_ADMIN_USER:-admin}" \
#       --admin_password "${MAGENTO_ADMIN_PASS:-admin25}" \
#       --admin_email "${MAGENTO_ADMIN_EMAIL:-admin@localhost}" \
#       --admin_firstname "${MAGENTO_ADMIN_FIRSTNAME:-Admin}" \
#       --admin_lastname "${MAGENTO_ADMIN_LASTNAME:-Admin}"

  touch "${HOME}/firstrun"
fi

chown -R www-data:www-data /var/lib/magento /var/lib/magento-module
service php5-fpm start
nginx
