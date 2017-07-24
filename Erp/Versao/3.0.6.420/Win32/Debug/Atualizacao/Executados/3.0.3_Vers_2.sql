/*HIST�RICO DE VERS�ES - BANCO DE DADOS.*/
Begin
  Declare @StSequenciaScript Integer
  Declare @StScriptRodado Integer
  Declare @NrVersaoBd Varchar(255) 
  Declare @NrVersaoApp Varchar(255)
  
  Select 
    @StSequenciaScript = Count(*) 
  From Versao
  Where NrVersaoBd = '3.0.1.0'  /*<<<<---- SEMPRE INFORMAR O SCRIPT ANTERIOAR*/
 
  /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>INICIO LEITURA DE HIST�RICO<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/
  Set @NrVersaoBd = '3.0.2.0'
  Set @NrVersaoApp = '3.0.2.XXX'
  /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>FINAL LEITURA DE HIST�RICO<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/

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
       Select 'Script ATUAL J� Rodado, Vers�o: ' + @NrVersaoBd + '.'  
     End
  Else
    Select 'Script ANTERIOR da Vers�o: ' + @NrVersaoBd + ' N�O FOI RODADO, RODE O MESMO E DEPOIS RODE NOVAMENTE ESTE.'  
End;