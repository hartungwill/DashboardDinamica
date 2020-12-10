
-- =============================================
-- Author:		William Hartung
-- Create date: 03/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Filtros_Modelo 123,1
-- proc_Dash_Filtros_Modelo 123,2
-- =============================================
alter PROCEDURE dbo.proc_Dash_Filtros_Modelo
	@IDUsuario INT,
	@IDParam1 INT
AS
BEGIN

DECLARE @Filtros AS Table (
	ID INT,
	Descricao VARCHAR(50)
)

--INSERT INTO @Filtros VALUES (0,'Selecione');
INSERT INTO @Filtros VALUES (1,'Valor 1');
INSERT INTO @Filtros VALUES (2,'Valor 2');
INSERT INTO @Filtros VALUES (3,'Valor 3');
    

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
