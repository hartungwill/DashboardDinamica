-- =============================================
-- Author:		William Hartung
-- Create date: 17/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Table_Modelo 123,1,3
-- proc_Dash_Table_Modelo 123,2,2
-- proc_Dash_Table_Modelo 123,3
-- proc_Dash_Table_Modelo 123,null
-- =============================================
alter PROCEDURE dbo.proc_Dash_Table_Modelo
	@IDUsuario INT,
	@IDParam1 INT = NULL,
	@IDParam2 INT = NULL,
	@IDParam3 INT = NULL
AS
BEGIN

	DECLARE @Tabela AS Table (
		Nome VARCHAR(150),
		Valor INT,
		Perfil VARCHAR(150),
		Pontos INT,
		[Data de Atualização] VARCHAR(10)
	)
	
	WAITFOR DELAY '00:00:01:00';

	INSERT INTO @Tabela VALUES ('Lunna Alcoforado Miguéis', 260,'User',0, Convert(varchar(10),getdate(),103));
	INSERT INTO @Tabela VALUES ('Mouhamed Vilaverde Peseiro', 32,'Gerente',17, Convert(varchar(10),getdate(),103));
	INSERT INTO @Tabela VALUES ('Dominika Lalanda Olaio', 64,'User',61, Convert(varchar(10),getdate(),103));
	INSERT INTO @Tabela VALUES ('Stéphanie Cachoeira Diegues', 43,'Coordenador',41, Convert(varchar(10),getdate(),103));
	INSERT INTO @Tabela VALUES ('Micaela Malheiro Nogueira', 58,'Coordenador',55, Convert(varchar(10),getdate(),103));
	INSERT INTO @Tabela VALUES ('Haniel Estrela Carrasco', 50,'Gerente',10, Convert(varchar(10),getdate(),103));
	INSERT INTO @Tabela VALUES ('Melissa Vilarinho Barroso', 58,'Coordenador',55, Convert(varchar(10),getdate(),103));
	INSERT INTO @Tabela VALUES ('Lisandra Varejão Bivar', 64,'User',61, Convert(varchar(10),getdate(),103));
	INSERT INTO @Tabela VALUES ('Lina Cruz Gomide', 50,'User',10, Convert(varchar(10),getdate(),103));
	INSERT INTO @Tabela VALUES ('Kira Franca Mourato', 260,'User',0, Convert(varchar(10),getdate(),103));

	SELECT * FROM @Tabela
		

END
GO
