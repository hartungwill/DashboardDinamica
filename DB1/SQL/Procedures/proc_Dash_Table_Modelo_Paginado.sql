/* =============================================
Author:		William Hartung
Create date: 17/02/2020
Description:	Procedure de modelo para filtros dinâmicos
Página 1: proc_Dash_Table_Modelo_Paginado 1987,5,1,9,8,7 
Página 2: proc_Dash_Table_Modelo_Paginado 1987,5,2,9,8,7
Página 3: proc_Dash_Table_Modelo_Paginado 1987,5,3,9,8,7
Página 4: proc_Dash_Table_Modelo_Paginado 1987,5,4,9,8,7
-- =============================================*/
alter PROCEDURE dbo.proc_Dash_Table_Modelo_Paginado
	@IDUsuario INT,
	@QtdPorPagina   INT = NULL, 
    @Pagina         INT = NULL,  
	@IDParam1 VARCHAR(150) = NULL,
	@IDParam2 VARCHAR(150) = NULL,
	@IDParam3 VARCHAR(150) = NULL
AS
BEGIN

	if @QtdPorPagina is null  
		begin  
		   Set @QtdPorPagina = 3  
		end  

	if @Pagina is null  
		begin  
		   Set @Pagina = 1  
		end  

	DECLARE @Tabela AS Table (
		Nome VARCHAR(150),
		Valor INT,
		Perfil VARCHAR(150),
		Pontos INT,
		[Data de Atualização] VARCHAR(10)
	)

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

	SELECT * 
	FROM @Tabela
	ORDER BY [Data de Atualização]
	 OFFSET @QtdPorPagina * (@Pagina - 1) ROWS  
    FETCH NEXT @QtdPorPagina ROWS ONLY;  	

END
GO
