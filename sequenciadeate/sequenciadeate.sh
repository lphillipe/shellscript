#!/usr/bin/env bash

#tarefa3.sh

#Site www.luisph.net
#Autor Luis Phillipe
#Manutenção Luis Phillipe

#Variáveis
comeca=0
ate=10

#=======================TESTE==========================
[ $comeca -ge $ate ] && exit 1
#======================================================

#======================EXECUÇÃO========================
for i in $(seq $comeca  $ate); do
  for j in $(seq $i $ate); do
    printf "*"
  done
  printf "\n"
done
