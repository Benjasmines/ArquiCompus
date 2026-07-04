#Arquitectura de Computadores

Para que funcione el despliegue es necesario tener awsCLI configurado y terraform tambien

y tener en cuenta que cuando se quiera hacer la pirmera query como la siguiente de ejemplo saber cuan es el bucket ue tienes

```bash
CREATE EXTERNAL TABLE base_datos_investigacion.productos_test (
  id INT,
  nombre STRING,
  precio DOUBLE,
  categoria STRING
)
STORED AS PARQUET
LOCATION 's3://REEMPLAZA_AQUI_CON_TU_BUCKET/datos_productos/';
```

el formato es reemplazable y es necesario asignar la locacion del s3 y por eso saber el nombre de tu bucket.
el rest de las querys es como toda la vida en SQL
