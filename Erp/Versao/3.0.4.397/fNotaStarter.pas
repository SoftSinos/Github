unit fNotaStarter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  dxSkinsCore, dxSkinsDefaultPainters, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.Menus, cxButtons, cxCheckBox, dxSkinscxPCPainter, cxPC;

type
  TFrmNotaStarter = class(TFrmCadastro)
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
    PgcExtra                : TcxPageControl;
    TabServico              : TcxTabSheet;
    TabProduto              : TcxTabSheet;
    GrbServico              : TGroupBox;
    GrbProduto              : TGroupBox;
    PgcExtra2               : TcxPageControl;
    TabTipoPagamento        : TcxTabSheet;
    GrbTipoPagamento        : TGroupBox;
    Panel3                  : TPanel;
    Label2                  : TLabel;
    Label5                  : TLabel;
    Label8                  : TLabel;
    DbgPagamento            : TDBGrid;
    MkeNrCelular1           : TcxMaskEdit;
    DbgServico              : TDBGrid;
    GroupBox5               : TGroupBox;
    Label15                 : TLabel;
    Label17                 : TLabel;
    Label23                 : TLabel;
    Label25                 : TLabel;
    CbbIdProfServico        : TcxComboBox;
    CbbIdServico            : TcxComboBox;
    EdtNmPessoa             : TcxTextEdit;
    EdtIdCliente            : TcxTextEdit;
    GroupBox6               : TGroupBox;
    Label7                  : TLabel;
    Label18                 : TLabel;
    BtnProdutoPesquisar     : TcxButton;
    CbbIdProfProduto        : TcxComboBox;
    EdtNrEan                : TcxTextEdit;
    DbgProduto              : TDBGrid;
    EdtNmProduto            : TcxTextEdit;
    EdtQtdNotaItemServico   : TcxTextEdit;
    EdtVlServico            : TcxTextEdit;
    EdtDescServico          : TcxTextEdit;
    Panel1                  : TPanel;
    BtnAdiServico           : TcxButton;
    BtnCanServico           : TcxButton;
    Panel2                  : TPanel;
    BtnAdiProduto           : TcxButton;
    BtnCanProduto           : TcxButton;
    Label4                  : TLabel;
    Label19                 : TLabel;
    Label20                 : TLabel;
    EdtQtdNotaItemProduto   : TcxTextEdit;
    EdtVlProduto            : TcxTextEdit;
    EdtDescProduto          : TcxTextEdit;
    Panel4                  : TPanel;
    BtnAdiTipoPagamento     : TcxButton;
    BtnCanTipoPagamento     : TcxButton;
    Label14                 : TLabel;
    EdtVlPgtoDinheiro       : TcxTextEdit;
    EdtVlPgtoDebito         : TcxTextEdit;
    EdtVlPgtoCredito        : TcxTextEdit;
    Label26                 : TLabel;
    Label24                 : TLabel;
    MkeVlServicos           : TcxTextEdit;
    MkeVlProdutos           : TcxTextEdit;
    Label3                  : TLabel;
    EdtVlGeral              : TcxTextEdit;
    Label6                  : TLabel;
    EdtVlTroco              : TcxTextEdit;
    Label10                 : TLabel;
    EdtVlRestante           : TcxTextEdit;
    BtnEmpresaPesquisa: TcxButton;
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
    procedure CbbIdServicoClick(Sender: TObject);
    procedure BtnAdiServicoClick(Sender: TObject);
    procedure EdtNrEanKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAdiTipoPagamentoClick(Sender: TObject);
    procedure MkeNrCelular1KeyPress(Sender: TObject; var Key: Char);
    procedure CbbIdServicoEnter(Sender: TObject);
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
  private
    { Private declarations }
    procedure InicializarTela;
    procedure InicializarServico;
    procedure InicializarProduto;
    procedure InicializarTipoPagamento;
    procedure AtualizaVlServicos;
    procedure AtualizaVlProdutos;
    procedure AtualizaVlGeral;
  public
    { Public declarations }
    procedure CarregarTela(ATpChamadaClasse: String);
    procedure CopulaTela;
    procedure ControleBotao;
  end;

