use Homol_MIRANTE
go
-- =============================================
-- Author:		William Hartung
-- Create date: 03/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Grafico_Waterfall_Modelo 123,1,3
-- proc_Dash_Grafico_Waterfall_Modelo 123,2,2
-- proc_Dash_Grafico_Waterfall_Modelo 123,3
-- proc_Dash_Grafico_Waterfall_Modelo 123,null
-- =============================================
alter PROCEDURE dbo.proc_Dash_Grafico_Waterfall_Modelo
	@IDUsuario INT,
	@IDParam1 INT = NULL,
	@IDParam2 INT = NULL,
	@IDParam3 INT = NULL
AS
BEGIN

DECLARE @Cor1 VARCHAR(8) = '#000', @Cor2 VARCHAR(8) = '#aaaaaa', @Cor3 VARCHAR(8) = '#ff5469', @Cor4 VARCHAR(15) = 'transparent';

DECLARE @Grafico AS Table (
		Descricao VARCHAR(50),
		CorFonte VARCHAR(50),
		CorFundo VARCHAR(50),
		CorLegenda VARCHAR(50),
		Tipo VARCHAR(50),
		[2019] VARCHAR(50),
		[2020] VARCHAR(50),
		[2021] VARCHAR(50),
		[2022] VARCHAR(50),
		[2023] VARCHAR(50)
	)

--WAITFOR DELAY '00:00:01:30';

	INSERT INTO @Grafico VALUES ('Gold', @Cor1,@Cor4,@Cor3,'line','0','10%','15%','12%','0');
	INSERT INTO @Grafico VALUES ('Points', @Cor1,@Cor2,@Cor2,'bar','0|66.672,00','66.672,00|72.672,00','72.672,00|78.072,00','78.072,00|78.438,00','78.438,00');
	
	SELECT * FROM @Grafico
		
END
GO
