# Realizar copia de seguridad

Para realizar la copia de seguridad planificada, hay que ejecutar:

```bash
crontab -e
```

Después, seleccionar el editor de ficheros, **preferiblemente nano o vi**, después seguiremos la siguiente plantilla para establecer la planificación:

```bash
.---------------- minute (0 - 59)
|  .------------- hour (0 - 23)
|  |  .---------- day of month (1 - 31)
|  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
|  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
|  |  |  |  |
*  *  *  *  * user-name command to be executed
```

En mi caso, quiero que la copia de seguridad se ejecute a las 23:30 de cada sábado, por lo que siguiendo la plantilla, primero pondremos los minutos, 30, y la hora, 23.

A continuación como no queremos que se ejecute un día concreto, pondremos asterisco (*), y como tampoco interesa que se ejecute un mes concreto, usaremos otro asterisco.

Como nos interesa que se ejecute los sábados, pondremos un 6 ya que el domingo es tanto el 0 como el 7 y de esta forma el sábado está en la sexta posición.

Después indicaremos el usuario que queremos que ejecute el script o comando, el usuario root, y por último, indicaremos el comando o la ruta del script.

```bash
30 23 * * 6 root ./path/to/backup.sh
```

Guardaremos los cambios según el editor que hayamos escogido y comprobaremos que se ha guardado correctamente la tarea planificada mediante:

```bash
crontab -l
```

Deberá salir la tarea que hemos creado.
