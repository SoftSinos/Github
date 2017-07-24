/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridPessoa                                                                                         :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
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
	  On Usuario.IdUsuario = Empresa.IdUsuario
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
:                                                                                                            :
: View criada para mostrar as Pessoa do Sistema                                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/












GO


