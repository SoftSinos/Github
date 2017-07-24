/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Function_FN_ConverteHorasPorMinutos                                                                        :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - JUNHO/2017                                                                           :
:                                                                                                            :
: Function Criada para Converter Horas em Minutos.                                                           :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
CREATE Function [dbo].[FN_ConverteHorasPorMinutos] (@Horas Varchar(8))
Returns Integer
Begin

  /*Informações Uteis
    Relacionamento das Horas Inicia as 00:00
    
    Select dbo.FN_ConverteHorasPorMinutos ('12:12') 
  */

  Declare @iMinutos Integer
  Declare @HrNegatica Varchar(1)
    
  Set @HrNegatica = SubString(@Horas, 1, 1)
  
  If @HrNegatica = '-'
    Begin
      Set @Horas = Replace(@Horas, ':', ':-') 
    End  
  
  Select 
    @iMinutos = (Convert(int, SubString(Convert(VarChar(10), @Horas), 1, 
                 CharIndex(':', Convert(VarChar(10), @Horas)) - 1)) * 60) + (Convert(int, SubString(Convert(VarChar(10), @Horas), 
                 CharIndex(':', Convert(VarChar(10), @Horas)) + 1, 
                 Len(Convert(VarChar(10), @Horas)) -  CharIndex(':', Convert(VarChar(10), @Horas)))))
 
  Return @iMinutos
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Function_FN_ConverteHorasPorMinutos                                                                        :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - JUNHO/2017                                                                           :
:                                                                                                            :
: Function Criada para Converter Horas em Minutos.                                                           :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Function_FN_ConverteMinutosPorHora                                                                         :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - JUNHO/2017                                                                           :
:                                                                                                            :
: Function Criada para Converter Minutos em Horas.                                                           :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
CREATE Function [dbo].[FN_ConverteMinutosPorHora] (@NrMinutosEntrada Integer)
Returns NVarchar(7)

  /*Informações Uteis

    Select dbo.FN_ConverteMinutosPorHora(1439)
  */

Begin
  Declare @iHoras   Integer
  Declare @iMinutos Decimal 
  Declare @sEdita   Varchar(7)

  If @NrMinutosEntrada = 1439
    Begin
	  Set @NrMinutosEntrada = @NrMinutosEntrada + (Select NmValor From Configuracao Where NmSigla = 'AMEJ') /*Para Fechar as 24h*/
	End
  Else If @NrMinutosEntrada = 1
    Begin
	  Set @NrMinutosEntrada = @NrMinutosEntrada - (Select NmValor From Configuracao Where NmSigla = 'AMEJ') /*Para Fechar as 24h*/
	End 
  
  Set @iHoras = Cast(Round(@NrMinutosEntrada/60, 0) As Integer)
  Set @iMinutos = @NrMinutosEntrada % 60
  
  Set @sEdita = Case Len(@iHoras)
                  When 0 Then '00'
                  When 1 Then '0' + Convert(NVarchar(1), @iHoras)
                  Else Convert(NVarchar(4),@iHoras)
                End
 
  If @iMinutos < 0
    Begin
      Set @iMinutos = (@iMinutos * -1)
      
      If @sEdita = '00'
        Begin
          Set @sEdita = '-00'
        End
    End   
 
  Set @sEdita = @sEdita + ':' + Case Len(@iMinutos)
                                  When 0 Then '00' 
                                  When 1 Then '0' + Convert(NVarchar(3), @iMinutos)    
                                  Else Convert(NVarchar(4), @iMinutos)      
                                 End 
   
Return @sEdita
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Function_FN_ConverteMinutosPorHora                                                                         :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - JUNHO/2017                                                                           :
:                                                                                                            :
: Function Criada para Converter Minutos em Horas.                                                           :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO