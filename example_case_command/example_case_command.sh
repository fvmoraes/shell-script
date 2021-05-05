#!/bin/bash
#
# Written by Franklin Moraes.
# It is used to exemplify the case command..

principal() {           # Função principal do programa
    clear               # limpa a tela

    echo "[1] Mostrar a localização atual do usuário no sistema de arquivos"  # imprime na tela as opções que serão
    echo "[2] Mostrar o tipo de um arquivo"  				      # abordadas no comando case
    echo "[3] Criar um diretório"
    echo "[4] Apagar um diretório não vazio"			      
    echo "[5] Ler 2 números e indicar qual é o maior deles e qual é o menor"
    echo "[6] Exibir as últimas linhas de um arquivo(pedir ao usuário a quantidade de linhas a mostrar)"
    echo "[7] Exibir as primeiras linhas de um arquivo(pedir ao usuário a quantidade de linhas a mostrar)"
    echo "[8] Mostrar a localização de um comando específico utilizar which ou whereis"
    echo "[9] Mostra um diretório informado pelo usuário em formato de árvore (instalar comando tree)"
    echo "[10] Copiar um arquivo para um outro diretório (usuário deve informar qual é o arquivo e qual é o diretório)"
    echo "[11] Mover um arquivo para outro diretório"
    echo "[12] SAIR"
    echo -n "Qual a opcao desejada ? "
    read opcao          # faz a leitura da variável "opcao", 
                        # que será utilizada no comando case
                        # para indicar qual a opção a ser utilizada

                        # caso o valor da variável "opcao"...
    case $opcao in
        
	1)              # seja igual a "1", então faça as instruções abaixo
            clear
            localiza_user # Chama a função localiza_user
            ;;          # os 2 ";;" (ponto e virgula)
                        # significam que chegou ao final
                        # esta opção do comando case

        2)		# seja igual a "2", então faça as instruções abaixo
            clear
            mostra_arquivos # Chama a função mostra_arquivos	
            ;;          # os 2 ";;" (ponto e virgula)
                        # significam que chegou ao final
                        # esta opção do comando case

        3)              # seja igual a "3", então faça as instruções abaixo
            clear
	    criar_diretorio # Chama a função criar_diretorio
            ;;          # os 2 ";;" (ponto e virgula)
                        # significam que chegou ao final
                        # esta opção do comando case

        4)		# seja igual a "4", então faça as instruções abaixo
            clear
	    excluir_diretorio # Chama a função excluir_diretorio		
            ;;          # os 2 ";;" (ponto e virgula)
                        # significam que chegou ao final
                        # esta opção do comando case

        5)		# seja igual a "5", então faça as instruções abaixo              
            clear
	    compara_numero # Chama a função compara_numero
            ;;          # os 2 ";;" (ponto e virgula)
                        # significam que chegou ao final
                        # esta opção do comando case

        6)		# seja igual a "6", então faça as instruções abaixo
            clear
	    ler_fim  # Chama a função ler_fim		
            ;;          # os 2 ";;" (ponto e virgula)
                        # significam que chegou ao final
                        # esta opção do comando case

        7)		# seja igual a "7", então faça as instruções abaixo    
            clear
	    ler_inicio # Chama a função ler_inicio
            ;;          # os 2 ";;" (ponto e virgula)
                        # significam que chegou ao final
                        # esta opção do comando case

        8)		# seja igual a "8", então faça as instruções abaixo
            clear
            localiza_comando # Chama a função localiza_comando
            ;;          # os 2 ";;" (ponto e virgula)
                        # significam que chegou ao final
                        # esta opção do comando case

        9)              # seja igual a "9, então faça as instruções abaixo
            clear
	    mostra_tree # Chama a função mostra_tree
            ;;          # os 2 ";;" (ponto e virgula)
                        # significam que chegou ao final
                        # esta opção do comando case

        10)		# seja igual a "10", então faça as instruções abaixo
            clear
	    copia_diretorio # Chama a função copia_diretorio
            ;;          # os 2 ";;" (ponto e virgula)
                        # significam que chegou ao final
                        # esta opção do comando case

        11)              # seja igual a "11", então faça as instruções abaixo
            clear
	    mover_arquivo # Chama a função mover_arquivo
            ;;          # os 2 ";;" (ponto e virgula)
                        # significam que chegou ao final
                        # esta opção do comando case

        12)              # seja igual a "11", então faça as instruções abaixo
            clear
	    sair_aplicacao # Chama a função sair_aplicacao
            ;;          # os 2 ";;" (ponto e virgula)
                        # significam que chegou ao final
                        # esta opção do comando case

        13)		# seja igual a "12", então faça as instruções abaixo
            clear
            exit ;;
        *)              # esta opçao existe para caso o usuário digite um 
                        # valor diferente das funções
            opcao_invalida ;;
    esac
}

