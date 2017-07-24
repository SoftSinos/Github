unit fNotaConsumoStarter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  dxSkinsCore, dxSkinsDefaultPainters, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.Menus, cxButtons, cxCheckBox, dxSkinscxPCPainter, cxPC;

type
  TFrmNotaConsumoStarter = class(TFrmCadastro)
    CdsServico              : TClientDataSet;
    CdsProduto              : TClientDataSet;
    CdsTipoPagamento        : TClientDataSet;
    GroupBox2               : TGroupBox;
    Label11                 : TLabel;
    Label13                 : TLabel;
    DtsServico              : TDataSource;
    DtsProduto              : TDataSource;
    DtsTipoPagamento        : TDataSource;
    BtnImprimir             : TcxButton;
    BtnClientePesquisar     : TcxButton;
    CbbIdEmpresa            : TcxComboBox;
    MkeNrCelular1           : TcxMaskEdit;
    EdtNmPessoa             : TcxTextEdit;
    Label3                  : TLabel;
    EdtVlGeral              : TcxTextEdit;
    BtnEmpresaPesquisa      : TcxButton;
    PgcExtra                : TPageControl;
    TabServico              : TTabSheet;
    GrbServico              : TGroupBox;
    DbgServico              : TDBGrid;
    GroupBox5               : TGroupBox;
    Label15                 : TLabel;
    Label17                 : TLabel;
    Label23                 : TLabel;
    Label25                 : TLabel;
    Label14                 : TLabel;
    CbbIdProfServico        : TcxComboBox;
    CbbIdServico            : TcxComboBox;
    EdtQtdNotaItemServico   : TcxTextEdit;
    EdtVlServico            : TcxTextEdit;
    EdtDescServico          : TcxTextEdit;
    Panel1                  : TPanel;
    BtnAdiServico           : TcxButton;
    BtnCanServico           : TcxButton;
    TabProduto              : TTabSheet;
    GrbProduto              : TGroupBox;
    GroupBox6               : TGroupBox;
    Label7                  : TLabel;
    Label18                 : TLabel;
    Label4                  : TLabel;
    Label19                 : TLabel;
    Label20                 : TLabel;
    BtnProdutoPesquisar     : TcxButton;
    CbbIdProfProduto        : TcxComboBox;
    EdtNrEan                : TcxTextEdit;
    EdtNmProduto            : TcxTextEdit;
    Panel2                  : TPanel;
    BtnAdiProduto           : TcxButton;
    BtnCanProduto           : TcxButton;
    EdtQtdNotaItemProduto   : TcxTextEdit;
    EdtVlProduto            : TcxTextEdit;
    EdtDescProduto          : TcxTextEdit;
    DbgProduto              : TDBGrid;
    PgcExtra2               : TPageControl;
    TabTipoPagamento        : TTabSheet;
    GrbTipoPagamento        : TGroupBox;
    Panel3                  : TPanel;
    Label2                  : TLabel;
    Label5                  : TLabel;
    Label8                  : TLabel;
    Label26                 : TLabel;
    Label24                 : TLabel;
    Label6                  : TLabel;
    Label10                 : TLabel;
    Panel4                  : TPanel;
    BtnAdiTipoPagamento     : TcxButton;
    BtnCanTipoPagamento     : TcxButton;
    EdtVlPgtoDinheiro       : TcxTextEdit;
    EdtVlPgtoDebito         : TcxTextEdit;
    EdtVlPgtoCredito        : TcxTextEdit;
    MkeVlServicos           : TcxTextEdit;
    MkeVlProdutos           : TcxTextEdit;
    EdtVlTroco              : TcxTextEdit;
    EdtVlRestante           : TcxTextEdit;
    DbgPagamento            : TDBGrid;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnProdutoPesquisarClick(Sender: TObject);
    procedure BtnClientePesquisarClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnAdiServicoClick(Sender: TObject);
    procedure EdtNrEanKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAdiTipoPagamentoClick(Sender: TObject);
    procedure MkeNrCelular1KeyPress(Sender: TObject; var Key: Char);
    procedure EdtQtdNotaItemServicoExit(Sender: TObject);
    procedure EdtDescServicoExit(Sender: TObject);
    procedure BtnCanServicoClick(Sender: TObject);
    procedure BtnAdiProdutoClick(Sender: TObject);
    procedure BtnCanProdutoClick(Sender: TObject);
    procedure EdtDescProdutoExit(Sender: TObject);
    procedure EdtQtdNotaItemProdutoExit(Sender: TObject);
    procedure BtnCanTipoPagamentoClick(Sender: TObject);
    procedure EdtVlPgtoDinheiroExit(Sender: TObject);
    procedure EdtVlPgtoDebitoExit(Sender: TObject);
    procedure EdtVlPgtoCreditoExit(Sender: TObject);
    procedure MkeNrCelular1PropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure TabProdutoClick(Sender: TObject);
    procedure BtnEmpresaPesquisaClick(Sender: TObject);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
    procedure BtnSalvarClick(Sender: TObject);
    procedure CbbIdProfServicoClick(Sender: TObject);
    procedure CbbIdServicoClick(Sender: TObject);
    procedure CbbIdProfProdutoClick(Sender: TObject);
    procedure EdtNrEanExit(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
    procedure InicializarServico;
    procedure InicializarProduto;
    procedure InicializarTipoPagamento;
    procedure AtualizaVlServicos;
    procedure AtualizaVlProdutos;
    procedure AtualizaVlGeral;
    procedure NotaItemServico;
    procedure NotaItemProduto;
    procedure NotaPagamento;
    procedure SetaFoco;
    procedure ValorRestante;
  public
    { Public declarations }
    procedure CarregarTela(ATpChamadaClasse: String);
    procedure CopulaTela;
    procedure ControleBotao;
    procedure Edicao;
  end;

var
  FrmNotaConsumoStarter: TFrmNotaConsumoStarter;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uNota, uNotaItem, uNotaPagamento, fAjuda, fPessoaPesquisa, fProdutoPesquisa,
    fTipoPagamentoPesquisa, dRelatorios, uEmpresa, uPessoa, uServico, uProduto, uTipoPagamento, fPrincipal, fEmpresaPesquisa;

var
  unNota             : TNota;
  unNotaItem         : TNotaItem;
  unNotaPagamento    : TNotaPagamento;
  unCarregaDados     : TCarregaDados;
  unEmpresa          : TEmpresa;
  unPessoa           : TPessoa;
  unServico          : TServico;
  unProduto          : TProduto;
  unTipoPagamento    : TTipoPagamento;
  dnRelatorios       : TDtmRelatorios;
  lTpChamadaClasse   : Boolean;
  lFormEdit          : Boolean;
  lIdEmpCliente      : Integer;
  lIdCliente         : Integer;

procedure TFrmNotaConsumoStarter.AtualizaVlGeral;
var
  lVlGeralGrid : Currency;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'AtualizaVlGeral';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    lVlGeralGrid := 0;

    if CdsTipoPagamento.IsEmpty then
    begin
      CdsTipoPagamento.EmptyDataSet;
    end;

    CdsProduto.DisableControls;
    CdsProduto.First;

    while not CdsProduto.Eof do
    begin
      lVlGeralGrid     := lVlGeralGrid + CdsProduto.FieldByName('VlProduto').AsCurrency;

      CdsProduto.Next
    end;
    CdsProduto.EnableControls;

    CdsServico.DisableControls;
    CdsServico.First;

    while not CdsServico.Eof do
    begin
      lVlGeralGrid     := lVlGeralGrid + CdsServico.FieldByName('VlServico').AsCurrency;

      CdsServico.Next
    end;
    CdsServico.EnableControls;

  finally
    EdtVlGeral.Text    := RetornaValorEmReal(lVlGeralGrid);
    EdtVlRestante.Text := RetornaValorEmReal(lVlGeralGrid);
  end;
end;

procedure TFrmNotaConsumoStarter.AtualizaVlProdutos;
var
  lVlProdutoGrid : Currency;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'AtualizaVlProduto';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    lVlProdutoGrid := 0;

    CdsProduto.DisableControls;
    CdsProduto.First;

    while not CdsProduto.Eof do
    begin
      lVlProdutoGrid := lVlProdutoGrid + CdsProduto.FieldByName('VlProduto').AsCurrency;

      CdsProduto.Next
    end;
      MkeVlProdutos.Text := RetornaValorEmReal(lVlProdutoGrid);
      CdsProduto.EnableControls;
      InicializarProduto;
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.AtualizaVlServicos;
var
  lVlServicoGrid : Currency;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'AtualizaVlServicos';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);
  try
    lVlServicoGrid := 0;

    CdsServico.DisableControls;
    CdsServico.First;

    while not CdsServico.Eof do
    begin
      lVlServicoGrid := lVlServicoGrid + CdsServico.FieldByName('VlServico').AsCurrency;

      CdsServico.Next
    end;
      MkeVlServicos.Text := RetornaValorEmReal(lVlServicoGrid);
      CdsServico.EnableControls;
      InicializarServico;
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.BtnAdiProdutoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAdiProdutoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((unProduto.IdProduto > 0) and (unProduto.VlVenda > 0)) then
    begin
      CdsProduto.Append;
      CdsProduto.FieldByName('IdEmpProfissional').AsInteger   := unServico.IdEmpProfissional;
      CdsProduto.FieldByName('IdProfissional')   .AsInteger   := Integer(CbbIdProfProduto.Properties.Items.Objects[CbbIdProfProduto.ItemIndex]);
      CdsProduto.FieldByName('NmProfissional')   .AsString    := CbbIdProfProduto.Text;
      CdsProduto.FieldByName('IdProduto')        .AsInteger   := unProduto.IdProduto;
      CdsProduto.FieldByName('NrEan')            .AsString    := EdtNrEan.Text;
      CdsProduto.FieldByName('NmProduto')        .AsString    := EdtNmProduto.Text;
      CdsProduto.FieldByName('QtdNotaItem')      .AsFloat     := StrToFloat(EdtQtdNotaItemProduto.Text);
      CdsProduto.FieldByName('PcDesconto')       .AsCurrency  := StrToFloat(EdtDescProduto.Text);
      CdsProduto.FieldByName('VlProduto')        .AsCurrency  := StrToCurr(RemoveMoeda(EdtVlProduto.Text));
      CdsProduto.Post;
    end
    else
    begin
      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
    end;
  finally
    AtualizaVlProdutos;
    AtualizaVlGeral;
  end;
