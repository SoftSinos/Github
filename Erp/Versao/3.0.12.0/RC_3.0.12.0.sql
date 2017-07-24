/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridNota                                                                                           :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.01 - JULHO/2017                                                                           :
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
	Cast(IsNull((Select Sum(NotaItem.VlProduto * NotaItem.QtdNotaItem) From NotaItem Where NotaItem.IdEmpresa = Nota.IdEmpresa And NotaItem.IdNota = Nota.IdNota), 0) As Decimal(10,2)) As VlTotalProduto,
	Cast(IsNull((Select Sum(NotaItem.VlServico * NotaItem.QtdNotaItem)  From NotaItem Where NotaItem.IdEmpresa = Nota.IdEmpresa And NotaItem.IdNota = Nota.IdNota), 0) As Decimal(10,2)) As VlTotalServico,
	IsNull((Select Sum(NotaPagamento.VlPagamento) From NotaPagamento Where NotaPagamento.IdEmpresa = Nota.IdEmpresa And NotaPagamento.IdNota = Nota.IdNota), 0) As VlTotalPagamento,
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
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridNota                                                                                           :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
: Versão: 01.00.00.01 - 12/07/2017 - AJUSTE DOS SELECTS QUE GERAL O VALOR TOTAL DE PRODUTOS E SERVICOS.      :
: Versão: 01.00.01.00 - 24/07/2017 - ADIÇÃO NA RAZÃO SOCIAL DA EMPRESA.                                      :
:                                                                                                            :
: View criada para mostrar as Nota do Sistema                                                                :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

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
: Versão: 01.00.02.03 - 24/07/2017 - AJUSTE DO ALIAS DA BASE DE CARGA.                                       : 
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO


