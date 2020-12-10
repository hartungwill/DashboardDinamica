
-- =============================================
-- Author:		William Hartung
-- Create date: 03/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Filtros_Modelo_Nivel2 123,1
-- proc_Dash_Filtros_Modelo_Nivel2 123,2
-- proc_Dash_Filtros_Modelo_Nivel2 123,3
-- proc_Dash_Filtros_Modelo_Nivel2 123,0
-- proc_Dash_Filtros_Modelo_Nivel2 123,104
-- =============================================
alter PROCEDURE dbo.proc_Dash_Filtros_Modelo_Nivel2
	@IDUsuario INT,
	@IDCombo1 INT
AS
BEGIN

DECLARE @Filtros AS Table (
	ID INT ,
	Descricao VARCHAR(50),
	IDCombo1 int
)

--DECLARE @FiltrosArgentina AS Table (
--	ID INT,
--	Descricao VARCHAR(50)
--)

--INSERT INTO @Filtros VALUES (0,'Selecione');
INSERT INTO @Filtros VALUES (1,'Nordeste',1);
INSERT INTO @Filtros VALUES (2,'Sudeste',1);
INSERT INTO @Filtros VALUES (3,'Sul',1);

INSERT INTO @Filtros VALUES (1,'Córdova',2);
INSERT INTO @Filtros VALUES (2,'Buenos Aires',2);
INSERT INTO @Filtros VALUES (3,'Mendoza',2);

INSERT INTO @Filtros VALUES (1,'Montevidéu',3);

INSERT INTO @Filtros VALUES (66,'Relatório',104);


SELECT	0 AS ID, 
	    'Selecione' AS Descricao 

UNION ALL

SELECT	ID, 
		Descricao 
FROM @Filtros
WHERE IDCombo1 = @IDCombo1



	--IF	@IDCombo1 = 1
	--	BEGIN
	--		SELECT ID, Descricao FROM @FiltrosBrasil
	--	END
	--ELSE IF	@IDCombo1 = 2
	--	BEGIN
	--		SELECT ID AS Chave, Descricao AS Valor FROM @FiltrosArgentina
	--	END
	--ELSE IF	@IDCombo1 = 3
	--	BEGIN
	--		SELECT 0 AS Chave, 'Nenhum Resultado' AS Valor 
	--	END


END
GO
