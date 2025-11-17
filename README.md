# Proyecto Contenedor Web Linux

### GRUPO NÚMERO 6
### Integrantes:
* Francisco Javier Calderón Castro **CC18147**
* Jonathan Giovanni Hernández Recinos **HR24018**
* Marlon Alexis Núñez Ramos **NR24002**
* Javier Alexander Rodríguez Flores **RF24006**

## Preparación del Entorno Sevidor
### Administración Básica del Sistema
1. Instalación y configuración de una maquina virtual de Linux (Preferiblemente Ubuntu Server)
2. Asignar nombre al host del sistema: **servidor-grupo6**
3. Creación de usuarios: **adminsys, tecnico y visitante**
4. Creación de grupos: **soporte y web**
5. Asignación de grupos:
   * **adminsys** debe tener privilegios **sudo**
   * **tecnico** debe pertenecer al grupo **soporte**
   * **visitante** debe pertenecer al grupo **web**
6. Asegurarse de tener un servicio para la conexión remota con protocolo SSH (como OpenSSH)
7. Para conectarse usar el servicio SSH y utilizar la IP de la máquina virtual

### Estructura de Directorios y Permisos
* **datos/**: Contiene la configuración del contenedor Docker.  
* **web/**: Contiene la página web con sus archivos CCS y JS.  
* **scripts/**: Contiene los scripts de automatización de reportes.  
* **capturas/**: Contiene evidencias del desarrollo del proyecto.

## Automatización y Monitoreo
### Script de Monitoreo del Sistema
```
#!/bin/bash
#Reporte del sistema

echo "=========================================================="
echo "REPORTE DEL SISTEMA - $(date '+%d/%m/%Y %H:%M:%S')"
echo "=========================================================="

#Hora y fecha actual
echo "Fecha y hora actual: $(date '+%d/%m/%Y %H:%M:%S')"

#Nombre del host del sistema
echo "Nombre del host: $(hostname)"

#Números de usuarios conectados
echo "Usuarios conectados: $(who | wc -l)"

#Espacio libre de disco principal
echo "Espacio libre en disco(/):"
df -h / | awk 'NR==2 {print $4 " libres de " $2}'

#Memoria RAM disponible
echo "Memoria RAM disponible:"
free -h | awk '/Mem:/ {print $7 " libres de " $2}'

#Número de contenedores Docker activos
echo "Numero de contenedores Docker activos:"
if command -v docker &> /dev/null; then
    activos=$(docker ps -q | wc -l)
    echo "Contenedores Docker activos: $activos"
else
    echo "Docker no esta instalado en el sistema"
fi

echo "=========================================================="
```
### Automatización con Cron
Tarea en archivo Crontab:  
```*/30 * * * * /proyecto/scripts/reporte_sistema.sh >> /var/log/proyecto/reporte_sistema.log 2>&1```

## Sevidor Web en Contenedor Nginx
###### Usaremos Docker para la creación de nuestro contenedor Nginx
```docker run -d -p 8080:80 -v /proyecto/web/:/usr/share/nginx/html/ --name servidor-web nginx```

| Parámetro  | Descripción |
| ------------- |:-------------:|
| -d   | Ejecuta el contenedor en segundo plano (detached).     |
| -p 8080:80      | Mapea el puerto 8080 del host al puerto 80 del contenedor.     |
| -v /proyecto/web/:/usr/share/nginx/html/    | Monta el directorio local /proyecto/web/ en el directorio raíz de Nginx dentro del contenedor.     |
| --name servidor-web     | Asigna un nombre al contenedor.    |
| nginx    | Especifica la imagen oficial de Nginx a usar.     |

## Docker Avanzado
### Creación de un Dockerfile Personalizado

Contenido del Dockerfile:
```
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
```
### Imagen Personalizada y Ejecución

Construir imagen personalizada:
```sudo docker build -t servidor-grupo6 -f Dockerfile ..```

Ejecutar contenedor Docker con la imagen:
```sudo docker run -d -p 8081:80 --name app-web servidor-grupo6```

### Capturas de Pantalla
Acceder al servidor desde sistema remoto (Windows).
<img width="1366" height="768" alt="Conectarse Remotamente" src="https://github.com/user-attachments/assets/852187a6-8a49-4b75-bddb-b3b53a4e6b7d" />

Mostrar usuarios del proyecto.
<img width="1366" height="768" alt="Mostrar Usuarios" src="https://github.com/user-attachments/assets/4d98399c-88ac-48eb-a1e5-ccb84a7cffa4" />

Estructura de archivos del proyecto.
<img width="1366" height="768" alt="Estructura de Archivos del Proyecto" src="https://github.com/user-attachments/assets/638425aa-1980-4a8f-8052-129be5e750da" />

Mostrar logs del script de monitoreo.
<img width="1366" height="768" alt="Logs del script de Monitoreo" src="https://github.com/user-attachments/assets/8e27612b-a652-4b09-9618-3f30a92005a9" />

Inicar contenedor Docker y logs de inicio.
<img width="1366" height="768" alt="Iniciar Contenedor Docker" src="https://github.com/user-attachments/assets/eed4aa6d-40a6-43f1-9472-c8891f340db0" />

Proyecto web visto en el navegador.
<img width="1366" height="768" alt="Proyecto en Navegador" src="https://github.com/user-attachments/assets/a52feca5-877f-4aad-ab3e-06f7b132b29c" />