end;


procedure TFrmNotaConsumoStarter.BtnAdiServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAdiServicoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((Integer(CbbIdProfServico.Properties.Items.Objects[CbbIdProfServico.ItemIndex]) > 0) and (Integer(CbbIdServico.Properties.Items.Objects[CbbIdServico.ItemIndex]) > 0) and (unServico.VlServico > 0)) then
    begin
      CdsServico.Append;
      CdsServico.FieldByName('IdServico')         .AsInteger   := Integer(CbbIdServico.Properties.Items.Objects[CbbIdServico.ItemIndex]);
      CdsServico.FieldByName('IdEmpProfissional') .AsInteger   := unServico.IdEmpProfissional;
      CdsServico.FieldByName('IdProfissional')    .AsInteger   := Integer(CbbIdProfServico.Properties.Items.Objects[CbbIdProfServico.ItemIndex]);
      CdsServico.FieldByName('NmProfissional')    .AsString    := CbbIdProfServico.Text;
      CdsServico.FieldByName('NmTpServico')       .AsString    := CbbIdServico.Text;
      CdsServico.FieldByName('QtdNotaItem')       .AsFloat     := StrToFloat(EdtQtdNotaItemServico.Text);
      CdsServico.FieldByName('PcDesconto')        .AsCurrency  := StrToFloat(EdtDescServico.Text);
      CdsServico.FieldByName('VlServico')         .AsCurrency  := StrToCurr(RemoveMoeda(EdtVlServico.Text));
      CdsServico.Post;
    end
    else
    begin
      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
    end;
  finally
    AtualizaVlServicos;
    AtualizaVlGeral
  end;
