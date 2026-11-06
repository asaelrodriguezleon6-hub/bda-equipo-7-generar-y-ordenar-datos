#!/bin/bash
set -euo pipefail

export JAVA_HOME="$(dirname "$(dirname "$(readlink -f "$(command -v java)")")")"
export HADOOP_HOME=/opt/hadoop-3.3.6
export PATH="$HADOOP_HOME/bin:$PATH"

JAR="$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar"

mkdir -p /opt/equipo7
BASE=$(mktemp -d /opt/equipo7/demo-XXXXXXXX)

echo "1. Generando texto aleatorio"

hadoop jar "$JAR" randomtextwriter \
  -Dmapreduce.randomtextwriter.totalbytes=1048576 \
  -Dmapreduce.randomtextwriter.bytespermap=1048576 \
  -outFormat org.apache.hadoop.mapreduce.lib.output.TextOutputFormat \
  "$BASE/texto" 2>&1 | tee "$BASE/01_randomtextwriter.log"

echo "2. Generando datos binarios"

hadoop jar "$JAR" randomwriter \
  -Dmapreduce.randomwriter.totalbytes=1048576 \
  -Dmapreduce.randomwriter.bytespermap=1048576 \
  "$BASE/binarios" 2>&1 | tee "$BASE/02_randomwriter.log"

echo "3. Ordenando datos binarios"

hadoop jar "$JAR" sort -r 1 \
  "$BASE/binarios" \
  "$BASE/ordenados" 2>&1 | tee "$BASE/03_sort.log"

echo "4. Revisando resultados"

ls -lh "$BASE/texto"
ls -lh "$BASE/binarios"
ls -lh "$BASE/ordenados"

echo "Proceso terminado."
echo "Resultados guardados en: $BASE"
