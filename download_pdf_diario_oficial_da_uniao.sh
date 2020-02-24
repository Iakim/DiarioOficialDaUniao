#!/bin/bash
###################################################################################
## Nginx-Log-Csv 						   		 ##
## Script bash for create a graph from csv of processing of logs nginx/apache	 ##
## Author: https://github.com/Iakim 				    		 ##
## Simplicity is the ultimate degree of sophistication		    		 ##
###################################################################################

#### Configuração de dia
#diainicio=21 #Manualmente
#mesinicio=02 #Manualmente

diainicio=`date +%d`
mesinicio=`date +%m`

diafim=`date +%d`
mesfim=`date +%m`

#### Não alterar abaixo #####
curl --silent -X GET "http://pesquisa.in.gov.br/imprensa/core/jornalList.action?edicao.dtInicio=$diainicio%2F$mesinicio&edicao.ano=2020&edicao.dtFim=$diafim%2F$mesfim&edicao.jornal_hidden=1%2C1000%2C1010%2C1020%2C515%2C521%2C522%2C531%2C535%2C536%2C523%2C532%2C540%2C1040%2C2%2C2000%2C529%2C525%2C3%2C3000%2C3020%2C1040%2C526%2C530%2C600%2C601%2C602%2C603%2C604%2C605%2C606%2C607%2C608%2C609%2C610%2C611%2C612%2C613%2C614%2C615%2C701%2C702&edicao.jornal=1%2C1000%2C1010%2C1020%2C515%2C521%2C522%2C531%2C535%2C536%2C523%2C532%2C540%2C1040%2C2%2C2000%2C529%2C525%2C3%2C3000%2C3020%2C1040%2C526%2C530%2C600%2C601%2C602%2C603%2C604%2C605%2C606%2C607%2C608%2C609%2C610%2C611%2C612%2C613%2C614%2C615%2C701%2C702&__checkbox_edicao.jornal=1%2C1000%2C1010%2C1020%2C515%2C521%2C522%2C531%2C535%2C536%2C523%2C532%2C540%2C1040%2C2%2C2000%2C529%2C525%2C3%2C3000%2C3020%2C1040%2C526%2C530%2C600%2C601%2C602%2C603%2C604%2C605%2C606%2C607%2C608%2C609%2C610%2C611%2C612%2C613%2C614%2C615%2C701%2C702&__checkbox_edicao.jornal=1%2C1000%2C1010%2C1020%2C515%2C521%2C522%2C531%2C535%2C536%2C523%2C532%2C540%2C1040%2C600%2C601%2C602%2C603%2C612%2C613%2C614%2C615%2C701&__checkbox_edicao.jornal=2%2C2000%2C529%2C525%2C604%2C605%2C606%2C607%2C702&__checkbox_edicao.jornal=3%2C3000%2C3020%2C1040%2C526%2C530%2C608%2C609%2C610%2C611&d-7825134-p=1" | grep onclick | grep download | awk '{print$1}' | sed 's/^onclick="redirecionaSelect(//' | sed 's/);"><img//' | sed "s/'//" | sed "s/'//" | sed 's/amp;//' > ok.txt
dos2unix -q ok.txt
while IFS= read -r line
do
	name=`echo "$line" | sed 's/http:\/\/download.in.gov.br\/sgpub\/do\/.*\/.*\/.*\///' | sed 's/?.*//'`
	echo "Baixando $name"
	wget --quiet -O "$name" "$line"
done < "ok.txt"
rm -rf ok.txt