end;

procedure TFrmNotaConsumoStarter.BtnAdiTipoPagamentoClick(Sender: TObject);
var
   lIdTpPgtoDinheiro : Integer;
   lIdTpPgtoDebito   : Integer;
   lIdTpPgtoCredito  : Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAdiTipoPagamentoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if (StrToFloat(EdtVlPgtoDinheiro.Text) = 0) or (StrToFloat(EdtVlPgtoDebito.Text) = 0) or (StrToFloat(EdtVlPgtoCredito.Text) = 0) then
    begin
      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
    end;

    if StrToFloat(EdtVlPgtoDinheiro.Text) > 1 then
    begin
      unTipoPagamento.Inicializar;
      unTipoPagamento.BuscarNmTpPagamento(DtmPrincipal.Conexao, 'DINHEIRO');

      if unTipoPagamento.IdTpPagamento > 0 then
      begin
        lIdTpPgtoDinheiro := unTipoPagamento.IdTpPagamento
      end;

      CdsTipoPagamento.Append;
      CdsTipoPagamento.FieldByName('IdTpPagamento') .AsInteger   := lIdTpPgtoDinheiro;
      CdsTipoPagamento.FieldByName('NmTpPagamento') .AsString    := 'DINHEIRO';
      CdsTipoPagamento.FieldByName('VlPagamento')   .AsCurrency  := StrToFloat(EdtVlPgtoDinheiro.Text);
      CdsTipoPagamento.Post;
    end;
    if StrToFloat(EdtVlPgtoDebito.Text) > 1 then
    begin
      unTipoPagamento.Inicializar;
      unTipoPagamento.BuscarNmTpPagamento(DtmPrincipal.Conexao, 'DEBITO');

      if unTipoPagamento.IdTpPagamento > 0 then
      begin
        lIdTpPgtoDebito := unTipoPagamento.IdTpPagamento
      end;

      CdsTipoPagamento.Append;
      CdsTipoPagamento.FieldByName('IdTpPagamento') .AsInteger   := lIdTpPgtoDebito;
      CdsTipoPagamento.FieldByName('NmTpPagamento') .AsString    := 'DEBITO';
      CdsTipoPagamento.FieldByName('VlPagamento')   .AsCurrency  := StrToFloat(EdtVlPgtoDebito.Text);
      CdsTipoPagamento.Post;
    end;
    if StrToFloat(EdtVlPgtoCredito.Text) > 1 then
    begin
      unTipoPagamento.Inicializar;
      unTipoPagamento.BuscarNmTpPagamento(DtmPrincipal.Conexao, 'CREDITO');

      if unTipoPagamento.IdTpPagamento > 0 then
      begin
        lIdTpPgtoCredito := unTipoPagamento.IdTpPagamento
      end;

      CdsTipoPagamento.Append;
      CdsTipoPagamento.FieldByName('IdTpPagamento') .AsInteger   := lIdTpPgtoCredito;
      CdsTipoPagamento.FieldByName('NmTpPagamento') .AsString    := 'CREDITO';
      CdsTipoPagamento.FieldByName('VlPagamento')   .AsCurrency  := StrToFloat(EdtVlPgtoCredito.Text);
      CdsTipoPagamento.Post;
    end;
  finally
    InicializarTipoPagamento;
  end;
end;

procedure TFrmNotaConsumoStarter.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmAjuda := TFrmAjuda.Create(Application);
    FrmAjuda.Caption        := 'Ajuda Sobre à Tela de ' +  Caption;
    FrmAjuda.gNmTelaChamada := Name;
    FrmAjuda.ShowModal;
  finally
    FrmAjuda.Free;
  end;
