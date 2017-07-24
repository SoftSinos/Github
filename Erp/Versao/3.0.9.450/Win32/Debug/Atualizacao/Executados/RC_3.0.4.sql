If (Select Count(*) From SysObjects Where Name = 'FN_ConverteHorasPorMinutos' And Type = 'FN') > 0
  Begin
    Drop Function FN_ConverteHorasPorMinutos 
  End 
Go

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
Create Function [dbo].[FN_ConverteHorasPorMinutos] (@Horas Varchar(8))
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

If (Select Count(*) From SysObjects Where Name = 'FN_ConverteMinutosPorHora' And Type = 'FN') > 0
  Begin
    Drop Function FN_ConverteMinutosPorHora 
  End 
Go

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
Create Function [dbo].[FN_ConverteMinutosPorHora] (@NrMinutosEntrada Integer)
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

If (Select Count(*) From Licenca Where NmMenu = 'MenManManualSginERP') = 0
  Begin
    Insert Into Licenca (NmMenu, NmLicenca) Values ('MenManManualSginERP', 'Full')
  End
GO

If (Select Count(*) From Licenca Where NmMenu = 'MenComAgenda') = 0
  Begin
    Insert Into Licenca (NmMenu, NmLicenca) Values ('MenComAgenda', 'Full')
  End
GO

If (Select Count(*) From Licenca Where NmMenu = 'MenCadAgendaGeral') = 0
  Begin
    Insert Into Licenca (NmMenu, NmLicenca) Values ('MenCadAgendaGeral', 'Full')
  End
GO

If (Select Count(*) From SysObjects Where Name = 'PC_Agendar' And Type = 'P') > 0
  Begin
    Drop Procedure PC_Agendar 
  End 
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: PC_Agendar                                                                                                 :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - JUNHO/2017                                                                           :
:                                                                                                            :
: Procedure criada para inserir agendas dos profissionais.                                                   :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Procedure [dbo].[PC_Agendar](@IdEmpresaEntrada Integer, @IdEmpProfissionalEmpresa Integer, @IdProfissionalEntrada Integer, @NrAnoEntrada Varchar(255), @TpChamadaClasse Varchar(255))
As
  /*Informações Uteis

  Exec PC_Agendar 1, 0, 0, '2018', 'GeralProximoAAno'

  Exec PC_Agendar 1, 0, 0, '', 'GeralAnoAtual'

  Exec PC_Agendar 1, 1, 3, '', 'Profissional'

  Exec PC_Agendar 0, 1, 3, '', 'DeletaProfissional'

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
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: PC_Agendar                                                                                                 :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - JUNHO/2017                                                                           :
:                                                                                                            :
: Procedure criada para inserir agendas dos profissionais.                                                   :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
GO

If (Select Count(*) From SysObjects Where Name = 'FK_Agenda_Servico' And Type = 'F') > 0
  Begin
    ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [FK_Agenda_Servico]
  End 
Go

If (Select Count(*) From SysObjects Where Name = 'FK_Agenda_TipoServico' And Type = 'F') > 0
  Begin
    ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [FK_Agenda_TipoServico]
  End 
Go

If  Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysObjects.Name='Agenda')
  Begin                   
    ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [FK_Agenda_Pessoa_Profissional]
    ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [FK_Agenda_Pessoa_Cliente]
    ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [FK_Agenda_Empresa]
    ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [FK_Agenda_EmpCliente]
    ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [DF_Agenda_SnRealizada]
    ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [DF_Agenda_SnSituacao]
    ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [DF_Agenda_DtCadastro]
    ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [DF_Agenda_IdUsuario]

	DROP TABLE [dbo].[Agenda]
  End
go

CREATE TABLE [dbo].[Agenda](
	[IdAgenda] [int] IDENTITY(1, 1) NOT NULL,
	[IdEmpresa] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL,
	[DtCadastro] [datetime] NOT NULL,
	[SnSituacao] [bit] NOT NULL,
	[DtAgenda] [datetime] NOT NULL,
	[HrAgenda] [time](7) NOT NULL,
	[SnRealizada] [bit] NOT NULL,
	[IdEmpProfissional] [int] NULL,
	[IdProfissional] [int] NOT NULL,
	[IdTpServico] [int] NULL,
	[IdEmpCliente] [int] NULL,
	[IdCliente] [int] NULL,
 CONSTRAINT [PK_Agenda] PRIMARY KEY CLUSTERED 
(
	[IdAgenda] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY];

ALTER TABLE [dbo].[Agenda] ADD  CONSTRAINT [DF_Agenda_IdUsuario]  DEFAULT ((0)) FOR [IdUsuario];

ALTER TABLE [dbo].[Agenda] ADD  CONSTRAINT [DF_Agenda_DtCadastro]  DEFAULT (getdate()) FOR [DtCadastro];

ALTER TABLE [dbo].[Agenda] ADD  CONSTRAINT [DF_Agenda_SnSituacao]  DEFAULT ((1)) FOR [SnSituacao];

ALTER TABLE [dbo].[Agenda] ADD  CONSTRAINT [DF_Agenda_SnRealizada]  DEFAULT ((0)) FOR [SnRealizada];

ALTER TABLE [dbo].[Agenda]  WITH CHECK ADD  CONSTRAINT [FK_Agenda_EmpCliente] FOREIGN KEY([IdEmpCliente])
REFERENCES [dbo].[Empresa] ([IdEmpresa]);

ALTER TABLE [dbo].[Agenda] CHECK CONSTRAINT [FK_Agenda_EmpCliente];

ALTER TABLE [dbo].[Agenda]  WITH CHECK ADD  CONSTRAINT [FK_Agenda_Empresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresa] ([IdEmpresa]);

ALTER TABLE [dbo].[Agenda] CHECK CONSTRAINT [FK_Agenda_Empresa];

ALTER TABLE [dbo].[Agenda]  WITH CHECK ADD  CONSTRAINT [FK_Agenda_Pessoa_Cliente] FOREIGN KEY([IdCliente])
REFERENCES [dbo].[Pessoa] ([IdPessoa]);

ALTER TABLE [dbo].[Agenda] CHECK CONSTRAINT [FK_Agenda_Pessoa_Cliente];

ALTER TABLE [dbo].[Agenda]  WITH CHECK ADD  CONSTRAINT [FK_Agenda_Pessoa_Profissional] FOREIGN KEY([IdProfissional])
REFERENCES [dbo].[Pessoa] ([IdPessoa]);

ALTER TABLE [dbo].[Agenda] CHECK CONSTRAINT [FK_Agenda_Pessoa_Profissional];

ALTER TABLE [dbo].[Agenda]  WITH CHECK ADD  CONSTRAINT [FK_Agenda_TipoServico] FOREIGN KEY([IdTpServico])
REFERENCES [dbo].[TipoServico] ([IdTpServico]);

ALTER TABLE [dbo].[Agenda] CHECK CONSTRAINT [FK_Agenda_TipoServico];

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='IdEmpProfissional'
                 And SysObjects.Name='Servico')
  Begin                   
	Alter Table Servico Add IdEmpProfissional Integer
	
	Update Servico Set IdEmpProfissional = 1
	
	Alter Table Servico Alter Column IdEmpProfissional Integer Not Null;

	ALTER TABLE [dbo].[Servico]  WITH CHECK ADD  CONSTRAINT [FK_Servico_Empresa] FOREIGN KEY([IdEmpProfissional])
	REFERENCES [dbo].[Empresa] ([IdEmpresa])

	ALTER TABLE [dbo].[Servico] CHECK CONSTRAINT [FK_Servico_Empresa]
  End
Go

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='HrServico'
                 And SysObjects.Name='TipoServico')
  Begin                   
	Alter Table TipoServico Add HrServico Time Null

	Update TipoServico Set HrServico = '03:30'

	Alter Table TipoServico Alter Column HrServico Time Not Null

	ALTER TABLE [dbo].[TipoServico] ADD  CONSTRAINT [DF_TipoServico_HrServico]  DEFAULT ('00:00:00.0000000') FOR [HrServico]
  End
Go


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

If (Select Count(*) From SysObjects Where Name = 'VW_GridAgenda' And Type = 'V') > 0
  Begin
    Drop View VW_GridAgenda 
  End 
Go

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
:                                                                                                            :
: View criada para mostrar as agendas dos profissionais                                                      :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

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

If (Select Count(*) From Configuracao Where NmSigla = 'HABR') = 0
  Begin
    INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(1, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'HABR', N'AGENDA - HORÁRIO DE ABERTURA DA EMPRESA', N'09:00', 0)
  End
Go

If (Select Count(*) From Configuracao Where NmSigla = 'NTTA') = 0
  Begin
    INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(1, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'NTTA', N'AGENDA - NÚMERO TOTAL DE ATENDIMENTOS', N'25', 0)
  End
Go

If (Select Count(*) From Configuracao Where NmSigla = 'TIEA') = 0
  Begin
    INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(1, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'TIEA', N'AGENDA - TEMPO DE INTERVALO ENTRE ATENDIMENTOS', N'00:30', 0)
  End
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Configuracao                                                                                  :
: Criada Por: Clauber JÃºnio.                                                                                 :
:                                                                                                            :
: VersÃ£o: 01.00.00.00 - ABRIL/2017                                                                           : 
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ã‡ Ã• E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER Proc [dbo].[PC_Configuracao](@IdEmpresaEntrada Integer)
As
Set NoCount On
  /*InformaÃ§Ãµes Uteis
	Sempre sera iniciao para a IdEmpresa = 0

	Insert Into SoftHouse (NmLogoTipo) Values ((Select * From OPENROWSET(BULK N'D:\SoftSinos\Desenvolvimento\Imagem\Logo\Logo.jpg', SINGLE_BLOB) AS Imagem ))

	Exec PC_Configuracao 1
  */
