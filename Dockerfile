## redbook-platform

## Base platform for a redbook instance

FROM phusion/baseimage:0.9.13

RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

CMD ["/sbin/my_init"]

ENV HOME /home
ENV EDITOR /usr/bin/vim 
ADD ssh_key.pub /tmp/ssh_key.pub

RUN cat /tmp/ssh_key.pub >> /root/.ssh/authorized_keys && rm -f /tmp/ssh_key.pub

ADD excludes /etc/dpkg/dpkg.cfg.d/excludes

RUN apt-get update && apt-get -y --no-install-recommends install php5 php5-mysql php5-json php5-curl

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /etc/service/apache2
ADD apache-run /etc/service/apache2/run
RUN chmod 755 /etc/service/apache2/run && \
	rm /etc/apache2/sites-available/000-default.conf && \
	ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/ && \
	ln -s /etc/apache2/mods-available/expires.load /etc/apache2/mods-enabled/

ADD apache.conf /etc/apache2/sites-available/000-default.conf
ADD crontab /var/spool/cron/crontabs/www-data

RUN chmod 0600 /var/spool/cron/crontabs/www-data && \
	chown www-data:www-data /var/spool/cron/crontabs/www-data && \
	echo 'Australia/Brisbane' > /etc/timezone && dpkg-reconfigure -f noninteractive tzdata

VOLUME ["/app"]
