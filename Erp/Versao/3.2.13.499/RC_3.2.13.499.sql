/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Inicializacao                                                                                 :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 02.00.00.00 - AGOSTO/2017                                                                          : 
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER Proc [dbo].[PC_Inicializacao](@IdEmpresaEntrada Integer)
As
  /*Informações Uteis
	Sempre sera iniciao para a IdEmpresa = 0

	Exec PC_Inicializacao 1

	/*Select's*/
	Select * From Calendario
	Select * FRom Pais
	Select * From Regiao
	Select * From Uf
	Select * From Cidade
	Select * From Cep
  */
Begin
  If (Select Count(*) From Sys.DataBases Where Name = 'SoftSinosCARGA') > 0
    Begin
	  /*Cadastro de Calendário*/
	  If (Select Count(*) From Calendario) = 0
        Begin
          Alter Table Calendario Disable Trigger All

    	  Insert Into Calendario ([DtCalendario], [NrAno], [NmMes], [NrMes], [NrDia], [NmDiaSemana], [DtInicioSemana], [DtFinalSemana], [DtInicioMes], [DtFinalMes], [DtInicioTrimestre], [DtFinalTrimestre], [DtInicioAno], [DtFinalAno], [SnDiaUtil], [SnDiaNaoUtil], [SnFinalSemana], [SnFeriado], [SnDiaSemana], [NmDescricaoFeriado], [DtCadastro], [NmFeriadoTrocado], [IdUsuario])
		  Select [DtCalendario], [NrAno], [NmMes], [NrMes], [NrDia], [NmDiaSemana], [DtInicioSemana], [DtFinalSemana], [DtInicioMes], [DtFinalMes], [DtInicioTrimestre], [DtFinalTrimestre], [DtInicioAno], [DtFinalAno], [SnDiaUtil], [SnDiaNaoUtil], [SnFinalSemana], [SnFeriado], [SnDiaSemana], [NmDescricaoFeriado], [DtCadastro], [NmFeriadoTrocado], [IdUsuario] From SoftSinosCARGA.dbo.Calendario Order By [DtCalendario]
	
	      Alter Table Calendario Enable Trigger All	  
		End    
      
	  /*Cadastro de Pais*/
      If (Select Count(*) From Pais) = 0
        Begin
          Alter Table Pais Disable Trigger All

	      Insert Into Pais (IdPais, NmPais, NmSigla, NrIbge)
		  Select IdPais, Upper(NmPais), Upper(NmSigla), NrIbge From SoftSinosCARGA.dbo.Pais Order By [NmPais]

	      Alter Table Pais Enable Trigger All	  
        End
      
	  /*Cadastro de Região*/
	  If (Select Count(*) From Regiao) = 0
		Begin
		  Insert Into Regiao (IdRegiao, NmRegiao, IdPais)
		  Select IdRegiao, Upper(NmRegiao), IdPais From SoftSinosCARGA.dbo.Regiao Order By [NmRegiao]
	    End

	  /*Cadastro de UF*/
	  If (Select Count(*) From Uf) = 0
		Begin
		  Insert Into Uf (IdUf, NmUf, NmSigla, PcIcms, NrIbge, IdRegiao)
		  Select IdUf, Upper(NmUf), Upper(NmSigla), PcIcms, NrIbge, IdRegiao From SoftSinosCARGA.dbo.Uf Order By [NmUf] 
		End

	  /*Cadastro de Cidade*/
	  If (Select Count(*) From Cidade) = 0
		Begin
		  Alter Table Cidade Disable Trigger All	  

		  Insert Into Cidade (IdCidade, NmCidade, NrIbge, IdUf)
		  Select IdCidade, Upper(NmCidade), NrIbge, IdUf From SoftSinosCARGA.dbo.Cidade Order By [NmCidade]
		   
		  Alter Table Cidade Enable Trigger All	  
		End

		/*Cadastro de Cep*/
		If (Select Count(*) From Cep) = 0
		  Begin
            Alter Table Cep Disable Trigger All

		    Insert Into Cep (NrCep, NmTpLogradouro, NmLogradouro, NmBairro, IdCidade)
		    Select NrCep, Upper(NmTpLogradouro), Upper(NmLogradouro), Upper(NmBairro), IdCidade  From SoftSinosCARGA.dbo.Cep Order By NrCep

            Alter Table Cep Enable Trigger All
          End
	End
   
  Exec PC_Configuracao @IdEmpresaEntrada
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Inicializacao.                                                                                :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           : 
: Versão: 02.00.00.00 - 08/08/2017 - CRIADA NOVA VERSAO.                                                     : 
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Configuracao                                                                                  :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: VersÃ£o: 01.00.03.00 - AGOSTO/2017                                                                         : 
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
: Versão: 01.00.03.00 - 08/08/2017 - RETIRADO O INSERT QUE VEM DA BASE DE CARGA.                             :
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

If Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysObjects.Name='AgendaEmCaixe')
  Begin                   
   Drop Table AgendaEmCaixe
  End
Go

If Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysObjects.Name='AgendaEncaixe')
  Begin                   
	ALTER TABLE [dbo].[AgendaEncaixe] DROP CONSTRAINT [FK_AgendaEncaixe_TipoServico]
	ALTER TABLE [dbo].[AgendaEncaixe] DROP CONSTRAINT [FK_AgendaEncaixe_Pessoa_Cliente]
	ALTER TABLE [dbo].[AgendaEncaixe] DROP CONSTRAINT [FK_AgendaEncaixe_EmpCliente]
	ALTER TABLE [dbo].[AgendaEncaixe] DROP CONSTRAINT [FK_AgendaEncaixe_Empresa]
	ALTER TABLE [dbo].[AgendaEncaixe] DROP CONSTRAINT [FK_AgendaEncaixe_Agenda]
	DROP TABLE [dbo].[AgendaEncaixe]
  End
Go


CREATE TABLE [dbo].[AgendaEncaixe](
	[IdAgendaEncaixe] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpresa] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL CONSTRAINT [DF_AgendaEncaixe_IdUsuario]  DEFAULT ((0)),
	[DtCadastro] [datetime] NOT NULL CONSTRAINT [DF_AgendaEncaixe_DtCadastro]  DEFAULT (getdate()),
	[SnSituacao] [bit] NOT NULL CONSTRAINT [DF_AgendaEncaixe_SnSituacao]  DEFAULT ((1)),
	[IdAgenda] [int] NOT NULL,
	[IdTpServico] [int] NOT NULL,
	[IdEmpCliente] [int] NOT NULL,
	[IdCliente] [int] NOT NULL,
 CONSTRAINT [PK_AgendaEncaixe] PRIMARY KEY CLUSTERED 
