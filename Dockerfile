FROM nginx:1.26.2-alpine

RUN apk add --no-cache certbot

COPY ./renew-certbot-entrypoint.sh /renew-certbot-entrypoint.sh

ENTRYPOINT ["/renew-certbot-entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