end;

procedure TFrmNotaConsumoStarter.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Nota', 'Anterior', CdsRetorno);

  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmNotaConsumoStarter.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  InicializarTela
end;

procedure TFrmNotaConsumoStarter.BtnCanProdutoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCanProdutoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if MsgConfirmacao(uMensagem.DesejaExcluirORegistro) then
    begin
      if not CdsProduto.IsEmpty then
      begin
        CdsProduto.Delete;
      end;
    end;
  finally
    AtualizaVlProdutos;
    AtualizaVlGeral;
  end;
end;

procedure TFrmNotaConsumoStarter.BtnCanServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCanServicoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if MsgConfirmacao(uMensagem.DesejaExcluirORegistro) then
    begin
      if not CdsServico.IsEmpty then
      begin
        CdsServico.Delete;
      end;
    end;
  finally
    AtualizaVlServicos;
    AtualizaVlGeral;
  end;
end;

procedure TFrmNotaConsumoStarter.BtnCanTipoPagamentoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCanTipoPagamentoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if MsgConfirmacao(uMensagem.DesejaExcluirORegistro) then
    begin
      if not CdsTipoPagamento.IsEmpty then
      begin
        CdsTipoPagamento.Delete;
      end;
    end;
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.BtnClientePesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnClientePesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmPessoaPesquisa           := TFrmPessoaPesquisa.Create(Application);
    FrmPessoaPesquisa.TpAcao    := 'CarregaDados';
    FrmPessoaPesquisa.ShowModal;
  finally
    if not FrmPessoaPesquisa.CdsPesquisa.IsEmpty then
    begin
      MkeNrCelular1.Text        := FrmPessoaPesquisa.CdsPesquisa.FieldByName('NrCelular')  .AsString;
      EdtNmPessoa.Text          := FrmPessoaPesquisa.CdsPesquisa.FieldByName('NmPessoa')   .AsString;
      lIdCliente                := FrmPessoaPesquisa.CdsPesquisa.FieldByName('IdPessoa')   .AsInteger;
      lIdEmpCliente             := FrmPessoaPesquisa.CdsPesquisa.FieldByName('IdEmpresa')  .AsInteger;

      SetaFoco;
    end;
    FrmPessoaPesquisa.Free;
  end;
end;

procedure TFrmNotaConsumoStarter.BtnEmpresaPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnEmpresaPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmEmpresaPesquisa := TFrmEmpresaPesquisa.Create(Application);
    FrmEmpresaPesquisa.ShowModal;
  finally
    FrmEmpresaPesquisa.Free;
    CbbIdEmpresa.Properties.Items.Clear;
    CarregarTela('Empresa');
  end;
end;

procedure TFrmNotaConsumoStarter.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if lFormEdit then
  begin
    if MsgConfirmacao(uMensagem.DesejaSairDaTelaSemSalvarOsDados) then
    begin
      inherited;

      unNota.Free;
      unNotaItem.Free;
      unNotaPagamento.Free;
    end;
  end
  else
  begin
    inherited;

    unNota.Free;
    unNotaItem.Free;
    unNotaPagamento.Free;
  end;
end;

procedure TFrmNotaConsumoStarter.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    dnRelatorios := TDtmRelatorios.Create(Self);
    unEmpresa    := TEmpresa.Create;
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelEmpresa);

    if not DtmPrincipal.UsuarioAdministrador then
    begin
      unNota.CarregaDbGrid(DtmPrincipal.Conexao, 2, StrToInt(EdtIdRegistro.Text), 0, '', '0', 0, 0, dnRelatorios.CDSRelPesquisa);
      unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, 0, StrToInt(EdtIdRegistro.Text), '', '', dnRelatorios.CDSRelPesquisa);
      unNotaPagamento.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, 0, StrToInt(EdtIdRegistro.Text), 0, '', dnRelatorios.CDSRelPesquisa);
    end
    else
    begin
      unNota.CarregaDbGrid(DtmPrincipal.Conexao, 2, StrToInt(EdtIdRegistro.Text), 0, '', '0', 0, 0, dnRelatorios.CDSRelPesquisa);
      unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, 0, StrToInt(EdtIdRegistro.Text), '', '', dnRelatorios.CDSRelPesquisa);
      unNotaPagamento.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, 0, StrToInt(EdtIdRegistro.Text), 0, '', dnRelatorios.CDSRelPesquisa);
    end;

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\RelNotaConsulmoStarter.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmNotaConsumoStarter.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmNotaConsumoStarter.BtnProdutoPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProdutoPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmProdutoPesquisa         := TFrmProdutoPesquisa.Create(Application);
    FrmProdutoPesquisa.TpAcao  := 'CarregaDados';
    FrmProdutoPesquisa.ShowModal;
  finally
    if not FrmProdutoPesquisa.CdsPesquisa.IsEmpty then
    begin
      EdtNrEan.Text              := FrmProdutoPesquisa.CdsPesquisa.FieldByName('NrEan')     .AsString;
      EdtNmProduto.Text          := FrmProdutoPesquisa.CdsPesquisa.FieldByName('NmProduto') .AsString;
      EdtDescProduto.Text        := '0';
      EdtQtdNotaItemProduto.Text := '1';
      EdtVlProduto.Text          := FrmProdutoPesquisa.CdsPesquisa.FieldByName('VlVenda')   .AsString;
    end;
    FrmProdutoPesquisa.Free;
  end;