(
	[IdAgendaEncaixe] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [UN_AgendaEncaixe_NmArquivoAgendaEncaixe] UNIQUE NONCLUSTERED 
(
	[IdAgenda] ASC,
	[IdTpServico] ASC,
	[IdEmpCliente] ASC,
	[IdCliente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[AgendaEncaixe]  WITH CHECK ADD  CONSTRAINT [FK_AgendaEncaixe_Agenda] FOREIGN KEY([IdAgenda])
REFERENCES [dbo].[Agenda] ([IdAgenda])
GO

ALTER TABLE [dbo].[AgendaEncaixe] CHECK CONSTRAINT [FK_AgendaEncaixe_Agenda]
GO

ALTER TABLE [dbo].[AgendaEncaixe]  WITH CHECK ADD  CONSTRAINT [FK_AgendaEncaixe_Empresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresa] ([IdEmpresa])
GO

ALTER TABLE [dbo].[AgendaEncaixe] CHECK CONSTRAINT [FK_AgendaEncaixe_Empresa]
GO

ALTER TABLE [dbo].[AgendaEncaixe]  WITH CHECK ADD  CONSTRAINT [FK_AgendaEncaixe_EmpCliente] FOREIGN KEY([IdEmpCliente])
REFERENCES [dbo].[Empresa] ([IdEmpresa])
GO

ALTER TABLE [dbo].[AgendaEncaixe] CHECK CONSTRAINT [FK_AgendaEncaixe_EmpCliente]
GO

ALTER TABLE [dbo].[AgendaEncaixe]  WITH CHECK ADD  CONSTRAINT [FK_AgendaEncaixe_Pessoa_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Pessoa] ([IdPessoa])
GO

ALTER TABLE [dbo].[AgendaEncaixe] CHECK CONSTRAINT [FK_AgendaEncaixe_Pessoa_Cliente]
GO

ALTER TABLE [dbo].[AgendaEncaixe]  WITH CHECK ADD  CONSTRAINT [FK_AgendaEncaixe_TipoServico] FOREIGN KEY([IdTpServico])
REFERENCES [dbo].[TipoServico] ([IdTpServico])
GO

ALTER TABLE [dbo].[AgendaEncaixe] CHECK CONSTRAINT [FK_AgendaEncaixe_TipoServico]
GO

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
    Agenda.*,
    Profissional.NmPessoa NmProfissional,
	Profissional.NmApelido NmApelidoProfissional, 
	Cliente.NmPessoa NmCliente,
	Cliente.NrCelular,
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
               Where SysColumns.Name='NrCelular'
                 And SysObjects.Name='Empresa')
  Begin                   
    Alter Table Empresa Add NrCelular Varchar(12)
  End
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridEmpresa                                                                                        :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.02 - AGOSTO/2017                                                                          :
:                                                                                                            :
: View Criada para Mostrar os Dados da Grid de Empresa.                                                      :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER View [dbo].[VW_GridEmpresa]
As
  /* Informações Uteis
  
  Select * From VW_GridEmpresa

  */
  Select
    Empresa.*,
	Empresa.NmFantasia + ' - ' + Empresa.NmRazaoSocial As NmFantasiaNmRazaoSocial,
	Cep.NmTpLogradouro + ' ' + Cep.NmLogradouro + ' ' As NmEndereco,
	Cep.NmBairro,
	Cidade.NmCidade,
	Uf.NmSigla As NmSiglaUf,
	Case
	  When Empresa.IdUsuario = 0 Then 'SOFTSINOS'
	  Else Usuario.NmLogin
    End As NmUsuarioCadastro,
	(Select NmLogoTipo From SoftHouse) ImLogoTipoSoftHouse
  From Empresa
    Left Join Usuario
	  On Usuario.IdUsuario = Empresa.IdUsuario
    Left Join Cep
	  On Cep.NrCep = Empresa.NrCep
    Left Join Cidade
	  On Cidade.IdCidade = Cep.IdCidade
    Left Join Uf
	  On Uf.IdUf = Cidade.IdUf
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridEmpresa                                                                                        :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
: Versão: 01.00.00.01 - 20/06/2017 - AJUSTADO NO MESMO DO CAMPO QUE CARREGA A LOGOMARCA DA SOFTHOUSE.        :
: Versão: 01.00.00.02 - 04/08/2017 - ADIÇÃO DE NOVO COMPO DA TABELA EMPRESA.                                 :
:                                                                                                            :
: View Criada para Mostrar os Dados da Grid de Empresa.                                                      :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

Truncate Table Cep
Go

Delete Cidade
Go

Delete Uf
Go

Delete Regiao
Go

Delete Pais
Go

Exec PC_Inicializacao 1
Go

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='HxCor'
                 And SysObjects.Name='TipoServico')
  Begin                   
    Alter Table TipoServico Add HxCor Varchar(255)
  End
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridTipoServico                                                                                    :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as TipoServico do Sistema                                                         :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER View [dbo].[VW_GridTipoServico]
As
  /* Informações Uteis
  
  Select * From VW_GridTipoServico

  */
  Select Distinct
    TipoServico.*,
	GrupoServico.NmGrupoServico,
	Case
	  When TipoServico.IdUsuario = 0 Then 'SOFTSINOS'
	  Else Usuario.NmLogin
    End As NmUsuarioCadastro
  From TipoServico
    Left Join Usuario
	  On Usuario.IdUsuario = TipoServico.IdUsuario
    Left Join GrupoServico
	  On GrupoServico.IdGrupoServico = TipoServico.IdGrupoServico
   
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridTipoServico                                                                                    :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as TipoServico do Sistema                                                         :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

If (Select Count(*) From SysObjects Where Name = 'FN_AtendimentoProfissionaisDia' And Type = 'FN') > 0
  Begin
    Drop Function FN_AtendimentoProfissionaisDia 
  End 
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Function_FN_AtendimentoProfissionaisDia                                                                    :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Function criada para mostrar o número de atendimento dia de cada profissional.                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Create Function [dbo].[FN_AtendimentoProfissionaisDia] (@DtAgendaEntrada Date,  @TpChamadaClasse Varchar(255))
Returns Integer
Begin

  /*Informações Uteis
  
  Select dbo.FN_AtendimentoProfissionaisDia('2017-06-12', 'Atendimento') 
  Select dbo.FN_AtendimentoProfissionaisDia('2017-06-12', 'Profissional') 
  */
  Declare @Valor Integer
  Declare @ExisteAgenda Integer 

  Select
	@ExisteAgenda = Count(1) 
  From VW_GridAgenda Where DtAgenda = @DtAgendaEntrada

  If @ExisteAgenda > 0
    Begin
	  If @TpChamadaClasse = 'Atendimento'
		Begin
		  Select
		   @Valor = Count(1) / IsNull(Count(Distinct IdProfissional), -1) 
		  From VW_GridAgenda Where DtAgenda = @DtAgendaEntrada
		End
	  Else
	  If @TpChamadaClasse = 'Profissional'
		Begin
		  Select
		   @Valor = Count(Distinct IdProfissional) 
		  From VW_GridAgenda Where DtAgenda = @DtAgendaEntrada
		End
    End
  Else
    Begin
	  Set @Valor = 0
	End	     

  Return @Valor
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Function_FN_AtendimentoProfissionaisDia                                                                    :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Function criada para mostrar o número de atendimento dia de cada profissional.                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Insert_Log_AgendaEncaixe')
DROP TRIGGER TR_Insert_Log_AgendaEncaixe
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_AgendaEncaixe                                                                        :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Insert_Log_AgendaEncaixe On AgendaEncaixe
For Insert
As
Set NoCount On
 
  Declare @IdAgendaEncaixe Integer
  Declare @IdEmpresa Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdAgenda Integer
  Declare @IdTpServico Integer
  Declare @IdEmpCliente Integer
  Declare @IdCliente Integer
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedInsertAgendaEncaixe Cursor For
 
    Select
      Inserted.IdAgendaEncaixe,
      Inserted.IdEmpresa,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdAgenda,
      Inserted.IdTpServico,
      Inserted.IdEmpCliente,
      Inserted.IdCliente
    From Inserted
 
  Open CrsInsertedInsertAgendaEncaixe
  Fetch Next From CrsInsertedInsertAgendaEncaixe Into
 
      @IdAgendaEncaixe,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdAgenda,
      @IdTpServico,
      @IdEmpCliente,
      @IdCliente
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2, Pk3, Pk4, Pk5)
        Values (
          @IdEmpresa,
          @IdUsuario,
          'SQL Server',
          'Insert',
          'AgendaEncaixe',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
		  @IdAgendaEncaixe,
          @IdAgenda,
          @IdTpServico,
          @IdEmpCliente,
          @IdCliente
          )
 
  Fetch Next From CrsInsertedInsertAgendaEncaixe Into
 
      @IdAgendaEncaixe,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdAgenda,
      @IdTpServico,
      @IdEmpCliente,
      @IdCliente
 
    End
  Close CrsInsertedInsertAgendaEncaixe
  DealLocate CrsInsertedInsertAgendaEncaixe
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_AgendaEncaixe                                                                        :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Update_Log_AgendaEncaixe')
DROP TRIGGER TR_Update_Log_AgendaEncaixe
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_AgendaEncaixe                                                                        :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Update_Log_AgendaEncaixe On AgendaEncaixe
For Update
As
Set NoCount On
 
  Declare @IdAgendaEncaixe Integer
  Declare @IdEmpresa Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdAgenda Integer
  Declare @IdTpServico Integer
  Declare @IdEmpCliente Integer
  Declare @IdCliente Integer
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedUpdateAgendaEncaixe Cursor For
 
    Select
      Inserted.IdAgendaEncaixe,
      Inserted.IdEmpresa,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdAgenda,
      Inserted.IdTpServico,
      Inserted.IdEmpCliente,
      Inserted.IdCliente
    From Inserted
 
  Open CrsInsertedUpdateAgendaEncaixe
  Fetch Next From CrsInsertedUpdateAgendaEncaixe Into
 
      @IdAgendaEncaixe,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdAgenda,
      @IdTpServico,
      @IdEmpCliente,
      @IdCliente
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2, Pk3, Pk4, Pk5)
        Values (
          @IdEmpresa,
          @IdUsuario,
          'SQL Server',
          'Update',
          'AgendaEncaixe',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdAgendaEncaixe,
          @IdAgenda,
          @IdTpServico,
          @IdEmpCliente,
          @IdCliente
          )
 
  Fetch Next From CrsInsertedUpdateAgendaEncaixe Into
 
      @IdAgendaEncaixe,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdAgenda,
      @IdTpServico,
      @IdEmpCliente,
      @IdCliente
 
    End
  Close CrsInsertedUpdateAgendaEncaixe
  DealLocate CrsInsertedUpdateAgendaEncaixe
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_AgendaEncaixe                                                                        :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Update_Log_Nota')
DROP TRIGGER TR_Update_Log_Nota
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_Nota                                                                                 :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Update_Log_Nota On Nota
For Update
As
Set NoCount On
 
  Declare @IdNota Integer
  Declare @IdEmpresa Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdCliente Integer
  Declare @IdEmpCliente Integer
  Declare @VlNota Decimal(10,2)
  Declare @SnFinalizada Bit
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedUpdateNota Cursor For
 
    Select
      Inserted.IdNota,
      Inserted.IdEmpresa,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdCliente,
      Inserted.IdEmpCliente,
      Inserted.VlNota,
      Inserted.SnFinalizada
    From Inserted
 
  Open CrsInsertedUpdateNota
  Fetch Next From CrsInsertedUpdateNota Into
 
      @IdNota,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdCliente,
      @IdEmpCliente,
      @VlNota,
      @SnFinalizada
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2)
        Values (
          @IdEmpresa,
          @IdUsuario,
          'SQL Server',
          'Update',
          'Nota',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdNota,
          @IdEmpresa
          )
 
  Fetch Next From CrsInsertedUpdateNota Into
 
      @IdNota,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdCliente,
      @IdEmpCliente,
      @VlNota,
      @SnFinalizada
 
    End
  Close CrsInsertedUpdateNota
  DealLocate CrsInsertedUpdateNota
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_Nota                                                                                 :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Insert_Log_Nota')
DROP TRIGGER TR_Insert_Log_Nota
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_Nota                                                                                 :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Insert_Log_Nota On Nota
For Insert
As
Set NoCount On
 
  Declare @IdNota Integer
  Declare @IdEmpresa Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdCliente Integer
  Declare @IdEmpCliente Integer
  Declare @VlNota Decimal(10,2)
  Declare @SnFinalizada Bit
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedInsertNota Cursor For
 
    Select
      Inserted.IdNota,
      Inserted.IdEmpresa,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdCliente,
      Inserted.IdEmpCliente,
      Inserted.VlNota,
      Inserted.SnFinalizada
    From Inserted
 
  Open CrsInsertedInsertNota
  Fetch Next From CrsInsertedInsertNota Into
 
      @IdNota,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdCliente,
      @IdEmpCliente,
      @VlNota,
      @SnFinalizada
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2)
        Values (
          @IdEmpresa,
          @IdUsuario,
          'SQL Server',
          'Insert',
          'Nota',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdNota,
          @IdEmpresa
          )
 
  Fetch Next From CrsInsertedInsertNota Into
 
      @IdNota,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdCliente,
      @IdEmpCliente,
      @VlNota,
      @SnFinalizada
 
    End
  Close CrsInsertedInsertNota
  DealLocate CrsInsertedInsertNota
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_Nota                                                                                 :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Insert_Log_NotaItem')
DROP TRIGGER TR_Insert_Log_NotaItem
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_NotaItem                                                                             :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Insert_Log_NotaItem On NotaItem
For Insert
As
Set NoCount On
 
  Declare @IdNotaItem Integer
  Declare @IdEmpresa Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdNota Integer
  Declare @IdServico Integer
  Declare @IdProduto Integer
  Declare @QtdNotaItem Decimal(10,2)
  Declare @VlServico Decimal(10,2)
  Declare @VlProduto Decimal(10,2)
  Declare @IdProfissional Integer
  Declare @PcDesconto Decimal(10,2)
  Declare @IdEmpProfissional Integer
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedInsertNotaItem Cursor For
 
    Select
      Inserted.IdNotaItem,
      Inserted.IdEmpresa,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdNota,
      Inserted.IdServico,
      Inserted.IdProduto,
      Inserted.QtdNotaItem,
      Inserted.VlServico,
      Inserted.VlProduto,
      Inserted.IdProfissional,
      Inserted.PcDesconto,
      Inserted.IdEmpProfissional
    From Inserted
 
  Open CrsInsertedInsertNotaItem
  Fetch Next From CrsInsertedInsertNotaItem Into
 
      @IdNotaItem,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdNota,
      @IdServico,
      @IdProduto,
      @QtdNotaItem,
      @VlServico,
      @VlProduto,
      @IdProfissional,
      @PcDesconto,
      @IdEmpProfissional
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2, Pk3)
        Values (
          @IdEmpresa,
          @IdUsuario,
          'SQL Server',
          'Insert',
          'NotaItem',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdNotaItem,
          @IdNota,
          @IdEmpresa
          )
 
  Fetch Next From CrsInsertedInsertNotaItem Into
 
      @IdNotaItem,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdNota,
      @IdServico,
      @IdProduto,
      @QtdNotaItem,
      @VlServico,
      @VlProduto,
      @IdProfissional,
      @PcDesconto,
      @IdEmpProfissional
 
    End
  Close CrsInsertedInsertNotaItem
  DealLocate CrsInsertedInsertNotaItem
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_NotaItem                                                                             :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Update_Log_NotaItem')
DROP TRIGGER TR_Update_Log_NotaItem
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_NotaItem                                                                             :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Update_Log_NotaItem On NotaItem
For Update
As
Set NoCount On
 
  Declare @IdNotaItem Integer
  Declare @IdEmpresa Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdNota Integer
  Declare @IdServico Integer
  Declare @IdProduto Integer
  Declare @QtdNotaItem Decimal(10,2)
  Declare @VlServico Decimal(10,2)
  Declare @VlProduto Decimal(10,2)
  Declare @IdProfissional Integer
  Declare @PcDesconto Decimal(10,2)
  Declare @IdEmpProfissional Integer
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedUpdateNotaItem Cursor For
 
    Select
      Inserted.IdNotaItem,
      Inserted.IdEmpresa,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdNota,
      Inserted.IdServico,
      Inserted.IdProduto,
      Inserted.QtdNotaItem,
      Inserted.VlServico,
      Inserted.VlProduto,
      Inserted.IdProfissional,
      Inserted.PcDesconto,
      Inserted.IdEmpProfissional
    From Inserted
 
  Open CrsInsertedUpdateNotaItem
  Fetch Next From CrsInsertedUpdateNotaItem Into
 
      @IdNotaItem,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdNota,
      @IdServico,
      @IdProduto,
      @QtdNotaItem,
      @VlServico,
      @VlProduto,
      @IdProfissional,
      @PcDesconto,
      @IdEmpProfissional
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2, Pk3)
        Values (
          @IdEmpresa,
          @IdUsuario,
          'SQL Server',
          'Update',
          'NotaItem',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdNotaItem,
          @IdNota,
          @IdEmpresa
          )
 
  Fetch Next From CrsInsertedUpdateNotaItem Into
 
      @IdNotaItem,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdNota,
      @IdServico,
      @IdProduto,
      @QtdNotaItem,
      @VlServico,
      @VlProduto,
      @IdProfissional,
      @PcDesconto,
      @IdEmpProfissional
 
    End
  Close CrsInsertedUpdateNotaItem
  DealLocate CrsInsertedUpdateNotaItem
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_NotaItem                                                                             :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Update_Log_NotaPagamento')
DROP TRIGGER TR_Update_Log_NotaPagamento
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_NotaPagamento                                                                        :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Update_Log_NotaPagamento On NotaPagamento
For Update
As
Set NoCount On
 
  Declare @IdNotaPagamento Integer
  Declare @IdEmpresa Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdNota Integer
  Declare @IdTpPagamento Integer
  Declare @VlPagamento Decimal(10,2)
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedUpdateNotaPagamento Cursor For
 
    Select
      Inserted.IdNotaPagamento,
      Inserted.IdEmpresa,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdNota,
      Inserted.IdTpPagamento,
      Inserted.VlPagamento
    From Inserted
 
  Open CrsInsertedUpdateNotaPagamento
  Fetch Next From CrsInsertedUpdateNotaPagamento Into
 
      @IdNotaPagamento,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdNota,
      @IdTpPagamento,
      @VlPagamento
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2, Pk3, Pk4)
        Values (
          @IdEmpresa,
          @IdUsuario,
          'SQL Server',
          'Update',
          'NotaPagamento',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdNotaPagamento,
          @IdNota,
          @IdEmpresa,
          @IdTpPagamento
          )
 
  Fetch Next From CrsInsertedUpdateNotaPagamento Into
 
      @IdNotaPagamento,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdNota,
      @IdTpPagamento,
      @VlPagamento
 
    End
  Close CrsInsertedUpdateNotaPagamento
  DealLocate CrsInsertedUpdateNotaPagamento
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_NotaPagamento                                                                        :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Insert_Log_NotaPagamento')
DROP TRIGGER TR_Insert_Log_NotaPagamento
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_NotaPagamento                                                                        :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Insert_Log_NotaPagamento On NotaPagamento
For Insert
As
Set NoCount On
 
  Declare @IdNotaPagamento Integer
  Declare @IdEmpresa Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdNota Integer
  Declare @IdTpPagamento Integer
  Declare @VlPagamento Decimal(10,2)
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedInsertNotaPagamento Cursor For
 
    Select
      Inserted.IdNotaPagamento,
      Inserted.IdEmpresa,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdNota,
      Inserted.IdTpPagamento,
      Inserted.VlPagamento
    From Inserted
 
  Open CrsInsertedInsertNotaPagamento
  Fetch Next From CrsInsertedInsertNotaPagamento Into
 
      @IdNotaPagamento,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdNota,
      @IdTpPagamento,
      @VlPagamento
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2, Pk3, Pk4)
        Values (
          @IdEmpresa,
          @IdUsuario,
          'SQL Server',
          'Insert',
          'NotaPagamento',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdNotaPagamento,
          @IdNota,
          @IdEmpresa,
          @IdTpPagamento
          )
 
  Fetch Next From CrsInsertedInsertNotaPagamento Into
 
      @IdNotaPagamento,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdNota,
      @IdTpPagamento,
      @VlPagamento
 
    End
  Close CrsInsertedInsertNotaPagamento
  DealLocate CrsInsertedInsertNotaPagamento
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_NotaPagamento                                                                        :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Insert_Log_Relatorio')
DROP TRIGGER TR_Insert_Log_Relatorio
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_Relatorio                                                                            :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Insert_Log_Relatorio On Relatorio
For Insert
As
Set NoCount On
 
  Declare @IdRelatorio Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @NmTpRelatorio Varchar(255)
  Declare @NmArquivoRelatorio Varchar(255)
  Declare @NmRelatorio Varchar(255)
  Declare @NmProcedure Varchar(255)
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedInsertRelatorio Cursor For
 
    Select
      Inserted.IdRelatorio,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.NmTpRelatorio,
      Inserted.NmArquivoRelatorio,
      Inserted.NmRelatorio,
      Inserted.NmProcedure
    From Inserted
 
  Open CrsInsertedInsertRelatorio
  Fetch Next From CrsInsertedInsertRelatorio Into
 
      @IdRelatorio,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @NmTpRelatorio,
      @NmArquivoRelatorio,
      @NmRelatorio,
      @NmProcedure
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2)
        Values (
          '0',
          @IdUsuario,
          'SQL Server',
          'Insert',
          'Relatorio',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdRelatorio,
          @NmArquivoRelatorio
          )
 
  Fetch Next From CrsInsertedInsertRelatorio Into
 
      @IdRelatorio,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @NmTpRelatorio,
      @NmArquivoRelatorio,
      @NmRelatorio,
      @NmProcedure
 
    End
  Close CrsInsertedInsertRelatorio
  DealLocate CrsInsertedInsertRelatorio
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_Relatorio                                                                            :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Update_Log_Relatorio')
DROP TRIGGER TR_Update_Log_Relatorio
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_Relatorio                                                                            :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Update_Log_Relatorio On Relatorio
For Update
As
Set NoCount On
 
  Declare @IdRelatorio Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @NmTpRelatorio Varchar(255)
  Declare @NmArquivoRelatorio Varchar(255)
  Declare @NmRelatorio Varchar(255)
  Declare @NmProcedure Varchar(255)
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedUpdateRelatorio Cursor For
 
    Select
      Inserted.IdRelatorio,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.NmTpRelatorio,
      Inserted.NmArquivoRelatorio,
      Inserted.NmRelatorio,
      Inserted.NmProcedure
    From Inserted
 
  Open CrsInsertedUpdateRelatorio
  Fetch Next From CrsInsertedUpdateRelatorio Into
 
      @IdRelatorio,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @NmTpRelatorio,
      @NmArquivoRelatorio,
      @NmRelatorio,
      @NmProcedure
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2)
        Values (
          '0',
          @IdUsuario,
          'SQL Server',
          'Update',
          'Relatorio',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdRelatorio,
          @NmArquivoRelatorio
          )
 
  Fetch Next From CrsInsertedUpdateRelatorio Into
 
      @IdRelatorio,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @NmTpRelatorio,
      @NmArquivoRelatorio,
      @NmRelatorio,
      @NmProcedure
 
    End
  Close CrsInsertedUpdateRelatorio
  DealLocate CrsInsertedUpdateRelatorio
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_Relatorio                                                                            :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Update_Log_RelatorioOrdem')
DROP TRIGGER TR_Update_Log_RelatorioOrdem
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_RelatorioOrdem                                                                       :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Update_Log_RelatorioOrdem On RelatorioOrdem
For Update
As
Set NoCount On
 
  Declare @IdRelatorioOrdem Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdRelatorio Integer
  Declare @NmRelatorioOrdem Varchar(255)
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedUpdateRelatorioOrdem Cursor For
 
    Select
      Inserted.IdRelatorioOrdem,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdRelatorio,
      Inserted.NmRelatorioOrdem
    From Inserted
 
  Open CrsInsertedUpdateRelatorioOrdem
  Fetch Next From CrsInsertedUpdateRelatorioOrdem Into
 
      @IdRelatorioOrdem,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdRelatorio,
      @NmRelatorioOrdem
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2, Pk3)
        Values (
          '0',
          @IdUsuario,
          'SQL Server',
          'Update',
          'RelatorioOrdem',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdRelatorioOrdem,
          @IdRelatorio,
          @NmRelatorioOrdem
          )
 
  Fetch Next From CrsInsertedUpdateRelatorioOrdem Into
 
      @IdRelatorioOrdem,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdRelatorio,
      @NmRelatorioOrdem
 
    End
  Close CrsInsertedUpdateRelatorioOrdem
  DealLocate CrsInsertedUpdateRelatorioOrdem
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_RelatorioOrdem                                                                       :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Insert_Log_RelatorioOrdem')
DROP TRIGGER TR_Insert_Log_RelatorioOrdem
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_RelatorioOrdem                                                                       :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Insert_Log_RelatorioOrdem On RelatorioOrdem
For Insert
As
Set NoCount On
 
  Declare @IdRelatorioOrdem Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdRelatorio Integer
  Declare @NmRelatorioOrdem Varchar(255)
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedInsertRelatorioOrdem Cursor For
 
    Select
      Inserted.IdRelatorioOrdem,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdRelatorio,
      Inserted.NmRelatorioOrdem
    From Inserted
 
  Open CrsInsertedInsertRelatorioOrdem
  Fetch Next From CrsInsertedInsertRelatorioOrdem Into
 
      @IdRelatorioOrdem,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdRelatorio,
      @NmRelatorioOrdem
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2, Pk3)
        Values (
          '0',
          @IdUsuario,
          'SQL Server',
          'Insert',
          'RelatorioOrdem',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdRelatorioOrdem,
          @IdRelatorio,
          @NmRelatorioOrdem
          )
 
  Fetch Next From CrsInsertedInsertRelatorioOrdem Into
 
      @IdRelatorioOrdem,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdRelatorio,
      @NmRelatorioOrdem
 
    End
  Close CrsInsertedInsertRelatorioOrdem
  DealLocate CrsInsertedInsertRelatorioOrdem
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_RelatorioOrdem                                                                       :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

/* VERSIONAMENTO */
If (Select Count(*) From Versao Where NrVersaoBd = '3.2.13.499') = 0
  Begin
    Insert Into Versao (NrVersaoBd, NrVersaoApp) Values ('3.2.13.499', '3.2.13.499')
  End	
Go