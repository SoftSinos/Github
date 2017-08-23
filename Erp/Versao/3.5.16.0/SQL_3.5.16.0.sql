If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='TpNota'
                 And SysObjects.Name='Nota')
  Begin                   
    Alter Table Nota Add TpNota Varchar(255) Null
  End
Go

Update Nota Set 
  TpNota = 'Consumo'
Go

Alter Table Nota Alter Column TpNota Varchar(255) Not Null
Go

If (Select Count(*) From SysObjects Where Name = 'TR_Insert_Log_Produto' And Type = 'TR') > 0
  Begin
    DROP TRIGGER [dbo].[TR_Insert_Log_Produto]
  End 
Go

If (Select Count(*) From SysObjects Where Name = 'TR_Update_Log_Produto' And Type = 'TR') > 0
  Begin
    DROP TRIGGER [dbo].[TR_Update_Log_Produto]
  End 
Go

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='QtdEstoque'
                 And SysObjects.Name='Produto')
  Begin                   
    Alter Table Produto Add QtdEstoque Decimal(10,3)

	ALTER TABLE [dbo].[Produto] ADD  CONSTRAINT [DF_Produto_QtdEstoque]  DEFAULT ((0)) FOR [QtdEstoque]
  End
Go

Update Produto Set
  QtdEstoque = 0
Where QtdEstoque Is Null   
Go

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='TpMovimento'
                 And SysObjects.Name='NotaItem')
  Begin                   
    Alter Table NotaItem Add TpMovimento Varchar(1) Null
  End
Go

Update NotaItem Set
  TpMovimento = 'S'
Where TpMovimento Is Null
Go

Alter Table NotaItem Alter Column TpMovimento Varchar(1) Not Null
Go

Alter Table NotaItem Alter Column IdEmpProfissional Integer Null
Go

If Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysObjects.Name='ProdutoEstoque')
  Begin                   
    DROP TABLE [dbo].[ProdutoEstoque]
  End
Go

CREATE TABLE [dbo].[ProdutoEstoque](
	[IdProdutoEstoque] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpresa] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL CONSTRAINT [DF_ProdutoEstoque_IdUsuario]  DEFAULT ((0)),
	[DtCadastro] [datetime] NOT NULL CONSTRAINT [DF_ProdutoEstoque_DtCadastro]  DEFAULT (getdate()),
	[SnSituacao] [bit] NOT NULL CONSTRAINT [DF_ProdutoEstoque_SnSituacao]  DEFAULT ((1)),
	[IdProduto] [int] NOT NULL,
	[QtdEstoque] [decimal](10, 3) NOT NULL CONSTRAINT [DF_ProdutoEstoque_QtdEstoque]  DEFAULT ((0)),
 CONSTRAINT [PK_ProdutoEstoque] PRIMARY KEY CLUSTERED 
