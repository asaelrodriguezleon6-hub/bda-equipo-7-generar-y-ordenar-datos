# Ejercicio: Generación y ordenamiento de datos

## Objetivo

Generar cuatro archivos de texto aleatorio de aproximadamente 1 MB cada uno y ordenarlos con MapReduce.

## Instrucciones

1. Generar cuatro archivos de texto.
2. Guardarlos en una misma carpeta.
3. Ordenar los archivos utilizando Sort.
4. Comprobar el número de divisiones de entrada.
5. Mostrar las primeras diez líneas del resultado.

## Ejecución

En la terminal de Ubuntu:

```bash
docker cp scripts/ejercicio.sh hadoop:/opt/equipo7/ejercicio.sh
docker exec -it hadoop bash /opt/equipo7/ejercicio.sh
```

## Resultados

- Archivos de entrada: 4.
- Divisiones de Sort: 4.
- Archivo ordenado: 4.1 MB.
- Ejecución completada.

## Solución

El script `scripts/ejercicio.sh` genera cuatro archivos de texto de aproximadamente 1 MB cada uno.

Después utiliza Sort para ordenar los datos. Los resultados se guardan dentro del contenedor.
