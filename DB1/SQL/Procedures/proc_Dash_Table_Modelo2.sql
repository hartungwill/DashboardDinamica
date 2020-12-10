-- =============================================
-- Author:		William Hartung
-- Create date: 17/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Table_Modelo2 1232,1,3
-- proc_Dash_Table_Modelo2 1232,2,2
-- proc_Dash_Table_Modelo2 1232,3
-- proc_Dash_Table_Modelo2 1232,null
-- =============================================
alter PROCEDURE dbo.proc_Dash_Table_Modelo2
	@IDUsuario INT,
	@IDParam1 VARCHAR(150) = NULL,
	@IDParam2 VARCHAR(150) = NULL,
	@IDParam3 VARCHAR(150) = NULL
AS
BEGIN

	DECLARE @Tabela AS Table (
		Nome VARCHAR(150),
		Valor INT,
		Metas VARCHAR(150),
		Pontos INT,
		[Data de Atualização] VARCHAR(10)
	)
	
	INSERT INTO @Tabela VALUES ('William Hartung', 260,'Ponto Extra - Baden Baden',0, Convert(varchar(10),getdate(),103));
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
	INSERT INTO @Tabela VALUES ('Eric Ricardo', 50,'Ponto Extra - Amstel',10, Convert(varchar(10),getdate(),103));
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
	INSERT INTO @Tabela VALUES ('Richardson', 43,'Ponto Extra - Baden Baden',41, Convert(varchar(10),getdate(),103));

	WAITFOR DELAY '00:00:00:50';
	SELECT * FROM @Tabela
		
END
GO