(
	[IdProdutoEstoque] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [UN_ProdutoEstoque_IdEmpresa_IdProduto] UNIQUE NONCLUSTERED 
(
	[IdEmpresa] ASC,
	[IdProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ProdutoEstoque]  WITH CHECK ADD  CONSTRAINT [FK_ProdutoEstoque_Produto] FOREIGN KEY([IdProduto])
REFERENCES [dbo].[Produto] ([IdProduto])
GO

ALTER TABLE [dbo].[ProdutoEstoque] CHECK CONSTRAINT [FK_ProdutoEstoque_Produto]
GO

ALTER TABLE [dbo].[ProdutoEstoque]  WITH CHECK ADD  CONSTRAINT [FK_ProdutoEstoque_Empresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresa] ([IdEmpresa])
GO

ALTER TABLE [dbo].[ProdutoEstoque] CHECK CONSTRAINT [FK_ProdutoEstoque_Empresa]
GO

If Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysObjects.Name='ProdutoValor')
  Begin                   
    DROP TABLE [dbo].[ProdutoValor]
  End
Go

CREATE TABLE [dbo].[ProdutoValor](
	[IdProdutoValor] [int] IDENTITY(1,1) NOT NULL,
	[IdEmpresa] [int] NOT NULL,
	[IdUsuario] [int] NOT NULL CONSTRAINT [DF_ProdutoValor_IdUsuario]  DEFAULT ((0)),
	[DtCadastro] [datetime] NOT NULL CONSTRAINT [DF_ProdutoValor_DtCadastro]  DEFAULT (getdate()),
	[SnSituacao] [bit] NOT NULL CONSTRAINT [DF_ProdutoValor_SnSituacao]  DEFAULT ((1)),
	[IdProduto] [int] NOT NULL,
	[VlCusto] [decimal](10, 2) NOT NULL CONSTRAINT [DF_ProdutoValor_VlCusto]  DEFAULT ((0)),
	[VlVenda] [decimal](10, 2) NOT NULL CONSTRAINT [DF_ProdutoValor_VlVenda]  DEFAULT ((0)),
 CONSTRAINT [PK_ProdutoValor] PRIMARY KEY CLUSTERED 
(
	[IdProdutoValor] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [UN_ProdutoValor_IdEmpresa_IdProduto] UNIQUE NONCLUSTERED 
(
	[IdEmpresa] ASC,
	[IdProduto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[ProdutoValor]  WITH CHECK ADD  CONSTRAINT [FK_ProdutoValor_Produto] FOREIGN KEY([IdProduto])
REFERENCES [dbo].[Produto] ([IdProduto])
GO

ALTER TABLE [dbo].[ProdutoValor] CHECK CONSTRAINT [FK_ProdutoValor_Produto]
GO

ALTER TABLE [dbo].[ProdutoValor]  WITH CHECK ADD  CONSTRAINT [FK_ProdutoValor_Empresa] FOREIGN KEY([IdEmpresa])
REFERENCES [dbo].[Empresa] ([IdEmpresa])
GO

ALTER TABLE [dbo].[ProdutoValor] CHECK CONSTRAINT [FK_ProdutoValor_Empresa]
GO

If (Select Count(*) From SysObjects Where Name = 'TR_Insere_ProdutoValor' And Type = 'TR') > 0
  Begin
    DROP TRIGGER [dbo].[TR_Insere_ProdutoValor]
  End 
Go

If (Select Count(*) From SysObjects Where Name = 'TR_Insere_ProdutoEstoque' And Type = 'TR') > 0
  Begin
    DROP TRIGGER [dbo].[TR_Insere_ProdutoEstoque]
  End 
Go


/*------------------------------------------------------------------------------------------------------------
: SoftSinos.                                                                                                 :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Trigger_TR_Insere_ProdutoValor                                                                             :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir a ProdutoValor Apartir de sua Criação.                                         :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger [dbo].[TR_Insere_ProdutoValor] On [dbo].[Produto]
After Update
As
Set NoCount On
  /*Informações Uteis

  Update Produto Set NmProduto = NmProduto
  Select * From ProdutoValor
  
  */
Begin
  Declare @IdUsuario Integer
  Declare @IdProduto Integer
  
  Set @IdUsuario = 0
 
  Declare CrsInsertedGradeEstoque Cursor For
   	
  Select
    Inserted.IdUsuario,
    Inserted.IdProduto
  From Inserted

  Open CrsInsertedGradeEstoque
  Fetch Next From CrsInsertedGradeEstoque Into	  

      @IdUsuario,
      @IdProduto  

  While @@Fetch_Status = 0
    Begin	  
      Insert Into ProdutoValor (IdEmpresa, IdUsuario, IdProduto)
        Select IdEmpresa, @IdUsuario, @IdProduto From Empresa

  Fetch Next From CrsInsertedGradeEstoque Into

      @IdUsuario,
      @IdProduto
    End
  Close CrsInsertedGradeEstoque
  DealLocate CrsInsertedGradeEstoque  
End  
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos.                                                                                                 :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Trigger_TR_Insere_ProdutoValor                                                                             :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir a ProdutoValor Apartir de sua Criação.                                         :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*------------------------------------------------------------------------------------------------------------
: SoftSinos.                                                                                                 :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Trigger_TR_Insere_ProdutoEstoque                                                                           :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir a ProdutoEstoque Apartir de sua Criação.                                       :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger [dbo].[TR_Insere_ProdutoEstoque] On [dbo].[Produto]
After Update
As
Set NoCount On
  /*Informações Uteis

  Update Produto Set NmProduto = NmProduto
  Select * From ProdutoEstoque
  Select * From Produto
  
  */
Begin
  Declare @IdUsuario Integer
  Declare @IdProduto Integer
  
  Set @IdUsuario = 0
 
  Declare CrsInsertedGradeEstoque Cursor For
   	
  Select
    Inserted.IdUsuario,
    Inserted.IdProduto
  From Inserted

  Open CrsInsertedGradeEstoque
  Fetch Next From CrsInsertedGradeEstoque Into	  

      @IdUsuario,
      @IdProduto  

  While @@Fetch_Status = 0
    Begin	  
      Insert Into ProdutoEstoque (IdEmpresa, IdUsuario, IdProduto)
        Select IdEmpresa, @IdUsuario, @IdProduto From Empresa

  Fetch Next From CrsInsertedGradeEstoque Into

      @IdUsuario,
      @IdProduto
    End
  Close CrsInsertedGradeEstoque
  DealLocate CrsInsertedGradeEstoque  
End  
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos.                                                                                                 :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Trigger_TR_Insere_ProdutoEstoque                                                                           :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir a ProdutoEstoque Apartir de sua Criação.                                       :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

Update Produto Set NmProduto = NmProduto
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos.                                                                                                 :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Trigger_TR_Insere_ProdutoValor                                                                             :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir a ProdutoValor Apartir de sua Criação.                                         :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Alter Trigger [dbo].[TR_Insere_ProdutoValor] On [dbo].[Produto]
After Insert
As
Set NoCount On
  /*Informações Uteis

  Update Produto Set NmProduto = NmProduto
  Select * From ProdutoValor
  
  */
Begin
  Declare @IdUsuario Integer
  Declare @IdProduto Integer
  
  Set @IdUsuario = 0
 
  Declare CrsInsertedGradeEstoque Cursor For
   	
  Select
    Inserted.IdUsuario,
    Inserted.IdProduto
  From Inserted

  Open CrsInsertedGradeEstoque
  Fetch Next From CrsInsertedGradeEstoque Into	  

      @IdUsuario,
      @IdProduto  

  While @@Fetch_Status = 0
    Begin	  
      Insert Into ProdutoValor (IdEmpresa, IdUsuario, IdProduto)
        Select IdEmpresa, @IdUsuario, @IdProduto From Empresa

  Fetch Next From CrsInsertedGradeEstoque Into

      @IdUsuario,
      @IdProduto
    End
  Close CrsInsertedGradeEstoque
  DealLocate CrsInsertedGradeEstoque  
End  
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos.                                                                                                 :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Trigger_TR_Insere_ProdutoValor                                                                             :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir a ProdutoValor Apartir de sua Criação.                                         :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*------------------------------------------------------------------------------------------------------------
: SoftSinos.                                                                                                 :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Trigger_TR_Insere_ProdutoEstoque                                                                           :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir a ProdutoEstoque Apartir de sua Criação.                                       :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Alter Trigger [dbo].[TR_Insere_ProdutoEstoque] On [dbo].[Produto]
After Insert
As
Set NoCount On
  /*Informações Uteis

  Update Produto Set NmProduto = NmProduto
  Select * From ProdutoEstoque
  Select * From Produto
  
  */
Begin
  Declare @IdUsuario Integer
  Declare @IdProduto Integer
  
  Set @IdUsuario = 0
 
  Declare CrsInsertedGradeEstoque Cursor For
   	
  Select
    Inserted.IdUsuario,
    Inserted.IdProduto
  From Inserted

  Open CrsInsertedGradeEstoque
  Fetch Next From CrsInsertedGradeEstoque Into	  

      @IdUsuario,
      @IdProduto  

  While @@Fetch_Status = 0
    Begin	  
      Insert Into ProdutoEstoque (IdEmpresa, IdUsuario, IdProduto)
        Select IdEmpresa, @IdUsuario, @IdProduto From Empresa

  Fetch Next From CrsInsertedGradeEstoque Into

      @IdUsuario,
      @IdProduto
    End
  Close CrsInsertedGradeEstoque
  DealLocate CrsInsertedGradeEstoque  
End  
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos.                                                                                                 :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Trigger_TR_Insere_ProdutoEstoque                                                                           :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir a ProdutoEstoque Apartir de sua Criação.                                       :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

If (Select Count(*) From SysObjects Where Name = 'DF_Produto_VlCusto' And Type = 'D') > 0
  Begin
    Alter Table Produto Drop Constraint DF_Produto_VlCusto
  End 
Go

If Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='VlCusto'
                 And SysObjects.Name='Produto')
  Begin                   
    Alter Table Produto Drop Column VlCusto
  End
Go

If (Select Count(*) From SysObjects Where Name = 'DF_Produto_VlVenda' And Type = 'D') > 0
  Begin
    Alter Table Produto Drop Constraint DF_Produto_VlVenda
  End 
Go 

If Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='VlVenda'
                 And SysObjects.Name='Produto')
  Begin                   
    Alter Table Produto Drop Column VlVenda
  End
Go

If (Select Count(*) From SysObjects Where Name = 'DF_Produto_QtdEstoque' And Type = 'D') > 0
  Begin
    Alter Table Produto Drop Constraint DF_Produto_QtdEstoque
  End 
Go 

If Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='QtdEstoque'
                 And SysObjects.Name='Produto')
  Begin                   
    Alter Table Produto Drop Column QtdEstoque
  End
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridProduto                                                                                        :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as Produto do Sistema                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER View [dbo].[VW_GridProduto]
As
  /* Informações Uteis
  
  Select * From VW_GridProduto

  */
  Select
    Produto.*,
	ProdutoEstoque.IdEmpresa IdEmpresaEstoque,
	Empresa.NmRazaoSocial,
	ProdutoEstoque.QtdEstoque,
	ProdutoValor.IdProdutoValor,
	ProdutoValor.IdEmpresa IdEmpresaValor,
	ProdutoValor.VlCusto,
	ProdutoValor.VlVenda,
	Marca.NmMarca,
	GrupoProduto.NmGrupoProduto,
	Case
	  When Produto.IdUsuario = 0 Then 'SOFTSINOS'
	  Else Usuario.NmLogin
    End As NmUsuarioCadastro
  From Produto
    Left Join Usuario
	  On Usuario.IdUsuario = Produto.IdUsuario
    Inner Join Marca
	  On Marca.IdMarca = Produto.IdMarca
    Inner Join GrupoProduto
	  On GrupoProduto.IdGrupoProduto = Produto.IdGrupoProduto
    Inner Join ProdutoEstoque
	  On ProdutoEstoque.IdProduto = Produto.IdProduto
    Inner Join ProdutoValor
	  On ProdutoValor.IdProduto = Produto.IdProduto
    Inner Join Empresa
	  On Empresa.IdEmpresa = ProdutoValor.IdEmpresa
   
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: View_VW_GridProduto                                                                                        :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
:                                                                                                            :
: View criada para mostrar as Produto do Sistema                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_Produto                                                                              :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
CREATE Trigger [dbo].[TR_Insert_Log_Produto] On [dbo].[Produto]
For Insert
As
Set NoCount On
 
  Declare @IdProduto Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @NmProduto Varchar(255)
  Declare @IdMarca Integer
  Declare @IdGrupoProduto Integer
  Declare @NrEan Varchar(255)
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedInsertProduto Cursor For
 
    Select
      Inserted.IdProduto,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.NmProduto,
      Inserted.IdMarca,
      Inserted.IdGrupoProduto,
      Inserted.NrEan
    From Inserted
 
  Open CrsInsertedInsertProduto
  Fetch Next From CrsInsertedInsertProduto Into
 
      @IdProduto,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @NmProduto,
      @IdMarca,
      @IdGrupoProduto,
      @NrEan
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2)
        Values (
		  0,
          @IdUsuario,
          'SQL Server',
          'Inseriu',
          'Produto',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdProduto,
          @NrEan
          )
 
  Fetch Next From CrsInsertedInsertProduto Into
 
      @IdProduto,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @NmProduto,
      @IdMarca,
      @IdGrupoProduto,
      @NrEan
 
    End
  Close CrsInsertedInsertProduto
  DealLocate CrsInsertedInsertProduto
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_Produto                                                                              :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/04/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
GO

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_Produto                                                                              :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
CREATE Trigger [dbo].[TR_Update_Log_Produto] On [dbo].[Produto]
For Update
As
Set NoCount On
 
  Declare @IdProduto Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @NmProduto Varchar(255)
  Declare @IdMarca Integer
  Declare @IdGrupoProduto Integer
  Declare @NrEan Varchar(255) 
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedUpdateProduto Cursor For
 
    Select
      Inserted.IdProduto,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.NmProduto,
      Inserted.IdMarca,
      Inserted.IdGrupoProduto,
      Inserted.NrEan
    From Inserted
 
  Open CrsInsertedUpdateProduto
  Fetch Next From CrsInsertedUpdateProduto Into
 
      @IdProduto,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @NmProduto,
      @IdMarca,
      @IdGrupoProduto,
      @NrEan
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2)
        Values (
		  0,
          @IdUsuario,
          'SQL Server',
          'Atualizou',
          'Produto',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdProduto,
          @NrEan
          )
 
  Fetch Next From CrsInsertedUpdateProduto Into
 
      @IdProduto,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @NmProduto,
      @IdMarca,
      @IdGrupoProduto,
      @NrEan
 
    End
  Close CrsInsertedUpdateProduto
  DealLocate CrsInsertedUpdateProduto
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_Produto                                                                              :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/04/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
GO

