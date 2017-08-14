/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Function_FN_AtendimentoProfissionaisDia                                                                    :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.01 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Function criada para mostrar o número de atendimento dia de cada profissional.                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER Function [dbo].[FN_AtendimentoProfissionaisDia] (@DtAgendaEntrada Date,  @TpChamadaClasse Varchar(255))
Returns Integer
Begin

  /*Informações Uteis
  
  Select dbo.FN_AtendimentoProfissionaisDia('2017-08-11', 'Atendimento') 
  Select dbo.FN_AtendimentoProfissionaisDia('2017-06-12', 'Profissional') 
  */
  Declare @Valor1 Integer
  Declare @Valor2 Integer
  Declare @Resultado Integer  
    Declare @ExisteAgenda Integer 

  Select
	@ExisteAgenda = Count(1) 
  From VW_GridAgenda Where DtAgenda = @DtAgendaEntrada

  If @ExisteAgenda > 0
    Begin
	  If @TpChamadaClasse = 'Atendimento'
		Begin
		  Select
		    @Valor1 = Count(1) / IsNull(Count(Distinct IdProfissional), -1) 
		  From VW_GridAgenda 
		  Where DtAgenda = @DtAgendaEntrada
		    And IdAgendaEncaixe = 0

		  Select 
		    @Valor2 = Case 
			            When (Count(*) = 0) And (Count(Distinct IdProfissional) = 0) Then 1
			            Else Count(1) / IsNull(Count(Distinct IdProfissional), -1)
                      End 
		  From VW_GridAgenda 
		  Where DtAgenda = @DtAgendaEntrada
		    And IdAgendaEncaixe = 1 

		  Set @Resultado = @Valor1 + @Valor2
		End
	  Else
	  If @TpChamadaClasse = 'Profissional'
		Begin
		  Select
		   @Valor1 = Count(Distinct IdProfissional) 
		  From VW_GridAgenda Where DtAgenda = @DtAgendaEntrada

		  Set @Resultado = @Valor1 
		End
    End
  Else
    Begin
	  Set @Resultado = 0
	End	     

  Return @Resultado
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Function_FN_AtendimentoProfissionaisDia                                                                    :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
: Versão: 01.00.00.01 - 11/08/2017 - CORREÇÃO EM RELAÇÃO AO CALCULO DOS ENCAIXAS DA AGENDA                   :
:                                                                                                            :
: Function criada para mostrar o número de atendimento dia de cada profissional.                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/* VERSIONAMENTO */
If (Select Count(*) From Versao Where NrVersaoBd = '3.3.14.504') = 0
  Begin
    Insert Into Versao (NrVersaoBd, NrVersaoApp) Values ('3.3.14.499', '3.3.14.504')
  End	
Go