end;

procedure TFrmNotaConsumoStarter.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Nota', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmNotaConsumoStarter.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]) > 0) and (lIdCliente > 0) and ((CdsServico.RecordCount > 0) or (CdsProduto.RecordCount > 0))) then
    begin
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unNota.IdNota     := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unNota.IdNota     := 0;
      end;
      unNota.IdUsuario      := DtmPrincipal.IdUsuarioLogado;
      unNota.DtCadastro     := Now;
      if ChkSnSituacao.Checked then
      begin
        unNota.SnSituacao   := 1;
      end
      else
      begin
        unNota.SnSituacao   := 0;
      end;
      unNota.IdEmpresa      := Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]);
      unNota.IdCliente      := lIdCliente;
      unNota.IdEmpCliente   := lIdEmpCliente;
      unNota.VlNota         := StrToCurr(RemoveMoeda(EdtVlGeral.Text));

      if unNota.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unNota.Buscar(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text), Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]));
        end
        else
        begin
          unNota.Buscar(DtmPrincipal.Conexao, unNota.BuscaMaxId(DtmPrincipal.Conexao), Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]));
        end;
        EdtIdRegistro.Text      := IntToStr(unNota.IdNota);
        DtpDtCadastro.Date      := unNota.DtCadastro;
        EdtNmUsuario.Text       := unNota.NmUsuarioCadastro;

        if unNota.SnSituacao = 1 then
        begin
          ChkSnSituacao.Checked := True;
        end
        else
        begin
          ChkSnSituacao.Checked := False;
        end;

        NotaItemServico;

        NotaItemProduto;

        NotaPagamento;

        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        inherited;
        InicializarTela;
      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      BtnIncluir.Enabled      := False;
      BtnSalvar.Enabled       := True;
      BtnCancelar.Enabled     := True;
      BtnFechar.Enabled       := True;

      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
      Abort;
    end;
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.CarregarTela(ATpChamadaClasse: String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;

  if ATpChamadaClasse = 'Geral' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', '', CbbIdEmpresa);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'PessoaTipoPessoa', 0, 'Profissional', '', '', CbbIdProfServico);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'PessoaTipoPessoa', 0, 'Profissional', '', '', CbbIdProfProduto);
  end
  else
  if ATpChamadaClasse = 'Empresa' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', '', CbbIdEmpresa);
  end
  else
  if ATpChamadaClasse = 'Pessoa' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'PessoaTipoPessoa', 0, 'Profissional', '', '', CbbIdProfServico);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'PessoaTipoPessoa', 0, 'Profissional', '', '', CbbIdProfProduto);
  end;
end;

procedure TFrmNotaConsumoStarter.CbbIdProfProdutoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdProfProdutoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unServico.Inicializar;
    unServico.BuscarProfissional(DtmPrincipal.Conexao, '', CbbIdProfProduto.Text);
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.CbbIdProfServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdProfServicoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    CbbIdServico.Properties.Items.Clear;
    unCarregaDados.gCarregarSelecionar := 1;
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Servico', 0, 'Profissional', CbbIdProfServico.Text, '', CbbIdServico);
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.CbbIdServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdServicoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlServico.Clear;
    unServico.Inicializar;
    unServico.BuscarProfissional(DtmPrincipal.Conexao, CbbIdServico.Text, CbbIdProfServico.Text);

    if unServico.IdServico > 0 then
    begin
      EdtQtdNotaItemServico.Text := '1';
      EdtDescServico.Text        := '0';
      EdtVlServico.Text          := RetornaValorEmReal(unServico.VlServico);
    end;
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(FrmNotaConsumoStarter.EdtIdRegistro.Text) <> '' then
  begin
    FrmNotaConsumoStarter.BtnIncluir.Enabled    := True;
    FrmNotaConsumoStarter.BtnAnterior.Enabled   := True;
    FrmNotaConsumoStarter.BtnProximo.Enabled    := True;
    FrmNotaConsumoStarter.MkeNrCelular1.Enabled := False;
  end
  else
  begin
    FrmNotaConsumoStarter.BtnSalvar.Enabled     := True;
    FrmNotaConsumoStarter.BtnCancelar.Enabled   := True;
    FrmNotaConsumoStarter.MkeNrCelular1.Enabled := True;
  end;
end;

procedure TFrmNotaConsumoStarter.CopulaTela;
begin
  //Herança
end;

procedure TFrmNotaConsumoStarter.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmPrincipal.TasConsumo.TabVisible := False;
  FrmPrincipal.PgcVisivel;
  inherited;
end;

procedure TFrmNotaConsumoStarter.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados  := TCarregaDados.Create;
  unNota          := TNota.Create;
  unNotaItem      := TNotaItem.Create;
  unNotaPagamento := TNotaPagamento.Create;
  unPessoa        := TPessoa.Create;
  unServico       := TServico.Create;
  unProduto       := TProduto.Create;
  unTipoPagamento := TTipoPagamento.Create;
end;