If Exists (Select * From Sys.Triggers Where Name = 'TR_Update_Log_ProdutoEstoque')
DROP TRIGGER TR_Update_Log_ProdutoEstoque
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_ProdutoEstoque                                                                       :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Update_Log_ProdutoEstoque On ProdutoEstoque
For Update
As
Set NoCount On
 
  Declare @IdProdutoEstoque Integer
  Declare @IdEmpresa Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdProduto Integer
  Declare @QtdEstoque Decimal(10,2)
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedUpdateProdutoEstoque Cursor For
 
    Select
      Inserted.IdProdutoEstoque,
      Inserted.IdEmpresa,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdProduto,

      Inserted.QtdEstoque
    From Inserted
 
  Open CrsInsertedUpdateProdutoEstoque
  Fetch Next From CrsInsertedUpdateProdutoEstoque Into
 
      @IdProdutoEstoque,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdProduto,
      @QtdEstoque
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2, Pk3)
        Values (
          @IdEmpresa,
          @IdUsuario,
          'SQL Server',
          'Update',
          'ProdutoEstoque',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdProdutoEstoque,
          @IdEmpresa,
          @IdProduto
          )
 
  Fetch Next From CrsInsertedUpdateProdutoEstoque Into
 
      @IdProdutoEstoque,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdProduto,
      @QtdEstoque
 
    End
  Close CrsInsertedUpdateProdutoEstoque
  DealLocate CrsInsertedUpdateProdutoEstoque
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_ProdutoEstoque                                                                       :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Insert_Log_ProdutoEstoque')
DROP TRIGGER TR_Insert_Log_ProdutoEstoque
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_ProdutoEstoque                                                                       :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Insert_Log_ProdutoEstoque On ProdutoEstoque
For Insert
As
Set NoCount On
 
  Declare @IdProdutoEstoque Integer
  Declare @IdEmpresa Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdProduto Integer
  Declare @QtdEstoque Decimal(10,2)
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedInsertProdutoEstoque Cursor For
 
    Select
      Inserted.IdProdutoEstoque,
      Inserted.IdEmpresa,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdProduto,
      Inserted.QtdEstoque
    From Inserted
 
  Open CrsInsertedInsertProdutoEstoque
  Fetch Next From CrsInsertedInsertProdutoEstoque Into
 
      @IdProdutoEstoque,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdProduto,
      @QtdEstoque
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2, Pk3)
        Values (
          @IdEmpresa,
          @IdUsuario,
          'SQL Server',
          'Insert',
          'ProdutoEstoque',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdProdutoEstoque,
          @IdEmpresa,
          @IdProduto
          )
 
  Fetch Next From CrsInsertedInsertProdutoEstoque Into
 
      @IdProdutoEstoque,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdProduto,
      @QtdEstoque
 
    End
  Close CrsInsertedInsertProdutoEstoque
  DealLocate CrsInsertedInsertProdutoEstoque
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_ProdutoEstoque                                                                       :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Insert_Log_ProdutoValor')
DROP TRIGGER TR_Insert_Log_ProdutoValor
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_ProdutoValor                                                                         :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Insert_Log_ProdutoValor On ProdutoValor
For Insert
As
Set NoCount On
 
  Declare @IdProdutoValor Integer
  Declare @IdEmpresa Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdProduto Integer
  Declare @VlCusto Decimal(10,2)
  Declare @VlVenda Decimal(10,2)
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedInsertProdutoValor Cursor For
 
    Select
      Inserted.IdProdutoValor,
      Inserted.IdEmpresa,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdProduto,
      Inserted.VlCusto,
      Inserted.VlVenda
    From Inserted
 
  Open CrsInsertedInsertProdutoValor
  Fetch Next From CrsInsertedInsertProdutoValor Into
 
      @IdProdutoValor,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdProduto,
      @VlCusto,
      @VlVenda
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2, Pk3)
        Values (
          @IdEmpresa,
          @IdUsuario,
          'SQL Server',
          'Insert',
          'ProdutoValor',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdProdutoValor,
          @IdEmpresa,
          @IdProduto
          )
 
  Fetch Next From CrsInsertedInsertProdutoValor Into
 
      @IdProdutoValor,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdProduto,
      @VlCusto,
      @VlVenda
 
    End
  Close CrsInsertedInsertProdutoValor
  DealLocate CrsInsertedInsertProdutoValor
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Insert_Log_ProdutoValor                                                                         :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Exists (Select * From Sys.Triggers Where Name = 'TR_Update_Log_ProdutoValor')
DROP TRIGGER TR_Update_Log_ProdutoValor
Go
 
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_ProdutoValor                                                                         :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger TR_Update_Log_ProdutoValor On ProdutoValor
For Update
As
Set NoCount On
 
  Declare @IdProdutoValor Integer
  Declare @IdEmpresa Integer
  Declare @IdUsuario Integer
  Declare @DtCadastro DateTime
  Declare @SnSituacao Bit
  Declare @IdProduto Integer
  Declare @VlCusto Decimal(10,2)
  Declare @VlVenda Decimal(10,2)
 
  Declare @NmComputador Varchar(255)
  Declare @NmVersao Varchar(255)
 
  Set @NmComputador = Cast(SERVERPROPERTY('ComputerNamePhysicalNetBIOS') As Varchar(255))
 
  Set @NmVersao = (Select NrVersaoApp + '/' + NrVersaoBd From Versao Where IdVersao = (Select Max(IdVersao) As IdVersaoBd From Versao))
 
  Declare CrsInsertedUpdateProdutoValor Cursor For
 
    Select
      Inserted.IdProdutoValor,
      Inserted.IdEmpresa,
      Inserted.IdUsuario,
      Inserted.DtCadastro,
      Inserted.SnSituacao,
      Inserted.IdProduto,
      Inserted.VlCusto,
      Inserted.VlVenda
    From Inserted
 
  Open CrsInsertedUpdateProdutoValor
  Fetch Next From CrsInsertedUpdateProdutoValor Into
 
      @IdProdutoValor,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdProduto,
      @VlCusto,
      @VlVenda
 
  While @@Fetch_Status = 0
    Begin
      Insert Into Log (IdEmpresa, IdUsuario, NmModulo, NmOperacao, NmTabela, NmClasse, NmMetodo, NmVersao, NmMensagem, NmComputador, Pk1, Pk2, Pk3)
        Values (
          @IdEmpresa,
          @IdUsuario,
          'SQL Server',
          'Update',
          'ProdutoValor',
          '',
          '',
          @NmVersao,
          '',
          @NmComputador,
          @IdProdutoValor,
          @IdEmpresa,
          @IdProduto
          )
 
  Fetch Next From CrsInsertedUpdateProdutoValor Into
 
      @IdProdutoValor,
      @IdEmpresa,
      @IdUsuario,
      @DtCadastro,
      @SnSituacao,
      @IdProduto,
      @VlCusto,
      @VlVenda
 
    End
  Close CrsInsertedUpdateProdutoValor
  DealLocate CrsInsertedUpdateProdutoValor