var
  FrmNotaStarter: TFrmNotaStarter;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uNota, uNotaItem, uNotaPagamento, fAjuda, fPessoaPesquisa, fProdutoPesquisa,
    fTipoPagamentoPesquisa, dRelatorios, uEmpresa, uPessoa, uServico, uProduto, uTipoPagamento, fPrincipal, fEmpresaPesquisa;

var
  unNota           : TNota;
  unNotaItem       : TNotaItem;
  unNotaPagamento  : TNotaPagamento;
  unCarregaDados   : TCarregaDados;
  unEmpresa        : TEmpresa;
  unPessoa         : TPessoa;
  unServico        : TServico;
  unProduto        : TProduto;
  unTipoPagamento  : TTipoPagamento;
  dnRelatorios     : TDtmRelatorios;
  lTpChamadaClasse : Boolean;

procedure TFrmNotaStarter.AtualizaVlGeral;
var
  lVlGeralGrid : Currency;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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

procedure TFrmNotaStarter.AtualizaVlProdutos;
var
  lVlProdutoGrid : Currency;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'AtualizaVlProduto';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    lVlProdutoGrid := 0;

    CdsProduto.DisableControls;
    CdsProduto.First;

    while not CdsProduto.Eof do
    begin
      lVlProdutoGrid     := lVlProdutoGrid + CdsProduto.FieldByName('VlProduto').AsCurrency;

      CdsProduto.Next
    end;
      MkeVlProdutos.Text := RetornaValorEmReal(lVlProdutoGrid);
      CdsProduto.EnableControls;
      InicializarProduto;
  finally

  end;
end;

procedure TFrmNotaStarter.AtualizaVlServicos;
var
  lVlServicoGrid : Currency;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'AtualizaVlServicos';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);
  try
    lVlServicoGrid := 0;

    CdsServico.DisableControls;
    CdsServico.First;

    while not CdsServico.Eof do
    begin
      lVlServicoGrid     := lVlServicoGrid + CdsServico.FieldByName('VlServico').AsCurrency;

      CdsServico.Next
    end;
      MkeVlServicos.Text := RetornaValorEmReal(lVlServicoGrid);
      CdsServico.EnableControls;
      InicializarServico;
  finally

  end;
end;

procedure TFrmNotaStarter.BtnAdiProdutoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAdiProdutoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((Trim(EdtNrEan.Text) <> '' ) and (Trim(EdtVlProduto.Text) <> '')) then
    begin
      CdsProduto.Append;
      CdsProduto.FieldByName('IdProfissional') .AsInteger   := Integer(CbbIdProfProduto.Properties.Items.Objects[CbbIdProfProduto.ItemIndex]);
      CdsProduto.FieldByName('IdProduto')      .AsInteger   := unProduto.IdProduto;
      CdsProduto.FieldByName('NrEan')          .AsString    := EdtNrEan.Text;
      CdsProduto.FieldByName('NmProduto')      .AsString    := EdtNmProduto.Text;
      CdsProduto.FieldByName('QtdNotaItem')    .AsFloat     := StrToFloat(EdtQtdNotaItemProduto.Text);
      CdsProduto.FieldByName('PcDesconto')     .AsCurrency  := StrToFloat(EdtDescProduto.Text);
      CdsProduto.FieldByName('VlProduto')      .AsCurrency  := StrToCurr(RemoveMoeda(EdtVlProduto.Text));
      CdsProduto.Post;
    end;
  finally
    AtualizaVlProdutos;
    AtualizaVlGeral;
  end;
end;


