# Equipo 7 - Generar y ordenar datos

Práctica de MapReduce con Hadoop 3.3.6 utilizando los ejemplos randomtextwriter, randomwriter y sort.

## 1. Programas utilizados

| Programa | Función |
|---|---|
| randomtextwriter | Genera palabras y registros de texto aleatorios. |
| randomwriter | Genera datos binarios aleatorios. |
| sort | Ordena los registros según sus claves. |

Estos programas pueden utilizarse para generar datos de prueba y comprobar el funcionamiento de sistemas de procesamiento de información.

## 2. Funcionamiento de MapReduce

**RandomTextWriter y RandomWriter**

Utilizan tareas Map para generar los registros. No necesitan Reduce.

**Sort**

- Map: lee los registros de entrada.
- Shuffle y Sort: organiza los registros según sus claves.
- Reduce: escribe los registros ordenados.

## 3. Requisitos

- Docker instalado.
- Contenedor Debian llamado hadoop.
- Java 17.
- Hadoop 3.3.6 en /opt/hadoop-3.3.6.
- Hadoop configurado en modo Standalone.

## 4. Ejecución

Los siguientes comandos se ejecutan en la terminal de Ubuntu.

Clonar el repositorio:

```bash
git clone https://github.com/mtorresmartinez255-source/bda-equipo-7-generar-y-ordenar-datos.git
cd bda-equipo-7-generar-y-ordenar-datos
```

Iniciar el contenedor:

```bash
docker start hadoop
```

Preparar la carpeta:

```bash
docker exec hadoop mkdir -p /opt/equipo7
```

Copiar el script:

```bash
docker cp scripts/ejecutar.sh hadoop:/opt/equipo7/ejecutar.sh
```

Ejecutar la práctica:

```bash
docker exec -it hadoop bash /opt/equipo7/ejecutar.sh
```

El script ejecuta los tres programas y muestra la carpeta donde se guardaron los resultados.

Los datos de entrada se generan automáticamente.

## 5. Resultados

En la prueba realizada con Hadoop 3.3.6 obtuvimos:

| Programa | Resultado |
|---|---|
| RandomTextWriter | 1,590 registros |
| RandomWriter | 115 registros |
| Sort | Archivo ordenado de aproximadamente 1.1 MB |

Los tres programas terminaron correctamente.

Los registros de ejecución se encuentran en `resultados/logs/`.

Los archivos generados están en `resultados/ejecucion-real/`.

## 6. Mini ejercicio

El ejercicio consiste en generar cuatro archivos de texto aleatorio de aproximadamente 1 MB y ordenarlos con Sort.

Desde Ubuntu:

```bash
docker cp scripts/ejercicio.sh hadoop:/opt/equipo7/ejercicio.sh
docker exec -it hadoop bash /opt/equipo7/ejercicio.sh
```

Resultados obtenidos:

- 4 archivos de entrada.
- 4 divisiones de entrada en Sort.
- 1 archivo ordenado de aproximadamente 4.1 MB.

Las instrucciones y la solución están en `ejercicio/ejercicio.md`.

## 7. Archivos del proyecto

- `datos/`: información sobre los datos.
- `scripts/`: comandos de ejecución.
- `resultados/`: archivos de salida y registros.
- `ejercicio/`: actividad y solución.

Los archivos grandes de Hadoop no están incluidos en el repositorio.
