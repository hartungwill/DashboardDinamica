-- =============================================
-- Author:		William Hartung
-- Create date: 11/03/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Mapa_Modelo 123,1,3
-- proc_Dash_Mapa_Modelo 123,2,2
-- proc_Dash_Mapa_Modelo 123,3
-- proc_Dash_Mapa_Modelo 123,null
-- =============================================
alter PROCEDURE dbo.proc_Dash_Mapa_Modelo
	@IDUsuario INT,
	@IDParam1 VARCHAR(150) = NULL,
	@IDParam2 VARCHAR(150) = NULL,
	@IDParam3 VARCHAR(150) = NULL
AS
BEGIN

	DECLARE @Tabela AS Table (
		Descricao VARCHAR(150),
		CaminhoImagem VARCHAR(150),
		Latitude VARCHAR(20),
		Longitude VARCHAR(20)
	)
	
	WAITFOR DELAY '00:00:01:00';

	INSERT INTO @Tabela VALUES ('Paraná', '/Images/iconfinder__Articuro_Pokeball_1337442.png', '-23.5489', '-46.6388');
	INSERT INTO @Tabela VALUES ('São Paulo', '/Images/iconfinder__Battle_1337441.png', '-22.5489', '-45.6388');
	INSERT INTO @Tabela VALUES ('Minas Gerais', '/Images/iconfinder__Moltros_Pokeball_1337490.png', '-24.5489', '-47.6388');
	INSERT INTO @Tabela VALUES ('Minas Gerais', '/Images/iconfinder__Pokemon_Go_Locator_1337527.png', '-24.0489', '-47.0388');
	INSERT INTO @Tabela VALUES ('Paraná', '/Images/iconfinder__windy_1337503.png', '-20.5489', '-46.6388');
	INSERT INTO @Tabela VALUES ('São Paulo', '/Images/iconfinder__Zapdos_Pokeball_1337502.png', '-22.5489', '-47.6388');

	SELECT * FROM @Tabela		

END
GO
