USE [SoftSinosERP]
GO

/****** Object:  View [dbo].[VW_GridServico]    Script Date: 06/06/2017 09:30:26 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




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
	TipoServico.NmTpServico,
	TipoServico.VlServico,
	TipoServico.HrServico,
	Pessoa.NmPessoa As NmProfissional,
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