procedure TFrmNotaStarter.BtnAdiServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAdiServicoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((Integer(CbbIdProfServico.Properties.Items.Objects[CbbIdProfServico.ItemIndex]) > 0) and (Integer(CbbIdServico.Properties.Items.Objects[CbbIdServico.ItemIndex]) > 0) and (Trim(EdtVlServico.Text) <> '')) then
    begin
      CdsServico.Append;
      CdsServico.FieldByName('IdServico')      .AsInteger   := Integer(CbbIdServico.Properties.Items.Objects[CbbIdServico.ItemIndex]);
      CdsServico.FieldByName('IdProfissional') .AsInteger   := Integer(CbbIdProfServico.Properties.Items.Objects[CbbIdProfServico.ItemIndex]);
      CdsServico.FieldByName('NmTpServico')    .AsString    := CbbIdServico.Text;
      CdsServico.FieldByName('QtdNotaItem')    .AsFloat     := StrToFloat(EdtQtdNotaItemServico.Text);
      CdsServico.FieldByName('PcDesconto')     .AsCurrency  := StrToFloat(EdtDescServico.Text);
      CdsServico.FieldByName('VlServico')      .AsCurrency  := StrToCurr(RemoveMoeda(EdtVlServico.Text));
      CdsServico.Post;
    end;
  finally
    AtualizaVlServicos;
    AtualizaVlGeral
  end;
end;

procedure TFrmNotaStarter.BtnAdiTipoPagamentoClick(Sender: TObject);
var
   lIdTpPgtoDinheiro : Integer;
   lIdTpPgtoDebito   : Integer;
   lIdTpPgtoCredito  : Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAdiTipoPagamentoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
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

procedure TFrmNotaStarter.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmAjuda := TFrmAjuda.Create(Application);
    FrmAjuda.Caption        := 'Ajuda Sobre � Tela de ' +  Caption;
    FrmAjuda.gNmTelaChamada := Name;
    FrmAjuda.ShowModal;
  finally
    FrmAjuda.Free;
  end;
end;

procedure TFrmNotaStarter.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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

procedure TFrmNotaStarter.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  InicializarTela
end;

procedure TFrmNotaStarter.BtnCanProdutoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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

procedure TFrmNotaStarter.BtnCanServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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

procedure TFrmNotaStarter.BtnCanTipoPagamentoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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

procedure TFrmNotaStarter.BtnClientePesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnClientePesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmPessoaPesquisa         := TFrmPessoaPesquisa.Create(Application);
    FrmPessoaPesquisa.TpAcao  := 'CarregaDados';
    FrmPessoaPesquisa.ShowModal;
  finally
    if not FrmPessoaPesquisa.CdsPesquisa.IsEmpty then
    begin
      MkeNrCelular1.Text      := FrmPessoaPesquisa.CdsPesquisa.FieldByName('NrCelular')  .AsString;
      EdtNmPessoa.Text        := FrmPessoaPesquisa.CdsPesquisa.FieldByName('NmPessoa')   .AsString;
      EdtIdCliente.Text       := FrmPessoaPesquisa.CdsPesquisa.FieldByName('IdPessoa')   .AsString;
    end;
    FrmPessoaPesquisa.Free;
  end;
end;

procedure TFrmNotaStarter.BtnEmpresaPesquisaClick(Sender: TObject);
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

procedure TFrmNotaStarter.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if MsgConfirmacao(uMensagem.DesejaSairDaTelaSemSalvarOsDados) then
  begin
    inherited;

    unNota.Free;
    unNotaItem.Free;
    unNotaPagamento.Free;
  end;
end;

