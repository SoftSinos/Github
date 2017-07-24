ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [FK_Agenda_Servico];
ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [FK_Agenda_Pessoa_Profissional];
ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [FK_Agenda_Pessoa_Cliente];
ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [FK_Agenda_Empresa];
ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [FK_Agenda_EmpCliente];
ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [DF_Agenda_SnRealizada];
ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [DF_Agenda_SnSituacao];
ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [DF_Agenda_DtCadastro];
ALTER TABLE [dbo].[Agenda] DROP CONSTRAINT [DF_Agenda_IdUsuario];

DROP TABLE [dbo].[Agenda]

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
	[IdServico] [int] NULL,
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

ALTER TABLE [dbo].[Agenda]  WITH CHECK ADD  CONSTRAINT [FK_Agenda_Servico] FOREIGN KEY([IdServico])
REFERENCES [dbo].[Servico] ([IdServico]);

ALTER TABLE [dbo].[Agenda] CHECK CONSTRAINT [FK_Agenda_Servico];

Alter Table Servico Add IdEmpProfissional Integer;

Update Servico Set IdEmpProfissional = 1;

Alter Table Servico Alter Column IdEmpProfissional Integer Not Null;


Alter Table TipoServico Add HrServico Time Null

Update TipoServico Set HrServico = '03:30'

Alter Table TipoServico Alter Column HrServico Time Not Null

ALTER TABLE [dbo].[TipoServico] ADD  CONSTRAINT [DF_TipoServico_HrServico]  DEFAULT ('00:00:00.0000000') FOR [HrServico]
GO