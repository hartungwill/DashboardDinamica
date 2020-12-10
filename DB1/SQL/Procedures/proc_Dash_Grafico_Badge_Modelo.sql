
-- =============================================
-- Author:		William Hartung
-- Create date: 03/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Grafico_Badge_Modelo 123,1,3
-- proc_Dash_Grafico_Badge_Modelo 123,2,2
-- proc_Dash_Grafico_Badge_Modelo 123,0
-- proc_Dash_Grafico_Badge_Modelo 123,3
-- =============================================
alter PROCEDURE dbo.proc_Dash_Grafico_Badge_Modelo
	@IDUsuario INT,
	@IDParam1 VARCHAR(50) = NULL,
	@IDParam2 VARCHAR(50) = NULL,
	@IDParam3 VARCHAR(50) = NULL
AS
BEGIN

	DECLARE @GraficoBadge AS Table (
		Descricao VARCHAR(50),
		CorFonte VARCHAR(50),
		CorFundo VARCHAR(50),
		Qtde FLOAT
	)
   
   DECLARE @GraficoBadge2 AS Table (
		Descricao VARCHAR(50),
		CorFonte VARCHAR(50),
		CorFundo VARCHAR(50),
		Qtde FLOAT
	)

	INSERT INTO @GraficoBadge2 VALUES ('Meta', '#0000ff','ff0000', 122.959)
	INSERT INTO @GraficoBadge2 VALUES ('Realizado', '#008000','0000ff', 122.959)

	INSERT INTO @GraficoBadge VALUES ('Meta', '#0000ff','#008000', 1000)
	INSERT INTO @GraficoBadge VALUES ('Realizado', '#ff0000','0000ff', 1200)

	IF	@IDParam1 = 'SP'
		BEGIN
			SELECT Descricao, CorFonte, CorFundo, Qtde FROM @GraficoBadge
		END
	ELSE IF	@IDParam1 = 'RJ'
		BEGIN
			SELECT Descricao AS Texto, CorFonte AS CorTexto, CorFundo AS CorCor, Qtde AS Percentual FROM @GraficoBadge
		END

	ELSE IF	@IDParam1 = 'VALOR 3'
		BEGIN
			SELECT * FROM @GraficoBadge2
		END
	ELSE 
		BEGIN
			SELECT * FROM @GraficoBadge2
		END
END
GO
