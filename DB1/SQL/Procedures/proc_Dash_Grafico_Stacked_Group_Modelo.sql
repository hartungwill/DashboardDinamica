
-- =============================================
-- Author:		William Hartung
-- Create date: 17/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- Observação: O tipo (line) deve vir em primeiro para a linha aparecer na frente das barras
-- proc_Dash_Grafico_Stacked_Group_Modelo 123,1,3
-- proc_Dash_Grafico_Stacked_Group_Modelo 123,2,2
-- proc_Dash_Grafico_Stacked_Group_Modelo 123,3
-- proc_Dash_Grafico_Stacked_Group_Modelo 123,null
-- =============================================
alter PROCEDURE dbo.proc_Dash_Grafico_Stacked_Group_Modelo
	@IDUsuario INT,
	@IDParam1 INT = NULL,
	@IDParam2 INT = NULL,
	@IDParam3 INT = NULL
AS
BEGIN

DECLARE @Cor1 VARCHAR(8) = '#fbe5d6', @Cor2 VARCHAR(8) = '#fff2cc', @Cor3 VARCHAR(8) = '#b0b0b0';
DECLARE @Black VARCHAR(8) = '#000000', @Grey VARCHAR(8) = '#808080', @Gold VARCHAR(8) = '#ffd700', @Blue VARCHAR(8) = '#6e6eff', @Total VARCHAR(8) = '#d0d0d0';

DECLARE @GraficoCombo AS Table (
		Descricao VARCHAR(50),
		CorFonte VARCHAR(50),
		CorFundo VARCHAR(50),
		Tipo VARCHAR(50),
		--Grupo VARCHAR(50),
		Jan INT,
		Fev INT,
		Mar INT,
		Abr INT,
		Mai INT,
		Jun INT,
		Jul INT,
		Ago INT,
		[Set] INT,
		[Out] INT,
		Nov INT,
		Dez INT
	)
 
	INSERT INTO @GraficoCombo VALUES ('Black', @Black,@Black, 'line', 1500, 1500, 1500, 1500, 1500, 1500,1500,1500,1500,1500,1500,1500);
	INSERT INTO @GraficoCombo VALUES ('Platinum', @Grey,@Grey, 'line', 1200, 1200, 1200, 1200, 1200, 1200,1200,1200,1200,1200,1200,1200);
	INSERT INTO @GraficoCombo VALUES ('Gold', @Gold,@Gold, 'line', 800, 800, 800, 800, 800, 800,800,800,800,800,800,800);
	INSERT INTO @GraficoCombo VALUES ('Blue', @Blue,@Blue, 'line',0,0,0,0,0,0,0,0,0,0,0,0);
	INSERT INTO @GraficoCombo VALUES ('Total', @Total,@Total, 'line', 350,300,650,750,1050,1750,0,0,0,0,0,0);
	
	INSERT INTO @GraficoCombo VALUES ('Exp', @Cor1,@Cor1, 'bar', 0,100,300,500,800,800,0,0,0,0,0,0);
	INSERT INTO @GraficoCombo VALUES ('Tickets', @Cor2,@Cor2, 'bar', 200,200,200,200,200,800,0,0,0,0,0,0);
	INSERT INTO @GraficoCombo VALUES ('Orbs', @Cor3,@Cor3, 'bar', 150,0,150,50,50,150,0,0,0,0,0,0);
	
	SELECT * FROM @GraficoCombo
	

END
GO
