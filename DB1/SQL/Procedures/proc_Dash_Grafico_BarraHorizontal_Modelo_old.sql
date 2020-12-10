
-- =============================================
-- Author:		William Hartung
-- Create date: 03/02/2020
-- Description:	Procedure de modelo para filtros dinâmicos
-- proc_Dash_Grafico_BarraHorizontal_Modelo 123,1,3
-- proc_Dash_Grafico_BarraHorizontal_Modelo 123,2,2
-- proc_Dash_Grafico_BarraHorizontal_Modelo 123,3
-- proc_Dash_Grafico_BarraHorizontal_Modelo 123,null
-- =============================================
alter PROCEDURE dbo.proc_Dash_Grafico_BarraHorizontal_Modelo
	@IDUsuario INT,
	@IDParam1 INT = NULL,
	@IDParam2 INT = NULL,
	@IDParam3 INT = NULL
AS
BEGIN

DECLARE @CorFonte VARCHAR(8) = '#00ff00', @CorFundo VARCHAR(8) = '#00b050', @CorFundo2 VARCHAR(8) = '#f4b183';

DECLARE @Graficobarra AS Table (
	Descricao VARCHAR(50),
	Real INT,
	RealCorFonte VARCHAR(8),
	RealCorFundo VARCHAR(8),
	Meta INT,
	MetaCorFonte VARCHAR(8),
	MetaCorFundo VARCHAR(8)
)

DECLARE @Graficobarra2 AS Table (
	Descricao VARCHAR(50),
	Real INT,
	RealCorFonte VARCHAR(8),
	RealCorFundo VARCHAR(8),
	Meta INT,
	MetaCorFonte VARCHAR(8),
	MetaCorFundo VARCHAR(8)
)

INSERT INTO @Graficobarra VALUES ('mar/20',0,@CorFonte,@CorFundo2,0,@CorFonte,@CorFundo)  
INSERT INTO @Graficobarra VALUES ('fev/20',0,@CorFonte,@CorFundo2,0,@CorFonte,@CorFundo)  
INSERT INTO @Graficobarra VALUES ('jan/20',1267,@CorFonte,@CorFundo2,1078,@CorFonte,@CorFundo)  

INSERT INTO @Graficobarra2 VALUES ('mar/20',0,@CorFonte,@CorFundo,0,@CorFonte,@CorFundo2)  
INSERT INTO @Graficobarra2 VALUES ('fev/20',0,@CorFonte,@CorFundo,0,@CorFonte,@CorFundo2)  
INSERT INTO @Graficobarra2 VALUES ('jan/20',1013,@CorFonte,@CorFundo,1271,@CorFonte,@CorFundo2)

WAITFOR DELAY '00:00:01:30';

	IF	@IDParam1 = 2
		BEGIN
			SELECT	Descricao AS Texto, 
					Real AS TT_Meta, 
					RealCorFonte AS CorFonte1, 
					RealCorFundo AS CorFundo1,   
					Meta AS TT_Real, 
					MetaCorFonte AS CorFonte1, 
					MetaCorFundo AS CorFundo1
			FROM @Graficobarra
		END
	ELSE IF	@IDParam1 = 3
		BEGIN

		SELECT	*
		FROM @Graficobarra2

		END
	ELSE
		BEGIN
			SELECT * FROM @Graficobarra
		END

END
GO