localiza_user() {       # função da opção localiza_user
    whoami && pwd       # executa os comandos da função "whoami && pwd"
    echo "Finalizado, pressione ENTER para continuar"
    read pause          # usado para pausar a execução do script
    principal           # volta para a função principal
}

mostra_arquivos() {     # função da opção mostra_arquivos
    clear
    ls -lahn           #mostra os tipos de arquivos, seus tamanhos, seus donos e grupos 
    echo "Finalizado, pressione ENTER para continuar"
    read pause          # usado para pausar a execução do script
    principal           # volta para a função principal
}

criar_diretorio() {      # função da opção criar_diretorio
    clear
    echo "Digite o nome do diretório que deseja criar ou a referência absoluta ex: pasta ou /home/user/pasta."
    read diretorioCriado	# Efetua leitura da variavel a ser utilizada
    mkdir $diretorioCriado    # executa os comandos da função "mkdir"
    echo "Finalizado, pressione ENTER para continuar"
    read pause          # usado para pausar a execução do script
    principal           # volta para a função principal
}

excluir_diretorio() {      # função da opção excluir_diretorio
    clear
    echo "Digite o nome do diretório que deseja excluir:"
    echo "Digite o nome do diretório ou a referência absoluta ex: pasta ou /home/user/pasta."
    echo "O diretório só será excluido se não estiver vazio."
    read diretorioExcluido	# Efetua leitura da variavel a ser utilizada
    rmdir $diretorioExcluido    # executa os comandos da função "rmdir" 
    echo "Finalizado, pressione ENTER para continuar"
    read pause          # usado para pausar a execução do script
    principal           # volta para a função principal
}

compara_numero() {    # função da opção compara_numero
    clear
    echo "Digite o primeiro número:"    
    read numeroUm	# Efetua leitura da variavel a ser utilizada
    clear
    echo "Digite o segundo número:"
    read numeroDois	# Efetua leitura da variavel a ser utilizada
    clear
    if [ $numeroUm -gt $numeroDois ]	# executa os comandos da função "if"
	then	
	echo "O $numeroUm é o maior"
	echo "O $numeroDois é o menor"
    elif [ $numeroDois -gt $numeroUm ]	# executa os comandos da função "else if"
	then	
	echo "O $numeroDois é o maior"
	echo "O $numeroUm é o menor"
    else
	echo "Os dois são iguais"
    fi					# finaliza a função "if"
    echo "Finalizado, pressione ENTER para continuar"
    read pause          # usado para pausar a execução do script
    principal           # volta para a função principal
}

ler_fim() {             # função da opção ler_fim
    echo "Digite o nome do arquivo que deseja ler ex: arquivo ou /home/user/arquivo"   
    read arquivoLido		# Efetua leitura da variavel a ser utilizada
    echo "Digite o número de últimas linhas que deseja visualizar."
    read ultimasLinhas		# Efetua leitura da variavel a ser utilizada
    clear
    tail $arquivoLido -n $ultimasLinhas 	# executa os comandos da função "tail"
    echo "Finalizado, pressione ENTER para continuar"
    read pause          # usado para pausar a execução do script
    principal           # volta para a função principal
}

