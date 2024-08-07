#!/usr/bin/env bash

#tarefa4.sh Buscando informações de úsuários no etc/passwd por letras.

#Site www.luisph.net
#Autor Luis Phillipe
#Manutenção Luis Phillipe

#--------------------Variáveis---------------------
USUARIOS="$(cat /etc/passwd | cut -d : -f 1)"
VERSAO="v10.9"
MENSAGEM_USO="
$(basename $0)- [OPÇÕES]

-m - Menu de Ajuda
-l - Lista os úsuarios
-a - Busca pela letra A
-b - Busca pela Letra B
-c - Busca pela letra C
-d - Busca pela letra D
-o - Ordenar a lista em ordem alfabética
-v - Versão do programa
"
CHAVE_A=0
CHAVE_B=0
CHAVE_C=0
CHAVE_D=0
CHAVE_ORDENA=0
CHAVE_VERSAO=0
CHAVE_MENU=0
CHAVE_LISTA=0
#--------------------------------------------------------------------

#-----------------EXECUÇÃO-------------------------------------------
set -x
while test -n "$1"; do
  case "$1" in

    -a) CHAVE_A=1                            ;;
    -b) CHAVE_B=1                            ;;
    -c) CHAVE_C=1                            ;;
    -d) CHAVE_D=1                            ;;
    -o) CHAVE_ORDENA=1                       ;;
    -v) CHAVE_VERSAO=1                       ;;
    -m) CHAVE_MENU=1                         ;;
    -l) CHAVE_LISTA=1                        ;;
     *) echo "Opção inválida, vá ao menu -m" ;;
  esac
  shift
done
[ $CHAVE_MENU -eq 1 ] && echo "$MENSAGEM_USO"
[ $CHAVE_LISTA -eq 1 ] && echo "$USUARIOS"
[ $CHAVE_A -eq 1 ] && echo "$USUARIOS" | grep -i ^a
[ $CHAVE_B -eq 1 ] && echo "$USUARIOS" | grep -i ^b
[ $CHAVE_C -eq 1 ] && echo "$USUARIOS" | grep -i ^c
[ $CHAVE_D -eq 1 ] && echo "$USUARIOS" | grep -i ^d
[ $CHAVE_ORDENA -eq 1 ] && echo "$USUARIOS" | sort
[ $CHAVE_VERSAO -eq 1 ] && echo "$VERSAO"
set +x
