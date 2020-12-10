use master
go

CREATE TABLE dbo.[Dash_Dashboards] (
  [IDDashboard] int PRIMARY KEY IDENTITY,
  [Descricao] VARCHAR(255)
)
GO

CREATE TABLE dbo.[Dash_ConteudoPrimario] (
  [IDConteudoPrimario] int PRIMARY KEY IDENTITY,
  [Descricao] VARCHAR(255)
)
GO

CREATE TABLE dbo.[Dash_ConteudoSecundario] (
  [IDConteudoSecundario] int PRIMARY KEY IDENTITY,
  [Descricao] VARCHAR (255)
)
GO

CREATE TABLE dbo.[Dash_ProcedureCalls] (
  [IDCall] int PRIMARY KEY IDENTITY,
  [SP_Call] VARCHAR(255),
  [Descricao] VARCHAR(255),
  [ConcatenaFiltros] BIT
)
GO

CREATE TABLE dbo.[Dash_Html] (
  [IDHtml] int PRIMARY KEY IDENTITY,
  [Html] NVARCHAR(MAX),
  [Descricao] VARCHAR(255)
)
GO

CREATE TABLE dbo.[Dash_Elemento] (
  [IDElemento] int PRIMARY KEY IDENTITY,
  [IDDashboard] int,
  [Linha] int,
  --[IDComponente] AS '' + '' + ROW_NUMBER,
  [IDConteudoPrimario] int,
  [IDConteudoSecundario] int,
  [Titulo] VARCHAR(255),
  [IDCall] int,
  [IDHtml] int,
  [Ordem] INT NULL
)
GO

/*

ALTER TABLE dbo.[Dash_Elemento] ADD FOREIGN KEY ([IDDashboard]) REFERENCES dbo.[Dash_Dashboards] ([IDDashboard])
GO

ALTER TABLE dbo.[Dash_Elemento] ADD FOREIGN KEY ([IDConteudoPrimario]) REFERENCES dbo.[Dash_ConteudoPrimario] ([IDConteudoPrimario])
GO

ALTER TABLE dbo.[Dash_Elemento] ADD FOREIGN KEY ([IDConteudoSecundario]) REFERENCES dbo.[Dash_ConteudoSecundario] ([IDConteudoSecundario])
GO

ALTER TABLE dbo.[Dash_Elemento] ADD FOREIGN KEY ([IDCall]) REFERENCES dbo.[Dash_ProcedureCalls] ([IDCall])
GO

ALTER TABLE dbo.[Dash_Elemento] ADD FOREIGN KEY ([IDHtml]) REFERENCES dbo.[Dash_Html] ([IDHtml])
GO
*/