Set NoCount Off
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Trigger_TR_Update_Log_ProdutoValor                                                                         :
: Criado Por: Clauber                                                                                        :
:                                                                                                            :
: Versão: 01.00.00.00 - 10/08/2017 - CRIAÇÃO                                                                 :
:                                                                                                            :
: Trigger Criada para Inserir Iniciar a Sincronização de Dados.                                              :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   'D B A'                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='IdFornecedor'
                 And SysObjects.Name='Nota')
  Begin                   
    Alter Table Nota Add IdFornecedor Integer Null
  End
Go

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='IdEmpFornecedor'
                 And SysObjects.Name='Nota')
  Begin                   
    Alter Table Nota Add IdEmpFornecedor Integer Null
  End
Go

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='DtEmissao'
                 And SysObjects.Name='Nota')
  Begin                   
    Alter Table Nota Add DtEmissao Date
  End
Go

If Not Exists (Select 
                 SysObjects.Name  
               From SysColumns 
                 Inner Join SysObjects 
                   On SysColumns.Id = SysObjects.Id
               Where SysColumns.Name='NrNota'
                 And SysObjects.Name='Nota')
  Begin                   
    Alter Table Nota Add NrNota Varchar(255) Null
  End
Go

Alter Table Nota Alter Column IdCliente Integer Null
Go

