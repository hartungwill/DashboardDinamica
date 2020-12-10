
-- =============================================
-- Author:		William Hartung
-- Create date: 04/02/2020
-- Description:	Procedure para filtros dinâmicos - star
-- proc_Dash_Filtros_Star_Franquia 123,1
-- proc_Dash_Filtros_Star_Franquia 123,2
-- =============================================
alter PROCEDURE dbo.proc_Dash_Filtros_Star_Franquia
	@IDUsuario INT,
	@IDParam1 INT
AS
BEGIN

DECLARE @Filtros AS Table (
	ID INT,
	Descricao VARCHAR(50)
)

--INSERT INTO @Filtros VALUES (0,'Selecione');
INSERT INTO @Filtros VALUES (1,'UBERLANDIA');
INSERT INTO @Filtros VALUES (2,'SOLAR BR');
INSERT INTO @Filtros VALUES (3,'BRASAL');
INSERT INTO @Filtros VALUES (4,'KOF BR');
INSERT INTO @Filtros VALUES (5,'SIMÕES');
INSERT INTO @Filtros VALUES (6,'ANDINA BR');
INSERT INTO @Filtros VALUES (7,'BANDEIRANTES');
INSERT INTO @Filtros VALUES (8,'SOROCABA');
INSERT INTO @Filtros VALUES (9,'CVI');

	IF	@IDParam1 = 1
		BEGIN
			SELECT ID, Descricao FROM @Filtros
		END
	ELSE IF	@IDParam1 = 2
		BEGIN
			SELECT ID AS Chave, Descricao AS Valor FROM @Filtros
		END
END
GO
