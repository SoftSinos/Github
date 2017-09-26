If Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysObjects.Name='CaixaFechamento')
  Begin                   
    DROP TABLE [dbo].[CaixaFechamento]
  End
Go

If Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysObjects.Name='Caixa')
  Begin                   
    DROP TABLE [dbo].[Caixa]
  End
Go

If Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysObjects.Name='TipoMovimento')
  Begin                   
    DROP TABLE [dbo].[TipoMovimento]
  End
Go

CREATE TABLE [dbo].[TipoMovimento](
	[IdTpMovimento] [int] IDENTITY(1,1) NOT NULL,
	[IdUsuario] [int] NOT NULL CONSTRAINT [DF_TipoMovimento_IdUsuario]  DEFAULT ((0)),
	[DtCadastro] [datetime] NOT NULL CONSTRAINT [DF_TipoMovimento_DtCadastro]  DEFAULT (getdate()),
	[SnSituacao] [bit] NOT NULL CONSTRAINT [DF_TipoMovimento_SnSituacao]  DEFAULT ((1)),
	[NmTpMovimento] [varchar](255) NOT NULL,
	[NmSigla] [varchar](255) NOT NULL,
 CONSTRAINT [PK_TipoMovimento] PRIMARY KEY CLUSTERED 
(
	[IdTpMovimento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [UN_TipoMovimento_NmTpPagamento_NmSigla] UNIQUE NONCLUSTERED 
(
	[NmTpMovimento] ASC,
	[NmSigla] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

CREATE TABLE [dbo].[Caixa](
	[IdCaixa] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpresa] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL CONSTRAINT [DF_Caixa_IdUsuario]  DEFAULT ((0)),
	[DtCadastro] [datetime] NOT NULL CONSTRAINT [DF_Caixa_DtCadastro]  DEFAULT (getdate()),
	[SnSituacao] [int] NOT NULL CONSTRAINT [DF_Caixa_SnSituacao]  DEFAULT ((1)),
	[DtAbertura] [datetime] NOT NULL,
	[DtFechamento] [datetime] NULL,
 CONSTRAINT [PK_Caixa] PRIMARY KEY CLUSTERED 
(
	[IdCaixa] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[Caixa]  WITH CHECK ADD  CONSTRAINT [FK_Caixa_Empresas] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresa] ([IdEmpresa])
GO

ALTER TABLE [dbo].[Caixa] CHECK CONSTRAINT [FK_Caixa_Empresas]
GO

ALTER TABLE [dbo].[Caixa]  WITH CHECK ADD  CONSTRAINT [FK_Caixa_IdUsuario] FOREIGN KEY([IdUsuario])
REFERENCES [dbo].[Usuario] ([IdUsuario])
GO

ALTER TABLE [dbo].[Caixa] CHECK CONSTRAINT [FK_Caixa_IdUsuario]
GO

CREATE TABLE [dbo].[CaixaFechamento](
	[IdCaixaFechamento] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpresa] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL CONSTRAINT [DF_CaixaFechamento_IdUsuario]  DEFAULT ((0)),
	[DtCadastro] [datetime] NOT NULL CONSTRAINT [DF_CaixaFechamento_DtCadastro]  DEFAULT (getdate()),
	[SnSituacao] [int] NOT NULL CONSTRAINT [DF_CaixaFechamento_SnSituacao]  DEFAULT ((1)),
	[IdCaixa] [int] NOT NULL,
	[IdTpPagamento] [int] NOT NULL,
	[VlDia] [decimal](10, 2) NULL,
	[VlGaveta] [decimal](10, 2) NULL,
	[VlResultado] [decimal](10, 2) NULL,
 CONSTRAINT [PK_CaixaFechamento] PRIMARY KEY CLUSTERED 
(
	[IdCaixaFechamento] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[CaixaFechamento]  WITH CHECK ADD  CONSTRAINT [FK_CaixaFechamento_Caixa] FOREIGN KEY([IdCaixa])
REFERENCES [dbo].[Caixa] ([IdCaixa])
GO

ALTER TABLE [dbo].[CaixaFechamento] CHECK CONSTRAINT [FK_CaixaFechamento_Caixa]
GO

ALTER TABLE [dbo].[CaixaFechamento]  WITH CHECK ADD  CONSTRAINT [FK_CaixaFechamento_Empresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresa] ([IdEmpresa])
GO

ALTER TABLE [dbo].[CaixaFechamento] CHECK CONSTRAINT [FK_CaixaFechamento_Empresa]
GO

ALTER TABLE [dbo].[CaixaFechamento]  WITH CHECK ADD  CONSTRAINT [FK_CaixaFechamento_TipoPagamento] FOREIGN KEY([IdTpPagamento])
REFERENCES [dbo].[TipoPagamento] ([IdTpPagamento])
GO

ALTER TABLE [dbo].[CaixaFechamento] CHECK CONSTRAINT [FK_CaixaFechamento_TipoPagamento]
GO


If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='IdCaixa'
                 And SysObjects.Name='NotaPagamento')
  Begin                   
    Alter Table NotaPagamento Add IdCaixa Integer
  End
Go

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='IdCaixa'
                 And SysObjects.Name='NotaParcela')
  Begin                   
    Alter Table NotaParcela Add IdCaixa Integer
  End
Go

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='IdCaixa'
                 And SysObjects.Name='NotaParcelaLiquidacao')
  Begin                   
    Alter Table NotaParcelaLiquidacao Add IdCaixa Integer
  End
Go

Insert Into TipoMovimento([IdUsuario], [NmTpMovimento], [NmSigla]) Values (0, 'VENDA', 'E') 
Go
Insert Into TipoMovimento([IdUsuario], [NmTpMovimento], [NmSigla]) Values (0, 'COMPRA', 'S') 
Go
Insert Into TipoMovimento([IdUsuario], [NmTpMovimento], [NmSigla]) Values (0, 'SANGRIA', 'S') 
Go
Insert Into TipoMovimento([IdUsuario], [NmTpMovimento], [NmSigla]) Values (0, 'SUPRIMENTO', 'E') 
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Configuracao                                                                                  :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: VersÃ£o: 01.00.03.02 - AGOSTO/2017                                                                         : 
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER Proc [dbo].[PC_Configuracao](@IdEmpresaEntrada Integer)
As
Set NoCount On
  /*Informações Uteis
	Sempre sera iniciao para a IdEmpresa = 0

	Insert Into SoftHouse (NmLogoTipo) Values ((Select * From OPENROWSET(BULK N'D:\SoftSinos\Desenvolvimento\Imagem\Logo\Logo.jpg', SINGLE_BLOB) AS Imagem ))

	Exec PC_Configuracao 1
  */
Begin
	If (Select Count(*) From TipoMovimento) = 0
	  Begin
        Insert Into TipoMovimento([IdUsuario], [NmTpMovimento], [NmSigla]) Values (0, 'VENDA', 'E') 
        Insert Into TipoMovimento([IdUsuario], [NmTpMovimento], [NmSigla]) Values (0, 'COMPRA', 'S') 
        Insert Into TipoMovimento([IdUsuario], [NmTpMovimento], [NmSigla]) Values (0, 'SANGRIA', 'S') 
        Insert Into TipoMovimento([IdUsuario], [NmTpMovimento], [NmSigla]) Values (0, 'SUPRIMENTO', 'E') 
      End	

	If (Select Count(*) From TipoPagamento) = 0
	  Begin
        Insert Into TipoPagamento([IdUsuario], [NmTpPagamento]) Values (0, 'DINHEIRO') 
        Insert Into TipoPagamento([IdUsuario], [NmTpPagamento]) Values (0, 'CREDITO') 
        Insert Into TipoPagamento([IdUsuario], [NmTpPagamento]) Values (0, 'DEBITO') 
        Insert Into TipoPagamento([IdUsuario], [NmTpPagamento]) Values (0, 'CHEQUE') 
      End	
	
	If (Select Count(*) From SoftHouse) = 0
	  Begin
		Insert Into SoftHouse (NmLogoTipo) Values ((Select * From OPENROWSET(BULK N'C:\SginERP\Imagem\Sistema\Logo.jpg', SINGLE_BLOB) AS Imagem ))
	  End

    If (Select Count(*) From Versao) = 0
	  Begin
        INSERT Into Versao (NrVersaoBd, NrVersaoApp) Values ('3.0.0.0', '3.0.0.0')
      End

    If (Select Count(*) From Configuracao Where IdEmpresa = @IdEmpresaEntrada) = 0
	  Begin
	    INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'AMEJ', N'FECHAR O TIME DE 24HORAS "MINUTOS"', N'1', 0)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'TDCS', N'TEMPO DE DURACAO CONTRA SENHA "SAFERY OPEN"', N'293054292642929', 1)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'BPIN', N'BASE DE DADOS PADRÃƒO PARA INICIALIZAÇÃO', N'1', 0)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'LAPP', N'LOG DA APLICAÇÃO "CLIQUES DO EXECUTAVEL"', N'S', 1)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'HABR', N'AGENDA - HORÁRIO DE ABERTURA DA EMPRESA', N'09:00', 0)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'NTTA', N'AGENDA - NÚMERO TOTAL DE ATENDIMENTOS', N'25', 0)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'TIEA', N'AGENDA - TEMPO DE INTERVALO ENTRE ATENDIMENTOS', N'00:30', 0)

      End

	If (Select Count(*) From Licenca) = 0
	  Begin
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenPessoas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadPessoa', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenComPessoas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadTipoPessoa', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadCidade', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadCep', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadCalendario', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenServicos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadServico', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenComServicos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadTipoServico', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenProdutos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadProduto', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenComProdutos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadMarca', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadGrupoProduto', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenOperacoes', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadOperacoesStarter', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenPesNotas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenComOperacoes', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadTipoPagamento', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenAgendas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadAgendaStarter', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenRelatorios', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenRelPessoas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenRelServicos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenRelProdutos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenRelOperacoes', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenRelAgendas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenAvancados', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadEmpresa', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadUsuario', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSupAtenderRemoto', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSupBaixaSuporte', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSupLiberarAcesso', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadConfiguracaoSistema', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenBkpBackupSistema', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenLogLogSistema', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenPapPapelParede', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSqlBancoDados', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSqlEditorBancoDados', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenAjudas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenTelLogin', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSaiSair', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenInfInformacoes', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSobSobre', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenAtiSistema', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadGrupoServico', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCargaDados', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgPessoas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgProdutos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgNotaStarter', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgAgendaStarter', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgConexao', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgBackup', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgLoginSistema', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgSair', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgNotaPesquisa', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenExecutarScriptSQL', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenManManualSginERP', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenComAgenda', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadAgendaGeral', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenPnlPainelDiario', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgPainel', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelClientes', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelProfissionais', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelServicos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelProdutos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelFinanceiros', 'Full');
    	Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadNotaEntradaEstoque', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenContas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadDespesas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadBaixaParcelas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCaixa', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadSuprimento', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadSangria', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadFecharCaixa', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadPessoaCompleto', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadClienteRapido', 'Full');		
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadAgenda', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadAgendaProfissional', 'Full');
	End	 
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Configuracao                                                                                  :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
: Versão: 01.00.01.00 - 18/06/2017 - ADICIONADO NOVOS MENUS DE ACESSO.                                       : 
: Versão: 01.00.02.00 - 29/06/2017 - ADICIONADO A NOVA LOGO MARCA DA SOFTHOUSE.                              : 
: Versão: 01.00.02.01 - 12/07/2017 - AJUSTE NA CHAMADA A LOGO MARCA DA SOFTHOUSE.                            : 
: Versão: 01.00.02.02 - 20/07/2017 - RETIRADO MENUS DESNECESSARIOS.                                          : 
: Versão: 01.00.02.03 - 24/07/2017 - AJUSTE DO ALIAS DA BASE DE CARGA, ADIÇÃO DE MAIS UM TIPO DE PAGAMENTO.  : 
: Versão: 01.00.03.00 - 08/08/2017 - RETIRADO O INSERT QUE VEM DA BASE DE CARGA.                             :
: Versão: 01.00.03.01 - 21/08/2017 - ADICIONADO NOVO MENU.                                                   :
: Versão: 01.00.03.02 - 21/08/2017 - ADICIONADO NOVOS DADOS.                                                 :
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridCidade                                                                                         :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as Cidade do Sistema                                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER View [dbo].[VW_GridCidade]
As
  /* Informações Uteis
  
  Select * From VW_GridCidade

  */
  Select Distinct
    Cidade.*,
	Uf.NmUf,
	Uf.NmSigla As NmSiglaUf,
	Uf.NrIbge As NrIbgeUf,
	Regiao.IdRegiao,
	Regiao.NmRegiao,
	Pais.IdPais,
	Pais.NmPais,
	Pais.NmSigla As NmSiglaPais,
	Pais.NrIbge As NrIbgePais,
	Case
	  When Cidade.IdUsuario = 0 Then 'SOFTSINOS'
	  Else Usuario.NmLogin
    End As NmUsuarioCadastro
  From Cidade
    Inner Join Uf
	  on Uf.IdUf = Cidade.IdUf
    Inner Join Regiao
	  On Regiao.IdRegiao = Uf.IdRegiao
    Inner Join Pais
	  On Pais.IdPais = Regiao.IdPais
    Left Join Usuario
	    On Usuario.IdUsuario = Cidade.IdUsuario
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridCidade                                                                                         :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as Cidade do Sistema                                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