Alter Table Nota Alter Column IdEmpCliente Integer Null
Go

If (Select Count(*) From SysObjects Where Name = 'TR_Atualiza_ProdutoEstoque_NotaItem' And Type = 'TR') > 0
  Begin
    DROP TRIGGER [dbo].[TR_Atualiza_ProdutoEstoque_NotaItem]
  End 
Go

If (Select Count(*) From SysObjects Where Name = 'TR_Estorna_ProdutoEstoque_NotaItem' And Type = 'TR') > 0
  Begin
    DROP TRIGGER [dbo].[TR_Estorna_ProdutoEstoque_NotaItem]
  End 
Go



/*------------------------------------------------------------------------------------------------------------
: SoftSinos.                                                                                                 :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Trigger_TR_Estorna_ProdutoEstoque_NotaItem                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir a ProdutoValor Apartir de sua Criação.                                         :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger [dbo].[TR_Estorna_ProdutoEstoque_NotaItem] On [dbo].[NotaItem]
After Insert
As
Set NoCount On
  /*Informações Uteis

  Update Produto Set NmProduto = NmProduto
  Select * From ProdutoValor
  
  */
Begin
	Declare @IdEmpresa Integer
	Declare @IdProduto Integer
	Declare @QtdNotaItem Decimal(10,3)
	Declare @TpMovimento Varchar(1)
	Declare @QtdEstoque Decimal(10,3)

	Select
	  @IdEmpresa = Inserted.IdEmpresa,
	  @IdProduto = Inserted.IdProduto,
	  @QtdNotaItem = Inserted.QtdNotaItem,
	  @TpMovimento = Inserted.TpMovimento
	From Inserted
	Where Inserted.IdProduto Is Not Null

	Select
	  @QtdEstoque = QtdEstoque
	From ProdutoEstoque
	Where IdEmpresa = @IdEmpresa
	  And IdProduto = @IdProduto

	If @TpMovimento = 'E'
	  Begin
		Update  ProdutoEstoque Set
		  QtdEstoque = QtdEstoque + @QtdNotaItem
		Where IdEmpresa = @IdEmpresa
		  And IdProduto = @IdProduto
	  End
	Else
	If @TpMovimento = 'S'
	  Begin
		Update  ProdutoEstoque Set
		  QtdEstoque = QtdEstoque - @QtdNotaItem
		Where IdEmpresa = @IdEmpresa
		  And IdProduto = @IdProduto
	  End
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos.                                                                                                 :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Trigger_TR_Atualiza_ProdutoEstoque_NotaItem                                                                :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir a ProdutoValor Apartir de sua Criação.                                         :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Go




