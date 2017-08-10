/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Configuracao                                                                                  :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: VersÃ£o: 01.00.02.03 - JUNHO/2017                                                                          : 
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER Proc [dbo].[PC_Configuracao](@IdEmpresaEntrada Integer)
As
Set NoCount On
  /*InformaÃ§Ãµes Uteis
	Sempre sera iniciao para a IdEmpresa = 0

	Insert Into SoftHouse (NmLogoTipo) Values ((Select * From OPENROWSET(BULK N'D:\SoftSinos\Desenvolvimento\Imagem\Logo\Logo.jpg', SINGLE_BLOB) AS Imagem ))

	Exec PC_Configuracao 1
  */
Begin
    If (Select Count(*) From Sys.DataBases Where Name = 'SoftSinosCARGA') > 0
	  Begin
        Alter Table Cep Disable Trigger All

		If (Select Count(*) From Cep) = 0
		  Begin
		    Insert Into Cep (NrCep, NmTpLogradouro, NmLogradouro, NmBairro, IdCidade)
		    Select NrCep, Upper(NmTpLogradouro), Upper(NmLogradouro), Upper(NmBairro), IdCidade  From SoftSinosCARGA.dbo.Cep Order By NrCep
          End
        Alter Table Cep Enable Trigger All
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
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO


	If (Select Count(*) From TipoPagamento Where NmTpPagamento = 'CHEQUE') = 0
	  Begin
        Insert Into TipoPagamento([IdUsuario], [NmTpPagamento]) Values (0, 'CHEQUE') 
      End
GO	  	

ALTER TABLE [dbo].[AgendaEmCaixe] DROP CONSTRAINT [FK_AgendaEmCaixe_TipoServico]
GO

ALTER TABLE [dbo].[AgendaEmCaixe] DROP CONSTRAINT [FK_AgendaEmCaixe_Pessoa_Cliente]
GO

ALTER TABLE [dbo].[AgendaEmCaixe] DROP CONSTRAINT [FK_AgendaEmCaixe_EmpCliente]
GO

ALTER TABLE [dbo].[AgendaEmCaixe] DROP CONSTRAINT [FK_AgendaEmCaixe_Agenda]
GO

ALTER TABLE [dbo].[AgendaEmCaixe] DROP CONSTRAINT [DF_AgendaEmCaixe_SnSituacao]
GO

ALTER TABLE [dbo].[AgendaEmCaixe] DROP CONSTRAINT [DF_AgendaEmCaixe_DtCadastro]
GO

ALTER TABLE [dbo].[AgendaEmCaixe] DROP CONSTRAINT [DF_AgendaEmCaixe_IdUsuario]
GO

DROP TABLE [dbo].[AgendaEmCaixe]
GO

CREATE TABLE [dbo].[AgendaEmCaixe](
	[IdAgendaEmCaixe] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpAgenda] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[DtCadastro] [datetime] NOT NULL,
	[SnSituacao] [bit] NOT NULL,
	[IdAgenda] [int] NOT NULL,
	[IdTpServico] [int] NOT NULL,
	[IdEmpCliente] [int] NOT NULL,
	[IdCliente] [int] NOT NULL,
 CONSTRAINT [PK_AgendaEmCaixe] PRIMARY KEY CLUSTERED 
