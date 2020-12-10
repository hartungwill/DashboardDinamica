
-- =============================================
-- Author:		William Hartung
-- Create date: 11/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Grafico_Linha_Modelo 123,1,3
-- proc_Dash_Grafico_Linha_Modelo 123,2,2
-- proc_Dash_Grafico_Linha_Modelo 123,3
-- proc_Dash_Grafico_Linha_Modelo 123,null
-- =============================================
alter PROCEDURE dbo.proc_Dash_Grafico_Linha_Modelo
	@IDUsuario INT,
	@IDParam1 INT = NULL,
	@IDParam2 INT = NULL,
	@IDParam3 INT = NULL
AS
BEGIN

DECLARE @Cor1 VARCHAR(8) = '#00b050', @Cor2 VARCHAR(8) = '#f4b183', @Cor3 VARCHAR(8) = '#00ff00', @Cor4 VARCHAR(8) = '#0000ff', @black VARCHAR(8) = '#000000';

DECLARE @GraficoLinha AS Table (
		Descricao VARCHAR(50),
		CorFonte VARCHAR(50),
		CorFundo VARCHAR(50),
        CorLegenda VARCHAR(50),
		jan INT,
		fev INT,
		mar INT,
        abr int,
        mai int,
        jun int
	)
   
DECLARE @GraficoLinha2 AS Table (
		Descricao VARCHAR(50),
		CorFonte VARCHAR(50),
		CorFundo VARCHAR(50),
        CorLegenda VARCHAR(50),
        jan INT,
		fev INT,
		mar INT
	)

WAITFOR DELAY '00:00:00:30';

	INSERT INTO @GraficoLinha VALUES ('SP', @black,@Cor1,@Cor1,150,350,266,458,587,222);
	INSERT INTO @GraficoLinha VALUES ('RJ', @black,@Cor2,@Cor2, 100,500,700,654,325,545);
    INSERT INTO @GraficoLinha VALUES ('MG', @black,@Cor3,@Cor3, 300,238,982,854,848,774);
    INSERT INTO @GraficoLinha VALUES ('GO', @black,@Cor4,@Cor4, 1030,566,555,222,874,999);
    INSERT INTO @GraficoLinha VALUES ('PE', @black,@Cor1,@Cor1, 684,596,700, 684,596,700);

	INSERT INTO @GraficoLinha2 VALUES ('SP', @Cor2,@Cor2,@Cor2, 0,0,1271);
	INSERT INTO @GraficoLinha2 VALUES ('RJ', @Cor1,@Cor1,@Cor1,0,0,1013);

	IF	@IDParam1 = 1
		BEGIN
			SELECT * FROM @GraficoLinha
		END
	ELSE IF	@IDParam1 = 2
		BEGIN
			SELECT *  FROM @GraficoLinha
		END

	ELSE IF	@IDParam1 = 3
		BEGIN
			SELECT Descricao AS Texto, CorFonte AS CorPonto, CorFundo AS CorLinha, jan AS 'jan/20', fev AS 'fev/20', mar AS 'mar/20' FROM @GraficoLinha2
		END
	ELSE 
		BEGIN
			SELECT * FROM @GraficoLinha
		END

END
GO
