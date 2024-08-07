#!/usr/bin/env bash
#-----------------------VARIAVEIS-------------------------
CHAVE_DEBUG=1
NIVEL_DEBUG=1

ROXO="\033[35;1m"
CIANO="\033[36;1m"
#---------------------------------------------------------
#-----------------------FUNÇOES---------------------------
Debugar () {
  [ $1 -le $NIVEL_DEBUG ] && echo -e "${2}Debug $* ----------"
}
Soma () {
  local total=0
  for i in $(seq 1 25); do
    Debugar 1 "${ROXO}" "Entre no for com o valor: $i"
    total=$(($total+$i))
    Debugar 2 "${CIANO}" "Depois da Soma: $total"
  done
}
#---------------------------------------------------------
case "$1" in
  -d) [ $2 ] && NIVEL_DEBUG=$2 ;;
  *) Soma                      ;;
esac
#----------------------EXECUÇÃO---------------------------
#Soma
#---------------------------------------------------------
