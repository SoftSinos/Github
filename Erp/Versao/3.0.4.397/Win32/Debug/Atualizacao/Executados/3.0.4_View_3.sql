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