procedure TFrmNotaConsumoStarter.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if not DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.Enabled        := False;
    CbbIdEmpresa.ItemIndex      := Integer(CbbIdEmpresa.Properties.Items.IndexOf(DtmPrincipal.NmFantasiaNmRazaoSocial));
    MkeNrCelular1.SetFocus;
    BtnEmpresaPesquisa.Enabled  := False;
  end
  else
  begin
    CbbIdEmpresa.Enabled        := True;
    CbbIdEmpresa.SetFocus;
    BtnEmpresaPesquisa.Enabled  := False;
  end;

  PgcExtra.ActivePage := TabServico;

  unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, False, 2, 0, 0, 0, '', '', CdsServico);
  unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, False, 2, 0, 0, 0, '', '', CdsProduto);
  unNotaPagamento.CarregaDbGrid(DtmPrincipal.Conexao, False, 2, 0, 0, 0, 0, '', CdsTipoPagamento);
end;

procedure TFrmNotaConsumoStarter.InicializarProduto;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarProduto';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    CbbIdProfProduto.ItemIndex := 0;
    EdtNrEan.Clear;
    EdtNmProduto.Clear;
    EdtDescProduto.Text        := '0';
    EdtQtdNotaItemProduto.Text := '1';
    EdtVlProduto.Clear;
    CbbIdProfProduto.SetFocus;
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.InicializarServico;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarServico';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  CbbIdProfServico.ItemIndex := 0;
  CbbIdServico.Clear;
  EdtDescServico.Text        := '0';
  EdtQtdNotaItemServico.Text := '1';
  EdtVlServico.Clear;
  CbbIdProfServico.SetFocus;
end;

procedure TFrmNotaConsumoStarter.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unNota.IdNota                   := 0;
  unNotaItem.IdNota               := 0;
  unNotaPagamento.IdNota          := 0;
  EdtNmUsuario.Clear;
  ChkSnSituacao.Caption           := 'Cadastro Ativo';
  if DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.ItemIndex        := 0;
    CbbIdEmpresa.SetFocus;
  end
  else
  begin
    MkeNrCelular1.SetFocus;
  end;
  MkeNrCelular1.Clear;
  lIdCliente                      := 0;
  lIdEmpCliente                   := 0;
  EdtNmPessoa.Clear;
  CbbIdProfServico.ItemIndex      := 0;
  CbbIdServico.ItemIndex          := 0;
  CbbIdProfProduto.ItemIndex      := 0;
  EdtDescServico.Text             := '0,00';
  EdtVlServico.Text               := '0,00';
  EdtNrEan.Clear;
  EdtDescProduto.Text             := '0,00';
  EdtVlProduto.Text               := '0,00';
  EdtQtdNotaItemServico.Text      := '1,00';
  EdtQtdNotaItemProduto.Text      := '1,00';
  EdtNmProduto.Clear;
  EdtVlPgtoDinheiro.Text          := '0,00';
  EdtVlPgtoDebito.Text            := '0,00';
  EdtVlPgtoCredito.Text           := '0,00';
  MkeVlServicos.Text              := '0,00';
  MkeVlProdutos.Text              := '0,00';
  EdtVlGeral.Text                 := '0,00';
  GrbProduto.Enabled              := False;
  GrbServico.Enabled              := False;
  GrbTipoPagamento.Enabled        := False;
  if CdsServico.FieldCount > 0 then
  begin
    CdsServico.EmptyDataSet;
  end;
  if CdsProduto.FieldCount > 0 then
  begin
    CdsProduto.EmptyDataSet;
  end;
  if CdsTipoPagamento.FieldCount > 0 then
  begin
    CdsTipoPagamento.EmptyDataSet;
  end;
  if CdsCopula.FieldCount > 0 then
  begin
    CdsCopula.EmptyDataSet;
  end;
  if CdsRetorno.FieldCount > 0 then
  begin
    CdsRetorno.EmptyDataSet;
  end;
  lFormEdit                       := False;
  PgcExtra.ActivePage             := TabServico;
end;

procedure TFrmNotaConsumoStarter.InicializarTipoPagamento;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTipoPagamento';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  EdtVlPgtoDinheiro.Text          := '0,00';
  EdtVlPgtoDebito.Text            := '0,00';
  EdtVlPgtoCredito.Text           := '0,00';
  EdtVlTroco.Text                 := '0,00';
  EdtVlRestante.Text              := '0,00';
end;

procedure TFrmNotaConsumoStarter.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmNotaConsumoStarter.MkeNrCelular1KeyPress(Sender: TObject; var Key: Char);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtNrCelular1KeyPress';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Key = #13 then
  begin
    lIdCliente    := 0;
    lIdEmpCliente := 0;
    EdtNmPessoa.Clear;
    unPessoa.Inicializar;
    unPessoa.BuscarNrCelular(DtmPrincipal.Conexao, RemoveCaracteres(MkeNrCelular1.Text));

    if unPessoa.IdPessoa > 0 then
    begin
      EdtNmPessoa.Text          := unPessoa.NmPessoa;
      lIdCliente                := unPessoa.IdPessoa;
      lIdEmpCliente             := unPessoa.IdEmpresa;

      SetaFoco;

      CarregarTela('Pessoa');
   end;
  end;
end;