/*------------------------------------------------------------------------------------------------------------
: SoftSinos.                                                                                                 :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Trigger_TR_Atualiza_ProdutoEstoque_NotaItem                                                                :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir a ProdutoValor Apartir de sua Criação.                                         :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Create Trigger [dbo].[TR_Atualiza_ProdutoEstoque_NotaItem] On [dbo].[NotaItem]
After Update
As
Set NoCount On
  /*Informações Uteis

  Update Produto Set NmProduto = NmProduto
  Select * From ProdutoValor
  
  */
Begin
	Declare @IdEmpresa Integer
	Declare @IdProduto Integer
	Declare @QtdNotaItem Decimal(10,3)
	Declare @TpMovimento Varchar(1)
	Declare @QtdEstoque Decimal(10,3)

	Select
	  @IdEmpresa = Deleted.IdEmpresa,
	  @IdProduto = Deleted.IdProduto,
	  @QtdNotaItem = Deleted.QtdNotaItem,
	  @TpMovimento = Deleted.TpMovimento
	From Inserted
	  Inner Join Deleted
	    On Deleted.IdNotaItem = Inserted.IdNotaItem
	Where Deleted.IdProduto Is Not Null
	  And Deleted.SnSituacao <> Inserted.SnSituacao
	  And Deleted.SnSituacao = 0

	Select
	  @QtdEstoque = QtdEstoque
	From ProdutoEstoque
	Where IdEmpresa = @IdEmpresa
	  And IdProduto = @IdProduto

	If @TpMovimento = 'E'
	  Begin
		Update  ProdutoEstoque Set
		  QtdEstoque = QtdEstoque - @QtdNotaItem
		Where IdEmpresa = @IdEmpresa
		  And IdProduto = @IdProduto
	  End
	Else
	If @TpMovimento = 'S'
	  Begin
		Update  ProdutoEstoque Set
		  QtdEstoque = QtdEstoque + @QtdNotaItem
		Where IdEmpresa = @IdEmpresa
		  And IdProduto = @IdProduto
	  End
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos.                                                                                                 :
: Criado Por: Clauber Júnio                                                                                  :
:                                                                                                            :
: Trigger_TR_Estorna_ProdutoEstoque_NotaItem                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - AGOSTO/2017                                                                          :
:                                                                                                            :
: Trigger Criada para Inserir a ProdutoValor Apartir de sua Criação.                                         :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
Go