(
	[IdAgendaEmCaixe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [UN_AgendaEmCaixe_NmArquivoAgendaEmCaixe] UNIQUE NONCLUSTERED 
(
	[IdAgenda] ASC,
	[IdTpServico] ASC,
	[IdEmpCliente] ASC,
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[AgendaEmCaixe] ADD  CONSTRAINT [DF_AgendaEmCaixe_IdUsuario]  DEFAULT ((0)) FOR [IdUsuario]
GO

ALTER TABLE [dbo].[AgendaEmCaixe] ADD  CONSTRAINT [DF_AgendaEmCaixe_DtCadastro]  DEFAULT (getdate()) FOR [DtCadastro]
GO

ALTER TABLE [dbo].[AgendaEmCaixe] ADD  CONSTRAINT [DF_AgendaEmCaixe_SnSituacao]  DEFAULT ((1)) FOR [SnSituacao]
GO

ALTER TABLE [dbo].[AgendaEmCaixe]  WITH CHECK ADD  CONSTRAINT [FK_AgendaEmCaixe_Agenda] FOREIGN KEY([IdAgenda])
REFERENCES [dbo].[Agenda] ([IdAgenda])
GO

ALTER TABLE [dbo].[AgendaEmCaixe] CHECK CONSTRAINT [FK_AgendaEmCaixe_Agenda]
GO

ALTER TABLE [dbo].[AgendaEmCaixe]  WITH CHECK ADD  CONSTRAINT [FK_AgendaEmCaixe_EmpCliente] FOREIGN KEY([IdEmpCliente])
REFERENCES [dbo].[Empresa] ([IdEmpresa])
GO

ALTER TABLE [dbo].[AgendaEmCaixe] CHECK CONSTRAINT [FK_AgendaEmCaixe_EmpCliente]
GO

ALTER TABLE [dbo].[AgendaEmCaixe]  WITH CHECK ADD  CONSTRAINT [FK_AgendaEmCaixe_EmpAgenda] FOREIGN KEY([IdEmpAgenda])
REFERENCES [dbo].[Empresa] ([IdEmpresa])
GO

ALTER TABLE [dbo].[AgendaEmCaixe] CHECK CONSTRAINT [FK_AgendaEmCaixe_EmpAgenda]
GO

ALTER TABLE [dbo].[AgendaEmCaixe]  WITH CHECK ADD  CONSTRAINT [FK_AgendaEmCaixe_Pessoa_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Pessoa] ([IdPessoa])
GO

ALTER TABLE [dbo].[AgendaEmCaixe] CHECK CONSTRAINT [FK_AgendaEmCaixe_Pessoa_Cliente]
GO

ALTER TABLE [dbo].[AgendaEmCaixe]  WITH CHECK ADD  CONSTRAINT [FK_AgendaEmCaixe_TipoServico] FOREIGN KEY([IdTpServico])
REFERENCES [dbo].[TipoServico] ([IdTpServico])
GO

ALTER TABLE [dbo].[AgendaEmCaixe] CHECK CONSTRAINT [FK_AgendaEmCaixe_TipoServico]
GO

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


If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='SnFinalizada'
                 And SysObjects.Name='Nota')
  Begin                   
    Alter Table Nota Add SnFinalizada Bit Null
  End
Go

Update Nota Set SnFinalizada = 0
Go

Alter Table Nota Alter Column SnFinalizada Bit Not Null
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridNota                                                                                           :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.01.00 - JULHO/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as Nota do Sistema                                                                :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER View [dbo].[VW_GridNota]
As
  /* Informações Uteis
  
  Select * From VW_GridNota

  */
  Select Distinct
	Empresa.NmFantasia + ' - ' + Empresa.NmRazaoSocial As NmFantasiaNmRazaoSocial,
    Nota.*,
	Cliente.NmPessoa As NmCliente,
	Cliente.NrCelular,
	Cast(IsNull((Select Sum(NotaItem.VlProduto) From NotaItem Where NotaItem.IdEmpresa = Nota.IdEmpresa And NotaItem.IdNota = Nota.IdNota And NotaItem.SnSituacao = 1), 0) As Decimal(10,2)) As VlTotalProduto,
	Cast(IsNull((Select Sum(NotaItem.VlServico)  From NotaItem Where NotaItem.IdEmpresa = Nota.IdEmpresa And NotaItem.IdNota = Nota.IdNota And NotaItem.SnSituacao = 1), 0) As Decimal(10,2)) As VlTotalServico,
	IsNull((Select Sum(NotaPagamento.VlPagamento) From NotaPagamento Where NotaPagamento.IdEmpresa = Nota.IdEmpresa And NotaPagamento.IdNota = Nota.IdNota And NotaPagamento.SnSituacao = 1), 0) As VlTotalPagamento,
	Case
	  When Nota.IdUsuario = 0 Then 'SOFTSINOS'
	  Else Usuario.NmLogin
    End As NmUsuarioCadastro
  From Nota
    Inner Join Empresa
	  On Empresa.IdEmpresa = Nota.IdEmpresa
    Left Join Usuario
	  On Usuario.IdUsuario = Nota.IdUsuario
	Inner Join Pessoa Cliente
	  On Cliente.IdPessoa = Nota.IdCliente
  Where Nota.SnSituacao = 1

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridNota                                                                                           :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
: Versão: 01.00.00.01 - 12/07/2017 - AJUSTE DOS SELECTS QUE GERAL O VALOR TOTAL DE PRODUTOS E SERVICOS.      :
: Versão: 01.00.01.00 - 24/07/2017 - ADIÇÃO NA RAZÃO SOCIAL DA EMPRESA, NRCELULAR DO CLIENTE E AJUSTADO O    :
:                                    CALCULO DO VALOR TOTAL DE PRODUTOS E SERVIÇOS.                          :
:                                    ADICIONADO A OS ITENS ATIVOS.                                           :                                                                                                            :
:                                                                                                            :
: View criada para mostrar as Nota do Sistema                                                                :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

If (Select Count(*) From SysObjects Where Name = 'DF_Nota_SnFinalizada' And Type = 'D') = 1
  Begin
    ALTER TABLE [dbo].[Nota] DROP CONSTRAINT [DF_Nota_SnFinalizada]
  End
GO

ALTER TABLE [dbo].[Nota] ADD  CONSTRAINT [DF_Nota_SnFinalizada]  DEFAULT ((1)) FOR [SnFinalizada]
GO

If (Select Count(*) From Licenca Where NmMenu = 'ImgNotaPesquisa') = 0
  Begin
    Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgNotaPesquisa', 'Full');	
  End
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridNotaItem                                                                                       :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.01.00 - JULHO/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as NotaItem do Sistema                                                            :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER View [dbo].[VW_GridNotaItem]
As
  /* Informações Uteis
  
  Select * From VW_GridNotaItem Where IdNota = 5

  */
  Select Distinct
    NotaItem.*,
	Produto.NmProduto,
	Produto.NrEan,
	Produto.VlVenda,
	TipoServico.NmTpServico,
	 Cast(Profissional.IdEmpresa As Varchar(255)) + ' - ' + Cast(Profissional.IdPessoa As Varchar(255)) + ' - ' + Profissional.NmPessoa As NmProfissional,
	Case
	  When NotaItem.IdUsuario = 0 Then 'SOFTSINOS'
	  Else Usuario.NmLogin
    End As NmUsuarioCadastro
  From NotaItem
    Left Join Usuario
	  On Usuario.IdUsuario = NotaItem.IdUsuario
    Left Join Produto
	  On Produto.IdProduto = NotaItem.IdProduto
    Left Join Servico
	  On Servico.IdServico = NotaItem.IdServico
    Left Join TipoServico
	  On TipoServico.IdTpServico = Servico.IdTpServico
    Left Join Pessoa Profissional
	  On Profissional.IdPessoa = NotaItem.IdProfissional
  Where NotaItem.SnSituacao = 1
   
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridNotaItem                                                                                       :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
: Versão: 01.00.01.00 - 21/07/2017 - ADICIONADO O MESMO FORMATO PARA O NOME DO PROFISSIONAL.                 :
:                                    ADICIONADO A OS ITENS ATIVOS.                                           :                                                                                                            :
: View criada para mostrar as NotaItem do Sistema                                                            :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridNotaPagamento                                                                                  :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.01.00 - JULHO/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as NotaPagamento do Sistema                                                       :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER View [dbo].[VW_GridNotaPagamento]
As
  /* Informações Uteis
  
  Select * From VW_GridNotaPagamento

  */
  Select Distinct
    NotaPagamento.*,
	TipoPagamento.NmTpPagamento,
	(Select Sum(VlPagamento) From NotaPagamento Total Where Total.IdEmpresa = NotaPagamento.IdEmpresa And Total.IdNota = NotaPagamento.IdNota And Total.SnSituacao = 1) VlTotal,
	Case
	  When NotaPagamento.IdUsuario = 0 Then 'SOFTSINOS'
	  Else Usuario.NmLogin
    End As NmUsuarioCadastro
  From NotaPagamento
    Left Join Usuario
	  On Usuario.IdUsuario = NotaPagamento.IdUsuario
    Left Join TipoPagamento
	  On TipoPagamento.IdTpPagamento = NotaPagamento.IdTpPagamento
  Where NotaPagamento.SnSituacao = 1
   
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridNotaPagamento                                                                                  :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
: Versão: 01.00.01.00 - 31/07/2017 - ADICIONADO A CONDIÇÃO DE SÓ MOSTRAR PARCELAS ATIVAS.                    :
:                                                                                                            :
: View criada para mostrar as NotaPagamento do Sistema                                                       :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/* VERSIONAMENTO */
If (Select Count(*) From Versao Where NrVersaoBd = '3.1.12.486') = 0
  Begin
    Insert Into Versao (NrVersaoBd, NrVersaoApp) Values ('3.1.12.486', '3.1.12.486')
  End	
Go