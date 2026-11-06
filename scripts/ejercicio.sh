#!/bin/bash
set -euo pipefail

export JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
export HADOOP_HOME=/opt/hadoop-3.3.6
export PATH="$HADOOP_HOME/bin:$PATH"

JAR="$HADOOP_HOME/share/hadoop/mapreduce/hadoop-mapreduce-examples-3.3.6.jar"
BASE=$(mktemp -d /opt/equipo7/ejercicio4-XXXXXXXX)

mkdir -p "$BASE/entrada"

for i in 1 2 3 4; do
  hadoop jar "$JAR" randomtextwriter \
    -Dmapreduce.randomtextwriter.totalbytes=1048576 \
    -Dmapreduce.randomtextwriter.bytespermap=1048576 \
    -outFormat org.apache.hadoop.mapreduce.lib.output.TextOutputFormat \
    "$BASE/generado-$i" > "$BASE/generado-$i.log" 2>&1

  hadoop fs -cp "$BASE/generado-$i/part-m-00000" "$BASE/entrada/texto-$i.txt"
done

hadoop jar "$JAR" sort -r 1 \
  -inFormat org.apache.hadoop.mapreduce.lib.input.KeyValueTextInputFormat \
  -outFormat org.apache.hadoop.mapreduce.lib.output.TextOutputFormat \
  -outKey org.apache.hadoop.io.Text \
  -outValue org.apache.hadoop.io.Text \
  "$BASE/entrada" "$BASE/ordenado" > "$BASE/sort.log" 2>&1

echo "Archivos de entrada:"
find "$BASE/entrada" -name 'texto-*.txt' | wc -l

echo "Divisiones de Sort:"
grep 'number of splits:' "$BASE/sort.log"

echo "Resultado:"
ls -lh "$BASE/ordenado"

echo "Carpeta: $BASE"
