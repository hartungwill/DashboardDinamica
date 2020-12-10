
-- =============================================
-- Author:		William Hartung
-- Create date: 17/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- Observação: O tipo (line) deve vir em primeiro para a linha aparecer na frente das barras
-- proc_Dash_Grafico_Combo_Modelo 123,1,3
-- proc_Dash_Grafico_Combo_Modelo 123,2,2
-- proc_Dash_Grafico_Combo_Modelo 123,3
-- proc_Dash_Grafico_Combo_Modelo 123,null
-- =============================================
alter PROCEDURE dbo.proc_Dash_Grafico_Combo_Modelo
	@IDUsuario INT,
	@IDParam1 INT = NULL,
	@IDParam2 INT = NULL,
	@IDParam3 INT = NULL
AS
BEGIN

DECLARE @Cor1 VARCHAR(8) = '#00b050', @Cor2 VARCHAR(8) = '#f4b183', @Cor3 VARCHAR(8) = '#00ff00', @Cor4 VARCHAR(8) = '#0000ff', @Fonte VARCHAR(8) = '#000000';

DECLARE @GraficoCombo AS Table (
		Descricao VARCHAR(50),
		CorFonte VARCHAR(50),
		CorFundo VARCHAR(50),
		CorLegenda VARCHAR(50),
		Tipo VARCHAR(50),
		jan20 INT,
		fev20 INT,
		mar20 INT
	)

DECLARE @GraficoCombo2 AS Table (
		Descricao VARCHAR(50),
		CorFonte VARCHAR(50),
		CorFundo VARCHAR(50),
		CorLegenda VARCHAR(50),
		Tipo VARCHAR(50),
		jan20 INT,
		fev20 INT,
		mar20 INT
	)

WAITFOR DELAY '00:00:01:30';

	INSERT INTO @GraficoCombo VALUES ('SP', @Fonte,@Cor4,@Cor4, 'line', 175,480,600);
	INSERT INTO @GraficoCombo VALUES ('RJ', @Fonte,@Cor1,@Cor1, 'bar', 150,350,266);
	INSERT INTO @GraficoCombo VALUES ('MG', @Fonte,@Cor2,@Cor2, 'bar', 100,500,700);

	INSERT INTO @GraficoCombo2 VALUES ('RO', @Fonte,@Cor1,@Cor1,'line',0,10,1300);
	INSERT INTO @GraficoCombo2 VALUES ('PE', @Fonte,@Cor2,@Cor2, 'bar', 100,200,1700);
	INSERT INTO @GraficoCombo2 VALUES ('AP', @Fonte,@Cor4,@Cor4,'bar',300,0,1500);

	IF	@IDParam1 = 1
		BEGIN
			SELECT * FROM @GraficoCombo
		END
	ELSE IF	@IDParam1 = 2
		BEGIN
			SELECT Descricao AS Texto, CorFonte AS CorPonto, CorFundo AS CorLinha, Tipo AS Type,  jan20 AS [Janeiro 20], fev20 AS [Fevereiro 20], mar20 AS [Março 20]  FROM @GraficoCombo
		END

	ELSE IF	@IDParam1 = 3
		BEGIN
			SELECT * FROM @GraficoCombo2
		END
	ELSE 
		BEGIN
			SELECT * FROM @GraficoCombo2
		END

END
GO