If (Select Count(*) From Licenca Where NmMenu = 'MenCadNotaEntradaEstoque' ) = 0
  Begin
    Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadNotaEntradaEstoque', 'Full');
  End
Go

/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Configuracao                                                                                  :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: VersÃ£o: 01.00.03.01 - AGOSTO/2017                                                                         : 
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
ALTER Proc [dbo].[PC_Configuracao](@IdEmpresaEntrada Integer)
As
Set NoCount On
  /*Informações Uteis
	Sempre sera iniciao para a IdEmpresa = 0

	Insert Into SoftHouse (NmLogoTipo) Values ((Select * From OPENROWSET(BULK N'D:\SoftSinos\Desenvolvimento\Imagem\Logo\Logo.jpg', SINGLE_BLOB) AS Imagem ))

	Exec PC_Configuracao 1
  */
Begin
	If (Select Count(*) From TipoPagamento) = 0
	  Begin
        Insert Into TipoPagamento([IdUsuario], [NmTpPagamento]) Values (0, 'DINHEIRO') 
        Insert Into TipoPagamento([IdUsuario], [NmTpPagamento]) Values (0, 'CREDITO') 
        Insert Into TipoPagamento([IdUsuario], [NmTpPagamento]) Values (0, 'DEBITO') 
        Insert Into TipoPagamento([IdUsuario], [NmTpPagamento]) Values (0, 'CHEQUE') 
      End	
	
	If (Select Count(*) From SoftHouse) = 0
	  Begin
		Insert Into SoftHouse (NmLogoTipo) Values ((Select * From OPENROWSET(BULK N'C:\SginERP\Imagem\Sistema\Logo.jpg', SINGLE_BLOB) AS Imagem ))
	  End

    If (Select Count(*) From Versao) = 0
	  Begin
        INSERT Into Versao (NrVersaoBd, NrVersaoApp) Values ('3.0.0.0', '3.0.0.0')
      End

    If (Select Count(*) From Configuracao Where IdEmpresa = @IdEmpresaEntrada) = 0
	  Begin
	    INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'AMEJ', N'FECHAR O TIME DE 24HORAS "MINUTOS"', N'1', 0)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'TDCS', N'TEMPO DE DURACAO CONTRA SENHA "SAFERY OPEN"', N'293054292642929', 1)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'BPIN', N'BASE DE DADOS PADRÃƒO PARA INICIALIZAÇÃO', N'1', 0)
        INSERT INTO [dbo].[Configuracao]  ([IdEmpresa] ,[IdUsuario] ,[DtCadastro] ,[SnSituacao] ,[NmSigla] ,[NmConfiguracao] ,[NmValor] ,[SnSuporte])  VALUES(@IdEmpresaEntrada, 0, CAST(N'2015-10-13 15:40:32.687' AS DateTime), 1, N'LAPP', N'LOG DA APLICAÇÃO "CLIQUES DO EXECUTAVEL"', N'S', 1)
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
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgNotaPesquisa', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenExecutarScriptSQL', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenManManualSginERP', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenComAgenda', 'Full');	
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadAgendaGeral', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenPnlPainelDiario', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'ImgPainel', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelClientes', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelProfissionais', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelServicos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelProdutos', 'Full');
		Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'RelFinanceiros', 'Full');
    	Insert Into Licenca (IdUsuario, SnSituacao, NmMenu, NmLicenca) Values (0, 1,'MenCadNotaEntradaEstoque', 'Full');
      End
