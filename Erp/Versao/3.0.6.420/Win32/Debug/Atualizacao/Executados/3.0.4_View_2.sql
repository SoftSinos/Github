/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridAgenda                                                                                         :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - JULHO/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as agendas dos profissionais                                                      :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Create View [dbo].[VW_GridAgenda]
As
  /* Informações Uteis
  
  Select * From VW_GridMarca

  */
  Select
    Agenda.*,
    Profissional.NmPessoa NmProfissional,
	Cliente.NmPessoa NmCliente,
	TipoServico.NmTpServico,
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
    Left Join Servico
      On Servico.IdEmpProfissional = Agenda.IdEmpProfissional
	    And Servico.IdProfissional  = Agenda.IdProfissional
    Left Join TipoServico
	  On TipoServico.IdTpServico = Servico.IdTpServico
    Left Join Usuario
	  On Usuario.IdUsuario = Agenda.IdUsuario
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridAgenda                                                                                         :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - JULHO/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as agendas dos profissionais                                                      :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/