
DECLARE	@ID_Usuario INT = 1987,
		@ID_Dashboard INT = 1;

	 SELECT  dash.IDElemento     
		 ,dash.IDDashboard    
			   ,dash.Linha    
		 ,cont1.Descricao + ISNULL(cont2.Descricao,'') + '-' + CAST(ROW_NUMBER() OVER(ORDER BY dash.IDDashboard, dash.Linha ) AS VARCHAR) AS IDComponente    
			   ,cont1.Descricao AS ConteudoPrimario    
		 ,cont2.Descricao AS ConteudoSecundario    
			   ,dash.Titulo    
		 ,REPLACE(spcall.SP_Call,'{IDUsuario}', @ID_Usuario)  AS SP_Call    
			   ,spcall.ConcatenaFiltros    
		 ,html.Html    
		 ,dash.Ordem    
	 FROM dbo.Dash_Elemento dash    
	 LEFT JOIN Dash_ConteudoPrimario cont1 ON cont1.IDConteudoPrimario = dash.IDConteudoPrimario    
	 LEFT JOIN Dash_ConteudoSecundario cont2 ON cont2.IDConteudoSecundario = dash.IDConteudoSecundario    
	 LEFT JOIN Dash_ProcedureCalls spcall ON spcall.IDCall = dash.IDCall    
	 LEFT JOIN Dash_Html html ON html.IDHtml = dash.IDHtml    
	 WHERE @ID_Dashboard IS NULL OR @ID_Dashboard = dash.IDDashboard    
	--AND dash.Linha = 3
	--AND dash.IDConteudoPrimario = 1 -- AND dash.IDConteudoSecundario is null
	--AND IDElemento = 30
	ORDER BY dash.IDDashboard, dash.Linha, dash.Ordem
	

/*
begin tran
update Dash_Elemento set IDConteudoSecundario = 6 where IDElemento in (48,49,50,51,52)

commit
*/