If (Select Count(*) From Licenca Where NmMenu = 'MenCadAgenda') = 0
  Begin 
	Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadAgenda', 'Full');
End
Go

If (Select Count(*) From Licenca Where NmMenu = 'MenCadAgendaProfissional') = 0
  Begin 
	Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadAgendaProfissional', 'Full');
  End
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridAgenda                                                                                         :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.02.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: View criada para mostrar as agendas dos profissionais                                                      :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER View [dbo].[VW_GridAgenda]
As
  /* Informações Uteis
  
  Select * From VW_GridAgenda Where DtAgenda = '2017/08/09'
  Select * From VW_GridAgenda Where IdAgenda = 14327
  */

  Select 
    *
  From (Select
		  Agenda.*,
		  Profissional.NmPessoa NmProfissional,
		  Profissional.NmApelido NmApelidoProfissional, 
		  Cliente.NmPessoa NmCliente,
		  Cliente.NrCelular,
		  Cliente.SnSituacao As SnSituacaoCliente,
		  TipoServico.NmTpServico,
		  TipoServico.HxCor,
		  'NORMAL' As 'NmTpAgenda',
		  0 As IdAgendaEncaixe,
		  dbo.FN_Preenchimento('PE', Cast(Agenda.IdAgenda As Varchar(10)), '0', '10') NrAgenda,
		  Case
		    When Agenda.IdTpServico > 0 Then 'AGENDADO'
		    Else 'DISPONÍVEL'
		  End StAgenda,
		  Case
		    When Agenda.IdUsuario = 0 Then 'SOFTSINOS'
		    Else Usuario.NmLogin
		  End As NmUsuarioCadastro
	    From Agenda
		  Inner Join Pessoa Profissional
		    On Profissional.IdEmpresa = Agenda.IdEmpProfissional
			  And Profissional.IdPessoa = Agenda.IdProfissional
		  Left Join Pessoa Cliente
		    On Cliente.IdEmpresa = Agenda.IdEmpCliente
			  And Cliente.IdPessoa = Agenda.IdCliente
		  Left Join TipoServico
		    On TipoServico.IdTpServico = Agenda.IdTpServico
		  Left Join Usuario
		    On Usuario.IdUsuario = Agenda.IdUsuario
	    Union All
	    Select
		  AgendaEnCaixe.IdAgenda,
		  Agenda.IdEmpresa,
		  AgendaEnCaixe.IdUsuario,
  		  AgendaEnCaixe.DtCadastro,
	  	  AgendaEnCaixe.SnSituacao,
		  Agenda.DtAgenda,
		  Agenda.HrAgenda,
		  Agenda.SnRealizada,
		  Agenda.IdEmpProfissional,
		  Agenda.IdProfissional,
		  AgendaEnCaixe.IdTpServico,
		  AgendaEnCaixe.IdEmpCliente,
		  AgendaEnCaixe.IdCliente,
		  Profissional.NmPessoa NmProfissional,
		  Profissional.NmApelido NmApelidoProfissional, 
		  Cliente.NmPessoa NmCliente,
		  Cliente.NrCelular,
		  Cliente.SnSituacao As SnSituacaoCliente,
		  TipoServico.NmTpServico,
		  TipoServico.HxCor,
		  'ENCAIXE' AS 'NmTpAgenda',
		  AgendaEnCaixe.IdAgendaEncaixe,
		  dbo.FN_Preenchimento('PE', Cast(AgendaEnCaixe.IdAgendaEncaixe As Varchar(10)), '0', '10') NrAgenda,
		  Case
		    When Agenda.IdTpServico > 0 Then 'AGENDADO'
		    Else 'DISPONÍVEL'
		  End StAgenda,
		  Case
		    When Agenda.IdUsuario = 0 Then 'SOFTSINOS'
		    Else Usuario.NmLogin
		  End As NmUsuarioCadastro
	    From AgendaEnCaixe
		  Inner Join Agenda
		    On Agenda.IdAgenda = AgendaEnCaixe.IdAgenda
		  Inner Join Pessoa Profissional
		    On Profissional.IdEmpresa = Agenda.IdEmpProfissional
			  And Profissional.IdPessoa = Agenda.IdProfissional
		  Left Join Pessoa Cliente
		    On Cliente.IdEmpresa = AgendaEnCaixe.IdEmpCliente
			  And Cliente.IdPessoa = AgendaEnCaixe.IdCliente
		  Left Join TipoServico
		    On TipoServico.IdTpServico = AgendaEnCaixe.IdTpServico
		  Left Join Usuario
		    On Usuario.IdUsuario = AgendaEnCaixe.IdUsuario
	      ) A
  Where (SnSituacao = 1 Or SnSituacaoCliente = 1) 

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridAgenda                                                                                         :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - JULHO/2017                                                                           :
: Versão: 01.00.00.01 - 15/06/2017 - RETIRADO O JOIN COM SERVIÇO, ONDE O MESMO ESTAVA TRAZENDO A INFORMAÇÃO  :
:									 DUPLICADA.                                                              :
: Versão: 01.00.01.00 - 18/06/2017 - ADICIONADO A CONDIÇÃO DE SNAGENDA, ONDE ESSA DIZ QUE SE A AGENDA ESTA OU:
:								     NÃO DISPONIVEL.                                                         :
: Versão: 01.00.02.00 - 19/06/2017 - ADICIONADO O NRCELULAR DO CLIENTE.                                      :
: Versão: 01.02.00.00 - 02/08/2017 - ADICIONADO A AGENDAENCAIXE E DA COR DOS ATENDIMENTO, E UM NRAGENDA PARA :
:                                    PESQUISAR A INFORMA EM RUNTIME NO PAINEL DE AGENDA.                     :
: View criada para mostrar as agendas dos profissionais                                                      :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='SnServico'
                 And SysObjects.Name='TipoPessoa')
  Begin  
    Alter Table TipoPessoa Add SnServico Bit
  End

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='SnComissao'
                 And SysObjects.Name='TipoPessoa')
  Begin 
    Alter Table TipoPessoa Add SnComissao Bit
  End	   