procedure TFrmNotaConsumoStarter.MkeNrCelular1PropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCelular1PropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 11) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end;
end;

procedure TFrmNotaConsumoStarter.NotaItemProduto;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'NotaItemProduto';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    CdsProduto.DisableControls;
    CdsProduto.First;

    while not CdsProduto.Eof do
    begin
      unNotaItem.IdNotaItem         := 0;
      unNotaItem.IdUsuario          := DtmPrincipal.IdUsuarioLogado;
      unNotaItem.DtCadastro         := Now;
      if ChkSnSituacao.Checked then
      begin
        unNotaItem.SnSituacao       := 1;
      end
      else
      begin
        unNotaItem.SnSituacao       := 0;
      end;
      unNotaItem.IdEmpresa          := Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]);
      unNotaItem.IdNota             := unNota.IdNota;
      unNotaItem.IdProduto          := CdsProduto.FieldByName('IdProduto').AsInteger;
      unNotaItem.QtdNotaItem        := CdsProduto.FieldByName('QtdNotaItem').AsFloat;
      unNotaItem.VlProduto          := CdsProduto.FieldByName('VlProduto').AsCurrency;
      unNotaItem.PcDesconto         := CdsProduto.FieldByName('PcDesconto').AsCurrency;
      unNotaItem.IdProfissional     := CdsProduto.FieldByName('IdProfissional').AsInteger;
      unNotaItem.IdEmpProfissional  := CdsProduto.FieldByName('IdEmpProfissional').AsInteger;

      if unNotaItem.Salvar(DtmPrincipal.Conexao) then
      begin
        CdsProduto.Next;
      end;
    end;

    CdsProduto.EnableControls;
    CdsProduto.First;
  finally
    unNotaItem.Inicializar;
  end;
end;

procedure TFrmNotaConsumoStarter.NotaItemServico;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'NotaItemServico';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    CdsServico.DisableControls;
    CdsServico.First;

    while not CdsServico.Eof do
    begin
      unNotaItem.IdNotaItem         := 0;
      unNotaItem.IdUsuario          := DtmPrincipal.IdUsuarioLogado;
      unNotaItem.DtCadastro         := Now;
      if ChkSnSituacao.Checked then
      begin
        unNotaItem.SnSituacao       := 1;
      end
      else
      begin
        unNotaItem.SnSituacao       := 0;
      end;
      unNotaItem.IdEmpresa          := Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]);
      unNotaItem.IdNota             := unNota.IdNota;
      unNotaItem.IdServico          := CdsServico.FieldByName('IdServico').AsInteger;
      unNotaItem.QtdNotaItem        := CdsServico.FieldByName('QtdNotaItem').AsFloat;
      unNotaItem.VlServico          := CdsServico.FieldByName('VlServico').AsCurrency;
      unNotaItem.PcDesconto         := CdsServico.FieldByName('PcDesconto').AsCurrency;
      unNotaItem.IdProfissional     := CdsServico.FieldByName('IdProfissional').AsInteger;
      unNotaItem.IdEmpProfissional  :=  CdsServico.FieldByName('IdEmpProfissional').AsInteger;

      if unNotaItem.Salvar(DtmPrincipal.Conexao) then
      begin
        CdsServico.Next;
      end;
    end;

    CdsServico.EnableControls;
    CdsServico.First;
  finally
    unNotaItem.Inicializar;
  end;
end;

procedure TFrmNotaConsumoStarter.NotaPagamento;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'NotaPagamento';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    CdsTipoPagamento.DisableControls;
    CdsTipoPagamento.First;

    while not CdsTipoPagamento.Eof do
    begin
      unNotaPagamento.IdNotaPagamento := 0;
      unNotaPagamento.IdUsuario            := DtmPrincipal.IdUsuarioLogado;
      unNotaPagamento.DtCadastro           := Now;
      if ChkSnSituacao.Checked then
      begin
        unNotaPagamento.SnSituacao       := 1;
      end
      else
      begin
        unNotaPagamento.SnSituacao       := 0;
      end;
      unNotaPagamento.IdEmpresa          := Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]);
      unNotaPagamento.IdNota             := unNota.IdNota;
      unNotaPagamento.IdTpPagamento      := CdsTipoPagamento.FieldByName('IdTpPagamento').AsInteger;
      unNotaPagamento.VlPagamento        := CdsTipoPagamento.FieldByName('VlPagamento').AsFloat;

      if unNotaPagamento.Salvar(DtmPrincipal.Conexao) then
      begin
        CdsTipoPagamento.Next;
      end;
    end;

    CdsTipoPagamento.EnableControls;
    CdsTipoPagamento.First;
  finally
    unNotaPagamento.Inicializar;
  end;
end;

