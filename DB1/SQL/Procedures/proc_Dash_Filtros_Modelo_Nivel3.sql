
-- =============================================
-- Author:		William Hartung
-- Create date: 03/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Filtros_Modelo_Nivel3 123,1,1
-- proc_Dash_Filtros_Modelo_Nivel3 123,1,2
-- proc_Dash_Filtros_Modelo_Nivel3 123,1,3
-- proc_Dash_Filtros_Modelo_Nivel3 123,2,5
-- proc_Dash_Filtros_Modelo_Nivel3 123,3,1
-- =============================================
alter PROCEDURE dbo.proc_Dash_Filtros_Modelo_Nivel3
	@IDUsuario INT,
	@IDCombo1 INT,
	@IDCombo2 INT
AS
BEGIN

DECLARE @Filtros AS Table (
	ID INT IDENTITY,
	Descricao VARCHAR(50),
	IDCombo1 int,
	IDCombo2 int
)

INSERT INTO @Filtros VALUES ('Bahia',1,1);
INSERT INTO @Filtros VALUES ('Pernambuco',1,1);
INSERT INTO @Filtros VALUES ('Alagoas',1,1);
INSERT INTO @Filtros VALUES ('Sergipe',1,1);

INSERT INTO @Filtros VALUES ('São Paulo',1,2);
INSERT INTO @Filtros VALUES ('Rio de Janeiro',1,2);
INSERT INTO @Filtros VALUES ('Minas Gerais',1,2);

INSERT INTO @Filtros VALUES ('Rio Grande do Sul',1,3);
INSERT INTO @Filtros VALUES ('Santa Catarina',1,3);
INSERT INTO @Filtros VALUES ('Paraná',1,3);

INSERT INTO @Filtros VALUES ('Sem Resultado',2,5);
--INSERT INTO @Filtros VALUES ('Buenos Aires',2);
--INSERT INTO @Filtros VALUES ('Mendoza',2);

--INSERT INTO @Filtros VALUES (1,'Nenhum Resultado',3);
 
 

SELECT	0 AS ID, 
	    'Selecione' AS Descricao 

UNION ALL


SELECT	ID, 
		Descricao 
FROM @Filtros
WHERE IDCombo1 = @IDCombo1 AND
	  IDCombo2 = @IDCombo2


END
GO
