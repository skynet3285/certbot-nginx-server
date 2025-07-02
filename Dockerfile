FROM nginx:1.28.0-alpine

RUN apk add --no-cache certbot

# ref https://github.com/nginxinc/docker-nginx/blob/master/entrypoint/20-envsubst-on-templates.sh
COPY ./default.conf.template /etc/nginx/templates/default.conf.template

COPY ./renew-certbot.sh /renew-certbot.sh

COPY ./bootstrap.sh /bootstrap.sh

ENTRYPOINT ["/bootstrap.sh"]

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
