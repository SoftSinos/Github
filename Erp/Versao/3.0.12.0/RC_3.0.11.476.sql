/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Configuracao                                                                                  :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: VersÃ£o: 01.00.02.01 - JUNHO/2017                                                                          : 
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
    If (Select Count(*) From Sys.DataBases Where Name = 'CargaInicial') > 0
	  Begin
        Alter Table Cep Disable Trigger All

		If (Select Count(*) From Cep) = 0
		  Begin
		    Insert Into Cep (NrCep, NmTpLogradouro, NmLogradouro, NmBairro, IdCidade)
		    Select NrCep, Upper(NmTpLogradouro), Upper(NmLogradouro), Upper(NmBairro), IdCidade  From CargaInicial.dbo.Cep Order By NrCep
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
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelCurvaMelhoresClientes', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelCurvaMelhoresProfissionais', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelCurvaMelhoresServicos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelCurvaMelhoresProdutos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelFechamentoCaixa', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelFaturamentoPeriodo', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelComissaoProfissionais', 'Full');

      End
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Configuracao                                                                                  :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: VersÃ£o: 01.00.00.00 - ABRIL/2017                                                                          :
: VersÃ£o: 01.00.01.00 - 18/06/2017 - ADICIONADO NOVOS MENUS DE ACESSO.                                      : 
: VersÃ£o: 01.00.02.00 - 29/06/2017 - ADICIONADO A NOVA LOGO MARCA DA SOFTHOUSE.                             : 
: VersÃ£o: 01.00.02.01 - 12/07/2017 - AJUSTE NA CHAMADA A LOGO MARCA DA SOFTHOUSE.                           : 
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

Delete SoftHouse
Go

If (Select Count(*) From SoftHouse) = 0
  Begin
	Insert Into SoftHouse (NmLogoTipo) Values ((Select * From OPENROWSET(BULK N'D:\SginERP\Imagem\Sistema\Logo.jpg', SINGLE_BLOB) AS Imagem ))
  End
Go

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
:                                                                                                            :
: View criada para mostrar as Nota do Sistema                                                                :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