Begin
    If (Select Count(*) From Sys.DataBases Where Name = 'CargaInicial') > 0
	  Begin
		If (Select Count(*) From Cep) = 0
		  Begin
		    Insert Into Cep (NrCep, NmTpLogradouro, NmLogradouro, NmBairro, IdCidade)
		    Select NrCep, Upper(NmTpLogradouro), Upper(NmLogradouro), Upper(NmBairro), IdCidade  From CargaInicial.dbo.Cep Order By NrCep
          End
	  End

	If (Select Count(*) From TipoPagamento) = 0
	  Begin
        Insert Into TipoPagamento([IdUsuario], [NmTpPagamento]) Values (0, 'DINHEIRO') 
        Insert Into TipoPagamento([IdUsuario], [NmTpPagamento]) Values (0, 'CREDITO') 
        Insert Into TipoPagamento([IdUsuario], [NmTpPagamento]) Values (0, 'DEBITO') 
      End	
	
	If (Select Count(*) From SoftHouse) = 0
	  Begin
        INSERT Into SoftHouse Values (0xFFD8FFE000104A46494600010101006000600000FFE100B24578696600004D4D002A000000080007013E00050000000200000062013F000500000006000000720301000500000001000000A20303000100000001000000005110000100000001010000005111000400000001000000005112000400000001000000000000000000007A26000186A000008084000186A00000FA00000186A0000080E8000186A000007530000186A00000EA60000186A000003A98000186A000001770000186A0000186A00000B18FFFDB0043000201010201010202020202020202030503030303030604040305070607070706070708090B0908080A0807070A0D0A0A0B0C0C0C0C07090E0F0D0C0E0B0C0C0CFFDB004301020202030303060303060C0807080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CFFC00011080200020003012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FDFCA28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28CD723F107E3E782FE15861E20F1368BA5C8BCF9335CAF9C7E918CB9FC056752B429C79AA349776EC7461F0B5B113F67420E52EC936FEE475D457CCFE35FF82AA7C34F0E164D3535DF10480E035B5A79319FC652A7FF001DAF2FF13FFC1616F65765D1BC136B0AF67BDD41A427FE0288BFFA1578788E29CAE8E92AA9FA5DFE4AC7D9E07C33E25C52BC30B28AFEF351FC24D3FC0FBA28CE2BF3735CFF0082ADFC4DD51DBECB078674D53D3C9B17723F1776FE55CBEA7FF051BF8C1A974F152DB8F4874EB65FFDA66BCBA9C779747E1527E897EAD1F4B43C13E209EB39538FAC9FE9167EA5EEA4DC07715F93F71FB767C5AB93F378E3551FEE2449FC905566FDB63E2B37FCCF5AF7E1281FD2B9DF1FE0FA5397E1FE67747C0BCDFAD7A7FF00937FF227EB4EE07B8A5DD5F92ABFB6CFC5643FF23D6BDF8CAA7FA55AB7FDBB7E2DDB1F97C6FAA9FF007D227FE68685C7F83EB4E5F87F984BC0BCDFA57A7FF937FF00227EB0673457E5AE99FF00051DF8C1A69F9BC52B743D27D3AD9B3F9462BA8D0FFE0AB9F1334C75FB55BF8675151D7CDB278C9FC5241FCABA29F1DE5D2F89497AA5FA3670D7F04F8821F04A9CBD24FF0058A3F48A8AF863C2FF00F0585BB8D9575AF04DBCC3F8A4B2D41A3C7D15D1BFF42AF51F057FC154BE19F88CA26A4BAE787E46E19AE6D3CE8C7FC0A22C7FF1D15EA61F8A72BADA46AA5EB75F9A48F99C77869C4B855CD3C2CA4BFBAD4BF08B6FF03E96A2B93F87FF001DBC1BF15117FE11EF1368DAB48DCF9505D2F9C3EB19C38FC457599AF729D58548F35369AEE9DCF8CC4616B509FB3AF07192E8D34FEE6145145686014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014515F3EFED53FF000504F0D7ECFC6E349D2C47E22F152655AD639316F64DFF004D9C771FDC5F9BD76E41AE4C663A861293AD88928C7FADBBB3D4C9F25C6E6988585C053739BEDD1776F64BCDE87BA788BC4BA7F847479F50D52FAD34EB1B65DD2DC5CCAB14518F766200AF973E377FC156BC2FE1069ACFC1BA7CDE26BC5CAFDAE6CDBD929F5191BE4FC0283D9ABE2AF8D3FB43F8BBE3FEB7F6CF136AD35DAA31682D13F776B6BED1C6381E993963DC9AE26BF35CD38EABD46E1815CABBBD5FDDB2FC4FE8AE19F05705412AD9CCFDACFF00962DA82F57A4A5FF0092AF267AEFC58FDB9BE267C5E6963BDF115C69B632F1F62D2FFD12103D0953BD87FBCC6BC92599A6919D999998E4B13924FD69B8CD755F0EFE0778BFE2CCFB3C39E1CD5B565CE0CB05B9F250FF00B521C22FE2457C654AD89C654F7DCA727EAD9FAF61F0B9765587B528C28D35BDAD15F37A7DECE568AFA83C09FF0004A3F887E23549358BCD0FC3D1B01B9249CDCCEBFF00018C15FF00C7EBD67C29FF000480F0EDA043AD78BB59BE6FE25B3B68ED57F36F30D7AD87E14CD2B2BAA4D2F3697E0F5FC0F95CC3C4EE1AC23E5962549F68272FC52E5FC4F81A8C1AFD39D0BFE098BF09748DBE7E95AA6A9B7BDD6A528CFD446505757A6FEC35F09B4AC795E07D1DB1FF003DBCC9BFF43635EB53E02C7BF8E715F36FF43E5F11E38649076A54AA4BE514BFF4ABFE07E4DF4A315FAF96FF00B28FC33B51F2780BC23E9CE97137F35AB11FECCFF0EE2FBBE05F088FFB84C1FF00C4D742F0FF0013D6AC7EE6704BC76CBFA61A7F7C4FC7BC51D6BF611FF667F87727DEF02F844FFDC260FF00E26AB5C7ECA1F0CEE47CFE02F097E1A5C4A7F4143F0FF13D2AC7EE611F1DB2FEB869FDF13F213068AFD64D4BF618F84BAAE7CDF03E8EBBBFE789921FFD0185727AE7FC130BE136AE1BC8D3356D2F777B5D4A438FA799BC573D4E02C7C7E19C1FCDAFD0EFC3F8E191CDDAAD2A91F945AFC257FC0FCC7A2BEF7F15FF00C11FFC3F748E744F17EB162DFC2B7B6B1DD2FE6BE59AF25F1DFF00C129BE23786D5E4D22E343F1146A32A90DC1B798FF00C064017FF1FAF2711C2B9A51D5D26D7934FF0005AFE07D465FE2770D62DF2C712A2FB4D38FE2D72FE27CC90CEF04AB246CC8EA72ACA7041F635EBFF09BF6EDF899F089A28ED7C4336AD611F1F63D57377111E8198EF51FEEB0AE1BE21FC15F167C27B8F2FC47E1DD5B47E701EE2DD9627FF75FEEB7E04D72FD2BC9A75B1383A9EE39425F34FE67D4E23079766B42D5A10AD4DED74A4BE4F5FBD1FA21F043FE0AADE13F1A34367E2FB19BC2D7CD85FB4A137164E7DC81BE3CFB820776AFA8342F1058F8A34A86FB4DBCB5D42CAE577C5716F28962947AAB2920D7E27E6BBCF823FB4978C3F67CD67ED5E1BD5A5B785D834F652FEF2D2EBFDF8CF19EDB86187622BED32AE3AAD4DA8639732EEB47F76CFF0003F20E26F053075D3AD934FD9CBF924DB8BF47ACA3F3E65E87EC0515E07FB2B7EDF5E19FDA2041A55EECF0FF008A9863EC334998AF0F73039FBDEBB0E1876DC0135EF99CD7E9583C750C5D255B0F2528BFEB5ECCFE76CDB27C6E5988785C753709AE8FAF9A7B35E6B40A28A2BA8F3028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00291DC46859885551924F6A5AF84FFE0A27FB7136AD7379F0FF00C1F79B6CE2261D6AFE16FF005EC386B6423F8074723EF1F97A03BBCBCDB36A397E1DD7ADF25D5BEDFE6FA1F49C2BC2F8BCF71CB0785565BCA4F68C7BBFD1757F36AC7EDB7FF051B92796F3C27F0EEF4C71A930DF6B70B7CCE7A18EDCF61D8C8393FC381F31F8A6495A69199999998E4927249A6D68785BC2DA8F8DBC416BA56936771A86A37D208A0B78137492B1EC07EA4F4001278AFC4F32CD31398D7F6959DDF44B65E497F4D9FD91C3BC3797E4182F61854A292BCA4ED7935BB93FE92E867F5AF6CFD9DFF60CF1C7ED0290DF476ABA0F87E5E7FB4AFD4A8957D628FEF49F5E17FDAAFA9BF64BFF00826BE8FF000CE2B5D73C711DAEB9E20E248EC8FCF65607A8C8E92B8F53F283D01C06AFAA51046A154600180076AFB0C9781E534AB660ECBF956FF37D3D16BE68FC978C3C6685194B09912526B4751EDFF6EAEBEAF4F26B53C13E0B7FC1393E1CFC26486E2F34F3E2AD523C1371AA00F106FF00660FB807FBDB88F5AF77B3B2874FB58E0B78A38618976A471A85541E800E054B457E8D84C0E1F0B1E4C3C145792FCDEEFE67E039A6778FCCAAFB6C755954979BD17A2D97A2490514515D47961451450014514500145145001451450014514500437B610EA56925BDC4315C4132ED78E440C8E3D083C1AF05F8D5FF0004DEF877F15926B8D3EC9BC27AA499227D3142C25BFDA80FC847FBBB4FBD7D0145726330187C54793110525E6BF27BAF91EA6559E63F2DABEDB015654DF93D1FAAD9FA34CFCABFDA1FF615F1C7ECF6B35EDC5A2EB5A0C7CFF69D82978E35FF00A6A9F7A3FA9CAFFB46BC5FA57EDD491ACC8CACA195860823208AF93FF6B5FF008269697F1061B9D7BC0515B68BAE7324BA76447677C7BECED0B9F6F909EA1796AFCEB3AE079534EB65FAAFE57BFC9F5F47AF9B3FA0383BC66A75E51C26789424F4551691FF00B7974F55A77496A7E7BC13C96B32C91BB47246C19594E1948E4107D6BEE0FD887FE0A32F793DA7847E225EE647221B0D6E638DC7A08EE0FAF6127FDF5FDEAF8AFC47E1BBFF00086B975A66A9677161A858C8629EDE7429244C3A820D510715F1F95E6989CBABFB4A2EDDD3D9F935FD347EAFC49C3397E7F82F618A5756BC64B78B7D62FB3EDB33F6F01DC28AF87FFE09DBFB72B19AC7E1EF8C2F0B06C41A2EA133720F45B6918FE48C7FDDFEED7DC15FB76539AD1CC30EABD1F9AEA9F67FD6A7F1B71470CE2F22C74B058B5E7192DA51E8D7EABA3D028A28AF48F9D0A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28AE7FE297C47D3BE127C3ED5BC49AB49E5D8E936ED3B807E6908E1517FDA662147B915352A4611739BB25AB35A346A56A91A3495E526924B76DE897CCF09FF00828AFED6CDF047C12BE19D0AE8278A3C4109DD2237CFA75B1CA993D9DB955F4C31EC33F9B2CDB8E4D749F16FE27EA9F193E22EABE24D5E4F32F75498C857395857A246BFECAA80A3D85737D6BF09CFF389E638A757ECAD22BB2FF37BBFBBA1FDB3C0DC274B20CB6386567525ACE5DE5DBD23B2F9BDDB34BC21E11D4BC7BE26B1D1F48B39AFB52D46510DBC110CB48C7F901D493C00093C0AFD3EFD8EFF00637D27F665F0B2DC4EB0EA1E2CBE8C7DBAFF006E4440F3E4C39E4463B9EAE464F180391FF82767EC889F067C191F8AF5DB55FF0084AB5C84346922FCDA6DB37213DA47E0B77030BC60E7E9AAFBEE13E1B8E1A0B19895FBC7B27F657F9BFC36EE7E17E2978853CC2B4B29CBE56A1176935F6DAFFDB574EEF5DAC1451457DD1F8A8514514005145140051451400514514005145140051451400514514005145140051451401E17FB677EC5FA5FED2DE1B7BEB15834FF001858C58B4BCC6D5BA03910CDEAA7B375427D320FE62F89FC33A87833C4379A56A969358EA1A7CAD05C412AED789C7041FF001E8473D2BF6BABE59FF828FF00EC88BF157C23278D341B61FF00092687013771469F36A56CA39E0759231C8EE572BCE1457C1F1770DC711078DC32F7D6E97DA5DFD57E2BE47EDDE15F8853C0D68E5198CAF464ED06FEC37B2FF0BFC1EBB5CFCEB8E468A45656656539041C106BF4BBFE09EBFB599F8F9E016D0F5AB80FE2BF0FC6A25763F35FDBFDD59BDD870AFEF83FC581F99F5D57C15F8B3A97C10F899A4F89B4A63F68D3660CD1EEC2DCC678789BFD965247B707A815F09C3F9C4F2EC52A9F61E925E5DFD56EBEEEA7EDBC79C234B3FCB6542DFBD8DDC1F67DAFDA5B3F93E87EC95158BF0EFC79A7FC4FF03E97E20D265F3B4FD5ADD6E216EE011CA9F46539523B106B6ABF7584E338A945DD3D51FC515A8CE94DD2A8AD28B69A7BA6B74C28A28AA330A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800AF853FE0AC7F1EDAF758D37E1ED84DFB9B30BA8EA9B4FDE9181F2633FEEA92E47FB6BE95F6CF8C3C5367E08F0A6A5AC6A1208AC74AB592EE763D9114B37E82BF1CBE26F8F6F3E28FC41D63C45A836EBBD62EE4BA719E1371C851ECAB851EC057C3F1C666E86156160F5A9BFF00856FF7BB7CAE7ECDE0BF0EAC66672CCAAAF7282D3FC72DBEE577E4ECCC2AFA37FE09C3FB35AFC69F8B5FDB9AA5BF99E1FF000AB24F22B8F96EAE4F3145EE0637B0F4500FDEAF9DADADE4BBB88E28D1A492460A88A32CC4F0001EA6BF5C3F64FF0082317C00F81DA3683E5AAEA1E5FDAB5171FF002D2E6400BF3DF6F083D9057C7708E52B198CE7A8BDCA7ABF37D17EBF23F5BF15B8A5E51943A341DAAD6BC57751FB52FB9A4BB369F43D23A514515FB49FC7C14514500145145001451450014514500145145001451450014514500145145001451450014514500141E45145007E627FC143BF66B5F811F181B50D32DFCBF0EF89CBDD5A851F25B4D9FDEC3EC0121947F75B1FC26BE7EAFD6AFDB1BE0527ED03F02357D1E3895F54B55FB7698D8E45C4609551FEF8DC87FDFF006AFC9796368646565656538208C107D2BF14E2DCA560B1BCD4D7B93D5793EABEFD7D1A3FB17C2DE2979C650A9D777AB46D19776BECCBE6B47DDA6CFB73FE0933F1ED8B6A9F0F7509BE5C36A5A56E3D3A79F10FD1C0FF007CD7DBD5F8D1F07BE24DD7C20F89FA1F896CB779DA3DDA4E541C79A9D1D3E8C8597F1AFD8BF0EEBD6BE28D02CB52B1904D67A8409730483F8E3750CA7F10457DAF03E66EBE11E1A6FDEA7B7F85EDF76ABD2C7E39E3370EAC166B1CC292B42BABBFF1AB5FEF567E6EE5CA28A2BED8FC7428A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00F99FFE0A97F151BC11FB3DC7A1C126CBBF15DDADB100F3E44789243F8911A9F6735F9B75F4E7FC155BE237FC257FB43DBE891C81ADFC33611C2CA0E7134BFBD73FF7C9887FC06BE63AFC478BB1BF58CCA76DA1EEAF96FF008DCFECCF0B327580E1DA2DAF7AADEA3FFB7BE1FF00C9544F7AFF008272FC1E5F8ADFB4969D71730F99A6F8650EAD3EE1F2B3A10215FF00BF855B1DC21AFD42AF95FF00E093FF000C17C2FF0003F51F124D1EDB9F135F111B15E4DBC1945FFC8865FD2BEA8AFD1783F03F57CBA327BCFDE7F3DBF0D7E67F3FF8B19DBCC3882A538BF728FB8BD56B2FFC99B5F241451457D49F99851451400514514005145140051451400514514005145140051451400514514005145140051451400514514001E6BF2C7FE0A09F07C7C21FDA57585B78BCBD375EC6AD6802E140949F3147D250FC760457EA757C95FF00056BF860BAF7C26D17C530C60DC787EF7ECD330FF9E1380327E922201FEF9AF94E32C0FD632E94D6F4FDE5E9B3FC35F91FA878479DBC067F0A327EE564E0FD778BF5BAB7CD9F9F00E2BF4C3FE098BF153FE13FFD9BA0D2E693CCBCF0ADCBD8364FCC613FBC88FD0062A3FEB9D7E67D7D51FF00049CF88C7C39F1CF52F0FC8F8B7F11E9EC5173F7A780EF5FFC8665AFCFB8431BF57CCA09ED3F75FCF6FC6C7EF1E2B64EB1DC3B56497BD4AD35F2D25FF92B7F71FA29451457ED87F1B851451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005231DABCFE34B5C7FED05E2FFF00840BE0778B7580DB64D3F49B996339FF00969E5B04FF00C788ACEB5454E0EA4B649BFB8E8C2E1E55EBC2843793497AB763F287E3CF8E5BE257C68F146BA5B7AEA7A9CF3447D23DE420FC1028FC2B938D1A470AA0B331C000724D34F5AEEBF663F060F883FB41783B4865DD15D6AB0199719CC68C1DFF00F1D535FCEF153C4D7B7DA9BFC5B3FBE272A597E05B5F05287E115FE48FD55F80FE025F85FF0006BC33E1F55DADA5E9D0C32FBCBB4190FE2E58FE35D6D03A515FD114A9C69C1538EC924BE47F0362B113C4569D7A9ACA4DB7EADDD8514515A1805145140051451400514514005145140051451400514514005145140051451400514514005145140051451400570FFB4AF8007C50F809E2CD0F6EF96FB4D97C818CFEF906F8FF00F1F55AEE286E45675A946AD395296D24D3F9E874E0F153C3622188A7F1424A4BD53BA3F10CF5AEE3F668F1CFFC2B7F8FDE11D6B76D8ECF5487CE39E913B6C93FF1C66AABF1F3C19FF0AF3E35F8AB450BB63D3755B88621FF004CFCC253FF001D2B5C923156C8C823A115FCEF173C357BFDA83FC533FBDE51A598605AFB1561F8497F933F6EC74A2B9BF837E2DFF84F3E1378675ADDB9B54D2EDAE98FFB4F1296FD735D257F44D3A8A70538ECD5FEF3F8171146546ACA8CF78B69FAA76614514559885145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140057837FC14A3C4ADE1FFD9275F8D5B6BEA93DB5983EC66576FF00C750D7BCD7C9FF00F0574D5E4B5F819E1FB35E23BAD6D5DFDF6412E07E6DFA578DC435BD9E5B5A5FDD6BEFD3F53EBB80B0AB11C4383A6FFE7E45FF00E03EF7E87E79939AFA2BFE0977E171AFFED556774CBB9745D3AEAF32474254423FF46D7CEB5F637FC11EF4759FC79E34D43FE5A5AE9F6F6E3E9248CC7FF450AFC8386E8FB4CCE8C5FF0035FEED7F43FABFC44C53C3F0DE2EA2EB0E5FFC09A8FEA7DED451457EF07F1105145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005079A28A00FCC1FF8297F85C7873F6B3D6A655DA9ABDB5B5F0F7CC42363F8B466BC041C1AFAEFFE0AF7A22DBFC59F0B6A0BB775DE92F037BF973311FF00A33F4AF912BF05E22A3ECB33AD15FCCDFDFAFEA7F70787F8A788E1DC1D47FC8A3FF80FBBFA1FA9DFF04EDF129F12FEC8FE15DCDBA4B113D9373D3CB99C2FFE3A56BDBABE5BFF00824AEB325FFECEBAADABFDDB1D766543ECD0C2D8FCC9FCEBEA4AFD8F21ABED32EA32FEEA5F72B7E87F24F1C61561F883194D7FCFC93FFC09F37EA1451457AE7CA85145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140057C89FF057DFF924BE15FF00B0BBFF00E886AFAEEBE44FF82BEFFC925F0AFF00D85DFF00F44357CFF14FFC8AAB7A2FCD1F75E1AFFC94D84FF13FFD259F9FD5F6A7FC11D3FE435E3EFF00AE363FFA14F5F15D7DA9FF000474FF0090D78FBFEB8D8FFE853D7E5DC25FF236A3F3FF00D259FD2DE29FFC92F8AFFB73FF004E40FBA28A28AFDC4FE2F0A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2803E0DFF82C1FFC8E7E0AFF00AF1BAFFD1895F1AD7D95FF000583FF0091CFC15FF5E375FF00A312BE35AFC338ABFE46B5BD57FE928FED2F0BFF00E498C2FA4BFF004B91FA17FF000487FF009213E22FFB0F37FE93C35F58D7C9DFF0487FF9213E22FF00B0F37FE93C35F58D7EABC33FF22BA3E9FAB3F98FC48FF929717FE2FD10514515EF1F121451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450015F227FC15F7FE492F857FEC2EFF00FA21ABEBBAF913FE0AFBFF002497C2BFF6177FFD10D5F3FC53FF0022AADE8BF347DD786BFF00253613FC4FFF004967E7F57DA9FF000474FF0090D78FBFEB8D8FFE853D7C575F6A7FC11D3FE435E3EFFAE363FF00A14F5F977097FC8DA8FCFF00F4967F4B78A7FF0024BE2BFEDCFF00D3903EE8A28A2BF713F8BC28A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00F837FE0B07FF00239F82BFEBC6EBFF0046257C6B5F657FC160FF00E473F057FD78DD7FE8C4AF8D6BF0CE2AFF0091AD6F55FF00A4A3FB4BC2FF00F92630BE92FF00D2E47E85FF00C121FF00E484F88BFEC3CDFF00A4F0D7D635F277FC121FFE484F88BFEC3CDFFA4F0D7D635FAAF0CFFC8AE8FA7EACFE63F123FE4A5C5FF8BF441451457BC7C485145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140057C89FF00057DFF00924BE15FFB0BBFFE886AFAEEBE44FF0082BEFF00C925F0AFFD85DFFF0044357CFF0014FF00C8AAB7A2FCD1F75E1AFF00C94D84FF0013FF00D259F9FD5F6A7FC11D3FE435E3EFFAE363FF00A14F5F15D7DA9FF0474FF90D78FBFEB8D8FF00E853D7E5DC25FF00236A3F3FFD259FD2DE29FF00C92F8AFF00B73FF4E40FBA28A28AFDC4FE2F0A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2803E0DFF0082C1FF00C8E7E0AFFAF1BAFF00D1895F1AD7D95FF0583FF91CFC15FF005E375FFA312BE35AFC338ABFE46B5BD57FE928FED2F0BFFE498C2FA4BFF4B91FA17FF0487FF9213E22FF00B0F37FE93C35F58D7C9DFF000487FF009213E22FFB0F37FE93C35F58D7EABC33FF0022BA3E9FAB3F98FC48FF00929717FE2FD10514515EF1F121451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450015F227FC15F7FE492F857FEC2EFFF00A21ABEBBAF913FE0AFBFF2497C2BFF006177FF00D10D5F3FC53FF22AADE8BF347DD786BFF253613FC4FF00F4967E7F57DA9FF0474FF90D78FBFEB8D8FF00E853D7C575F6A7FC11D3FE435E3EFF00AE363FFA14F5F977097FC8DA8FCFFF004967F4B78A7FF24BE2BFEDCFFD3903EE8A28A2BF713F8BC28A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00F837FE0B07FF239F82BFEBC6EBFF46257C6B5F657FC160FFE473F057FD78DD7FE8C4AF8D6BF0CE2AFF91AD6F55FFA4A3FB4BC2FFF0092630BE92FFD2E47E85FFC121FFE484F88BFEC3CDFFA4F0D7D635F277FC121FF00E484F88BFEC3CDFF00A4F0D7D635FAAF0CFF00C8AE8FA7EACFE63F123FE4A5C5FF008BF441451457BC7C485145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140057C89FF057DFF924BE15FF00B0BBFF00E886AFAEEBE44FF82BEFFC925F0AFF00D85DFF00F44357CFF14FFC8AAB7A2FCD1F75E1AFFC94D84FF13FFD259F9FD5F6A7FC11D3FE435E3EFF00AE363FFA14F5F15D7DA9FF000474FF0090D78FBFEB8D8FFE853D7E5DC25FF236A3F3FF00D259FD2DE29FFC92F8AFFB73FF004E40FBA28A28AFDC4FE2F0A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2803E0DFF82C1FFC8E7E0AFF00AF1BAFFD1895F1AD7D95FF000583FF0091CFC15FF5E375FF00A312BE35AFC338ABFE46B5BD57FE928FED2F0BFF00E498C2FA4BFF004B91FA17FF000487FF009213E22FFB0F37FE93C35F58D7C9DFF0487FF9213E22FF00B0F37FE93C35F58D7EABC33FF22BA3E9FAB3F98FC48FF929717FE2FD10514515EF1F121451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450015F227FC15F7FE492F857FEC2EFF00FA21ABEBBAF913FE0AFBFF002497C2BFF6177FFD10D5F3FC53FF0022AADE8BF347DD786BFF00253613FC4FFF004967E7F57DA9FF000474FF0090D78FBFEB8D8FFE853D7C575F6A7FC11D3FE435E3EFFAE363FF00A14F5F977097FC8DA8FCFF00F4967F4B78A7FF0024BE2BFEDCFF00D3903EE8A28A2BF713F8BC28A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00F837FE0B07FF00239F82BFEBC6EBFF0046257C6B5F657FC160FF00E473F057FD78DD7FE8C4AF8D6BF0CE2AFF0091AD6F55FF00A4A3FB4BC2FF00F92630BE92FF00D2E47E85FF00C121FF00E484F88BFEC3CDFF00A4F0D7D635F277FC121FFE484F88BFEC3CDFFA4F0D7D635FAAF0CFFC8AE8FA7EACFE63F123FE4A5C5FF8BF441451457BC7C485145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140057C89FF00057DFF00924BE15FFB0BBFFE886AFAEEBE44FF0082BEFF00C925F0AFFD85DFFF0044357CFF0014FF00C8AAB7A2FCD1F75E1AFF00C94D84FF0013FF00D259F9FD5F6A7FC11D3FE435E3EFFAE363FF00A14F5F15D7DA9FF0474FF90D78FBFEB8D8FF00E853D7E5DC25FF00236A3F3FFD259FD2DE29FF00C92F8AFF00B73FF4E40FBA28A28AFDC4FE2F0A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2803E0DFF0082C1FF00C8E7E0AFFAF1BAFF00D1895F1AD7D95FF0583FF91CFC15FF005E375FFA312BE35AFC338ABFE46B5BD57FE928FED2F0BFFE498C2FA4BFF4B91FA17FF0487FF9213E22FF00B0F37FE93C35F58D7C9DFF000487FF009213E22FFB0F37FE93C35F58D7EABC33FF0022BA3E9FAB3F98FC48FF00929717FE2FD10514515EF1F121451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450015F227FC15F7FE492F857FEC2EFFF00A21ABEBBAF913FE0AFBFF2497C2BFF006177FF00D10D5F3FC53FF22AADE8BF347DD786BFF253613FC4FF00F4967E7F57DA9FF0474FF90D78FBFEB8D8FF00E853D7C575F6A7FC11D3FE435E3EFF00AE363FFA14F5F977097FC8DA8FCFFF004967F4B78A7FF24BE2BFEDCFFD3903EE8A28A2BF713F8BC28A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00F837FE0B07FF239F82BFEBC6EBFF46257C6B5F657FC160FFE473F057FD78DD7FE8C4AF8D6BF0CE2AFF91AD6F55FFA4A3FB4BC2FFF0092630BE92FFD2E47E85FFC121FFE484F88BFEC3CDFFA4F0D7D635F277FC121FF00E484F88BFEC3CDFF00A4F0D7D635FAAF0CFF00C8AE8FA7EACFE63F123FE4A5C5FF008BF441451457BC7C485145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140057C89FF057DFF924BE15FF00B0BBFF00E886AFAEEBE44FF82BEFFC925F0AFF00D85DFF00F44357CFF14FFC8AAB7A2FCD1F75E1AFFC94D84FF13FFD259F9FD5F6A7FC11D3FE435E3EFF00AE363FFA14F5F15D7DA9FF000474FF0090D78FBFEB8D8FFE853D7E5DC25FF236A3F3FF00D259FD2DE29FFC92F8AFFB73FF004E40FBA28A28AFDC4FE2F0A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2803E0DFF82C1FFC8E7E0AFF00AF1BAFFD1895F1AD7D95FF000583FF0091CFC15FF5E375FF00A312BE35AFC338ABFE46B5BD57FE928FED2F0BFF00E498C2FA4BFF004B91FA17FF000487FF009213E22FFB0F37FE93C35F58D7C9DFF0487FF9213E22FF00B0F37FE93C35F58D7EABC33FF22BA3E9FAB3F98FC48FF929717FE2FD10514515EF1F121451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450015F227FC15F7FE492F857FEC2EFF00FA21ABEBBAF913FE0AFBFF002497C2BFF6177FFD10D5F3FC53FF0022AADE8BF347DD786BFF00253613FC4FFF004967E7F57DA9FF000474FF0090D78FBFEB8D8FFE853D7C575F6A7FC11D3FE435E3EFFAE363FF00A14F5F977097FC8DA8FCFF00F4967F4B78A7FF0024BE2BFEDCFF00D3903EE8A28A2BF713F8BC28A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A00F837FE0B07FF00239F82BFEBC6EBFF0046257C6B5F657FC160FF00E473F057FD78DD7FE8C4AF8D6BF0CE2AFF0091AD6F55FF00A4A3FB4BC2FF00F92630BE92FF00D2E47E85FF00C121FF00E484F88BFEC3CDFF00A4F0D7D635F277FC121FFE484F88BFEC3CDFFA4F0D7D635FAAF0CFFC8AE8FA7EACFE63F123FE4A5C5FF8BF441451457BC7C4851451400514514005145140051451400514514005145140051451400514514005145140051451400514514005158BF10BE23687F0A7C2775AE788B52B5D274AB25DD2DC4EDB547A003AB31E8140249E0035F0BFC76FF82CE5DB5F4D67F0F7C3F6F1DB212ABA8EAE0BBCA3D5604202FA8DCC4FAA8E95ECE53C3F8ECC9DB0B0BA5BB7A25F3FD15D9F1BC59C7D9270E413CD2B28C9EAA09734DF9F2AD979BB2F33F40A8AFC8DD47FE0A89F1B2FEE0BAF8BA3B65EC90E976A147E7193FAD57FF879B7C6DFFA1D64FF00C16DA7FF001AAFA95E1AE676D670FBE5FF00C89F97CBE921C349D951AFFF0080C3FF00961FAF55F227FC15F7FE492F857FEC2EFF00FA21ABE40FF879B7C6DFFA1D64FF00C16DA7FF001AAE4FE2EFED89F113E3B68F6B61E2AF1136A96B6331B8850D9C116C72BB49CA2293C762715E6675E1466D8BC154C353A94D392D2EE56DD3FE467D1708FD2A78572ACE2866188C3E21C20DB6A31A6DECD697AA975EE64D7DA9FF000474FF0090D78FBFEB8D8FFE853D7C05FF00092DE7FCF73FF7C8AECFE0FF00ED51E3BF80B36A1278535C6D2DB54545B922D619BCC0858AFDF46C6371E98EB5F1991F80D9F60B1D4F1356B51718DEF694EFAA6BAD35DCFD7B8D3E9D1C0B9BE4D5B2EC361316A73E5B39428A5A4A32D6D5DBD9763F6CA8AFC85FF879B7C6DFFA1D64FF00C16DA7FF001AA3FE1E6DF1B7FE87593FF05B69FF00C6ABF47FF886B997FCFC87DF2FFE44FE7DFF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FD7AA2BF217FE1E6DF1B7FE87593FF05B69FF00C6A8FF00879B7C6DFF00A1D64FFC16DA7FF1AA3FE21AE65FF3F21F7CBFF910FF008991E1BFF9F15FFF0001A7FF00CB0FA23FE0B07FF239F82BFEBC6EBFF46257C6B563E2FF00ED45E38F8F1796371E2AD71B549B4D8DA2B76FB2C30EC5620B0F91573C81D735C77FC24B79FF003DCFFDF22BF37CEBC05CFF00198D9E26956A2A32B5AF29DF44974A6FB1FD09C1BF4E8E04CA726A197E27098B738277718516B5937A5EBA7B3EC7E9A7FC121FFE485788BFEC3CDFFA4F0D7D635F8B7F093F6CAF88DF02F42B8D37C2DE226D2EC6EEE3ED52C62CE097749B42E72E848E140C038E2BAAFF00879B7C6DFF00A1D64FFC16DA7FF1AAFB5C9FC29CD70982A787A9529DE2ACECE56FFD251F8EF167D2A385734CDEBE6187C3E2142A3BA528D34F64B5B556BF13F5EA8AFC85FF00879B7C6DFF00A1D64FFC16DA7FF1AAB5A67FC151BE35E9F701DBC590DD2F749B4BB52A7F28C1FC8D7A4FC36CCEDA4E1F7CBFF913E7E3F490E1A6ECE8D75FF6EC3FF961FAE1457C03F01FFE0B3933DFC363F113C3F6EB6EE429D4F480C0C5EEF0313B87725181E3853D2BEE7F02F8F746F899E16B3D6B40D4AD756D2AF937C1736EFB91C771EA083C153820F04035F2B9B6438ECB656C542C9ECD6A9FCFF47A9FA970A71E649C47072CAEB294A3BC5E935EB17D3CD5D799AF4514578E7D8051451400514514005145140051451400514514005145140051451400514514005437F7F0E976335CDC491C36F6E8D2CB239C2C6AA32589F400135357CFBFF053BF8913FC3AFD903C41F6591A2B8D7A487484707A2CAD9907E312483F1AECCBF072C562A9E1A3BCDA5F7BDFE478FC419BC32BCB2BE65515D5284A56EF64DA5F37A1F9FDFB737ED81A97ED4FF142768679A1F09E932B47A45992554A8E0DC38EF23F5E7EEA90A3B93E1D413935EA1FB22FECD57BFB547C65B3F0CDBDC1B2B348DAEF50BB09B8DB5BA101881DD896555078CB64F00D7F4A53A785CB70765EED3A6BF05D7CDBFBDB3FCDDAF5F34E25CE39E57AB88AF2B2F36F4495F4496CBA24BB23CC0293D8D1B1BD0FE55FB07E12FF008272FC1DF0968B0D9AF832C75268D407B9D4247B89E63FDE625B009F45007B0AD4FF00860DF83FFF0044FF00C3BFF7E0FF00F155F132F12B009DA34E6D7CBFCCFDA69FD1B33E704E789A49F5579BB7CF94FC68D8DE87F2A3637A1FCABF65FF00E1837E0FFF00D13FF0EFFDF83FFC551FF0C1BF07FF00E89FF877FEFC1FFE2AA7FE225E07FE7D4FFF0025FF0032FF00E25AF3CFFA0AA5FF0093FF00F227E346C6F43F951B1BD0FE55FB2A7F609F83E5F77FC2BFF0FF00FDFA6C7E5BB14EFF00860DF83FFF0044FF00C3BFF7E0FF00F1547FC44CC0FF00CFA9FF00E4BFE61FF12D79DFFD0552FF00C9FF00F913F1A3637A1FCA8D8DE87F2AFD97FF00860DF83FFF0044FF00C3BFF7E0FF00F1547FC306FC1FFF00A27FE1DFFBF07FF8AA3FE225E07FE7D4FF00F25FF30FF896BCF3FE82A97FE4FF00FC89F8D1B1BD0FE546C6F43F957ECBFF00C306FC1FFF00A27FE1DFFBF07FF8AA3FE1837E0FFF00D13FF0EFFDF83FFC551FF112F03FF3EA7FF92FF987FC4B5E79FF004154BFF27FFE44FC68D8DE87F2A3637A1FCABF65FF00E1837E0FFF00D13FF0EFFDF83FFC551FF0C1BF07FF00E89FF877FEFC1FFE2A8FF889781FF9F53FFC97FCC3FE25AF3CFF00A0AA5FF93FFF00227E346C6F43F951B1BD0FE55FB2FF00F0C1BF07FF00E89FF877FEFC1FFE2A8FF860DF83FF00F44FFC3BFF007E0FFF001547FC44BC0FFCFA9FFE4BFE61FF0012D79E7FD0552FFC9FFF00913F1A3637A1FCA8D8DE87F2AFD97FF860DF83FF00F44FFC3BFF007E0FFF001547FC306FC1FF00FA27FE1DFF00BF07FF008AA3FE225E07FE7D4FFF0025FF0030FF00896BCF3FE82A97FE4FFF00C89F8D1B1BD0FE546C6F43F957ECBFFC306FC1FF00FA27FE1DFF00BF07FF008AA3FE1837E0FF00FD13FF000EFF00DF83FF00C551FF00112F03FF003EA7FF0092FF00987FC4B5E79FF4154BFF0027FF00E44FC68D8DE87F2A3637A1FCABF65FFE1837E0FF00FD13FF000EFF00DF83FF00C551FF000C1BF07FFE89FF00877FEFC1FF00E2A8FF00889781FF009F53FF00C97FCC3FE25AF3CFFA0AA5FF0093FF00F227E346C6F43F951B1BD0FE55FB2FFF000C1BF07FFE89FF00877FEFC1FF00E2A8FF00860DF83FFF0044FF00C3BFF7E0FF00F1547FC44BC0FF00CFA9FF00E4BFE61FF12D79E7FD0552FF00C9FF00F913F1A3637A1FCA8D8DE87F2AFD97FF00860DF83FFF0044FF00C3BFF7E0FF00F1547FC306FC1FFF00A27FE1DFFBF07FF8AA3FE225E07FE7D4FF00F25FF30FF896BCF3FE82A97FE4FF00FC89F8D1B1BD0FE546C6F43F957ECBFF00C306FC1FFF00A27FE1DFFBF07FF8AA3FE1837E0FFF00D13FF0EFFDF83FFC551FF112F03FF3EA7FF92FF987FC4B5E79FF004154BFF27FFE44FC68D8DE87F2A3637A1FCABF65FF00E1837E0FFF00D13FF0EFFDF83FFC551FF0C1BF07FF00E89FF877FEFC1FFE2A8FF889781FF9F53FFC97FCC3FE25AF3CFF00A0AA5FF93FFF00227E346C6F43F951B1BD0FE55FB2FF00F0C1BF07FF00E89FF877FEFC1FFE2A8FF860DF83FF00F44FFC3BFF007E0FFF001547FC44BC0FFCFA9FFE4BFE61FF0012D79E7FD0552FFC9FFF00913F1A3637A1FCA8D8DE87F2AFD97FF860DF83FF00F44FFC3BFF007E0FFF001547FC306FC1FF00FA27FE1DFF00BF07FF008AA3FE225E07FE7D4FFF0025FF0030FF00896BCF3FE82A97FE4FFF00C89F8D1B1BD0FE546C6F43F957ECBFFC306FC1FF00FA27FE1DFF00BF07FF008AA3FE1837E0FF00FD13FF000EFF00DF83FF00C551FF00112F03FF003EA7FF0092FF00987FC4B5E79FF4154BFF0027FF00E44FC68D8DE87F2A3637A1FCABF65FFE1837E0FF00FD13FF000EFF00DF83FF00C55347EC13F07C396FF857FE1FE7FE99363F2DD8A3FE226607FE7D4FFF0025FF0030FF00896ACEFF00E82A97FE4FFF00C89F8D5B1BD0FE546C6F43F957ECBFFC306FC1FF00FA27FE1DFF00BF07FF008AA3FE1837E0FF00FD13FF000EFF00DF83FF00C551FF00112F03FF003EA7FF0092FF00987FC4B5E79FF4154BFF0027FF00E44FC68D8DE87F2A42A476AFD98FF860DF83FF00F44FFC3BFF007E0FFF0015591E33FF0082707C1DF19687359FFC21F67A5492290975A748F6F3C27FBC0E4A9C7A3023DAAA3E25601B4A54E697CBFCCCEAFD1B33E8C1CA189A4DF6BCD5FE7CA7E3F57BE7EC11FB62DF7ECBBF13E186F2E2697C1DAD4CB1EA96A4E560270A2E507674EF8FBCA083C852389FDAAFF677BEFD983E33EA5E15BC9BED90C216E2CAEB66CFB5DBBE763E3B1E0AB0ECCA71918AF390706BED6B52C2E6583E597BD4EA2FC1ECD766BF067E2F83C5E67C359C7B485E9E22849A6BCD3B34EDBA7B3E8D3EC7EF85B5CC7796F1CD0C8924522874743B958119041EE08A92BC27FE09BBF1266F897FB2078566BA91A5BBD2524D2A562724881CAC7FF90FCBAF76AFE6AC7616585C4D4C34B7836BEE763FD25C8B35A799E5D4331A5A2AB08CD2EDCC93B7CAF60A28A2B94F5428A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A002BE49FF82CB395FD9774919E0F88EDF3EFFB8B8AFADABE48FF0082CBFF00C9AF68FF00F631C1FF00A22E2BE83857FE46F87FF123F3FF00153FE492C7FF00D7B7F9A3F30ABED6FF00822928FF0085B9E326C7CC3478803FF6DC57C535F6BFFC1147FE4ACF8CBFEC1117FE8F15FB57187FC89EBFA2FF00D291FC5DE0F7FC96381FF13FFD2247E8ED14515FCEA7FA22145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145007E6AFF00C16A5147C7EF0BB6D1B8F8797271D7FD266AF8D6BECCFF0082D4FF00C97BF0B7FD8BE3FF004A66AF8CEBFA33847FE44F43D3F567F9D3E2E7FC9618FF00F1AFFD2627EA57FC11E98B7EC9B71FECEBF7607B7EEE1AFAAABE54FF00823CFF00C9A75CFF00D87EEBFF0045C15F55D7E23C51FF00236C47F899FDB5E17FFC92980FFAF51FC828A28AF04FBC0A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800AF92BFE0B2B133FECB7A4B01C2F88EDF3EDFB8B8AFAD6BC2FFE0A3DF0B27F8ADFB23F89ADECE369AFB4954D5A045192DE436E7007AF9464C7BD7B5C395A34734A1527B732FC5D8F8BF117055317C318EA1455E4E9C9A5DECAF6F5763F1FEBED4FF8229CE8BF187C6116E5F31F468D9573C90275C9FC323F3AF8ACF06BBBFD9C3E3F6B1FB34FC58D3FC55A3AC734B6A1A2B8B690911DE40D8DF1311C8CE0107B32A9E718AFDFB3FC0CF1B97D5C352F8A4B4F54EFF8D8FE07E01CFA864DC4185CCB137E4A72F7ADBA4D38B76EB64EF6EB63F6E68AF97BC23FF0572F84BAEE8B0DC6A573AD68778CA3CCB59F4F798A377C3C5B9587A1E09F41D2B53FE1EB1F057FE862D43FF05173FF00C457E052E1BCD62F95E1E7FF0080B7F8A3FBE29F88FC2D520A71CC28D9F7A914FE69B4D7A347D1B457CE5FF0F58F82BFF4316A1FF828B9FF00E228FF0087AC7C15FF00A18B50FF00C145CFFF001153FEAEE69FF40F3FFC05FF00917FF110F85FFE86147FF0643FCCFA368AF9CBFE1EB1F057FE862D43FF0005173FFC451FF0F58F82BFF4316A1FF828B9FF00E228FF0057734FFA079FFE02FF00C83FE221F0BFFD0C28FF00E0C87F99F46D15F397FC3D63E0AFFD0C5A87FE0A2E7FF88A3FE1EB1F057FE862D43FF05173FF00C451FEAEE69FF40F3FFC05FF00907FC443E17FFA1851FF00C190FF0033E8DA2BE72FF87AC7C15FFA18B50FFC145CFF00F1147FC3D63E0AFF00D0C5A87FE0A2E7FF0088A3FD5DCD3FE81E7FF80BFF0020FF008887C2FF00F430A3FF008321FE67D1B457CE5FF0F58F82BFF4316A1FF828B9FF00E228FF0087AC7C15FF00A18B50FF00C145CFFF001147FABB9A7FD03CFF00F017FE41FF00110F85FF00E86147FF000643FCCFA368AF9CBFE1EB1F057FE862D43FF05173FF00C451FF000F58F82BFF004316A1FF00828B9FFE228FF57734FF00A079FF00E02FFC83FE221F0BFF00D0C28FFE0C87F99F46D15F397FC3D63E0AFF00D0C5A87FE0A2E7FF0088A3FE1EB1F057FE862D43FF0005173FFC451FEAEE69FF0040F3FF00C05FF907FC443E17FF00A1851FFC190FF33E8DA2BE72FF0087AC7C15FF00A18B50FF00C145CFFF001147FC3D63E0AFFD0C5A87FE0A2E7FF88A3FD5DCD3FE81E7FF0080BFF20FF8887C2FFF00430A3FF8321FE67D1B457CE5FF000F58F82BFF004316A1FF00828B9FFE228FF87AC7C15FFA18B50FFC145CFF00F1147FABB9A7FD03CFFF00017FE41FF110F85FFE86147FF0643FCCFA368AF9CBFE1EB1F057FE862D43FF0005173FFC451FF0F58F82BFF4316A1FF828B9FF00E228FF0057734FFA079FFE02FF00C83FE221F0BFFD0C28FF00E0C87F99F46D15F397FC3D63E0AFFD0C5A87FE0A2E7FF88A3FE1EB1F057FE862D43FF05173FF00C451FEAEE69FF40F3FFC05FF00907FC443E17FFA1851FF00C190FF0033E8DA2BE6E93FE0ABBF0652450BADEA9229EACBA54E00FCC03FA549FF000F58F82BFF004316A1FF00828B9FFE22A2390666DB4B0F534FEE4BFCB51FFC442E185AFF006851FF00C1B0FF0033E8DA2BE72FF87AC7C15FFA18B50FFC145CFF00F1147FC3D63E0AFF00D0C5A87FE0A2E7FF0088ABFF0057734FFA079FFE02FF00C85FF110F85FFE86147FF0643FCCFA368AF9CBFE1EB1F057FE862D43FF0005173FFC451FF0F58F82BFF4316A1FF828B9FF00E228FF0057734FFA079FFE02FF00C83FE221F0BFFD0C28FF00E0C87F99F46D15F397FC3D63E0AFFD0C5A87FE0A2E7FF88A3FE1EB1F057FE862D43FF05173FF00C451FEAEE69FF40F3FFC05FF00907FC443E17FFA1851FF00C190FF0033E8DA2BE72FF87AC7C15FFA18B50FFC145CFF00F1147FC3D63E0AFF00D0C5A87FE0A2E7FF0088A3FD5DCD3FE81E7FF80BFF0020FF008887C2FF00F430A3FF008321FE67D1B457CE5FF0F58F82BFF4316A1FF828B9FF00E228FF0087AC7C15FF00A18B50FF00C145CFFF001147FABB9A7FD03CFF00F017FE41FF00110F85FF00E86147FF000643FCCFA368AF9CBFE1EB1F057FE862D43FF05173FF00C451FF000F58F82BFF004316A1FF00828B9FFE228FF57734FF00A079FF00E02FFC83FE221F0BFF00D0C28FFE0C87F99F46D15F397FC3D63E0AFF00D0C5A87FE0A2E7FF0088AC8F1AFF00C15D7E13F87F439A7D2A6D6B5EBD553E55AC362F6FBDBB6E79400A3D4804FB1AA8F0DE6B27CAB0F3FF00C05AFC5E8655BC48E16A7075259851B2ED38B7F249B6FD12B9F3BFFC169AEA393F682F0CC4AEA648FC3CA5941E57373363F91AF8DEBB4FDA07E396B1FB45FC55D4FC55AD796B757EC163823CF976B0A8C244BECA3BF524927935C58E4D7EFF0091606783CBE961AA7C515AFAEECFE05E3ACF28E719FE2B32C3A7C9526DC6FBD95926FB5D2BDBA1FA95FF00047B8D93F64D9C91C3EBD7647B8D908FE95F55578BFF00C13F3E164FF08BF64DF09E9D791B437F79036A5728C30C8D3B190291D8842808F515ED15FCFBC415E35B33AF521B393B7DE7FA01E1FE06AE0F86B0387ACAD28D285D766E29DBE57B0514515E39F601451450014514500145145001451450014514500145145001451450014D96259E364755656182A46411EF4EA2803F27FF00E0A17FB0FDF7ECDDE3AB8D7B45B479BC0FAC4E5EDA48D7234C918E4DBC9E8339D84F55E3A835F35D7EF46BDA058F8A746B9D3B52B3B6BFB0BC8CC53DBDC46248A643D5594F041F435F1D7C75FF008238786BC5B7F35FF81F5A9BC332C84B7D82EA3375660FA23644883D897C76C57EBDC39C7D47D9470F99B6A4B4E6B5D3F5B6A9F9F5DF43F917C45F00F19F5A9E61C3694A127774AEA2E2DEFC8DD938F6574D6CAFD3F3728AFACF51FF0082377C54B5BA658750F075D460FCAEB7D3267F030D41FF000E77F8B1FF003F1E11FF00C1949FFC6ABED1714652FF00E6223F79F8D4BC2FE2C4ECF0153FF013E53A2BEACFF873BFC58FF9F8F08FFE0CA4FF00E3547FC39DFE2C7FCFC7847FF06527FF001AA3FD68CA7FE8223F78BFE218715FFD0055FF00C059F29D15F567FC39DFE2C7FCFC7847FF0006527FF1AA3FE1CEFF00163FE7E3C23FF83293FF008D51FEB4653FF4111FBC3FE218715FFD0055FF00C059F29D15F567FC39DFE2C7FCFC7847FF0006527FF1AA3FE1CEFF00163FE7E3C23FF83293FF008D51FEB4653FF4111FBC3FE218715FFD0055FF00C059F29D15F567FC39DFE2C7FCFC7847FF0006527FF1AA3FE1CEFF00163FE7E3C23FF83293FF008D51FEB4653FF4111FBC3FE218715FFD0055FF00C059F29D15F567FC39DFE2C7FCFC7847FF0006527FF1AA3FE1CEFF00163FE7E3C23FF83293FF008D51FEB4653FF4111FBC3FE218715FFD0055FF00C059F29D15F567FC39DFE2C7FCFC7847FF0006527FF1AA8751FF008242FC54D2F4F9EE66BAF08AC56F1B4AE7FB464E02824FFCB2F6A9A9C5993C22E73C4C124AEDDF64823E17F16376597D5FFC059F2CD15EC9FF000C31E36FF9E9A1FF00E05B7FF1153E9BFB04F8EB55D420B585B4369AE2458907DADF966381FC1EF5F074FC7AF0F2A4D53867141B6EC973AD5B3D797823C7A95DE535BFF00678A515F561FF00823BFC5807FE3E3C23FF0083193FF8D51FF0E77F8B1FF3F1E11FFC1949FF00C6ABEFBFD68CA7FE8223F79E47FC430E2BFF00A00ABFF80B3E53A2BEACFF00873BFC58FF009F8F08FF00E0CA4FFE3547FC39DFE2C7FCFC7847FF0006527FF1AA3FD68CA7FE8223F787FC430E2BFF00A00ABFF80B3E53A2BEACFF00873BFC58FF009F8F08FF00E0CA4FFE3547FC39DFE2C7FCFC7847FF0006527FF1AA3FD68CA7FE8223F787FC430E2BFF00A00ABFF80B3E53A2BEACFF00873BFC58FF009F8F08FF00E0CA4FFE3547FC39E3E2C7FCFC7847FF0006327FF1AA3FD68CA7FE8223F787FC430E2BFF00A00ABFF80B3E53A2BDA6F3F60EF1CD85DCB04ADA1AC90B9471F6B6E08383FC1517FC30C78DBFE7A687FF00816DFF00C457C0CBC7CF0EE327196714135A7C68F5D7823C7AD5D6535BFF0000678DD15F545A7FC1207E2B5EDAC734775E1168E640EA7FB464E41191FF002CBDEA4FF873BFC58FF9F8F08FFE0CA4FF00E355F791E2ACA2494A388834FCCF21F85FC589D9E5F57FF0167CA7457D59FF000E77F8B1FF003F1E11FF00C1949FFC6A8FF873BFC58FF9F8F08FFE0CA4FF00E3555FEB4653FF004111FBC3FE218715FF00D0055FFC059F29D15F567FC39DFE2C7FCFC7847FF06527FF001AA3FE1CEFF163FE7E3C23FF0083293FF8D51FEB4653FF004111FBC3FE218715FF00D0055FFC059F29D15F567FC39DFE2C7FCFC7847FF06527FF001AA3FE1CEFF163FE7E3C23FF0083293FF8D51FEB4653FF004111FBC3FE218715FF00D0055FFC059F29D15F567FC39DFE2C7FCFC7847FF06527FF001AA3FE1CEFF163FE7E3C23FF0083293FF8D51FEB4653FF004111FBC3FE218715FF00D0055FFC059F29D15F567FC39DFE2C7FCFC7847FF06527FF001AA3FE1CEFF163FE7E3C23FF0083293FF8D51FEB4653FF004111FBC3FE218715FF00D0055FFC059F29D15F567FC39DFE2C7FCFC7847FF06527FF001AAB1A67FC11B7E295DDD2ACFA9783ED63CFCCE6FA67C7E021A4F8A7294AFF00588FDE38F85DC59276580A9FF809F25D7D41FF0004E6FD882F3F681F1DDAF89B5EB368FC11A2CE24732AE1756990E4429EA808F9DBA63E5EA4E3E88F80FF00F0474F0B7832FE1D43C6DAC4FE2A9E221C58C119B5B2CFA39C99241ED9507B822BEC3D1F46B3F0EE976F63A7DADBD9595AC62286082311C70A0E02AA8E001E82BE2F8938FA8BA52C3E5ADB6F472D925E57D6FE7A5BA5CFDA3C38F017171C5C331E244A30834D52BA93935AAE76AF151F24DB7B3B2DECAAEC5C0E00E83D28A28AFC88FEB70A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800AE5FE34DF1D3FE16EB52038DD0795FF007DB05FEB5D45713FB43923E136A5FEF45FFA316BE4F8F3112A3C35985586F1A155AF5E491E8E4F053C7D18BEB38FE68F9A4D761F01F4C1AA7C54D2D587CB0B34E7FE02A48FD715C7D7A0FECD001F8991E7FE7DA5C7E95FE72786F8686238AB2FA553675A9DFE524FF43F6FCF26E197D692FE597E47D17451457FA8E7F3F8514514005145140051451401F2EFC6CD2C693F147588D576AC930987FC0D43FF00326B951C9AEF3F691007C53BBC7530C59FFBE057075FE59F88185861F89F30A34FE155AA5BD39DD97C8FE81C96A39E028C9EFCB1FC91F557C25BF6D4BE1AE8B2B1DC7ECA884FAEDF97FA57455C87C0624FC25D1F3FDC93FF0046BD75F5FE93705D7957E1EC0569EF2A349BF5708B3F0CCD22A18DAD15D2525F8B0A28A2BE98E10A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800AE57E37D9FDBFE15EB28064AC224FFBE595BFA57555575CD3175AD16EECDFEEDD42F09CFF00B4A47F5AF1F88B2F78FCAB13815BD5A7387FE0516BF53AB055BD8E229D67F6649FDCEE7C7B5DA7ECFF00A88D3BE2A69BBBEECFBE13F56438FD715C7DDDB3D95CC90C8BB64898A30F420E0D4DA16AB2685AD5A5EC7FEB2D264997DCA907FA57F975C35993CAB3AC363E6BF8352126BFC324DAFC2C7EFD8EC3FD630B528AFB516BEF47D854541A66A116ADA741750B6F86E235951BD548C8A9EBFD59A7523520AA41DD3574D754F667F3C4A2E2ECF70A28A2B41051451400514555D6B558B43D22EAF276DB0DAC4D2B9F603359D6AD0A54E556ABB4629B6DEC92D5BF91518B949463BB3E6BF8EBA88D4FE2A6ACCA72B1C8B08FF8022A9FD41AE4475AB1AAEA326AFA9DC5D4BCC9752B4AFF0056249FE74DD3AC64D4F5082DA21BA4B8916341EA58E07F3AFF0028F3ECC259AE7188C6C16B5AA4E4975F7E4DA5F8D8FE87C1D1587C34293FB314BEE47D43F07ACCD87C31D163231BAD964FFBEB2DFD6BA5A874CB15D334EB7B68FF00D5DBC6B12FD14003F954D5FEA664780FA8E5B87C17FCFB8421FF0080C52FD0FE7EC5D6F6D5E757F99B7F7BB8514515EA1CE1451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145007CD9FB427848F867E21DC4C8BB6DF531F698C81C6E3F7C7FDF5CFFC08570D5F4D7C71F87E7C79E0C90409BAFEC499EDF0397E3E64FC47EA057CCACA55B07823A8F4AFF397C70E0C9E43C4B56A538FEE710DD483E976FDF8FF00DBB27B748B8F73F6EE13CD16330318B7EF43DD7F2D9FCD7E373DE3F665F880BAA688FA1DC49FE91620BC193F7E22791FF0127F223D2BD52BE3FD075CBAF0D6AF6F7D67218AE2D9F7A30FE47D41E847706BE99F863F13ECBE24E8E2588AC37B081F68B727E68CFA8F553D8FE1D6BFA23C01F13A866597C38771F3B6228AB42FF6E0B64BFBD05A35BB8A4D5ED2B7C5F18E433A159E368AF725BF93FF0027F9E9D8E9E8A28AFE923E1428A28A002BC97F69DF1FAD96971E836F27EFAEB12DCE0FDD8C1CAA9FA919FA0F7AEC3E28FC52B3F86FA41672B35FCCA7ECF6F9E58FF79BD147AF7E82BE67D6758B8D7F55B8BDBA91A6B8B972EEE7B9FF000ED8EC2BF99FE901E2750CBF013E1CCBE77AF595AA5BEC41EE9FF7A6B4B748B6DDAF1BFDDF06E433AD5963AB2F723F0F9BEFE8BF3F9956BBFF00D9CBC26DE21F8811DD32E6DF4A5F3D8F6DFD107E7CFF00C06B8244695D55559998E0003249AFA73E0BF807FE100F06450CCB8BEBA3E7DCFF00B2C470BFF011C7D735F81F817C193CF78969E22A47F73866AA4DF4BA7EE47D5C95EDD63191F63C5D9A2C2606504FDFA9EEAF4EAFE4BF168EBA8A28AFF450FC4C28A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A0028A28A002BC33F685F842DA65DCBAF69B0E6D663BAEE341FEA58FF0018FF0064F7F43EC78F73A6CB12CF1B23AAB2B021948C823D0D7C4F1F7036078AB2A965D8CF765BC2695DC25D1AEE9ED25D576766BD5C9F36AB97E2157A7AAD9AEEBFAD99F1AD5AD1F5ABBF0FEA11DDD95C496B7109CAC887047FF5BD8F06BD4BE2D7ECEB3594B2EA3E1F8DA6B76CB4966BCBC7EE9EA3FD9EA3B67B792C91B44ECACACACA70411820D7F9D3C53C239D70A663F57C745D39C5DE138DF96567A4A1256F27D1AEA933F6CCBF32C2E63439E8B4D3DD3DD7935FD267B3F82BF6A68CC490EBB68CAE38FB45B0C86F7287A7E07F0AEEF4FF008CFE17D4A30D1EB5671E7B4AC6223F0602BE5BA335FA770FFD2378A72FA2A862B93109759A6A5FF8145ABFAB4DBEACF0719C1197D6973D3BC3C96DF73BFE0CFA9351F8D1E17D3232D26B369263B424CA4FFDF20D705E36FDA994C4F0E836AC18F1F69B91D3DD53FC4FE15E319A2A7883E919C5398D17430BC9874FAC13E7FF00C0A4DDBD62935D18F07C1397D0973D4BCFD76FB95BF12C6ADABDD6B97F25D5E4F25C5C4C72F24872C7FCFA557A745134F22A22B3331C2A81924FA0AF5EF849FB3AC934916A3E208FCB8D4868EC9BEF3FA193D07FB3D7D71D0FE6BC27C1B9CF15E61F57C041CE4DDE7395F96377ACA72D7CDF594BA26CF7331CD30B9751E7ACECBA25BBF24BFA486FECEFF085AEAE22F106A51158633BACA261F7DBFE7A11E83B7A9E7B0CFB752222C4815542AA8C00074A5AFF0045B80F82303C2D95432DC1EAF79CDAD6727BB7D9744BA2496AEEDFE279BE6D5730C43AF57D12ECBB7F9F98514515F68796145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450015CC78DFE11687E3CDD25DDAF957447FC7CC07649F8F66FC41AE9E8AF3736C9F0399E1DE1331A51AB4DEF1924D7AEBB3ECD6ABA1BE1F155B0F3F69464E2FBA763C27C43FB2AEA56AECDA6DFDADDC7D424C0C4E3F983FA573377F013C5968F8FEC9793DE39A361FFA157D39457E259A7D1BB84B15373C3FB5A3E509A6BFF278C9FE27D5E1F8E332A6AD3E597AAD7F068F992CFE01F8B2EDF1FD92D18F59268D47FE855D3F877F654D42E5D5B53D42DAD63EA52006573ED93803F5AF74A29E55F46FE12C24D54AFED6B794E692FF00C92307F88B11C71995456872C7D16BF8B6735E09F84BA2780806B3B5F32EB1837331DF2FE07A2FE00574B4515FB6E5793E072CC3AC265F4A34A9ADA31492F5D3ABEADEAFA9F2B88C4D5AF3F695A4E4FBB770A28A2BD1300A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2803FFFD9)
      End

    If (Select Count(*) From Versao) = 0
	  Begin
        INSERT Into Versao (NrVersaoBd, NrVersaoApp) Values ('3.0.0.0', '3.0.0.0')
      End

    If (Select Count(*) From Configuracao Where IdEmpresa = @IdEmpresaEntrada) = 0
	  Begin
	    INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'AMEJ', N'FECHAR O TIME DE 24HORAS "MINUTOS"', N'1', 0)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'TDCS', N'TEMPO DE DURACAO CONTRA SENHA "SAFERY OPEN"', N'293054292642929', 1)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'BPIN', N'BASE DE DADOS PADRÃƒO PARA INICIALIZAÃ‡ÃƒO', N'1', 0)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'LAPP', N'LOG DA APLICAÃ‡ÃƒO "CLIQUES DO EXECUTAVEL"', N'S', 1)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'HABR', N'AGENDA - HORÁRIO DE ABERTURA DA EMPRESA', N'09:00', 0)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'NTTA', N'AGENDA - NÚMERO TOTAL DE ATENDIMENTOS', N'25', 0)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'TIEA', N'AGENDA - TEMPO DE INTERVALO ENTRE ATENDIMENTOS', N'00:30', 0)

      End

	If (Select Count(*) From Licenca) = 0
	  Begin
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenPessoas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadPessoa', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenComPessoas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadTipoPessoa', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadCidade', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadCep', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadCalendario', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenServicos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadServico', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenComServicos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadTipoServico', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenProdutos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadProduto', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenComProdutos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadMarca', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadGrupoProduto', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenOperacoes', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadOperacoesStarter', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenPesNotas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenComOperacoes', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadTipoPagamento', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenAgendas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadAgendaStarter', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenRelatorios', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenRelPessoas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenRelServicos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenRelProdutos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenRelOperacoes', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenRelAgendas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenAvancados', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadEmpresa', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadUsuario', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSupAtenderRemoto', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSupBaixaSuporte', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSupLiberarAcesso', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadConfiguracaoSistema', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenBkpBackupSistema', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenLogLogSistema', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenPapPapelParede', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSqlBancoDados', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSqlEditorBancoDados', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenAjudas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenTelLogin', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSaiSair', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenInfInformacoes', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenSobSobre', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenAtiSistema', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadGrupoServico', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCargaDados', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgPessoas', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgProdutos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgNotaStarter', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgAgendaStarter', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgConexao', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgBackup', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgLoginSistema', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgSair', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenExecutarScriptSQL', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenManManualSginERP', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenComAgenda', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadAgendaGeral', 'Full');
      End
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Configuracao                                                                                  :
: Criada Por: Clauber JÃºnio.                                                                                :
:                                                                                                            :
: VersÃ£o: 01.00.00.00 - ABRIL/2017                                                                          : 
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ã‡ Ã• E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                              :
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
  Where NrVersaoBd = '3.0.3.0'  /*<<<<---- SEMPRE INFORMAR O SCRIPT ANTERIOAR*/
 
  /*>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>INICIO LEITURA DE HISTÓRICO<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<*/
  Set @NrVersaoBd = '3.0.4.0'
  Set @NrVersaoApp = '3.0.4.XXX'
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