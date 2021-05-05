#!/bin/bash
#
# Written by Franklin Moraes.
# It is used to interact with directories.

echo "ATTENTION !!!!"
echo ""
echo "THIS SCRIPT WILL DELETE THE CURRENT DIRECTORIES THAT HAVE THE SAME NOMENCLATURE FOR YOUR CURRENT."
echo ""
echo "Press ENTER to continue or CTRL + C to cancel."
read	# Aguarda a decisão do usuário.
# Fim da interação com o usuário

for((i=1;i<=$2;i++))	#Inicio do laço FOR
do	

if [ -d "$1 $i" ]	# Teste da existencia do diretório.
then
echo "Erasing $1 $i"	# Msg de verificação apagar após produção.
rm -Rf "$1 $i"	# Apagar diretório caso exista
fi

mkdir "$1 $i"	#Criação de diretório.


done	# Fim do laço FOR

# Interação com o usuário
echo "Segue abaixo os diretórios criados"
echo ""
# Fim da interação com o usuário

ls $1*	
