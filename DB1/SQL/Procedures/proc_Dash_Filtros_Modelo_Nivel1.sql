
-- =============================================
-- Author:		William Hartung
-- Create date: 13/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Filtros_Modelo_Nivel1 123
-- proc_Dash_Filtros_Modelo_Nivel1 123
-- =============================================
alter PROCEDURE dbo.proc_Dash_Filtros_Modelo_Nivel1
	@IDUsuario INT
AS
BEGIN

DECLARE @Filtros AS Table (
	ID INT,
	Descricao VARCHAR(50)
)

--INSERT INTO @Filtros VALUES (0,'Selecione');
INSERT INTO @Filtros VALUES (1,'Brasil');
INSERT INTO @Filtros VALUES (2,'Argentina');
INSERT INTO @Filtros VALUES (3,'Uruguai');

	SELECT * FROM @Filtros

END
GO