End
/*------------------------------------------------------------------------------------------------------------
: SoftSinos                                                                                                  :
:                                                                                                            :
: Procedure_PC_Configuracao                                                                                  :
: Criada Por: Clauber Júnio.                                                                                 :
:                                                                                                            :
: Versão: 01.00.00.00 - ABRIL/2017                                                                           :
: Versão: 01.00.01.00 - 18/06/2017 - ADICIONADO NOVOS MENUS DE ACESSO.                                       : 
: Versão: 01.00.02.00 - 29/06/2017 - ADICIONADO A NOVA LOGO MARCA DA SOFTHOUSE.                              : 
: Versão: 01.00.02.01 - 12/07/2017 - AJUSTE NA CHAMADA A LOGO MARCA DA SOFTHOUSE.                            : 
: Versão: 01.00.02.02 - 20/07/2017 - RETIRADO MENUS DESNECESSARIOS.                                          : 
: Versão: 01.00.02.03 - 24/07/2017 - AJUSTE DO ALIAS DA BASE DE CARGA, ADIÇÃO DE MAIS UM TIPO DE PAGAMENTO.  : 
: Versão: 01.00.03.00 - 08/08/2017 - RETIRADO O INSERT QUE VEM DA BASE DE CARGA.                             :
: Versão: 01.00.03.00 - 21/08/2017 - ADICIONADO NOVO MENU.                                                   :
:                                                                                                            :
: Procedure Criada para Inicialiar Alguns Dados.                                                             :
: M O D I F I C A Ç Õ E S   D E V E   S E R   F E I T A S   P E L O   "D B A"                                :
-------------------------------------------------------------------------------------------------------------*/
GO