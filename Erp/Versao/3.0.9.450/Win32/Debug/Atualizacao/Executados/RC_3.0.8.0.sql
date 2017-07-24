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
	Empresa.NmFantasia + ' - ' + Empresa.NmRazaoSocial As NmRazaoSocialNmFantasia,
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