ler_inicio() {             # função da opção ler_inicio
    echo "Digite o nome do arquivo que deseja ler ex: arquivo ou /home/user/arquivo"   
    read arquivoLido2		# Efetua leitura da variavel a ser utilizada
    echo "Digite o número de primeiras linhas que deseja visualizar."
    read primeirasLinhas	# Efetua leitura da variavel a ser utilizada
    clear
    head $arquivoLido2 -n $primeirasLinhas 	# executa os comandos da função "head"
    echo "Finalizado, pressione ENTER para continuar"
    read pause          # usado para pausar a execução do script
    principal           # volta para a função principal
}

localiza_comando() {             # função da opção localiza_comando
    echo "Digite o comando que você necessita informações:"
    read comandoPesquisado	# Efetua leitura da variavel a ser utilizada
    whereis $comandoPesquisado
    echo "Finalizado, pressione ENTER para continuar"
    read pause          # usado para pausar a execução do script
    principal           # volta para a função principal
}

mostra_tree() {             # função da opção mostra_tree
    echo "Para utilizar essa opção é necessário instalar tree"
    echo "Deseja instalar o tree? S/N"
    read opcaoUsuario		# Efetua leitura da variavel a ser utilizada
    if [ "$opcaoUsuario" == "s" -o "$opcaoUsuario" == "S" ]
    	then
	clear
	echo "Instalando tree"
	sudo apt-get install tree	# Instala o tree se o usuário permitir
    elif [ "$opcaoUsuario" == "n" -o "$opcaoUsuario" == "N" ]
	then
	clear
    	echo "Nada será instalado."
    else
	clear
	echo "OPÇÂO INVÁLIDA"
	mostra_tree # Retorna ao inicio da função
    fi
    clear
    echo "Digite o nome do arquivo que deseja listar ex: arquivo ou /home/user/arquivo"
    read arquivoListado		# Efetua leitura da variavel a ser utilizada
    tree $arquivoListado	# Utiliza o comando "tree" listando o diretorio informado
    echo "Finalizado, pressione ENTER para continuar"
    read pause          # usado para pausar a execução do script
    principal           # volta para a função principal
}

copia_diretorio() {             # função da opção copia_diretorio
    echo "Digite o nome do arquivo que deseja copiar ex: arquivo ou /home/user/arquivo"
    read arquivoCopiado		# Efetua leitura da variavel a ser untilizada
    echo "Digite o nome do local que deseja colar ex: /home/user2/arquivo"
    read arquivoColado		# Efetua leitura da variavel a ser utilizada
    sudo cp $arquivoCopiado $arquivoColado -R
    echo "Finalizado, pressione ENTER para continuar"
    read pause          # usado para pausar a execução do script
    principal           # volta para a função principal
}

mover_arquivo() {             # função da opção mover_arquivo
    echo "Digite o nome do arquivo que deseja mover ex: arquivo ou /home/user/arquivo"
    read arquivoMovido		# Efetua leitura da variavel a ser utilizada
    echo "Digite o nome do local que deseja receber ex: arquivo ou /home/user2/arquivo"
    read arquivoRecebido	# Efetua leitura da variavel a ser utilizada
    sudo mv $arquivoMovido $arquivoRecebido
    echo "Finalizado, pressione ENTER para continuar"
    read pause          # usado para pausar a execução do script
    principal           # volta para a função principal
}

sair_aplicacao() {
    exit	# Sair do script
}

opcao_invalida() {     # função da opção opcao_invalida
    clear
    echo "Opção desconhecida"
    echo "Pressione ENTER para voltar ao menu principal"
    read pause      # Aguarda um "ENTER"
    principal       # Retorna a função principal
}

principal               # o script começa aqui, as funções das linhas anteriores
                        # são lidas pelo interpretador bash e armazenadas em memória.

                        # o bash não tem como adivinhar qual das funções ele deve 
                        # executar, por isto o a execução do script realmente começa
                        # quando aparece uma instrução fora de uma função, neste caso,
                        # chamando a função principal
