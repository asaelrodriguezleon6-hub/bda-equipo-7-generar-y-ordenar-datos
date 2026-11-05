# Práctica MapReduce - Equipo 7: Generar y Ordenar Datos

Este repositorio contiene la documentación, scripts de ejecución y evidencias de los ejemplos **`randomtextwriter`**, **`randomwriter`** y **`sort`** incluidos en Apache Hadoop 3.3.6.

---

## 1. Descripción de los Ejemplos y Casos Reales

| Ejemplo | Formato de Salida | ¿Qué hace? | Caso real de uso |
| :--- | :--- | :--- | :--- |
| **`randomtextwriter`** | Texto plano (`TextOutputFormat`) | Genera oraciones y palabras sintéticas aleatorias. | Benchmark de procesamiento de lenguaje natural (NLP), prueba de rendimiento en pipelines de ingesta de logs. |
| **`randomwriter`** | Binario (`SequenceFileOutputFormat`) | Genera pares clave-valor binarios aleatorios (`BytesWritable`). | Pruebas de estrés de hardware, benchmarking de I/O de disco y tasa de transferencia en clústeres. |
| **`sort`** | Texto o Binario (`SequenceFile`) | Ordena los registros de entrada por su clave lexicográfica o numéricamente. | Reorganización previa a cruces masivos (joins), ordenamiento previo a generación de índices invertidos o búsquedas binarias distribuidas. |

---

## 2. Arquitectura MapReduce

### `randomtextwriter` y `randomwriter` (Map-Only)
* **InputFormat:** `RandomInputFormat` (no lee archivos de disco; calcula divisiones virtuales según los bytes solicitados por parámetro).
* **Map:** Cada mapper genera secuencias continuas de bytes o palabras y emite pares `(Clave, Valor)`.
* **Reduce:** No existe (0 Reducers). La salida es escrita directamente por las tareas Map (`part-m-*`).

### `sort` (Full MapReduce)
* **Map:** Actúa como `IdentityMapper`. Lee los pares `(Clave, Valor)` y los reemite idénticos.
* **Shuffle & Sort:** El motor interno de Hadoop agrupa, particiona y ordena automáticamente todas las claves en tránsito.
* **Reduce:** Actúa como `IdentityReducer`. Recibe los registros ya ordenados y los escribe secuencialmente al sistema de archivos (`part-r-*` o `part-m-*` en modo directo).

---

## 3. Advertencia Crítica de Almacenamiento

Por defecto, tanto `randomwriter` como `randomtextwriter` intentan escribir **10 GB** (10 maps de 1 GB cada uno), lo que satura el almacenamiento del contenedor Docker. Es fundamental usar los parámetros `-D` antes del comando para limitar el tamaño:

* **Para texto (`randomtextwriter`):**
  - `-D mapreduce.randomtextwriter.totalbytes=<bytes>`
  - `-D mapreduce.randomtextwriter.bytespermap=<bytes>`
* **Para binario (`randomwriter`):**
  - `-D test.randomwrite.total_bytes=<bytes>`
  - `-D test.randomwrite.bytes_per_map=<bytes>`

---

## 4. Guía de Reproducción Paso a Paso

### 💻 En tu computadora (Host)
Asegurar que el contenedor esté corriendo y entrar en él:
```bash
docker start hadoop
docker exec -it hadoop bash
