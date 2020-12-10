
-- =============================================
-- Author:		William Hartung
-- Create date: 04/02/2020
-- Description:	Procedure para filtros dinâmicos - star
-- proc_Dash_Filtros_Star_QTR 123,1
-- proc_Dash_Filtros_Star_QTR 123,2
-- =============================================
alter PROCEDURE dbo.proc_Dash_Filtros_Star_QTR
	@IDUsuario INT,
	@IDParam1 INT
AS
BEGIN

DECLARE @Filtros AS Table (
	ID INT,
	Descricao VARCHAR(50)
)

--INSERT INTO @Filtros VALUES (0,'Selecione');
INSERT INTO @Filtros VALUES (1,'Q1');
INSERT INTO @Filtros VALUES (2,'Q2');
INSERT INTO @Filtros VALUES (3,'Q3');
INSERT INTO @Filtros VALUES (3,'Q4');
    

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