procedure TFrmNotaConsumoStarter.SetaFoco;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'SetaFoco';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    GrbServico.Enabled        := True;
    GrbProduto.Enabled        := True;
    GrbTipoPagamento.Enabled  := True;
    CbbIdProfServico.SetFocus;
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.TabProdutoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'TabProdutoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    CbbIdProfProduto.SetFocus;
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.ValorRestante;
var
  lVlRestante : Currency;
  lVlGeral    : Currency;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'ValorRestante';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    lVlGeral    := StrToCurr(RemoveMoeda(EdtVlGeral.Text));

    lVlRestante := StrToCurr(RemoveMoeda(EdtVlPgtoDinheiro.Text));
    lVlRestante := lVlRestante + StrToCurr(RemoveMoeda(EdtVlPgtoDebito.Text));
    lVlRestante := lVlRestante + StrToCurr(RemoveMoeda(EdtVlPgtoCredito.Text));

    if lVlRestante < lVlGeral then
    begin
      EdtVlRestante.Text := RetornaValorEmReal(lVlGeral - lVlRestante);
    end
    else
    begin
      EdtVlRestante.Text := RetornaValorEmReal(0.00);
    end;
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if not lTpChamadaClasse then
  begin
    BtnIncluir.Enabled   := False;
    BtnSalvar.Enabled    := True;
    BtnCancelar.Enabled  := True;
    BtnFechar.Enabled    := True;
    BtnAnterior.Enabled  := False;
    BtnProximo.Enabled   := False;
  end;
  lFormEdit := True
end;

procedure TFrmNotaConsumoStarter.EdtDescProdutoExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtDescProdutoExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlProduto.Text := RetornaValorEmReal((StrToCurr(RemoveMoeda(EdtVlProduto.Text)) - ((StrToCurr(RemoveMoeda(EdtVlProduto.Text)) * StrToFloat(EdtDescProduto.Text)) / 100)));
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.EdtDescServicoExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtDescServicoExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlServico.Text := RetornaValorEmReal((StrToCurr(RemoveMoeda(EdtVlServico.Text)) - ((StrToCurr(RemoveMoeda(EdtVlServico.Text)) * StrToFloat(EdtDescServico.Text)) / 100)));
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.EdtNrEanExit(Sender: TObject);
var
  Key: Char;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtNrEanExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Key := #0;
  EdtNrEanKeyPress(Sender, Key);
end;

procedure TFrmNotaConsumoStarter.EdtNrEanKeyPress(Sender: TObject; var Key: Char);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtNrEanKeyPress';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (not(Key in ['0'..'9', #08, #13, #46])) and (Key <> #0) then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
    DtmPrincipal.unLog.NmMetodo   := 'EdtNrEanKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Nota';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    MsgAtencao(uMensagem.ESoPermitidoNumeros);
    Key := #0;
  end;

  if Key = #13 then
  begin
    unProduto.Inicializar;
    unProduto.BuscarNrEan(DtmPrincipal.Conexao, EdtNrEan.Text);

    if unProduto.IdProduto > 0 then
    begin
      EdtNrEan.Text               := unProduto.NrEan;
      EdtNmProduto.Text           := unProduto.NmProduto;
      EdtDescProduto.Text         := '0';
      EdtQtdNotaItemProduto.Text  := '1';
      EdtVlProduto.Text           := RetornaValorEmReal(unProduto.VlVenda);
    end
    else
    begin
      MsgAtencao(uMensagem.ProdutoNaoEncontrado);
    end;
  end;
end;

procedure TFrmNotaConsumoStarter.EdtQtdNotaItemProdutoExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtQtdNotaItemProdutoExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlProduto.Text := RetornaValorEmReal((StrToFloat(EdtQtdNotaItemProduto.Text) * StrToCurr(RemoveMoeda(EdtVlProduto.Text))));
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.EdtQtdNotaItemServicoExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtQtdNotaItemServicoExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlServico.Text := RetornaValorEmReal((StrToFloat(EdtQtdNotaItemServico.Text) * StrToCurr(RemoveMoeda(EdtVlServico.Text))));
  finally

  end;
end;

procedure TFrmNotaConsumoStarter.EdtVlPgtoCreditoExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtVlPgtoCreditoExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlPgtoCredito.Text := RemoveMoeda(RetornaValorEmReal(StrToCurr(EdtVlPgtoCredito.Text)));
  finally
    ValorRestante;
  end;
end;

procedure TFrmNotaConsumoStarter.EdtVlPgtoDebitoExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtVlPgtoDebitoExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlPgtoDebito.Text := RemoveMoeda(RetornaValorEmReal(StrToCurr(EdtVlPgtoDebito.Text)));
  finally
    ValorRestante;
  end;
end;

procedure TFrmNotaConsumoStarter.EdtVlPgtoDinheiroExit(Sender: TObject);
var
  lVlDinheiro : Currency;
  lVlGeral    : Currency;
  lVlTroco    : Currency;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaConsumoStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtVlPgtoDinheiroExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  lVlDinheiro               := StrToCurr(RemoveMoeda(EdtVlPgtoDinheiro.Text));
  lVlGeral                  := StrToCurr(RemoveMoeda(EdtVlGeral.Text));
  try
    EdtVlPgtoDinheiro.Text  := RemoveMoeda(RetornaValorEmReal(StrToCurr(EdtVlPgtoDinheiro.Text)));

    if lVlDinheiro > lVlGeral then
    begin
      lVlTroco              := lVlDinheiro - lVlGeral;
      EdtVlTroco.Text       := RetornaValorEmReal(lVlTroco);
    end
    else
    begin
      EdtVlTroco.Text       := RetornaValorEmReal(0.00);
    end;
  finally
     ValorRestante;
  end;
end;

end.
