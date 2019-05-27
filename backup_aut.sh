#!/bin/bash

#Variavel contem Hora e Data
DATA=$(date "+%d-%m-%y_%Hh%Mm")

#Variavel contem informacao do Sistema
SO=$(cat /etc/*release | grep ^NAME | cut -d "=" -f2 | cut -d '"' -f2)

#Condicao para verificar informacao do sistema na Variavel SO
if [ $SO == Ubuntu ]; then
	echo "Sistema: $SO"
else
	echo "Sistema: $SO"
	exit
fi

#Sera feito um Backup do Diretorio e dos Arquivos abaixo para a pasta "/Backup_WebServer"
#	Diretorio: /var/log/apache2/
#	Arquivo:   /etc/apache2/apache2.conf
#	Arquivo:   /etc/apache2/conf-available
#	Arquivo:   /etc/apache2/conf-enabled

#Criacao e Verificacao se Diretorio de Backup Existe
if [ -e "/Backup_WebServer" ]; then
	echo "O diretorio existe!"
else
	echo " o diretorio não existe vamos criar o diretorio"
	mkdir /Backup_WebServer
fi

#Variaveis Contem Diretorio e Arquivos
LOCAL_BACKUP="/Backup_WebServer"
VAR_DIR=("/var/log/apache2" "/var/www")
VAR_ARC=("/etc/apache2/apache2.conf" "/etc/apache2/conf-available" "/etc/apache2/conf-enabled")
BACKUP=("${VAR_DIR[@]}" "${VAR_ARC[@]}")
NOME_ARC="Apache-$DATA.tgz"

#Compactando os arquivos e enviando para o Local de Backup
sudo tar -czvf ${LOCAL_BACKUP}/${NOME_ARC} ${BACKUP[@]}
