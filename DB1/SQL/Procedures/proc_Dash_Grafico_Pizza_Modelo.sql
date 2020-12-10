
-- =============================================
-- Author:		William Hartung
-- Create date: 03/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Grafico_Pizza_Modelo 123,1,3
-- proc_Dash_Grafico_Pizza_Modelo 123,2,2
-- =============================================
ALTER PROCEDURE dbo.proc_Dash_Grafico_Pizza_Modelo
	@IDUsuario INT,
	@IDParam1 INT = null,
	@IDParam2 INT = NULL
AS
BEGIN

DECLARE @GraficoPizza AS Table (
	Descricao VARCHAR(50),
	CorFonte VARCHAR(50),
	CorFundo VARCHAR(50),
	Qtde INT
)
   
INSERT INTO @GraficoPizza VALUES ('Legenda 1', '#0000ff','#D30827', 1663)
INSERT INTO @GraficoPizza VALUES ('Legenda 2', '#0000ff','#3B82B8', 587)
INSERT INTO @GraficoPizza VALUES ('Legenda 3', '#0000ff','#E4E6E7', 3050) 
INSERT INTO @GraficoPizza VALUES ('Legenda 4', '#0000ff','#F9D215', 2058)

WAITFOR DELAY '00:00:01:00';

	IF	@IDParam1 = 1
		BEGIN
			SELECT Descricao, CorFonte, CorFundo, Qtde FROM @GraficoPizza
		END
	ELSE IF	@IDParam1 = 2
		BEGIN
			SELECT Descricao AS Texto, CorFonte AS CorTexto, CorFundo AS CorCor, Qtde AS Percentual FROM @GraficoPizza
		END
	ELSE
		BEGIN
		SELECT	* FROM @GraficoPizza
		END

END
GO
