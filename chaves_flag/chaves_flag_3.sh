#!/usr/bin/env bash



#-------------------------VARIÁVEIS------------------------------------------
USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"
MENSAGEM_USO="
  $(basename $0) - [OPÇÕES]

  -h - Menu de Ajuda
  -v - Versão
  -s - Ordernar a saída
  -m - Coloca em maiusculo
"
VERSAO="v1.0"
CHAVE_ORDENA=0
CHAVE_MAIUSCULO=0
#-----------------------------------------------------------------------------

#-------------------------EXECUÇÃO---------------------------------------------
while test -n "$1"
do
case "$1" in
  -h) echo "$MENSAGEM_USO" && exit 0 ;;
  -v) echo "$VERSAO" && exit 0       ;;
  -s) CHAVE_ORDENA=1                 ;;
  -m) CHAVE_MAIUSCULO=1              ;;
   *) echo "$USUARIOS"               ;;
 esac
 shift
done

 [ $CHAVE_ORDENA -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | sort)
 [ $CHAVE_MAIUSCULO -eq 1 ] && USUARIOS=$(echo "$USUARIOS" | tr [a-z] [A-Z])
#------------------------------------------------------------------------------
