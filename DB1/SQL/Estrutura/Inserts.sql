USE [master]
GO
/*
INSERT INTO [dbo].[Dash_ConteudoPrimario] ([Descricao]) VALUES ('filtro')
INSERT INTO [dbo].[Dash_ConteudoPrimario] ([Descricao]) VALUES ('chart')
INSERT INTO [dbo].[Dash_ConteudoPrimario] ([Descricao]) VALUES ('label')
INSERT INTO [dbo].[Dash_ConteudoPrimario] ([Descricao]) VALUES ('custom')
INSERT INTO [dbo].[Dash_ConteudoPrimario] ([Descricao]) VALUES ('table')
INSERT INTO [dbo].[Dash_ConteudoPrimario] ([Descricao]) VALUES ('relatorio')
INSERT INTO [dbo].[Dash_ConteudoPrimario] ([Descricao]) VALUES ('map')
INSERT INTO [dbo].[Dash_ConteudoPrimario] ([Descricao]) VALUES ('badge')

INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('bar')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('pie')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('horizontalBar')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('line')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('doughnut')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('custom')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('stacked')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('stackedGroup')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('doughnutCustom')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('paginadoBD')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('paginadoAuto')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('dropdown')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('multiple')
INSERT INTO [dbo].[Dash_ConteudoSecundario] ([Descricao]) VALUES ('waterfall')

INSERT INTO [dbo].[Dash_Dashboards] ([Descricao]) VALUES('Dashboard Modelo')

INSERT INTO [dbo].[Dash_Html] ([Html],[Descricao]) VALUES ('<div style="display: flex; width: 100%;"><div style="flex-grow: 1; background-size: auto; background-position-x:left; height: 62px; background-image: url(/Images/f1_line.png); background-repeat: repeat-x;"></div><div style="height: 62px; width: 114px; background-image: url(/Images/f1_car.png);"></div></div>','Separador personalizado carrinho')
INSERT INTO [dbo].[Dash_Html] ([Html],[Descricao]) VALUES ('background-size: 30%; background-image: url(http://localhost:58893/Images/protetor-mini.jpg);','Imagem local de Protetor')
INSERT INTO [dbo].[Dash_Html] ([Html],[Descricao]) VALUES ('background-size: 30%; background-image: url(http://localhost:58893/Images/ceu-azul-nuvens.jpg);','Imagem local de Fundo')
INSERT INTO [dbo].[Dash_Html] ([Html],[Descricao]) VALUES ('height: auto;','Configuração de altura padrão')
INSERT INTO [dbo].[Dash_Html] ([Html],[Descricao]) VALUES ('floating-select','Configuração do filtro flutuante')


INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao]) VALUES ('proc_Dash_Filtros_Modelo 123,1','Filtro 1')
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao]) VALUES ('proc_Dash_Filtros_Modelo 123,2','Filtro 2')
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao]) VALUES ('proc_Dash_Grafico_Pizza_Modelo {@IDUsuario}','Proc de Gráfico Pizza 1')
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao]) VALUES ('proc_Dash_Filtros_Star_QTR {@IDUsuario},1','Star - QTR')
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao]) VALUES ('proc_Dash_Filtros_Star_Franquia {@IDUsuario},1','Star - Franquia')
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao]) VALUES ('proc_Dash_Grafico_BarraHorizontal_Modelo {@IDUsuario},1,3','Star - Modelo gráfico barra') 
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao]) VALUES ('proc_Dash_Grafico_Donut_Modelo {@IDUsuario}','Star - Modelo gráfico Donut') 
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao]) VALUES ('proc_Dash_Grafico_Linha_Modelo {@IDUsuario}','Modelo gráfico Linha') 
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao]) VALUES ('proc_Dash_Grafico_Linha_Modelo2 {@IDUsuario}','Modelo gráfico Linha 2 (Pivot)') 
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao]) VALUES ('proc_Dash_Grafico_BarraHorizontal_Modelo2 {@IDUsuario}','Modelo gráfico Barra 2 (Pivot)') 
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Filtros_Modelo_Nivel1 {@IDUsuario}','Modelo de Filtro em cascata Nível 1',0)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Filtros_Modelo_Nivel2 {@IDUsuario}','Modelo de Filtro em cascata Nível 2',1)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Filtros_Modelo_Nivel3 {@IDUsuario}','Modelo de Filtro em cascata Nível 3',1)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao]) VALUES ('proc_Dash_Table_Modelo {@IDUsuario}','Modelo de Tabela') 
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Grafico_Combo_Modelo {@IDUsuario}','Modelo de gráfico de Combo (linha e barra)',1)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Grafico_Combo_Modelo {@IDUsuario}','Modelo de gráfico de Combo (linha e barra)',1)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Grafico_Stacked_Modelo {@IDUsuario}','Modelo de gráfico de barra empilhada (linha e barra)',1)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Grafico_Stacked_Group_Modelo {@IDUsuario}','Modelo de gráfico de Grupo',1)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Relatorio_Cloud_Modelo {@IDUsuario}','Modelo de Chamada de relatário da API',1)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Relatorio_Cloud_Modelo {@IDUsuario},{@QtdPorPagina},{@Pagina}','Relatório com paginação via proc',1)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Table_Modelo2 {@IDUsuario},{@QtdPorPagina},{@Pagina}','Relatório com paginação auto 2',1)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Mapa_Modelo {@IDUsuario}','Gráfico de Mapa',1)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Grafico_Waterfall_Modelo {@IDUsuario}','Gráfico de Waterfall',1)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Grafico_Badge_Modelo {@IDUsuario}','Destaque tipo badge',1)
INSERT INTO [dbo].[Dash_ProcedureCalls] ([SP_Call],[Descricao],[ConcatenaFiltros]) VALUES ('proc_Dash_Grafico_Waterfall_Modelo2 {@IDUsuario}','Gráfico de Waterfall modelo 2',1)


--SELECTS
select * from Dash_ProcedureCalls where idcall = 20
select * from Dash_ConteudoPrimario
select * from Dash_ConteudoSecundario
select * from Dash_ProcedureCalls
*/


INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])
    VALUES
          (1
          ,1
          ,3
          ,null
          ,'Dashboard Dinâmica Modelo 1'
          ,null
          ,null)
GO

INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])
    VALUES
          (1
          ,2
          ,1
          ,null
          ,'Primeiro Filtro'
          ,1
          ,null)

		   
INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])
    VALUES
          (1
          ,2
          ,1
          ,null
          ,'Segundo Filtro'
          ,2
          ,null)


INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])
    VALUES
          (1
          ,2
          ,1
          ,null
          ,'Terceiro Filtro'
          ,1
          ,null)


INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])
    VALUES
          (1
          ,3
          ,2
          ,2
          ,'Gráfico de Pizza 1'
          ,3
          ,null)

INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])
    VALUES
          (1
          ,5
          ,2
          ,4
          ,'Gráfico de Linha'
          ,3
          ,null)



INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])
SELECT		1
          ,7
          ,IDConteudoPrimario
          ,IDConteudoSecundario
          ,Titulo
          ,IDCall
          ,IDHtml
FROM [Dash_Elemento] WHERE IDElemento IN (7,8,16,17)


INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])


INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])

SELECT		1
          ,9
          ,2
          ,6
          ,'Gráfico de Combo (Linha e barra)'
          ,15
          ,null

INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])

SELECT		1
          ,11
          ,2
          ,8
          ,'Gráfico de Grupo'
          ,17
          ,null



INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])

SELECT		1
          ,12
          ,6
          ,null
          ,'Lista de relatórios'
          ,18
          ,null





/*
Dashboard 3
*/


INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])
    VALUES
          (3
          ,1
          ,1
          ,null
          ,'Primeiro Filtro'
          ,1
          ,null)

		   
INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])
    VALUES
          (3
          ,1
          ,1
          ,null
          ,'Segundo Filtro'
          ,2
          ,null)


INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])
    VALUES
          (3
          ,1
          ,1
          ,null
          ,'Terceiro Filtro'
          ,1
          ,null)





INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])

SELECT		3
          ,2
          ,6
          ,null
          ,'Relat�rio com pagina��o via procedure'
          ,19
          ,null

INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])

SELECT		3
          ,3
          ,5
          ,11
          ,'Relat�rio com pagina��o autom�tica'
          ,14
          ,null

INSERT INTO [dbo].[Dash_Elemento]
          ([IDDashboard]
          ,[Linha]
          ,[IDConteudoPrimario]
          ,[IDConteudoSecundario]
          ,[Titulo]
          ,[IDCall]
          ,[IDHtml])

SELECT		3
          ,4
          ,7
          ,null
          ,'Gr�fico de Mapa'
          ,21
          ,null



INSERT INTO [dbo].[Dash_Elemento]
           ([IDDashboard]
           ,[Linha]
           ,[IDConteudoPrimario]
           ,[IDConteudoSecundario]
           ,[Titulo]
           ,[IDCall]
           ,[IDHtml])

SELECT		3
           ,6
           ,2
           ,14
           ,'Gr�fico de Waterfall'
           ,23
           ,null


INSERT INTO [dbo].[Dash_Elemento]
           ([IDDashboard]
           ,[Linha]
           ,[IDConteudoPrimario]
           ,[IDConteudoSecundario]
           ,[Titulo]
           ,[IDCall]
           ,[IDHtml])

SELECT		3
           ,5
           ,8
           ,null
           ,'CRESCIMENTO BADGE'
           ,24
           ,null