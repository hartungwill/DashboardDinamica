# DashboardDinamica
 Template de construção de dashboard dinâmica, com configurações vindo do banco de dados
 A Solution contém uma pasta com os scripts de Banco de Dados, estrutura de tabelas e procedures, que a aplicação .netframework conecta via Dapper (baixado via NUGET), manda via json para o JS que traduz os dados para os gráficos, com opções pré-definidas.
 Observação: Parte do Javascript está em outra pasta, diferente da aplicação principal, para ser usada como uma CDN. Ao rodar o projeto principal, o projeto do tipo WebSite, contendo os arquivos de CDN deverá ser executado também, do contrário, os links do JS não serão encontrados (404)

Utilizado:

* SQL Server (2014+)
* .Net Framework - C# - modelo MVC
* Dapper
* JS
* Google Maps API
* HTML
* CSS
* Less
* Plugin: ChartJS - https://www.chartjs.org/
* Plugin: Bootstrap - https://getbootstrap.com/

Acessos à página (sem mudar a porta configurada):

* http://localhost:54382/Dashboard/Index/1
* http://localhost:54382/Dashboard/Index/3
