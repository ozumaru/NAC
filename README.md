Script para realizar Backup do WebServer Apache no Ubuntu

- Primeiramente o script ira verificar algumas instruções com o usuario, podendo assim automatizar a ação do script, ou ainda permanecer "Manual" mesmo já sendo automatizado.

- Os seguintes passos que será realizado pelo script, será para seguir uma rotina que o próprio usuario irá realizar no tempo que o mesmo achar necessário, ou simplesmente permitir que o script execute a mesma função com base na opção que o usuario escolher, executando Hora a Hora, Dia a Dia, Mês a Mês, a forma como o Usuario escolher.

-É importante que ao realizaro "git clone" do arquivo, configurar o permissionamento para "chmod +x" dos arquivos ".sh", e os executar como Root. 

- A rotina que foi programada no script para que sempre que for executado, será de:

1: Inicialmente ira verificar quais das opções o usuario irá escolher, foi criado uma função para que, com base em um "case" seja chamado outras funções, sendo que essas informações iniciais que será necessário uma interação do usuario para seguir para o proximo passo.

    Informações a serem verificadas e ações a serem tomadas:
        - Verificar se o sistema é compativel com o script.
        - Instalar o WebServer Apache.
        - Verificar se o diretório "/Backup_webServer" já existe, e se não, criar o mesmo, e é feito o Backup inicial.
        - Fazer o Backup para o diretório que foi criado.
        - Mostrar o caminho de onde foi craido o Backup.
        - Automatizar o script para executar de hora/hora, dia/dia ou mensalmente. 

2: Dependendo da escolha do Usuario, o script vai executar a função que foi solicitada, dessa forma, segue abaixo o funcionamento de cada uma delas: 

    2.1: Função "inicio()" - Executa a verificação inicial do Usuario, qual será a ação que o mesmo ira tomar.

    2.2: Função "seeSystem()" - Verifica se o Sistema Operacional é compativel com o Script (Familia Ubuntu).

    2.3: Função "apache()" - Verifica se o Apache está instalado, caso não esteja, o instala.

    2.4: Função "seeDir()" - Verifica se o diretório "/Backup_webServer" existe para fazer os backup necessários, caso o diretório não exista, é criado, e é feito o Backup inicial.

    2.5: Função "doBackup()" - Faz o Backup necessário para a restauração do Apache em caso de falhas futuras, e dos arquivos de configuração do mesmo.

    2.6: Função "showPath()" - Mostra o caminho de onde está localizado o diretório do Backup.

    2.7: Função "autoScr()" - Cria a automação do Script para executar automanticamente dependendo do qual o usuario escolheu, necessário indicar todo o caminho até o arquivo, e o Script para simplesmente executar a automação é o "/backup_aut.sh" ao colocar o nome dele na indicação do local, o script será executado automaticamente de acordo com o agendamento.

