
-- =============================================
-- Author:		William Hartung
-- Create date: 03/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Grafico_Barra_Modelo 123,1,3
-- proc_Dash_Grafico_Barra_Modelo 123,2,2
-- proc_Dash_Grafico_Barra_Modelo 123,3
-- proc_Dash_Grafico_Barra_Modelo 123,null
-- =============================================
create PROCEDURE dbo.proc_Dash_Grafico_Barra_Modelo
	@IDUsuario INT,
	@IDParam1 INT = NULL,
	@IDParam2 INT = NULL,
	@IDParam3 INT = NULL
AS
BEGIN

DECLARE @Cor1 VARCHAR(8) = '#00b050', @Cor2 VARCHAR(8) = '#f4b183', @Cor3 VARCHAR(8) = '#00ff00', @Cor4 VARCHAR(8) = '#0000ff';

DECLARE @GraficoBarra AS Table (
		Descricao VARCHAR(50),
		CorFonte VARCHAR(50),
		CorFundo VARCHAR(50),
		jan20 INT,
		fev20 INT,
		mar20 INT
	)

DECLARE @GraficoBarra2 AS Table (
		Descricao VARCHAR(50),
		CorFonte VARCHAR(50),
		CorFundo VARCHAR(50),
		jan20 INT,
		fev20 INT,
		mar20 INT
	)

WAITFOR DELAY '00:00:01:30';

	INSERT INTO @GraficoBarra VALUES ('SP', @Cor1,@Cor1,150,350,266);
	INSERT INTO @GraficoBarra VALUES ('PE', @Cor2,@Cor2, 100,500,700);

	INSERT INTO @GraficoBarra2 VALUES ('RJ', @Cor2,@Cor2, 0,0,1271);
	INSERT INTO @GraficoBarra2 VALUES ('MG', @Cor1,@Cor1,0,0,1013);

	IF	@IDParam1 = 1
		BEGIN
			SELECT * FROM @GraficoBarra
		END
	ELSE IF	@IDParam1 = 2
		BEGIN
			SELECT Descricao AS Texto, CorFonte AS CorPonto, CorFundo AS CorLinha, jan20 AS [jan/20], fev20 AS [fev/20], mar20 AS [mar/20]  FROM @GraficoBarra
		END

	ELSE IF	@IDParam1 = 3
		BEGIN
			SELECT * FROM @GraficoBarra2
		END
	ELSE 
		BEGIN
			SELECT * FROM @GraficoBarra2
		END

END
GO
