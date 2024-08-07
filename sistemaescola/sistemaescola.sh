#!/usr/bin/env bash
#
# tarefa10.sh - Gerenciamento de Alunos
#
# Site:       https://luisphillipe.com.br
# Autor:      Luís Phillipe
# Manutenção: Luís Phillipe
#
# ------------------------------------------------------------------------ #
#  Este programa irá gerenciar os alunos de uma determinada escola.
#
#  Exemplos:
#      $ source sistemaescola.sh
#      $ VerificaAluno
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
ARQUIVO_BANCO_DE_DADOS="Banco_de_dados_escola_gs.txt"

VERDE="\033[32;1m"
VERMELHO="\033[31;1m"
SEP=":"
TEMP="temp.$$"
# ------------------------------------------------------------------------ #

# ------------------------------- TESTES ----------------------------------------- --------------#
[ ! -e "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. O arquivo não existe." && exit 1
[ ! -r "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. O arquivo não tem acesso a leitura." && exit 1
[ ! -w "$ARQUIVO_BANCO_DE_DADOS" ] && echo "ERRO. O arquivo não tem acesso a escrita." && exit 1
# ----------------------------------------------------------------------------------------------- #

# ------------------------------- FUNÇÕES ----------------------------------------- #
MostraAlunos () {
  local matricula="$(echo $linha | cut -d $SEP -f 1)"
  local aluno="$(echo $linha | cut -d $SEP -f 2)"
  local ano="$(echo $linha | cut -d $SEP -f 3)"

  echo -e "${VERDE}Matricula: ${VERMELHO}$matricula"
  echo -e "${VERDE}Aluno: ${VERMELHO}$aluno"
  echo -e "${VERDE}Ano: ${VERMELHO}$ano"
}

listaAlunos () {
  while read -r linha
  do
    [ "$(echo $linha | cut -c1)" = "#" ] && continue
    [ ! "$linha" ] && continue

    MostraAlunos "$linha"

  done < "$ARQUIVO_BANCO_DE_DADOS"
}

ValidaAluno () {
  grep -i -q "$1$SEP" "$ARQUIVO_BANCO_DE_DADOS"
}

InsereAluno () {
  local aluno="$(echo $1 | cut -d $SEP -f 2)"

  if ValidaAluno "$aluno"
  then
    echo "ERRO. O Aluno já existe no sistema !"
  else
    echo "$*" >> "$ARQUIVO_BANCO_DE_DADOS"
    echo "Aluno cadastrado com sucesso !"
  fi
}

ApagaAluno () {
  ValidaAluno "$1" || return

  grep -i -v "$1$SEP" "$ARQUIVO_BANCO_DE_DADOS" > "$TEMP"
  mv "$TEMP" "$ARQUIVO_BANCO_DE_DADOS"

  echo "Aluno removido do sistema com sucesso !"
}
# ------------------------------------------------------------------------ #

# ------------------------------- EXECUÇÃO ----------------------------------------- #

# ------------------------------------------------------------------------ #
