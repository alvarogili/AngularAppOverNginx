# Web Angular instalada en Nginx server usando Docker
Ejemplo de como generar una imagen Docker con un servidor Nginx y nuestra Web Angular

## Archivos incluídos

### **Dockerfile**
 Este archivo contiene la definición de nuestra imagen Docker con el siguiente contenido:

 ```docker
# base image
FROM nginx:latest

COPY dist /usr/share/nginx/html

# expose port 80
EXPOSE 80

# run nginx
CMD ["nginx", "-g", "daemon off;"]

```
La primer línea hace referencia a la última imagen disponible de ngnix. La segunda, copia la carpeta `dist` de nuestro proyecto a la carpeta `/usr/share/nginx/html` del servidor. La tercera indica que el puerto en donde va a publicar la web nuestro servidor es el 80 y la última línea, inicia el servicio **Nginx**.

### **docker-compose**

Este archivo define el entorno de ejecución de nuestra aplicación. El contenido es el siguiente:

```yml
version: '3.1'

services:

  my-nginx:
    image: myApp:0.0.1
    container_name: myApp
    restart: always
    ports:
      - 80:80
```

El contenido a destacar de este archivo es que va a publicarse el puerto 80 como público.

### **generar_docker.sh**

Este archivo bash generará nuestra imagen docker y ejecutará el contenedor para que nuestra Web quede disponible en nuestro puerto 80. El contenido: 

```bash
#!/bin/sh

VERSION=0.0.1
NAME=myApp

echo compilando ${NAME} version ${VERSION}
ng build
echo Creando imagen docker
sudo docker build -t "${NAME}:${VERSION}" -f ./Dockerfile ./
echo Ejecutando imagen docker
sudo docker-compose -f docker-compose.yml up -d
```

La línea `ng build` genera la carpeta dist de nuestro proyecto Angular. Luego las siguientes líneas crean la imagen con el nombre `myApp:0.0.1` y la ejecutan.

Si todo funcionó de manera correcta podremos ver nuestra web en [http://localhost:80](http://localhost:80 "http://localhost:80")