## redbook-platform

## Base platform for a redbook instance

FROM maxexcloo/nginx-php:latest

RUN mkdir /app
ADD Redbook /app

ADD supervisord-redbook.conf /etc/supervisor/conf.d/redbook.conf
ADD nginx-host.conf /etc/nginx/host.d/default.conf
ADD nginx-php.conf /etc/nginx/addon.d/default-php.conf
ADD init-timezone /config/init-timezone
ADD init-redbook /config/init-redbook
#ADD nginx-php.conf /etc/nginx/addon.d/default-php.conf

## ADD SSh
RUN apt-get install -y -qq openssh-server vim curl git
RUN mkdir -p /var/run/sshd
ADD supervisord-sshd.conf /etc/supervisor/conf.d/sshd.conf
EXPOSE 22
ADD ssh_key.pub /root/.ssh/authorized_keys 

RUN chown -R core:core /app \
	&& curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/bin --filename=composer \
	&& /usr/bin/composer install --no-dev -n -d /app

VOLUME ["/app/config", "/app/log"]
