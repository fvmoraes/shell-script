#!/bin/bash
#
# Written by Franklin Moraes.
# It is used to perform backups with the rsync command.

principal() {           	  # Função principal do programa
    clear                         # limpa a tela

    echo "[1] Definir o arquivo que vai ser copiado"    # imprime na tela as opções que serão abordadas no comando case.
    echo "[2] Definir diretório que está o arquivo que vai ser copiado"  
    echo "[3] Definir caminho de diretório remoto para backup"
    echo "[4] Definir socket [Ip + Rede] + Usuário"
    echo "[5] Definir software de backup [Rsync ou Scp]"
    echo "[6] Efetuar backup [Utilize depois de complementar as outras opções]"
    echo "[7] Sair do script"
    echo ""
    echo -n "Qual a opcao escolhida ? "
    read opcao          	  # faz a leitura da variável "opcao", 
                                  # que será utilizada no comando case
                                  # para indicar qual a opção a ser utilizada

                                  # caso o valor da variável "opcao"...
    case $opcao in
        1)                        # seja igual a "1", então faça as instruções abaixo
            clear
            seta_arq        # executa os comandos da função "seta_arq"
            ;;          	      # os 2 ";;" (ponto e virgula)
								  # significam que chegou ao final
								  # esta opção do comando case
        2)              		  # seja igual a "2", então faça as instruções abaixo
            clear
            seta_dir      # executa os comandos da função "seta_dir"
            ;;          		  # os 2 ";;" (ponto e virgula)
								  # significam que chegou ao final
								  # esta opção do comando case
        3)              		  # seja igual a "3", então faça as instruções abaixo
            clear
            seta_trip      # executa os comandos da função "define_caminho"
            ;;          		  # os 2 ";;" (ponto e virgula)
								  # significam que chegou ao final
								  # esta opção do comando case
        4)              		  # seja igual a "4", então faça as instruções abaixo
            clear
            seta_socket     	  # executa os comandos da função "seta_socket"
            ;;          		  # os 2 ";;" (ponto e virgula)
								  # significam que chegou ao final
								  # esta opção do comando case
        5)              		  # seja igual a "5", então faça as instruções abaixo
            clear
            seta_soft       # executa os comandos da função "seta_soft"
            ;;             		  # os 2 ";;" (ponto e virgula)
								  # significam que chegou ao final
								  # esta opção do comando case
        6)              		  # seja igual a "6", então faça as instruções abaixo
            clear
            faz_back     	  # executa os comandos da função "faz_back"
            ;;          		  # os 2 ";;" (ponto e virgula)
								  # significam que chegou ao final
								  # esta opção do comando case
        7)
            clear
            exit ;;
        *)              		  # esta opçao existe para caso o usuário digite um 
								  # valor diferente de 1, 2 ou 3
            opcao_invalida ;;		  # opcao inválida.
    esac
}

seta_arq() {      # função da opção seta_arq
    clear		# limpa tela
    echo "Qual o nome completo e extensão do arquivo que deseja copiar? [Use *,para todos os arquivos de um diretório]" # interação com usuário
    read nArq	# efetua a leitura de entradas para á variável
    read pause		# usado para pausar a execução do script
    principal		# volta para a função principal
}

seta_dir() {    # função da opção seta_dir
    clear		# limpa tela
    echo "Qual o nome do diretório que deseja copiar? [Especifique corretamente letras mauísculas e minusculas Exemplo: Documents]"	# interação com usuário
    echo "Você tambem pode colocar a referência absoluta: [Exemplo: /home/user/Downloads/]"	# interação com usuário
    read nDir	# efetua a leitura de entradas para á variável
    read pause		# usado para pausar a execução do script
    principal		# volta para a função principal
}

define_caminho() {	# função da opção define_caminho
    clear		# limpa tela
    echo "Qual a referência completa do caminho de destino para onde deseja copiar [Exemplo: ~/Documents]"	# interação com usuário
    read nTrip			  # efetua a leitura de entradas para á variável
    read pause          		  # usado para pausar a execução do script
    principal           		  # volta para a função principal
}

seta_socket() {	# função da opção seta_socket
    clear		# limpa tela
    echo "Qual o IP de conexão remota para backup?"	# interação com usuário
    read endIp	# efetua a leitura de entradas para á variável
    echo "Qual a porta SSH padrão do host remoto?"	# interação com usuário
    read pSsh	# efetua a leitura de entradas para á variável
    echo "Qual o usuário remoto para efetuar o backup?"	# interação com usuário
    read userBack	# efetua a leitura de entradas para á variável
    read pause			          # usado para pausar a execução do script
    principal	     			  # volta para a função principal
}

seta_soft() {	# função da opção seta_soft
    clear		# limpa tela
    echo "Qual o software que deseja usar para o backup? - [1] RSYNC | [2] SCP]"	# interação com usuário
    read sBackFranklin	# efetua a leitura de entradas para á variável
echo "teste"
    clear		# limpa tela
    if test $sBackFranklin -eq 1	# inicio if
	then
	clear		# limpa tela
	echo "Função RSYNC escolhida."	# interação com usuário
	principal

    elif test $sBackFranklin -eq 2
	then
	clear		# limpa tela
	echo "Função SCP escolhida."	# interação com usuário
	principal	# volta para a função principal

    else
	clear		# limpa tela
	echo "Opção inválida."		# interação com usuário
	seta_soft
    fi
    read pause	# usado para pausar a execução do script
    principal	# volta para a função principal
}
faz_back(){	# função da opção faz_back
    clear
    echo "EFETUADO BACKUP CONFORME DADOS PASSADOS...]"	# interação com usuário
     if test $sBackFranklin -eq 1	# inicio if
	then
	clear	# limpa tela
	echo "Utilizando RSYNC..."		# interação com usuário
	rsync -vzha -e 'ssh -p $pSsh' --progress $nDir/$nArq $userBack@$endIp:$nTrip # função rsync
    elif test $sBackFranklin -eq 2
	then
	clear	# limpa tela
	echo "Utilizando SCP..."		# interação com usuário
	scp -vP $pSsh $nDir/$nArq $userBack@$endIp:$nTrip	# funçao scp
    else
	clear	# limpa tela
	echo "Opção inválida."		# interação com usuário
	echo "Não foi possivel fazer o backup, cancele a execução do script e repita o processo."		# interação com usuário
    fi
    echo "Script finalizado, verifique o backup!"		# interação com usuário
    read pause	# usado para pausar a execução do script
    clear	# limpa tela
    exit 0	# sai da aplicação
}


opcao_invalida() {	# função da opção inválida
    clear	# limpa tela
    echo "Opcao desconhecida."		# interação com usuário
    read pause	# usado para pausar a execução do script
    principal	# volta para a função principal
}

principal               		 			 # o script começa aqui, as funções das linhas anteriores
								 # são lidas pelo interpretador bash e armazenadas em memória.

								 # o bash não tem como adivinhar qual das funções ele deve 
								 # executar, por isto o a execução do script realmente começa
								 # quando aparece uma instrução fora de uma função, neste caso,
								 # chamando a função principal
