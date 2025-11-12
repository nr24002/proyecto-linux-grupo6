# Usa la imagen base oficial de Nginx.
FROM nginx:latest

# Elimina el contenido por defecto de Nginx en la carpeta HTML.
# Esto asegura que solo se sirvan tus archivos.
RUN rm -rf /usr/share/nginx/html/*

# Copia todo el contenido del directorio 'web' del host
# al directorio raíz de Nginx dentro del contenedor.
COPY web/ /usr/share/nginx/html/

#Exponer el puerto 80.
EXPOSE 80

#Comando de incio de Nginx.
CMD ["nginx", "-g", "daemon off;"]

