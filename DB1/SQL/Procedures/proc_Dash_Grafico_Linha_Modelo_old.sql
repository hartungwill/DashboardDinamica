
-- =============================================
-- Author:		William Hartung
-- Create date: 03/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Grafico_Linha_Modelo 123,1,3
-- proc_Dash_Grafico_Linha_Modelo 123,2,2
-- proc_Dash_Grafico_Linha_Modelo 123,3
-- proc_Dash_Grafico_Linha_Modelo 123,null
-- =============================================
alter PROCEDURE dbo.proc_Dash_Grafico_Linha_Modelo
	@IDUsuario INT,
	@IDParam1 INT = NULL,
	@IDParam2 INT = NULL,
	@IDParam3 INT = NULL
AS
BEGIN

DECLARE @CorLinha VARCHAR(8) = '#ff0000', @CorPonto VARCHAR(8) = '#00b050', @CorFundo2 VARCHAR(8) = '#f4b183';

DECLARE @Graficolinha AS Table (
	Descricao VARCHAR(50),
	Real INT,
	RealCorLinha VARCHAR(8),
	RealCorPonto VARCHAR(8),
	Meta INT,
	MetaCorLinha VARCHAR(8),
	MetaCorPonto VARCHAR(8)
)

DECLARE @Graficolinha2 AS Table (
	Descricao VARCHAR(50),
	Real INT,
	RealCorFonte VARCHAR(8),
	RealCorFundo VARCHAR(8),
	Meta INT,
	MetaCorFonte VARCHAR(8),
	MetaCorFundo VARCHAR(8)
)

INSERT INTO @Graficolinha VALUES ('mar/20',700,@CorFundo2,@CorFundo2,375,@CorFundo2,@CorPonto)  
INSERT INTO @Graficolinha VALUES ('fev/20',1200,@CorFundo2,@CorFundo2,860,@CorFundo2,@CorPonto)  
INSERT INTO @Graficolinha VALUES ('jan/20',500,@CorFundo2,@CorFundo2,1078,@CorFundo2,@CorPonto)  

INSERT INTO @Graficolinha2 VALUES ('mar/20',100,@CorLinha,@CorPonto,125,@CorLinha,@CorFundo2)  
INSERT INTO @Graficolinha2 VALUES ('fev/20',300,@CorLinha,@CorPonto,525,@CorLinha,@CorFundo2)  
INSERT INTO @Graficolinha2 VALUES ('jan/20',700,@CorLinha,@CorPonto,422,@CorLinha,@CorFundo2)

WAITFOR DELAY '00:00:00:45';

	IF	@IDParam1 = 2
		BEGIN
			SELECT	Descricao AS Texto, 
					Real AS TT_Meta, 
					RealCorLinha AS CorFonte1, 
					RealCorPonto AS CorFundo1,   
					Meta AS TT_Real, 
					MetaCorLinha AS CorFonte1, 
					MetaCorPonto AS CorFundo1
			FROM @Graficolinha
		END
	ELSE IF	@IDParam1 = 3
		BEGIN

		SELECT	*
		FROM @Graficolinha2

		END
	ELSE
		BEGIN
			SELECT * FROM @Graficolinha
		END

END
GO
