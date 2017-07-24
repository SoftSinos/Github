/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridAgenda                                                                                         :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.01.00 - JULHO/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as agendas dos profissionais                                                      :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER View [dbo].[VW_GridAgenda]
As
  /* Informações Uteis
  
  Select * From VW_GridAgenda

  */
  Select
    Agenda.*,
    Profissional.NmPessoa NmProfissional,
	Cliente.NmPessoa NmCliente,
	TipoServico.NmTpServico,
	Case
	  When Agenda.IdTpServico > 0 Then 'AGENDADO'
	  Else 'DISPONÍVEL'
    End StAgenda,
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
    Left Join TipoServico
	  On TipoServico.IdTpServico = Agenda.IdTpServico
    Left Join Usuario
	  On Usuario.IdUsuario = Agenda.IdUsuario
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridAgenda                                                                                         :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - JULHO/2017                                                                           :
: Versão: 01.00.00.01 - 15/06/2017 - RETIRADO O JOIN COM SERVIÇO, ONDE O MESMO ESTAVA TRAZENDO A INFORMAÇÃO  :
:									 DUPLICADA.                                                              :
: Versão: 01.00.01.00 - 18/06/2017 - ADICIONADO A CONDIÇÃO DE SNAGENDA, ONDE ESSA DIZ QUE SE A AGENDA ESTA OU:
:								 NÃO DISPONIVEL.                                                             :
:                                                                                                            :
: View criada para mostrar as agendas dos profissionais                                                      :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: PC_Agendar                                                                                                 :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.01.00 - JUNHO/2017                                                                           :
:                                                                                                            :
: Procedure criada para inserir agendas dos profissionais.                                                   :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER Procedure [dbo].[PC_Agendar](@IdEmpresaEntrada Integer, @IdEmpProfissionalEmpresa Integer, @IdProfissionalEntrada Integer, @NrAnoEntrada Varchar(255), @IdAgenda Integer, @TpChamadaClasse Varchar(255))
As
  /*Informações Uteis

  Exec PC_Agendar 1, 0, 0, '2018', 0, 'GeralProximoAAno'

  Exec PC_Agendar 1, 0, 0, '', 0, 'GeralAnoAtual'

  Exec PC_Agendar 1, 1, 3, '', 0, 'Profissional'

  Exec PC_Agendar 0, 1, 3, '', 0, 'DeletaProfissional'

  Exec PC_Agendar 1, 0, 0, '', 8321, 'DesfazerAgenda'

  Select * From Agenda

  Truncate Table Agenda

  */
