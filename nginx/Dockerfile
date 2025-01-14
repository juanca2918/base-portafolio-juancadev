FROM nginx:bookworm

RUN mkdir -p /etc/nginx/sites-available && \
    mkdir -p /etc/nginx/sites-enabled
RUN chmod 755 /etc/nginx/sites-enabled && \
    chmod 755 /etc/nginx/sites-available
COPY ./nginx/nginx.conf /etc/nginx/sites-available/kds_restaurante.conf
RUN ln -s /etc/nginx/sites-available/kds_restaurante.conf /etc/nginx/sites-enabled/kds_restaurante.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]