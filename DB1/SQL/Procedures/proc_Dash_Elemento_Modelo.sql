-- =============================================
-- Author:		William Hartung
-- Create date: 03/02/2020
-- Description:	Procedure de modelo para gr�ficos din�micos
-- proc_Dash_Elemento_Modelo 442,1
-- proc_Dash_Elemento_Modelo 1167,3
-- =============================================

CREATE PROCEDURE dbo.proc_Dash_Elemento_Modelo
	@ID_Usuario INT,
	@ID_Dashboard INT = NULL
AS
BEGIN

	SELECT  dash.IDElemento 
		   ,dash.IDDashboard
           ,dash.Linha
		   ,cont1.Descricao + ISNULL(cont2.Descricao,'') + '-' + CAST(ROW_NUMBER() OVER(ORDER BY dash.IDDashboard, dash.Linha ) AS VARCHAR) AS IDComponente
           ,cont1.Descricao AS ConteudoPrimario
		   ,cont2.Descricao AS ConteudoSecundario
           ,dash.Titulo
           ,REPLACE(spcall.SP_Call,'{@IDUsuario}', @ID_Usuario) AS SP_Call
           ,spcall.ConcatenaFiltros
		   ,html.Html
		   ,dash.Ordem
	FROM dbo.Dash_Elemento dash
	LEFT JOIN Dash_ConteudoPrimario cont1 ON cont1.IDConteudoPrimario = dash.IDConteudoPrimario
	LEFT JOIN Dash_ConteudoSecundario cont2 ON cont2.IDConteudoSecundario = dash.IDConteudoSecundario
	LEFT JOIN Dash_ProcedureCalls spcall ON spcall.IDCall = dash.IDCall
	LEFT JOIN Dash_Html html ON html.IDHtml = dash.IDHtml
	WHERE @ID_Dashboard IS NULL OR @ID_Dashboard = dash.IDDashboard
	ORDER BY dash.IDDashboard, dash.Linha, dash.Ordem

END
GO
