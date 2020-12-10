-- =============================================
-- Author:		William Hartung
-- Create date: 19/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Relatorio_Cloud_Modelo 123,104,66
-- =============================================
create PROCEDURE dbo.proc_Dash_Relatorio_Cloud_Modelo
	@IDUsuario INT,
	@IDParam1 INT = NULL,
	@IDParam2 INT = NULL,
	@IDParam3 INT = NULL
AS
BEGIN

	DECLARE @Relatorios AS Table (
		Descricao VARCHAR(200),
		CorFonte VARCHAR(8),
		CorFundo VARCHAR(8),
		CaminhoArquivo VARCHAR(500)
	)
   
    -- simulação de tempo de processamento
    WAITFOR DELAY '00:00:00:30';
	
	INSERT INTO @Relatorios 
	VALUES (
	'Relatório 1'
	,'#ffffff'
	,'#007441'	
	,'https://go.microsoft.com/fwlink/?LinkID=521962'
	)
	
	INSERT INTO @Relatorios 
	VALUES (
	'Relatório 2'
	,'#ffffff'
	,'#000000'	
	,'https://go.microsoft.com/fwlink/?LinkID=521962'
	)
	
	INSERT INTO @Relatorios 
	VALUES (
	'Relatório 3'
	,'#0000ff'
	,'#ffffff'	
	,'https://go.microsoft.com/fwlink/?LinkID=521962'
	)

	SELECT * FROM @Relatorios

END
GO
