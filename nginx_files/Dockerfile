FROM nginx:1.23.0
WORKDIR /usr/scripts/
COPY nginx.conf /etc/nginx/
COPY Task6.conf /etc/nginx/sites-enable/Task6.conf
COPY www/ /var/www/html
COPY www/image1.jpg /var/www/html/image1/
COPY www/image2.png /var/www/html/image2/
COPY music/ /var/www/music

COPY StatPage.html /var/www/html/StatPage.html
COPY task6_1.sh /usr/scripts/task6_1.sh
COPY start.sh /usr/scripts/start.sh
RUN chmod +x /usr/scripts/start.sh 

RUN chown -R nginx:nginx /var/www/html /var/www/music
RUN mkdir -p /var/cache/nginx/client_temp && \
    chown -R nginx:nginx /var/cache/nginx
RUN touch /var/run/nginx.pid && \
    chown nginx:nginx /var/run/nginx.pid
RUN touch /var/www/html/backup.sql
RUN chmod +x /usr/scripts/task6_1.sh 
RUN apt-get update && \
    apt-get install -y procps
RUN ./task6_1.sh&
# apt-get update && \
# apt-get install -y supervisor && \
# apt-get install -y procps

#CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/supervisord.conf"]
CMD ["/usr/scripts/start.sh"]
#CMD ["nginx", "-g", "daemon off;"]
USER nginx
