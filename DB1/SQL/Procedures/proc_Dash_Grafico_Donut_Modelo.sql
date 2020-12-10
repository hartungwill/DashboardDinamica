
-- =============================================
-- Author:		William Hartung
-- Create date: 03/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Grafico_Donut_Modelo 123,1,3
-- proc_Dash_Grafico_Donut_Modelo 123,2,2
-- proc_Dash_Grafico_Donut_Modelo 123,0
-- proc_Dash_Grafico_Donut_Modelo 123,3
-- =============================================
ALTER PROCEDURE dbo.proc_Dash_Grafico_Donut_Modelo
	@IDUsuario INT,
	@IDParam1 INT = NULL,
	@IDParam2 INT = NULL,
	@IDParam3 INT = NULL
AS
BEGIN

	DECLARE @GraficoDonut AS Table (
		Descricao VARCHAR(50),
		CorFonte VARCHAR(50),
		CorFundo VARCHAR(50),
		Qtde FLOAT
	)
   
   DECLARE @GraficoDonut2 AS Table (
		Descricao VARCHAR(50),
		CorFonte VARCHAR(50),
		CorFundo VARCHAR(50),
		Qtde FLOAT
	)

WAITFOR DELAY '00:00:00:30';

	INSERT INTO @GraficoDonut VALUES ('Categoria', '#ffffff','#00b050', 750)
	INSERT INTO @GraficoDonut VALUES ('Perfil', '#0000ff','transparent', 1000)

	INSERT INTO @GraficoDonut2 VALUES ('MG', '#ffffff','#00b050', 89.989)
	INSERT INTO @GraficoDonut2 VALUES ('PE', '#0000ff','transparent', 85.123)

	IF	@IDParam1 = 1
		BEGIN
			SELECT Descricao, CorFonte, CorFundo, Qtde FROM @GraficoDonut
		END
	ELSE IF	@IDParam1 = 2
		BEGIN
			SELECT Descricao AS Texto, CorFonte AS CorTexto, CorFundo AS CorCor, Qtde AS Percentual FROM @GraficoDonut
		END

	ELSE IF	@IDParam1 = 3
		BEGIN
			SELECT * FROM @GraficoDonut2
		END
	ELSE 
		BEGIN
			SELECT * FROM @GraficoDonut2
		END
END
GO