If (Select Count(*) From SysObjects Where Name = 'FN_ValoresNotaItem' And Type = 'FN') > 0
  Begin
    Drop Function FN_ValoresNotaItem 
  End 
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Function_FN_ValoresNotaItem                                                                                :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - JULHO/2017                                                                           :
:                                                                                                            :
: Function criado para retornar o valor total dos itens da nota, por produto ou serviço.                     :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Create Function [dbo].[FN_ValoresNotaItem] (@IdNotaEntrada Integer, @TpChamadaClasse Varchar(255))
Returns Decimal(10,2)
Begin

  /*Informações Uteis
  Select * From NotaItem
  
  Select dbo.FN_ValoresNotaItem(1, 'Servico') 
  */
  Declare @Valor Decimal(10,2) 

  If @TpChamadaClasse = 'Produto'
    Begin
	  Select
	    @Valor = IsNull(Sum(VlProduto * QtdNotaItem), 0)
      From NotaItem
	  Where SnSituacao = 1 
	    And IdNota = @IdNotaEntrada
	    And IdProduto > 0
	End
  Else
  If @TpChamadaClasse = 'Servico'
    Begin
	  Select
	    @Valor = IsNull(Sum(VlServico * QtdNotaItem), 0)
      From NotaItem
	  Where SnSituacao = 1 
	    And IdNota = @IdNotaEntrada
	    And IdServico > 0
	End

  Return @Valor
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Function_FN_ValoresNotaItem                                                                                :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - JULHO/2017                                                                           :
:                                                                                                            :
: Function criado para retornar o valor total dos itens da nota, por produto ou serviço.                     :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_FastCurvaConsumoCliente                                                                       :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.01 - JULHO/2017                                                                           :
:                                                                                                            :
: Procedure criada para mostrar a curva de consumo do cliente                                                :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Alter Procedure [dbo].[PC_FastCurvaConsumoCliente](@IdEmpresaEntrada Integer, @DtInicioEntrada Datetime, @DtFinalEntrada DateTime, @TpChamadaClasse Varchar(255))
As
  /* Informações Uteis
  
  Exec PC_FastCurvaConsumoCliente 1, '2017/01/01', '2017/12/31', 'Periodo'

  */
  If @TpChamadaClasse = 'Periodo'
    Begin	
		Select
		  Nota.IdEmpresa,
		  Empresa.NmFantasia + ' - ' + Empresa.NmRazaoSocial NmFantasiaNmRazaoSocial,
		  Nota.IdEmpCliente,
		  Nota.IdCliente,
		  Pessoa.NmPessoa As NmCliente,
		  Pessoa.DtNascimento,
		  Pessoa.NmEmail,
		  Pessoa.NmFacebook,
		  Pessoa.NrCelular,
		  Pessoa.NrWhatsApp,
		  Count(Distinct Nota.IdNota) QtdNotas,
		  Sum(Nota.VlNota) VlNotas,
		  dbo.FN_ValoresNotaItem(Nota.IdNota, 'Produto') As VlProdutos,
		  dbo.FN_ValoresNotaItem(Nota.IdNota, 'Servico') As VlServicos,
		  IsNull((Select Sum(NotaPagamento.VlPagamento) From NotaPagamento Where NotaPagamento.IdEmpresa = Nota.IdEmpresa And NotaPagamento.IdNota = Nota.IdNota), 0) As VlPagamentos,
		  Cast(Sum(Nota.VlNota) / Count(Distinct Nota.IdNota) As Decimal(10,2)) As TkVlNotas,
		  Cast(dbo.FN_ValoresNotaItem(Nota.IdNota, 'Produto') / Count(Distinct Nota.IdNota) As Decimal(10,2)) As TkVlProdutos,
		  Cast(dbo.FN_ValoresNotaItem(Nota.IdNota, 'Produto') / Count(Distinct Nota.IdNota) As Decimal(10,2)) As TkVlServicos,
		  (Select Count(*) From Agenda Where Agenda.IdEmpCliente = Nota.IdEmpCliente And Agenda.IdCliente = Nota.IdCliente And Agenda.SnRealizada = 1) QtdAgdRealizadas,
		  (Select Case When Count(*) = 0 Then 1 Else Count(*) End From Agenda Where Agenda.IdEmpCliente = Nota.IdEmpCliente And Agenda.IdCliente = Nota.IdCliente And Agenda.SnRealizada = 1) / (Select Month(GetDate())) TkAgdRealizadas,
		  (Select Count(*) From Agenda Where Agenda.IdEmpCliente = Nota.IdEmpCliente And Agenda.IdCliente = Nota.IdCliente And Agenda.SnRealizada = 0 And Agenda.DtAgenda <= (Select dbo.FN_RetornoDataHora(GetDate() - 1, 'A'))) QtdAgdCanceladas,
		  @DtInicioEntrada DtInicioEntrada,
		  @DtFinalEntrada DtFinalEntrada 
		From Nota
		  Inner Join Pessoa
			On Pessoa.IdPessoa = Nota.IdCliente
		  Inner Join Empresa
			On Empresa.IdEmpresa = Nota.IdEmpresa
        Where Nota.IdEmpresa = @IdEmpresaEntrada
		  And Nota.DtCadastro Between @DtInicioEntrada And @DtFinalEntrada
		  And Nota.SnSituacao = 1
		Group By
		  Nota.IdEmpresa,
		  Nota.IdNota,
		  Empresa.NmFantasia,
		  Empresa.NmRazaoSocial,
		  Nota.IdEmpCliente,
		  Nota.IdCliente,
		  Pessoa.NmPessoa,
		  Pessoa.DtNascimento,
		  Pessoa.NmEmail,
		  Pessoa.NmFacebook,
		  Pessoa.NrCelular,
		  Pessoa.NrWhatsApp
        Order By
		  Count(Distinct Nota.IdNota)
	End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_FastCurvaConsumoCliente                                                                            :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - JULHO/2017                                                                           :
: Versão: 01.00.00.01 - 12/07/2017 - AJUSTADO A ORIGEM DOS VALORES DE TOTAL DE PRODUTOS E DE SERVIÇOS        :
:                                                                                                            :
: View criada para mostrar a curva de consumo do cliente                                                     :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

If Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysObjects.Name='RelatorioOrdem')
  Begin                   
    DROP TABLE [dbo].[RelatorioOrdem]
  End
Go

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysObjects.Name='RelatorioOrdem')
  Begin                   
		CREATE TABLE [dbo].[RelatorioOrdem](
			[IdRelatorioOrdem] [int] Identity(1, 1) NOT NULL,
			[IdUsuario] [int] NOT NULL,
			[DtCadastro] [datetime] NOT NULL,
			[SnSituacao] [bit] NOT NULL,
			[IdRelatorio] [int] NOT NULL,
			[NmRelatorioOrdem] [varchar](255) NOT NULL,
		 CONSTRAINT [PK_RelatorioOrdem] PRIMARY KEY CLUSTERED 
		(
			[IdRelatorioOrdem] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		 CONSTRAINT [UN_RelatorioOrdem_NmArquivoRelatorioOrdem] UNIQUE NONCLUSTERED 
		(
			[IdRelatorio] ASC,
			[NmRelatorioOrdem] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		ALTER TABLE [dbo].[RelatorioOrdem] ADD  CONSTRAINT [DF_RelatorioOrdem_IdUsuario]  DEFAULT ((0)) FOR [IdUsuario]

		ALTER TABLE [dbo].[RelatorioOrdem] ADD  CONSTRAINT [DF_RelatorioOrdem_DtCadastro]  DEFAULT (getdate()) FOR [DtCadastro]

		ALTER TABLE [dbo].[RelatorioOrdem] ADD  CONSTRAINT [DF_RelatorioOrdem_SnSituacao]  DEFAULT ((1)) FOR [SnSituacao]

  End
Go

If Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysObjects.Name='Relatorio')
  Begin                   
    DROP TABLE [dbo].[Relatorio]
  End
Go

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysObjects.Name='Relatorio')
  Begin                   
		CREATE TABLE [dbo].[Relatorio](
			[IdRelatorio] [int] NOT NULL,
			[IdUsuario] [int] NOT NULL,
			[DtCadastro] [datetime] NOT NULL,
			[SnSituacao] [bit] NOT NULL,
			[NmTpRelatorio] [varchar](255) NOT NULL,
			[NmArquivoRelatorio] [varchar](255) NOT NULL,
			[NmRelatorio] [varchar](255) NOT NULL,
			[NmProcedure] [varchar](255) NOT NULL,
		 CONSTRAINT [PK_Relatorio] PRIMARY KEY CLUSTERED 
		(
			[IdRelatorio] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
		 CONSTRAINT [UN_Relatorio_NmArquivoRelatorio] UNIQUE NONCLUSTERED 
		(
			[NmArquivoRelatorio] ASC
		)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
		) ON [PRIMARY]

		ALTER TABLE [dbo].[Relatorio] ADD  CONSTRAINT [DF_Relatorio_IdUsuario]  DEFAULT ((0)) FOR [IdUsuario]

		ALTER TABLE [dbo].[Relatorio] ADD  CONSTRAINT [DF_Relatorio_DtCadastro]  DEFAULT (getdate()) FOR [DtCadastro]

		ALTER TABLE [dbo].[Relatorio] ADD  CONSTRAINT [DF_Relatorio_SnSituacao]  DEFAULT ((1)) FOR [SnSituacao]

		ALTER TABLE [dbo].[RelatorioOrdem]  WITH CHECK ADD  CONSTRAINT [FK_RelatorioOrdem_Relatorio] FOREIGN KEY([IdRelatorio])
		REFERENCES [dbo].[Relatorio] ([IdRelatorio])

		ALTER TABLE [dbo].[RelatorioOrdem] CHECK CONSTRAINT [FK_RelatorioOrdem_Relatorio]
  End
Go

  If (Select Count(*) From Relatorio Where NmArquivoRelatorio = 'RelImpCurvaABCCliente.fr3' ) = 0
    Begin
      Insert Into Relatorio(IdRelatorio, NmTpRelatorio, NmArquivoRelatorio, NmRelatorio, NmProcedure) Values (1, 'CLIENTE', 'RelImpCurvaABCCliente.fr3', 'CURVA ABC CLIENTES', 'FastCurvaABCCliente')
    End
Go

  If (Select Count(*) From RelatorioOrdem Where IdRelatorio = 1 And NmRelatorioOrdem = 'QtdNotas') = 0
    Begin
      Insert Into RelatorioOrdem (IdRelatorio, NmRelatorioOrdem) Values (1, 'QtdNotas')
    End
Go

  If (Select Count(*) From RelatorioOrdem Where IdRelatorio = 1 And NmRelatorioOrdem = 'VlNotas') = 0
    Begin
      Insert Into RelatorioOrdem (IdRelatorio, NmRelatorioOrdem) Values (1, 'VlNotas')
    End
Go

Update Licenca Set
  NmMenu = 'RelClientes'
Where NmMenu = 'RelCurvaMelhoresClientes'
Go

Update Licenca Set
  NmMenu = 'RelProfissionais'
Where NmMenu = 'RelCurvaMelhoresProfissionais'
Go

Update Licenca Set
  NmMenu = 'RelServicos'
Where NmMenu = 'RelCurvaMelhoresServicos'
Go

Update Licenca Set
  NmMenu = 'RelProdutos'
Where NmMenu = 'RelCurvaMelhoresProdutos'
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_FastCurvaProdutoProfissional                                                                  :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.01.00 - JULHO/2017                                                                           :
:                                                                                                            :
: Procedure criada para mostrar a curva de produto do profissional.                                          :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER Procedure [dbo].[PC_FastCurvaProdutoProfissional](@IdEmpresaEntrada Integer, @DtInicioEntrada Datetime, @DtFinalEntrada DateTime, @TpChamadaClasse Varchar(255))
As
  /* Informações Uteis
  
  Exec PC_FastCurvaProdutoProfissional 1, '2017/01/01', '2017/12/31', 'Periodo'

  */
  If @TpChamadaClasse = 'Periodo'
    Begin
		Select 
		  NotaItem.IdEmpresa,
		  Empresa.NmFantasia + ' - ' + Empresa.NmRazaoSocial NmFantasiaNmRazaoSocial,
		  NotaItem.IdEmpProfissional,
		  NotaItem.IdProfissional,
		  Pessoa.NmPessoa NmProfissional,
		  Count(Distinct NotaItem.IdNotaItem) QtdProdutos,
		  Produto.NmProduto + ' ' + Marca.NmMarca  NmProduto,
		  Cast(Sum(NotaItem.VlProduto * NotaItem.QtdNotaItem) As Decimal(10,2)) VlProdutos,
		  Cast(Cast(Sum(NotaItem.VlProduto * NotaItem.QtdNotaItem) As Decimal(10,2)) / Count(Distinct NotaItem.IdNotaItem) As Decimal(10,2)) TkVlProdutos,
		  @DtInicioEntrada DtInicioEntrada,
		  @DtFinalEntrada DtFinalEntrada
		From NotaItem
		  Inner Join Produto
		    On Produto.IdProduto = NotaItem.IdProduto
		  Inner Join Pessoa 
			On Pessoa.IdEmpresa = NotaItem.IdEmpProfissional
			  And Pessoa.IdPessoa = NotaItem.IdProfissional
		  Inner Join Empresa
			On Empresa.IdEmpresa = NotaItem.IdEmpresa
          Inner Join Marca
		    On Marca.IdMarca = Produto.IdMarca
		Where NotaItem.IdProduto > 0
		  And NotaItem.IdEmpresa = @IdEmpresaEntrada
		  And NotaItem.DtCadastro Between @DtInicioEntrada And @DtFinalEntrada
		  And NotaItem.SnSituacao = 1
		Group By
		  NotaItem.IdEmpresa,
		  NotaItem.IdEmpProfissional,
		  Empresa.NmFantasia,
		  Empresa.NmRazaoSocial,
		  NotaItem.IdProfissional,
		  Pessoa.NmPessoa,
		  Produto.NmProduto,
		  Marca.NmMarca
		Order By
		  Count(Distinct NotaItem.IdNotaItem) 
    End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_FastCurvaProdutoProfissional                                                                  :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - JULHO/2017                                                                           :
: Versão: 01.00.01.00 - 20/07/2017 - ADICIONADO AS DATAS DE ENTRAGA NA PROCEDURE. E A EMPRESA GERADORA DA IN-:
:                                    INFORMAÇÃO. ADIÇÃO DA MARCA DO PRODUTO.                                 : 
:                                                                                                            :
: Procedure criada para mostrar a curva de produto do profissional.                                          :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

  If (Select Count(*) From Relatorio Where NmArquivoRelatorio = 'RelImpCurvaABCProdutoProfissional.fr3' ) = 0
    Begin
      Insert Into Relatorio(IdRelatorio, NmTpRelatorio, NmArquivoRelatorio, NmRelatorio, NmProcedure) Values (2, 'PRODUTO', 'RelImpCurvaABCProdutoProfissional.fr3', 'CURVA ABC PRODUTOS', 'FastCurvaABCProfissional')
    End
Go

  If (Select Count(*) From RelatorioOrdem Where IdRelatorio = 2 And NmRelatorioOrdem = 'QtdProdutos') = 0
    Begin
      Insert Into RelatorioOrdem (IdRelatorio, NmRelatorioOrdem) Values (2, 'QtdProdutos')
    End
Go

  If (Select Count(*) From RelatorioOrdem Where IdRelatorio = 2 And NmRelatorioOrdem = 'VlProdutos') = 0
    Begin
      Insert Into RelatorioOrdem (IdRelatorio, NmRelatorioOrdem) Values (2, 'VlProdutos')
    End
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_FastCurvaServicoProfissional                                                                  :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.01.00 - JULHO/2017                                                                           :
:                                                                                                            :
: Procedure criada para mostrar a curva de serviço do profissional.                                          :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER Procedure [dbo].[PC_FastCurvaServicoProfissional](@IdEmpresaEntrada Integer, @DtInicioEntrada Datetime, @DtFinalEntrada DateTime, @TpChamadaClasse Varchar(255))
As
  /* Informações Uteis
  
  Exec PC_FastCurvaServicoProfissional 1, '2017/01/01', '2017/12/31', 'Periodo'

  */
  If @TpChamadaClasse = 'Periodo'
    Begin
		Select 
		  NotaItem.IdEmpresa,
		  Empresa.NmFantasia + ' - ' + Empresa.NmRazaoSocial NmFantasiaNmRazaoSocial,
		  NotaItem.IdEmpProfissional,
		  NotaItem.IdProfissional,
		  Pessoa.NmPessoa NmProfissional,
		  Count(Distinct NotaItem.IdNotaItem) QtdServicos,
		  TipoServico.NmTpServico,
		  Cast(Sum(NotaItem.VlServico * NotaItem.QtdNotaItem) As Decimal(10,2)) VlServicos,
		  Cast(Cast(Sum(NotaItem.VlServico * NotaItem.QtdNotaItem) As Decimal(10,2)) / Count(Distinct NotaItem.IdNotaItem) As Decimal(10,2)) TkVlServicos,
		  @DtInicioEntrada DtInicioEntrada,
		  @DtFinalEntrada DtFinalEntrada
		From NotaItem
		  Inner Join Servico
			On Servico.IdServico = NotaItem.IdServico
			  And Servico.IdEmpProfissional = NotaItem.IdEmpProfissional
			  And Servico.IdProfissional = NotaItem.IdProfissional
		  Inner Join TipoServico
			On TipoServico.IdTpServico = Servico.IdTpServico
		  Inner Join Pessoa 
			On Pessoa.IdEmpresa = NotaItem.IdEmpProfissional
			  And Pessoa.IdPessoa = NotaItem.IdProfissional
		  Inner Join Empresa
			On Empresa.IdEmpresa = NotaItem.IdEmpresa
		Where NotaItem.IdServico > 0
		  And NotaItem.IdEmpresa = @IdEmpresaEntrada
		  And NotaItem.DtCadastro Between @DtInicioEntrada And @DtFinalEntrada
		  And NotaItem.SnSituacao = 1
		Group By
		  NotaItem.IdEmpresa,
		  NotaItem.IdEmpProfissional,
		  Empresa.NmFantasia,
		  Empresa.NmRazaoSocial,
		  NotaItem.IdProfissional,
		  Pessoa.NmPessoa,
		  TipoServico.NmTpServico
		Order By
		  Count(Distinct NotaItem.IdNotaItem) 
    End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_FastCurvaServicoProfissional                                                                  :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - JULHO/2017                                                                           :
: Versão: 01.00.01.00 - 20/07/2017 - ADICIONADO AS DATAS DE ENTRAGA NA PROCEDURE. E A EMPRESA GERADORA DA IN-:
:                                    INFORMAÇÃO.                                                             : 
:                                                                                                            :
: Procedure criada para mostrar a curva de serviço do profissional.                                          :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

  If (Select Count(*) From Relatorio Where NmArquivoRelatorio = 'RelImpCurvaABCServicoProfissional.fr3' ) = 0
    Begin
      Insert Into Relatorio(IdRelatorio, NmTpRelatorio, NmArquivoRelatorio, NmRelatorio, NmProcedure) Values (3, 'SERVICO', 'RelImpCurvaABCServicoProfissional.fr3', 'CURVA ABC SERVICOS', 'FastCurvaABCProfissional')
    End
Go

  If (Select Count(*) From RelatorioOrdem Where IdRelatorio = 3 And NmRelatorioOrdem = 'QtdServicos') = 0
    Begin
      Insert Into RelatorioOrdem (IdRelatorio, NmRelatorioOrdem) Values (3, 'QtdServicos')
    End
Go

  If (Select Count(*) From RelatorioOrdem Where IdRelatorio = 3 And NmRelatorioOrdem = 'VlServicos') = 0
    Begin
      Insert Into RelatorioOrdem (IdRelatorio, NmRelatorioOrdem) Values (3, 'VlServicos')
    End
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_FastCurvaTipoPagamento                                                                        :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.01.00 - JULHO/2017                                                                           :
:                                                                                                            :
: Procedure criada para mostrar a fechamento financeiro.                                                     :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER Procedure [dbo].[PC_FastCurvaTipoPagamento](@IdEmpresaEntrada Integer, @DtInicioEntrada Datetime, @DtFinalEntrada DateTime, @TpChamadaClasse Varchar(255))
As
  /* Informações Uteis
  
  Exec PC_FastCurvaTipoPagamento 1, '2017/01/01', '2017/12/31', 'Periodo'
  
  */
  If @TpChamadaClasse = 'Periodo'
    Begin
		Select
		  NotaPagamento.IdEmpresa,
		  Empresa.NmFantasia + ' - ' + Empresa.NmRazaoSocial NmFantasiaNmRazaoSocial,
		  TipoPagamento.IdTpPagamento,
		  TipoPagamento.NmTpPagamento,
		  Cast(dbo.FN_RetornoDataHora(NotaPagamento.DtCadastro, 'D') As DateTime) DtCadastro,
		  Cast(Sum(NotaPagamento.VlPagamento) As Decimal(10,2)) VlPagamentos,
		  Cast((Select Sum(Nota.VlNota) From Nota Where Nota.SnSituacao = 1 And Convert(Varchar(12), Nota.DtCadastro, 111) = Convert(Varchar(12), NotaPagamento.DtCadastro, 111)) As Decimal(10,2)) VlNotas,
		  Cast((Sum(NotaPagamento.VlPagamento) * 100) / (Select Sum(Nota.VlNota) From Nota Where Nota.SnSituacao = 1 And Convert(Varchar(12), Nota.DtCadastro, 111) = Convert(Varchar(12), NotaPagamento.DtCadastro, 111)) As Decimal(10,2)) PcParticipacao,
		  @DtInicioEntrada DtInicioEntrada,
		  @DtFinalEntrada DtFinalEntrada
		From NotaPagamento
		  Inner Join TipoPagamento
			On TipoPagamento.IdTpPagamento = NotaPagamento.IdTpPagamento
		  Inner Join Empresa
			On Empresa.IdEmpresa = NotaPagamento.IdEmpresa
		Where NotaPagamento.IdEmpresa = @IdEmpresaEntrada
		  And NotaPagamento.DtCadastro Between @DtInicioEntrada And @DtFinalEntrada
		  And NotaPagamento.SnSituacao = 1
		Group By
		  NotaPagamento.IdEmpresa,
		  TipoPagamento.IdTpPagamento,
		  Empresa.NmFantasia,
		  Empresa.NmRazaoSocial,
		  TipoPagamento.NmTpPagamento,
		  NotaPagamento.DtCadastro
		Order By
		  Sum(NotaPagamento.VlPagamento) Desc,
		  TipoPagamento.NmTpPagamento  
    End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_FastCurvaTipoPagamento                                                                        :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - JULHO/2017                                                                           :
: Versão: 01.00.01.00 - 20/07/2017 - ADICIONADO AS DATAS DE ENTRAGA NA PROCEDURE. E A EMPRESA GERADORA DA IN-:
:                                    INFORMAÇÃO. AJUSTADO O FORMATO DA DATA.                                 : 
:                                                                                                            :
: Procedure criada para mostrar a fechamento financeiro.                                                     :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

  If (Select Count(*) From Relatorio Where NmArquivoRelatorio = 'RelImpCurvaABCTipoPagamento.fr3' ) = 0
    Begin
      Insert Into Relatorio(IdRelatorio, NmTpRelatorio, NmArquivoRelatorio, NmRelatorio, NmProcedure) Values (4, 'FINANCEIRO', 'RelImpCurvaABCTipoPagamento.fr3', 'CURVA ABC TIPOS DE PAGAMENTOS', 'FastCurvaABCTipoPagamento')
    End
Go

  If (Select Count(*) From RelatorioOrdem Where IdRelatorio = 4 And NmRelatorioOrdem = 'NmTpPagamento') = 0
    Begin
      Insert Into RelatorioOrdem (IdRelatorio, NmRelatorioOrdem) Values (4, 'NmTpPagamento')
    End
Go

  If (Select Count(*) From RelatorioOrdem Where IdRelatorio = 4 And NmRelatorioOrdem = 'VlPagamentos') = 0
    Begin
      Insert Into RelatorioOrdem (IdRelatorio, NmRelatorioOrdem) Values (4, 'VlPagamentos')
    End
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_FastComissaoServicoProfissional                                                               :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.01.00 - JULHO/2017                                                                           :
:                                                                                                            :
: Procedure criada para mostrar a comissao de serviço do profissional.                                       :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER Procedure [dbo].[PC_FastComissaoServicoProfissional](@IdEmpresaEntrada Integer, @DtInicioEntrada Datetime, @DtFinalEntrada DateTime, @TpChamadaClasse Varchar(255))
As
  /* Informações Uteis
  
  Exec PC_FastComissaoServicoProfissional 1, '2017/01/01', '2017/12/31', 'Periodo'

  */
  If @TpChamadaClasse = 'Periodo'
    Begin
	   Select 
		  NotaItem.IdEmpresa,
		  Empresa.NmFantasia + ' - ' + Empresa.NmRazaoSocial NmFantasiaNmRazaoSocial,
		  NotaItem.IdEmpProfissional,
		  NotaItem.IdProfissional,
		  Pessoa.NmPessoa NmProfissional,
		  TipoServico.NmTpServico,
		  Servico.PcComissao,
		  Cast(Sum(NotaItem.VlServico * NotaItem.QtdNotaItem) As Decimal(10,2)) VlServicos,
		  Cast((Sum(NotaItem.VlServico * NotaItem.QtdNotaItem) * Servico.PcComissao) / 100 As Decimal(10,2)) VlComissao,
		  @DtInicioEntrada DtInicioEntrada,
		  @DtFinalEntrada DtFinalEntrada
		From NotaItem
		  Inner Join Servico
			On Servico.IdServico = NotaItem.IdServico
			  And Servico.IdEmpProfissional = NotaItem.IdEmpProfissional
			  And Servico.IdProfissional = NotaItem.IdProfissional
		  Inner Join TipoServico
			On TipoServico.IdTpServico = Servico.IdTpServico
		  Inner Join Pessoa 
			On Pessoa.IdEmpresa = NotaItem.IdEmpProfissional
			  And Pessoa.IdPessoa = NotaItem.IdProfissional
		  Inner Join Empresa
			On Empresa.IdEmpresa = NotaItem.IdEmpresa
		Where NotaItem.IdServico > 0
		  And NotaItem.IdEmpresa = @IdEmpresaEntrada
		  And NotaItem.DtCadastro Between @DtInicioEntrada And @DtFinalEntrada
		  And NotaItem.SnSituacao = 1
		Group By
		  NotaItem.IdEmpresa,
		  NotaItem.IdEmpProfissional,
		  Empresa.NmFantasia,
		  Empresa.NmRazaoSocial,
		  NotaItem.IdProfissional,
		  Pessoa.NmPessoa,
		  TipoServico.NmTpServico,
		  Servico.PcComissao
    End		  		  
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_FastComissaoServicoProfissional                                                               :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - JULHO/2017                                                                           :
: Versão: 01.00.01.00 - 20/07/2017 - ADICIONADO AS DATAS DE ENTRAGA NA PROCEDURE. E A EMPRESA GERADORA DA IN-:
:                                    INFORMAÇÃO.                                                             : 
:                                                                                                            :
: Procedure criada para mostrar a comissao de serviço do profissional.                                       :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

  If (Select Count(*) From Relatorio Where NmArquivoRelatorio = 'RelImpComissaoServicoProfissional.fr3' ) = 0
    Begin
      Insert Into Relatorio(IdRelatorio, NmTpRelatorio, NmArquivoRelatorio, NmRelatorio, NmProcedure) Values (5, 'FINANCEIRO', 'RelImpComissaoServicoProfissional.fr3', 'COMISSÃO SERVIÇOS PROFISSIONAIS', 'FastComissaoProfissional')
    End
Go

  If (Select Count(*) From RelatorioOrdem Where IdRelatorio = 5 And NmRelatorioOrdem = 'NmProfissional') = 0
    Begin
      Insert Into RelatorioOrdem (IdRelatorio, NmRelatorioOrdem) Values (5, 'NmProfissional')
    End
Go

  If (Select Count(*) From RelatorioOrdem Where IdRelatorio = 5 And NmRelatorioOrdem = 'VlServicos') = 0
    Begin
      Insert Into RelatorioOrdem (IdRelatorio, NmRelatorioOrdem) Values (5, 'VlServicos')
    End
Go

Delete Licenca Where NmMenu = 'RelFaturamentoPeriodo'
Go

Delete Licenca Where NmMenu = 'RelComissoaProfissional'
Go

Delete Licenca Where NmMenu = 'RelProfissionais'
Go

Update Licenca Set
  NmMenu = 'RelFinanceiros'
Where NmMenu = 'RelFechamentoCaixa'
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Configuracao                                                                                  :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: VersÃ£o: 01.00.02.02 - JUNHO/2017                                                                          : 
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
    If (Select Count(*) From Sys.DataBases Where Name = 'CargaInicial') > 0
	  Begin
        Alter Table Cep Disable Trigger All

		If (Select Count(*) From Cep) = 0
		  Begin
		    Insert Into Cep (NrCep, NmTpLogradouro, NmLogradouro, NmBairro, IdCidade)
		    Select NrCep, Upper(NmTpLogradouro), Upper(NmLogradouro), Upper(NmBairro), IdCidade  From CargaInicial.dbo.Cep Order By NrCep
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
: Versão: 01.00.02.01 - 20/07/2017 - RETIRADO MENUS DESNECESSARIOS.                                          : 
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/* VERSIONAMENTO */
If (Select Count(*) From Versao Where NrVersaoBd = '3.0.11.476') = 0
  Begin
    Insert Into Versao (NrVersaoBd, NrVersaoApp) Values ('3.0.11.476', '3.0.11.476')
  End	
Go