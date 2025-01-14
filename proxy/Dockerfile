FROM nginx:bookworm

# Copia la configuración del proxy
COPY ./proxy/proxy.conf /etc/nginx/conf.d/default.conf

# Expone el puerto 8080
EXPOSE 80