Set NoCount On
	Declare @HrAberturaEmpresa Varchar(255)
	Declare @HrAbertura Varchar(255)
	Declare @NrTotalAtendimentos Integer
	Declare @HrIntervaloAtendimentos Varchar(255)
	Declare @HrAtendimento Varchar(255)
	Declare @Loop Integer
	Declare @LoopTemp Integer

	/*Chamada para debug*/
	Declare @Debug Bit
	Set @Debug = 0

	Set @LoopTemp = 0
	Set @HrAberturaEmpresa = (Select NmValor From Configuracao Where IdEmpresa = @IdEmpresaEntrada And NmSigla = 'HABR')
	Set @NrTotalAtendimentos = Cast((Select NmValor From Configuracao Where IdEmpresa = @IdEmpresaEntrada And NmSigla = 'NTTA') As Integer)
	Set @HrIntervaloAtendimentos = (Select NmValor From Configuracao Where IdEmpresa = @IdEmpresaEntrada And NmSigla = 'TIEA')

	Set @Loop = @NrTotalAtendimentos
	Set @HrAbertura = @HrAberturaEmpresa

	Declare @IdEmpProfissional Integer
	Declare @IdProfissional Integer
	Declare @IdPessoaTemp Integer
	Declare @DtAgenda Datetime


  If @TpChamadaClasse = 'GeralProximoAAno'
    Begin	
		Declare CrsInsertedPessoa Cursor For

		  Select
			Pessoa.IdEmpresa,
			Pessoa.IdPessoa
		  From Pessoa
		    Inner Join TipoPessoa
			  On TipoPessoa.IdTpPessoa = Pessoa.IdTpPessoa
		  Where TipoPessoa.SnFuncionario = 1

		Open CrsInsertedPessoa
		Fetch Next From CrsInsertedPessoa Into

			@IdEmpProfissional,
			@IdProfissional

		While @@Fetch_Status = 0 
		  Begin
			Declare CrsInsertedPessoaCalendario Cursor For
			
			/*Carrega o calendario*/
			Select
			  DtCadastro
			From VW_GridCalendario
			Where SnDiaUtil = 1
			  And NrAno = @NrAnoEntrada

			Open CrsInsertedPessoaCalendario
			Fetch Next From CrsInsertedPessoaCalendario Into

				@DtAgenda

			While @@Fetch_Status = 0
			  Begin
				While @LoopTemp <= @NrTotalAtendimentos
				  Begin
					If @LoopTemp = 0
					  Begin
						Set @HrAtendimento = dbo.FN_ConverteHorasPorMinutos(@HrAberturaEmpresa)
					  End
					Else
					  Begin 	   
						Set @HrAtendimento = Cast((Cast(dbo.FN_ConverteHorasPorMinutos(@HrAberturaEmpresa) As Integer) + Cast(dbo.FN_ConverteHorasPorMinutos(@HrIntervaloAtendimentos) As Integer)) As Varchar)
					  End

					  If (Select Count(*) From Agenda Where DtAgenda = @DtAgenda And HrAgenda = dbo.FN_ConverteMinutosPorHora(@HrAtendimento) And IdEmpProfissional = @IdEmpProfissional And IdProfissional = @IdProfissional) = 0
						Begin
						  Insert Into Agenda (IdEmpresa, IdUsuario, DtAgenda, HrAgenda, IdEmpProfissional, IdProfissional) Values (1, 0, @DtAgenda, dbo.FN_ConverteMinutosPorHora(@HrAtendimento), @IdEmpProfissional, @IdProfissional)
						End

						If @Debug = 1
						  Begin
							Print dbo.FN_RetornoDataHora(@DtAgenda, 'B') + ' - ' +  dbo.FN_ConverteMinutosPorHora(@HrAtendimento) + ' - ' + Cast(@IdProfissional As Varchar(255))
						  End

					  Set @LoopTemp = @LoopTemp + 1
					  Set @HrAberturaEmpresa = dbo.FN_ConverteMinutosPorHora(@HrAtendimento)
				  End

				/*Pula para o proximo profissional*/
				If @LoopTemp > @Loop
				  Begin
					Set @LoopTemp = 0
					Set @HrAberturaEmpresa = @HrAbertura
				  End

			Fetch Next From CrsInsertedPessoaCalendario Into

				@DtAgenda
			  End
			Close CrsInsertedPessoaCalendario
			DealLocate CrsInsertedPessoaCalendario

		Fetch Next From CrsInsertedPessoa Into

			@IdEmpProfissional,
			@IdProfissional
		  End
		Close CrsInsertedPessoa
		DealLocate CrsInsertedPessoa
	End	
  Else
  If @TpChamadaClasse = 'GeralAnoAtual'
    Begin	
		Declare CrsInsertedPessoa Cursor For

		  Select
			Pessoa.IdEmpresa,
			Pessoa.IdPessoa
		  From Pessoa
		    Inner Join TipoPessoa
			  On TipoPessoa.IdTpPessoa = Pessoa.IdTpPessoa
		  Where TipoPessoa.SnFuncionario = 1

		Open CrsInsertedPessoa
		Fetch Next From CrsInsertedPessoa Into

			@IdEmpProfissional,
			@IdProfissional

		While @@Fetch_Status = 0 
		  Begin
			Declare CrsInsertedPessoaCalendario Cursor For
			
			/*Carrega o calendario*/
			Select
			  DtCadastro
			From VW_GridCalendario
			Where SnDiaUtil = 1
			  And NrAno = (Select DatePart(YYYY, GetDate()))
			  And NrMes >= (Select DatePart(MM, GetDate()))
			  And NrDia >= (Select DatePart(DD, GetDate())) 

			Open CrsInsertedPessoaCalendario
			Fetch Next From CrsInsertedPessoaCalendario Into

				@DtAgenda

			While @@Fetch_Status = 0
			  Begin
				While @LoopTemp <= @NrTotalAtendimentos
				  Begin
					If @LoopTemp = 0
					  Begin
						Set @HrAtendimento = dbo.FN_ConverteHorasPorMinutos(@HrAberturaEmpresa)
					  End
					Else
					  Begin 	   
						Set @HrAtendimento = Cast((Cast(dbo.FN_ConverteHorasPorMinutos(@HrAberturaEmpresa) As Integer) + Cast(dbo.FN_ConverteHorasPorMinutos(@HrIntervaloAtendimentos) As Integer)) As Varchar)
					  End

					  If (Select Count(*) From Agenda Where DtAgenda = @DtAgenda And HrAgenda = dbo.FN_ConverteMinutosPorHora(@HrAtendimento) And IdEmpProfissional = @IdEmpProfissional And IdProfissional = @IdProfissional) = 0
						Begin
						  Insert Into Agenda (IdEmpresa, IdUsuario, DtAgenda, HrAgenda, IdEmpProfissional, IdProfissional) Values (1, 0, @DtAgenda, dbo.FN_ConverteMinutosPorHora(@HrAtendimento), @IdEmpProfissional, @IdProfissional)
						End

						If @Debug = 1
						  Begin
							Print dbo.FN_RetornoDataHora(@DtAgenda, 'B') + ' - ' +  dbo.FN_ConverteMinutosPorHora(@HrAtendimento) + ' - ' + Cast(@IdProfissional As Varchar(255))
						  End

					  Set @LoopTemp = @LoopTemp + 1
					  Set @HrAberturaEmpresa = dbo.FN_ConverteMinutosPorHora(@HrAtendimento)
				  End

				/*Pula para o proximo profissional*/
				If @LoopTemp > @Loop
				  Begin
					Set @LoopTemp = 0
					Set @HrAberturaEmpresa = @HrAbertura
				  End

			Fetch Next From CrsInsertedPessoaCalendario Into

				@DtAgenda
			  End
			Close CrsInsertedPessoaCalendario
			DealLocate CrsInsertedPessoaCalendario

		Fetch Next From CrsInsertedPessoa Into

			@IdEmpProfissional,
			@IdProfissional
		  End
		Close CrsInsertedPessoa
		DealLocate CrsInsertedPessoa
	End	
  Else
  If @TpChamadaClasse = 'Profissional'
    Begin	
		Declare CrsInsertedPessoa Cursor For

		  Select
			Pessoa.IdEmpresa,
			Pessoa.IdPessoa
		  From Pessoa
		    Inner Join TipoPessoa
			  On TipoPessoa.IdTpPessoa = Pessoa.IdTpPessoa
		  Where TipoPessoa.SnFuncionario = 1
		    And IdEmpresa = @IdEmpProfissionalEmpresa
			And Pessoa.IdPessoa = @IdProfissionalEntrada

		Open CrsInsertedPessoa
		Fetch Next From CrsInsertedPessoa Into

			@IdEmpProfissional,
			@IdProfissional

		While @@Fetch_Status = 0 
		  Begin
			Declare CrsInsertedPessoaCalendario Cursor For
			
			/*Carrega o calendario*/
			Select
			  DtCadastro
			From VW_GridCalendario
			Where SnDiaUtil = 1
			  And NrAno = (Select DatePart(YYYY, GetDate()))
			  And NrMes >= (Select DatePart(MM, GetDate()))
			  And NrDia >= (Select DatePart(DD, GetDate())) 

			Open CrsInsertedPessoaCalendario
			Fetch Next From CrsInsertedPessoaCalendario Into

				@DtAgenda

			While @@Fetch_Status = 0
			  Begin
				While @LoopTemp <= @NrTotalAtendimentos
				  Begin
					If @LoopTemp = 0
					  Begin
						Set @HrAtendimento = dbo.FN_ConverteHorasPorMinutos(@HrAberturaEmpresa)
					  End
					Else
					  Begin 	   
						Set @HrAtendimento = Cast((Cast(dbo.FN_ConverteHorasPorMinutos(@HrAberturaEmpresa) As Integer) + Cast(dbo.FN_ConverteHorasPorMinutos(@HrIntervaloAtendimentos) As Integer)) As Varchar)
					  End

					  If (Select Count(*) From Agenda Where DtAgenda = @DtAgenda And HrAgenda = dbo.FN_ConverteMinutosPorHora(@HrAtendimento) And IdEmpProfissional = @IdEmpProfissional And IdProfissional = @IdProfissional) = 0
						Begin
						  Insert Into Agenda (IdEmpresa, IdUsuario, DtAgenda, HrAgenda, IdEmpProfissional, IdProfissional) Values (1, 0, @DtAgenda, dbo.FN_ConverteMinutosPorHora(@HrAtendimento), @IdEmpProfissional, @IdProfissional)
						End

						If @Debug = 1
						  Begin
							Print dbo.FN_RetornoDataHora(@DtAgenda, 'B') + ' - ' +  dbo.FN_ConverteMinutosPorHora(@HrAtendimento) + ' - ' + Cast(@IdProfissional As Varchar(255))
						  End

					  Set @LoopTemp = @LoopTemp + 1
					  Set @HrAberturaEmpresa = dbo.FN_ConverteMinutosPorHora(@HrAtendimento)
				  End

				/*Pula para o proximo profissional*/
				If @LoopTemp > @Loop
				  Begin
					Set @LoopTemp = 0
					Set @HrAberturaEmpresa = @HrAbertura
				  End

			Fetch Next From CrsInsertedPessoaCalendario Into

				@DtAgenda
			  End
			Close CrsInsertedPessoaCalendario
			DealLocate CrsInsertedPessoaCalendario

		Fetch Next From CrsInsertedPessoa Into

			@IdEmpProfissional,
			@IdProfissional
		  End
		Close CrsInsertedPessoa
		DealLocate CrsInsertedPessoa
	End
  Else
  If @TpChamadaClasse = 'DeletaProfissional'
    Begin
	  Delete Agenda
	  Where IdEmpProfissional = @IdEmpProfissionalEmpresa
	    And IdProfissional = @IdProfissionalEntrada
	    And SnRealizada = 0
		And DtAgenda > (Select DtFinalMes From Calendario Where DtCadastro = dbo.FN_RetornoDataHora(GetDate(), 'A'))
    End	  	 
  Else
  If @TpChamadaClasse = 'DesfazerAgenda'
    Begin
	  Update Agenda
	    Set IdEmpCliente = Null,
		  IdCliente = Null,
		  IdTpServico = Null
      Where IdAgenda = @IdAgenda
	    And IdEmpresa = @IdEmpresaEntrada
    End	  	 

Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: PC_Agendar                                                                                                 :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - JUNHO/2017                                                                           :
: Versão: 01.00.01.00 - 18/06/2017 - CRIADO A CONDIÇÃO DE DESFAZER UM DETERMINADO AGENDAMENTO.               :
:                                                                                                            :
: Procedure criada para inserir agendas dos profissionais.                                                   :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
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
  Where NrVersaoBd = '3.0.5.0'  /*<<<<---- SEMPRE INFORMAR O SCRIPT ANTERIOAR*/
 
  /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>INICIO LEITURA DE HISTÓRICO<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/
  Set @NrVersaoBd = '3.0.6.0'
  Set @NrVersaoApp = '3.0.6.420'
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
End;