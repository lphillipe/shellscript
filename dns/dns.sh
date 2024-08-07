#!/usr/bin/env bash
#
# tarefa8.sh - Extrai DNS utilizado pela ig.com.br
#
# Autor:      Luís Phíllipe
# Manutenção: Luís Phillipe
#
# ------------------------------------------------------------------------ #
#  Este programa irá extrair o DNS que a página ig.com.br utiliza.
#
#  Exemplos:
#      $ ./tarefa8.sh
#      Neste exemplo o programa vai extrair o DNS
# ------------------------------------------------------------------------ #
# Histórico:
#
#   v1.0 20/06/2022, Luís:
#       - Montamos a expressões regular com fator em comum
#   v1.1 07/08/2024, Luís:
#       - Testado o funcionamento do código.
# ------------------------------------------------------------------------ #
# Testado em:
#   bash 5.0.17
# ------------------------------------------------------------------------ #

# ------------------------------- VARIÁVEIS ----------------------------------------- #
ARQUIVO_DE_DNS="dns.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- #
[ ! -x "$(which lynx)" ] && sudo apt install lynx -y # Lynx instalado?
# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #
lynx -source https://www.ig.com.br | grep "dns-prefetch" | sed 's/<link.*href="//;s/".*\/>//' > dns.txt

while read -r dns_ig
do
  echo -e "${VERMELHO}DNS: ${VERDE}$dns_ig"
done < "$ARQUIVO_DE_DNS"
# ------------------------------------------------------------------------ #