procedure TFrmNotaStarter.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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
      unNota.CarregaDbGrid(DtmPrincipal.Conexao, 2, StrToInt(EdtIdRegistro.Text), 0, '', dnRelatorios.CDSRelPesquisa);
      unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, 0, StrToInt(EdtIdRegistro.Text), '', dnRelatorios.CDSRelPesquisa);
      unNotaPagamento.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, 0, StrToInt(EdtIdRegistro.Text), 0, '', dnRelatorios.CDSRelPesquisa);
    end
    else
    begin
      unNota.CarregaDbGrid(DtmPrincipal.Conexao, 2, StrToInt(EdtIdRegistro.Text), 0, '', dnRelatorios.CDSRelPesquisa);
      unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, 0, StrToInt(EdtIdRegistro.Text), '', dnRelatorios.CDSRelPesquisa);
      unNotaPagamento.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, 0, StrToInt(EdtIdRegistro.Text), 0, '', dnRelatorios.CDSRelPesquisa);
    end;

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\RelNotaStarter.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmNotaStarter.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmNotaStarter.BtnProdutoPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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

procedure TFrmNotaStarter.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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

procedure TFrmNotaStarter.CarregarTela(ATpChamadaClasse: String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;

  if ATpChamadaClasse = 'Geral' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', '', CbbIdEmpresa);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Pessoa', 0, 'Profissional', '', '', CbbIdProfServico);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Pessoa', 0, 'Profissional', '', '', CbbIdProfProduto);
  end
  else
  if ATpChamadaClasse = 'Empresa' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', '', CbbIdEmpresa);
  end
  else
  if ATpChamadaClasse = 'Pessoa' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Pessoa', 0, 'Profissional', '', '', CbbIdProfServico);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Pessoa', 0, 'Profissional', '', '', CbbIdProfProduto);
  end;
end;

procedure TFrmNotaStarter.CbbIdServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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

procedure TFrmNotaStarter.CbbIdServicoEnter(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdServicoEnter';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    CbbIdServico.Properties.Items.Clear;
    unCarregaDados.gCarregarSelecionar := 1;
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Servico', 0, 'Profissional', CbbIdProfServico.Text, '', CbbIdServico);
  finally

  end;
end;

procedure TFrmNotaStarter.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(FrmNotaStarter.EdtIdRegistro.Text) <> '' then
  begin
    FrmNotaStarter.BtnIncluir.Enabled    := True;
    FrmNotaStarter.BtnAnterior.Enabled   := True;
    FrmNotaStarter.BtnProximo.Enabled    := True;
    FrmNotaStarter.MkeNrCelular1.Enabled := False;
  end
  else
  begin
    FrmNotaStarter.BtnSalvar.Enabled     := True;
    FrmNotaStarter.BtnCancelar.Enabled   := True;
    FrmNotaStarter.MkeNrCelular1.Enabled := True;
  end;
end;

procedure TFrmNotaStarter.CopulaTela;
begin
//
end;

procedure TFrmNotaStarter.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmPrincipal.TasConsumo.TabVisible := False;
  FrmPrincipal.PgcVisivel;
  inherited;
end;

procedure TFrmNotaStarter.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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

procedure TFrmNotaStarter.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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

  unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, False, 2, 0, 0, 0, '', CdsServico);
  unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, False, 2, 0, 0, 0, '', CdsProduto);
  unNotaPagamento.CarregaDbGrid(DtmPrincipal.Conexao, False, 2, 0, 0, 0, 0, '', CdsTipoPagamento);
end;

procedure TFrmNotaStarter.InicializarProduto;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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

procedure TFrmNotaStarter.InicializarServico;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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

procedure TFrmNotaStarter.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
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
  EdtIdCliente.Clear;
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
end;

procedure TFrmNotaStarter.InicializarTipoPagamento;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTipoPagamento';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  EdtVlPgtoDinheiro.Text          := '0,00';
  EdtVlPgtoDebito.Text            := '0,00';
  EdtVlPgtoCredito.Text           := '0,00';
end;

procedure TFrmNotaStarter.MkeNrCelular1KeyPress(Sender: TObject; var Key: Char);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtNrCelular1KeyPress';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Key = #13 then
  begin
    EdtIdCliente.Clear;
    EdtNmPessoa.Clear;
    unPessoa.Inicializar;
    unPessoa.BuscarNrCelular(DtmPrincipal.Conexao, RemoveCaracteres(MkeNrCelular1.Text));

    if unPessoa.IdPessoa > 0 then
    begin
      EdtNmPessoa.Text          := unPessoa.NmPessoa;
      EdtIdCliente.Text         := IntToStr(unPessoa.IdPessoa);
      GrbServico.Enabled        := True;
      GrbProduto.Enabled        := True;
      GrbTipoPagamento.Enabled  := True;
      CbbIdProfServico.SetFocus;
    end;
  end;
