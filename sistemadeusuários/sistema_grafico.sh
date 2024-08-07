#!/usr/bin/env bash
#
# sistema_de_usuarios.sh - Sistema para gerenciamento de usuários
#
# Site:       https://luisphillipe.com.br
# Autor:      Luís Phillipe
# Manutenção: Luís Phillipe
#
# ------------------------------------------------------------------------ #
#  Este programa faz todas as funções de gerenciamento de usuários, como:
# inserir, deletar, alterar.
#
# Exemplos:
#      $ source sistema de usuarios.#!/bin/sh
#      $ listaUsuários
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 03/10/2018, Luís:
#       - Início do programa
#       - Conta com a funcionalidade X
#   v1.1 10/10/2018, Luís:
#       - Alterado parametro XXXXX
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.17
# ------------------------------------------------------------------------ #
# ------------------------------- VARIÁVEIS ----------------------------------------- #
ARQUIVO_BANCO_DE_DADOS="banco_de_dados.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
SEP=":"
TEMP="temp.$$"
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
[ ! -e "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Arquivo não existe." && exit 1
[ ! -r "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Sem acesso a leitura." && exit 1
[ ! -w "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. Sem acesso a escrita." && exit 1
[ ! -x "$(which dialog)" ] && sudo apt install dialog 1> /dev/null 2>&1
# ------------------------------------------------------------------------ #

# ------------------------------- FUNÇÕES ----------------------------------------- #
listaUsuarios () {
  egrep -v "^#|^$" "$ARQUIVO_BANCO_DE_DADOS" | tr : ' ' > "$TEMP"
  dialog --title "Lista de Usuários" --textbox "$TEMP" 20 40
  rm -f "$TEMP"
}

ValidaUsuario () {
  grep -i -q "$1$SEP" "$ARQUIVO_BANCO_DE_DADOS"
}

ApagaUsuario () {
  ValidaUsuario "$1" || return

  grep -i -v "$1$SEP" "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
  mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"

  echo "Usuário removido com sucesso!"
  OrdenaLista
}

OrdenaLista () {
  sort "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
  mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"
}

# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
while :
do
  acao=$(dialog --title "Gerenciamento de Usuários 2.0" \
                --stdout \
                --menu "Escolha uma das opções abaixo:" \
                0 0 0 \
                listar "Listar todos os usuários do sistema" \
                remover "Remover um usuário do sistema" \
                inserir "Inserir um novo usuário no sistema")
[ $? -ne 0 ] && exit
case $acao in
  listar) listaUsuarios    ;;
  inserir)
    ultimo_id=$(egrep -v "^#|^$" "$ARQUIVO_BANCO_DE_DADOS" | sort | tail -n 1 | cut -d $SEP -f 1)
    proximo_id=$(($ultimo_id+1))

    nome=$(dialog --title "Cadastro de Usuários" --stdout --inputbox "Digite seu nome" 0 0)
    [ ! "$nome" ] && exit 1

    ValidaUsuario "$nome" && {
      dialog --title "ERRO FATAL!" --msgbox "Usuário já cadastrado no sistema!" 6 40
      exit 1
    }

    local email=$(dialog --title "Cadastro de Usuários" --stdout --inputbox "Digite seu email" 0 0)
    [ $? -ne 0 ] && continue

    echo "$proximo_id$SEP$nome$SEP$email" >> "$ARQUIVO_BANCO_DE_DADOS"
    dialog --title "SUCESSO!" --msgbox "Usuário cadastrado com sucesso!" 6 40

    listaUsuarios
    ;;
  remover)
    usuarios=$(egrep "^#|^$" -v "$ARQUIVO_BANCO_DE_DADOS"| sort -h | cut -d $SEP -f 1,2 | sed 's/:/ "/;s/$/"/')
    id_usuario=$(eval dialog --stdout --menu \"Escolha um usuário:\" 0 0 0 $usuarios)
    [ $? -ne 0 ] && continue

    grep -i -v "$id_usuario$SEP" "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
    mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"

    dialog --msgbox "Usuário removido com sucesso!"
    listaUsuarios
    ;;
esac

done
# ------------------------------------------------------------------------ #
