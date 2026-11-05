#!/bin/bash
set -e

JAR=$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar

echo "=== 1. Limpiando directorios previos ==="
hdfs dfs -rm -r -f datos_texto texto_ordenado datos_binarios binario_ordenado

echo "=== 2. Ejecutando randomtextwriter (10 MB controlados) ==="
hadoop jar $JAR randomtextwriter \
  -D mapreduce.randomtextwriter.totalbytes=10485760 \
  -D mapreduce.randomtextwriter.bytespermap=5242880 \
  datos_texto

echo "=== 3. Ordenando texto con sort ==="
hadoop jar $JAR sort \
  -inFormat org.apache.hadoop.mapreduce.lib.input.KeyValueTextInputFormat \
  -outFormat org.apache.hadoop.mapreduce.lib.output.TextOutputFormat \
  -outKey org.apache.hadoop.io.Text \
  -outValue org.apache.hadoop.io.Text \
  datos_texto texto_ordenado

echo "=== 4. Ejecutando randomwriter binario (5 MB controlados) ==="
hadoop jar $JAR randomwriter \
  -D test.randomwrite.total_bytes=5242880 \
  -D test.randomwrite.bytes_per_map=5242880 \
  datos_binarios

echo "=== 5. Ordenando archivo binario con sort ==="
hadoop jar $JAR sort datos_binarios binario_ordenado

echo "=== Proceso finalizado con éxito ==="
