#!/usr/bin/env bash

#calculadora.sh Calculadora simples de adição e subtração

#Autor Luis Phillipe
#Manutenção Luis Phillipe

#--------------------CORES---------------------
AMARELO="\033[33;1m"
VERDE="\033[32;1m"
CIANO="\033[36;1m"
#----------------------------------------------
#------------------FUNÇÕES---------------------
function menu() {
  echo -e "${VERDE}-------------------------------$fim"
echo "1) Adição"
echo "2) Subtração"
echo -e "${VERDE}-------------------------------$fim"
read -p "Escolha uma opção: " opcao

case $opcao in
"1") adicao ;;
"2") subt   ;;
"3") exit 0 ;;
*) echo "Opção invalida, escolha uma operação..."
   menu
            ;;
esac
}
#------------------ADIÇÃO---------------------------
function adicao() {
	read -p "Valor A: " valA
	read -p "Valor B: " valB
	if [[ -z $valA ]] || [[ -z $valB ]] #Verificando campos vazio
	then
	echo -e "${AMARELO}Campo vazio entre com um valor!!${fim}"
	adicao
  fi
	sleep 1s
	total="$(( valA + valB ))" #Resultado
	echo -e "${AMARELO} resultado é: $total ${fim}" #Exibindo resultado
	sleep 5s
	clear
	menu

}
#--------------------SUBTRAÇÃO-------------------------
function subt() {
	read -p "Valor A: " valA
	read -p "Valor B: " valB
	if [[ -z $valA ]] || [[ -z $valB ]]
	then
	echo -e "${CIANO}Campo vazio entre com um valor!!${fim}"
	subt
	fi
	sleep 1s
	total="$(( $valA - $valB ))"
	echo -e "${CIANO} resultado é: $total ${fim}" #Exibindo resultado
	sleep 5s
	clear
	menu
}
#------------------------------------------------------
menu #Iniciando calculadora
