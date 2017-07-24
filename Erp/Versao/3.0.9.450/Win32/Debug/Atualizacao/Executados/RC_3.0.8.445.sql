/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridServico                                                                                        :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as Servico do Sistema                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER View [dbo].[VW_GridServico]
As
  /* Informações Uteis
  
  Select * From VW_GridServico

  */
  Select Distinct
    Servico.*,
	Empresa.NmFantasia + ' - ' + Empresa.NmRazaoSocial NmFantasiaNmRazaoSocial,
	TipoServico.NmTpServico,
	TipoServico.VlServico,
	TipoServico.HrServico,
	Cast(Pessoa.IdEmpresa As Varchar(255)) + ' - ' + Cast(Pessoa.IdPessoa As Varchar(255)) + ' - ' + Pessoa.NmPessoa As NmProfissional,
	GrupoServico.NmGrupoServico,
	Case
	  When Pessoa.IdUsuario = 0 Then 'SOFTSINOS'
	  Else Usuario.NmLogin
    End As NmUsuarioCadastro
  From Servico
    Inner Join TipoServico
	  On TipoServico.IdTpServico = Servico.IdTpServico
    Inner Join GrupoServico
	  On GrupoServico.IdGrupoServico = TipoServico.IdGrupoServico
    Inner Join Pessoa
	  On Pessoa.IdPessoa = Servico.IdProfissional
	    And Pessoa.IdEmpresa = Servico.IdEmpProfissional
    Inner Join Empresa
	  On Empresa.IdEmpresa = Pessoa.IdEmpresa
   Left Join Usuario
	  On Usuario.IdUsuario = Servico.IdUsuario
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridServico                                                                                        :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as Servico do Sistema                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridEmpresa                                                                                        :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.01 - JUNHO/2017                                                                           :
:                                                                                                            :
: View Criada para Mostrar os Dados da Grid de Empresa.                                                      :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Alter View [dbo].[VW_GridEmpresa]
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
:                                                                                                            :
: View Criada para Mostrar os Dados da Grid de Empresa.                                                      :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*HISTÓRICO DE VERSÕES - BANCO DE DADOS.*/
Begin
  Declare @StSequenciaScript Integer
  Declare @StScriptRodado Integer
  Declare @NrVersaoBd Varchar(255) 
  Declare @NrVersaoApp Varchar(255)
  
  Select 
    @StSequenciaScript = Count(*) 
  From Versao
  Where NrVersaoBd = '3.0.7.0'  /*<<<<---- SEMPRE INFORMAR O SCRIPT ANTERIOAR*/
 
  /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>INICIO LEITURA DE HISTÓRICO<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/
  Set @NrVersaoBd = '3.0.8.445'
  Set @NrVersaoApp = '3.0.8.445'
  /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>FINAL LEITURA DE HISTÓRICO<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/

  If @StSequenciaScript > 0
    Begin
      Select
        @StScriptRodado = Count(*)
      From Versao
      Where NrVersaoBd = @NrVersaoBd

      If @StScriptRodado = 0
        Begin        
          Insert Into Versao (NrVersaoBd, NrVersaoApp) Values (@NrVersaoBd, @NrVersaoApp)
        End
      Else
       Select 'Script ATUAL Já Rodado, Versão: ' + @NrVersaoBd + '.'  
     End
  Else
    Select 'Script ANTERIOR da Versão: ' + @NrVersaoBd + ' NÃO FOI RODADO, RODE O MESMO E DEPOIS RODE NOVAMENTE ESTE.'  
End
GO