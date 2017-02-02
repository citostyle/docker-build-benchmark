#!/bin/bash

OUTFILE="docker-build-benchmark.csv"

while IFS='' read -r line || [[ -n "$line" ]]; do
    #echo "Text read from file: $line"
    ./measure-build.sh $line $OUTFILE
done < "$1"
