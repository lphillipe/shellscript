#!/usr/bin/env bash

for i in $(seq 100); do
  [ $(($i % 2)) -eq 0 ] && echo "O Número $i é divisivel por 2"
done
