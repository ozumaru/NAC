#!/bin/bash

clear 

#Funcao inicial, mostra ao usuario as opcoes que podera escolher para a tomada de acao
inicio(){
	CONTROL=0
        if [ $CONTROL == 0 ] || [ $CONTROL <= 8 ]; then
                echo " "
                echo "Digite um numero para seguir com as opcoes abaixo!"
                echo " "
                echo "(1) - Verificar compatibilidade do Script com o Sistema"
                echo "(2) - Instalar o WebServer Apache"
                echo "(3) - Verificar Diretorio de Backup e Fazer Backup inicial"
                echo "(4) - Fazer Backup do WebServer"
                echo "(5) - Mostrar Caminho do Diretorio de Backup"
                echo "(6) - Automatizar o Script para auto execucao"
                echo "(7) - Recuperacao do WebServer em caso de Falha"
                echo "(8) - Sair do programa"
                read ver
        fi
        case $ver in
                1) seeSystem; inicio ;;
                2) apache; inicio ;;
                3) seeDir; doBackup; inicio ;;
                4) doBackup; inicio ;;
                5) showPath; inicio ;;
                6) autoScr; inicio ;;
                7) echo "(7) - Restauração do WebServer em caso de Falha" ;;
                8) echo "Programa Encerrado"; exit ;;
                *) echo "Opcao desconhecida"; inicio ;;
        esac
}


#Funcao ira instalar o WebServer Apache.
apache(){
    	sudo apt-get install apache2
	return inicio;
}

#Funcao inicial para verificar o sistema.
seeSystem(){
    	#Variavel contem informacao do Sistema.
    	SO=$(cat /etc/*release | grep ^NAME | cut -d "=" -f2 | cut -d '"' -f2)

    	#Condicao para verificar informacao do sistema na Variavel S.O.
    	if [ $SO == Ubuntu ]; then
    		echo "Sistema: $SO"
        	echo "Sistema $SO - Compativel com o Script, siga com as demais funcoes!"
    	else
    		echo "Sistema $SO - Não compativel."
    		exit
    	fi
}

#Funcao para verificar se Existe ou Não o Diretorio de Backup "/Backup_WebServer".
seeDir(){
    	#Criacao e Verificacao se Diretorio de Backup Existe
    	if [ -e "/Backup_WebServer" ]; then
    		echo "O diretorio existe!"
    	else
    		echo "O diretorio não existe!"
    		mkdir /Backup_WebServer
		echo "Diretorio criado com Sucesso!"
	fi
}

#Funcao para fazer o Backup.
doBackup(){
    	#Sera feito um Backup dos Diretorios e dos Arquivos abaixo para a pasta na Raiz "/Backup_WebServer"
    	#	Diretorio: /var/www/
    	#	Diretorio: /var/log/apache2/
    	#	Arquivo:   /etc/apache2/apache2.conf
    	#	Arquivo:   /etc/apache2/conf-available
    	#	Arquivo:   /etc/apache2/conf-enabled

    	#Variaveis Contem Diretorio e Arquivos
    	#Variavel contem Hora e Data.
    	DATA=$(date "+%d-%m-%y_%Hh%Mm")
    	LOCAL_BACKUP="/Backup_WebServer"
    	VAR_DIR=("/var/log/apache2" "/var/www")
    	VAR_ARC=("/etc/apache2/apache2.conf" "/etc/apache2/conf-available" "/etc/apache2/conf-enabled")
    	BACKUP=("${VAR_DIR[@]}" "${VAR_ARC[@]}")
   	NOME_ARC="Apache-"$DATA".tgz"
	echo " "
	echo "Realizando Backup..."
	echo " "
    	#Compactando os arquivos e enviando para o Local de Backup
    	sudo tar -czvf ${LOCAL_BACKUP}/${NOME_ARC} ${BACKUP[@]}
	echo " "
	echo "Backup realizado com Sucesso para a pasta $LOCAL_BACKUP."
	echo " "
}

#Funcao mostra o caminho para onde o Backup foi enviado.
showPath(){
    	echo " "
    	echo "Local a pasta $LOCAL_BACKUP foi criada na RAIZ do sistema."
    	echo " "
    	ls -l /
}

#Funcao para automatizar o Script de backup
autoScr(){
	echo " "
    	echo "Sera feito a Automação do Script, para que o mesmo execute automaticamente"
    	echo "Caso queria pular alguma informacao como Hora, Minuto ou etc, colocar asterisco *"
	echo " "
	read -p "Digite a hora - 0 a 23: " H
    	read -p "Digite a minuto - 0 a 59: " M
    	read -p "Digite a Dia do Mês - 1 a 31: " DDM
    	read -p "Digite a Mês - 1 a 12: " M
    	read -p "Digite a Dia da Semana - 0 a 6 (0 é Domingo): " DDS
    	read -p "Digite a Caminho do Script de Backup Automatico: " P
    	echo " "
	echo "$M $H $DDM $M $DDS $P" >> /etc/crontab
}

#Chamado a função Principal do Script
inicio
