# Mini Ejercicio: Generación y Ordenamiento Controlado

## Objetivo
Generar un conjunto de datos sintético de texto de exactamente 4 MB utilizando 4 tareas Map (1 MB por tarea) y posteriormente ordenarlo de forma ascendente.

## Instrucciones
1. Ejecuta `randomtextwriter` limitando el tamaño total a 4 MB (4,194,304 bytes) y el tamaño por Map a 1 MB (1,048,576 bytes) en el directorio HDFS `ejercicio_random`.
2. Verifica cuántos archivos `part-m-*` se crearon en `ejercicio_random`.
3. Ejecuta el ejemplo `sort` tomando como entrada `ejercicio_random` y guardando el resultado en `ejercicio_sort`.
4. Muestra las primeras 10 líneas ordenadas del resultado.
