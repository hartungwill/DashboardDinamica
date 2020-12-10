
-- =============================================        
-- Author: William Hartung      
-- Create date: 26/06/2020        
-- Description: Modelo de Procedure para gráfico de waterfall
-- proc_Dash_Grafico_Waterfall_Modelo2 123,1,3  
-- =============================================        
create PROCEDURE [dbo].[proc_Dash_Grafico_Waterfall_Modelo2]        
 @IDUsuario INT,
	@IDParam1 INT = NULL,
	@IDParam2 INT = NULL,
	@IDParam3 INT = NULL
        
AS        
BEGIN        
    
DECLARE @Cor1 VARCHAR(8) = '#fbe5d6', @Cor2 VARCHAR(8) = '#fff2cc', @Cor3 VARCHAR(8) = '#b0b0b0';    
DECLARE @Black VARCHAR(8) = '#000000', @Green VARCHAR(8) = '#A9D18E',  @Orange VARCHAR(8) = '#F4B183',  @Blue VARCHAR(8) = '#203864', @White VARCHAR(08) = '#FFFFFF', @AzulClaro VARCHAR(08) = '#8FAADC', @Yellow VARCHAR(08)= '#ffff7a'
   
 --v2  
 DECLARE @GraficoWaterfall AS Table (    
  Descricao VARCHAR(50),    
  CorFonte VARCHAR(50),    
  CorFundo VARCHAR(50),    
  CorLegenda VARCHAR(50),    
  Tipo VARCHAR(50),         
  Valor1 VARCHAR(50),  
  Valor2 VARCHAR(50),
  Valor3 VARCHAR(50),
  Valor5 VARCHAR(50),
  Valor6 VARCHAR(50)
 )   
   
DECLARE @GraficoLinha AS Table (    
  Descricao VARCHAR(50),    
  CorFonte VARCHAR(50),    
  CorFundo VARCHAR(50),    
  CorLegenda VARCHAR(50),    
  Tipo VARCHAR(50),         
  Valor1 VARCHAR(50),  
  Valor2 VARCHAR(50),
  Valor3 VARCHAR(50),
  Valor5 VARCHAR(50),
  Valor6 VARCHAR(50)
 )   
  
 --Tipo 1 
 INSERT INTO @GraficoWaterfall VALUES ('Maio', @Black, @AzulClaro, @AzulClaro, 'bar', '1000',0,0,0,0);      
 INSERT INTO @GraficoWaterfall VALUES ('Regular', @Black, @Green, @Green, 'bar', 0,'1000|1200',0,0,0);    
 INSERT INTO @GraficoWaterfall VALUES ('Promo', @Black, @Orange, @Orange, 'bar', 0,0,'1200|1400',0,0);    
 INSERT INTO @GraficoWaterfall VALUES ('Inovacao', @White, @Cor3, @Cor3, 'bar', 0,0,0,'1400|1600',0);   
 INSERT INTO @GraficoWaterfall VALUES ('Junho', @White, @Yellow, @Yellow, 'bar', 0,0,0,0,'1600');   

-- Tipo 2
 --INSERT INTO @GraficoWaterfall VALUES ('Junho', @Black, @Orange, @Orange, 'bar', '1000','1000|1200','1200|1400','1400|1600','1600');   

--  INSERT INTO @GraficoLinha VALUES ('% Ating', @White, 'transparent', @Blue, 'line', '500;100%','500;100%','500;100%','500;100%','500;100%');   
 INSERT INTO @GraficoLinha VALUES ('% Ating', @White, 'transparent', @Blue, 'line', '1100;100%','1300;100%','1500;100%','1700;100%','1700;100%');   

 SELECT * FROM @GraficoWaterfall
 union all
 SELECT * FROM @GraficoLinha
      
END 
GO