If (Select Count(*) From SysObjects Where Name = 'DF_TipoPessoa_SnServico' And Type = 'D') = 0
  Begin
    ALTER TABLE [dbo].[TipoPessoa] ADD  CONSTRAINT [DF_TipoPessoa_SnServico]  DEFAULT ((0)) FOR [SnServico]
  End

If (Select Count(*) From SysObjects Where Name = 'DF_TipoPessoa_SnComissao' And Type = 'D') = 0
  Begin
    ALTER TABLE [dbo].[TipoPessoa] ADD  CONSTRAINT [DF_TipoPessoa_SnComissao]  DEFAULT ((0)) FOR [SnComissao]
  End
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridTipoPessoa                                                                                     :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as TipoPessoa do Sistema                                                          :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER View [dbo].[VW_GridTipoPessoa]
As
  /* Informações Uteis
  
  Select * From VW_GridTipoPessoa

  */
  Select Distinct
    TipoPessoa.*,
	Case
	  When TipoPessoa.IdUsuario = 0 Then 'SOFTSINOS'
	  Else Usuario.NmLogin
    End As NmUsuarioCadastro
  From TipoPessoa
    Left Join Usuario
	  On Usuario.IdUsuario = TipoPessoa.IdTpPessoa
   
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridTipoPessoa                                                                                     :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as TipoPessoa do Sistema                                                          :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridPessoa                                                                                         :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.01 - JULHO/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as Pessoa do Sistema                                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER View [dbo].[VW_GridPessoa]
As
  /* Informações Uteis
  
  Select * From VW_GridPessoa
  Select * From Pessoa

  */
  Select 
    Pessoa.*,
	Empresa.NmFantasia + ' - ' + Empresa.NmRazaoSocial As NmRazaoSocialNmFantasia,
	TipoPessoa.NmTpPessoa,
	TipoPessoa.SnCliente,
	TipoPessoa.SnFornecedor,
	TipoPessoa.SnFuncionario,
	TipoPessoa.SnServico,
	TipoPessoa.SnComissao,
	Cep.NmTpLogradouro,
	Cep.NmLogradouro,
	Cep.NmTpLogradouro + ' ' + Cep.NmLogradouro As NmEndereco,
	Cep.NmBairro,
	Cidade.IdCidade,
	Cidade.NmCidade,
	Cidade.NrIbge As NrIbgeCidade,
	Uf.IdUf,
	Uf.NmUf,
	Uf.NmSigla As NmSiglaUf,
	Uf.NrIbge As NrIbgeUf,
	Regiao.IdRegiao,
	Regiao.NmRegiao,
	Pais.IdPais,
	Pais.NmPais,
	Pais.NmSigla As NmSiglaPais,
	Pais.NrIbge As NrIbgePais,
	(Select Max(Nota.DtCadastro) From Nota Where Nota.IdEmpCliente = Pessoa.IdEmpresa And Nota.IdCliente = Pessoa.IdPessoa ) DtUltimoMovto,
	(Select Count(*) From Agenda Where Agenda.IdEmpCliente = Pessoa.IdEmpresa And Agenda.IdCliente = Pessoa.IdPessoa And Agenda.SnRealizada = 1) QtdAgdRealizada,
	Case
	  When Pessoa.IdUsuario = 0 Then 'SOFTSINOS'
	  Else Usuario.NmLogin
    End As NmUsuarioCadastro
  From Pessoa
    Inner Join Empresa
	  On Empresa.IdEmpresa = Pessoa.IdEmpresa
    Inner Join TipoPessoa
	  On TipoPessoa.IdTpPessoa = Pessoa.IdTpPessoa
    Left Join Usuario
	  On Usuario.IdUsuario = Pessoa.IdUsuario
    Left Join Cep
	  On Cep.NrCep = Pessoa.NrCep
    Left Join Cidade
	  On Cidade.IdCidade = Cep.IdCidade
    Left Join Uf
	  on Uf.IdUf = Cidade.IdUf
    Left Join Regiao
	  On Regiao.IdRegiao = Uf.IdRegiao
    Left Join Pais
	  On Pais.IdPais = Regiao.IdPais
    
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridPessoa                                                                                         :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
: Versão: 01.00.00.01 - 27/07/2017 - CORREÇÃO DO JOIN DO USUARIO.                                            :
:                                                                                                            :
: View criada para mostrar as Pessoa do Sistema                                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Function_FN_AtendimentoProfissionaisDia                                                                    :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.01 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Function criada para mostrar o número de atendimento dia de cada profissional.                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER Function [dbo].[FN_AtendimentoProfissionaisDia] (@DtAgendaEntrada Date,  @TpChamadaClasse Varchar(255))
Returns Integer
Begin

  /*Informações Uteis
  
  Select dbo.FN_AtendimentoProfissionaisDia('2017-08-11', 'Atendimento') 
  Select dbo.FN_AtendimentoProfissionaisDia('2017-06-12', 'Profissional') 
  */
  Declare @Valor1 Integer
  Declare @Valor2 Integer
  Declare @Resultado Integer  
  Declare @ExisteAgenda Integer 

  Select
	@ExisteAgenda = Count(1) 
  From VW_GridAgenda Where DtAgenda = @DtAgendaEntrada

  If @ExisteAgenda > 0
    Begin
	  If @TpChamadaClasse = 'AtendimentoStarter'
		Begin
		  Select
		    @Valor1 = Count(1) / IsNull(Count(Distinct IdProfissional), -1) 
		  From VW_GridAgenda 
		  Where DtAgenda = @DtAgendaEntrada
		    And IdAgendaEncaixe = 0

		  Select 
		    @Valor2 = Case 
			            When (Count(*) = 0) And (Count(Distinct IdProfissional) = 0) Then 1
			            Else Count(1) / IsNull(Count(Distinct IdProfissional), -1)
                      End 
		  From VW_GridAgenda 
		  Where DtAgenda = @DtAgendaEntrada
		    And IdAgendaEncaixe = 1 

		  Set @Resultado = @Valor1 + @Valor2
		End
	  Else
	  If @TpChamadaClasse = 'ProfissionalStarter'
		Begin
		  Select
		   @Valor1 = Count(Distinct IdProfissional) 
		  From VW_GridAgenda 
		  Where DtAgenda = @DtAgendaEntrada

		  Set @Resultado = @Valor1 
		End
    End
  Else	
  If @TpChamadaClasse = 'ProfissionalPremium'
	Begin
	  Select
	   @Valor1 = Count(Distinct IdPessoa) 
	  From VW_GridPessoa 
	  Where SnServico = 1
	  
	  Set @Resultado = @Valor1 
  	End
  Else
    Begin
	  Set @Resultado = 0
	End   		
		     
  Return @Resultado
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Function_FN_AtendimentoProfissionaisDia                                                                    :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
: Versão: 01.00.00.01 - 11/08/2017 - CORREÇÃO EM RELAÇÃO AO CALCULO DOS ENCAIXAS DA AGENDA                   :
:                                                                                                            :
: Function criada para mostrar o número de atendimento dia de cada profissional.                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO


Alter View VW_GridAgendaPremium
As
  /* Informações Uteis
  
  Select * From VW_GridAgendaPremium
  */
  Select
    *
  From AgendaPremium
