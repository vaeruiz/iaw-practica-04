# Práctica IAW 4

## Creando la máquina front_end

En esta práctica deberemos crear una segunda máquina que hará también de front_end para más adelante hacer un balanceo de carga con la primera máquina front, pero en esta práctica dejaremos la máquina preparada solamente.

Creamos una nueva instancia en las máquinas de AWS de la misma forma que hemos estado haciendo hasta ahora, cuando lleguemos a los grupos de seguridad de la máquina añadiremos los 3 mismos puertos que le añadimos a la máquina front_end, recordemos que los puertos a abrir eran HTTP (80), HTTPS (443), y el MySQL (3306).

## Configurando la máquina

Una vez que se haya creado la máquina nos conectaremos a ella y clonaremos el repositorio de Github.

>git clone https://github.com/vaeruiz/iaw-practica-04.git

Cuando se haya descargado el repositorio movemos el script a /home/ubuntu:

>mv iaw-practica-03/front_end.sh ./

Hecho esto le añadimos los permisos de ejecución:

>sudo chmod +x front_end.sh

Y lo ejecutamos:

>sudo ./front_end.sh

Esta vez el script está corregido, lo único que tendremos que hacer es añadir la dirección IP de la máquina back_end a la variable (que recordemos que cambia con cada nuevo inicio de la máquina) y todo debe quedar en orden.