end;

procedure TFrmNotaStarter.MkeNrCelular1PropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCelular1PropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 11) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end;
end;

procedure TFrmNotaStarter.TabProdutoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'TabProdutoClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    CbbIdProfProduto.SetFocus;
  finally

  end;
end;

procedure TFrmNotaStarter.EdtDescProdutoExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtDescProdutoExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlProduto.Text := RetornaValorEmReal((StrToCurr(RemoveMoeda(EdtVlProduto.Text)) - ((StrToCurr(RemoveMoeda(EdtVlProduto.Text)) * StrToFloat(EdtDescProduto.Text)) / 100)));
  finally

  end;
end;

procedure TFrmNotaStarter.EdtDescServicoExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtDescServicoExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlServico.Text := RetornaValorEmReal((StrToCurr(RemoveMoeda(EdtVlServico.Text)) - ((StrToCurr(RemoveMoeda(EdtVlServico.Text)) * StrToFloat(EdtDescServico.Text)) / 100)));
  finally

  end;
end;

procedure TFrmNotaStarter.EdtNrEanKeyPress(Sender: TObject; var Key: Char);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtNrEanKeyPress';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (not(Key in ['0'..'9', #08, #13, #46])) and (Key <> #0) then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
    DtmPrincipal.unLog.NmMetodo   := 'EdtNrEanKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Produto';
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
    end;
  end;
end;

procedure TFrmNotaStarter.EdtQtdNotaItemProdutoExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtQtdNotaItemProdutoExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlProduto.Text := RetornaValorEmReal((StrToFloat(EdtQtdNotaItemProduto.Text) * StrToCurr(RemoveMoeda(EdtVlProduto.Text))));
  finally

  end;
end;

procedure TFrmNotaStarter.EdtQtdNotaItemServicoExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtQtdNotaItemServicoExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlServico.Text := RetornaValorEmReal((StrToFloat(EdtQtdNotaItemServico.Text) * StrToCurr(RemoveMoeda(EdtVlServico.Text))));
  finally

  end;
end;

procedure TFrmNotaStarter.EdtVlPgtoCreditoExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtVlPgtoCreditoExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlPgtoCredito.Text := RemoveMoeda(RetornaValorEmReal(StrToCurr(EdtVlPgtoCredito.Text)));
  finally

  end;
end;

procedure TFrmNotaStarter.EdtVlPgtoDebitoExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtVlPgtoDebitoExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtVlPgtoDebito.Text := RemoveMoeda(RetornaValorEmReal(StrToCurr(EdtVlPgtoDebito.Text)));
  finally

  end;
end;

procedure TFrmNotaStarter.EdtVlPgtoDinheiroExit(Sender: TObject);
var
  lVlDinheiro : Currency;
  lVlGeral    : Currency;
  lVlTroco    : Currency;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtVlPgtoDinheiroExit';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  lVlDinheiro := StrToCurr(RemoveMoeda(EdtVlPgtoDinheiro.Text));
  lVlGeral    := StrToCurr(RemoveMoeda(EdtVlGeral.Text));
  try
    EdtVlPgtoDinheiro.Text := RemoveMoeda(RetornaValorEmReal(StrToCurr(EdtVlPgtoDinheiro.Text)));

    if lVlDinheiro > lVlGeral then
    begin
      lVlTroco        := lVlDinheiro - lVlGeral;
      EdtVlTroco.Text := RetornaValorEmReal(lVlTroco);
    end;
  finally

  end;
end;

end.