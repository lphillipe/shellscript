#!/usr/bin/env bash
#
# extrai_titulos.sh - Extrai titulos do blog
#
# Autor:      Luís Phíllipe
# Manutenção: Luís Phillipe
#
# ------------------------------------------------------------------------ #
#  Este programa irá extrair títulos do blog LXER, colocar em um arquivo de
#  texto e ler mostrando com cores na tela.
#
#  Exemplos:
#      $ ./extrai_titulos.sh
#      Neste exemplo o programa vai extrair os titulos e mostrar na tela.
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 20/06/2022, Luís:
#       - Montamos a expressões regular com fator em comum
#   v1.1 20/06/2022, Luís:
#       - Criado primeiro código com cores
#   v1.2 07/08/24
#       -Efetuado o teste de funcionamento para inserção no meu github.
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.17
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
ARQUIVO_DE_TITULOS="titulos.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
[ ! -x "$(which lynx)" ] && sudo apt install lynx -y # Lynx instalado?
# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
lynx -source http://lxer.com/ | grep blurb | sed 's/<div.*line">//;s/<\/span.*//' > titulos.txt

while read -r titulo_lxer
do
  echo -e "${VERMELHO}Titulo: ${VERDE}$titulo_lxer"
done < "$ARQUIVO_DE_TITULOS"
# ------------------------------------------------------------------------ #
