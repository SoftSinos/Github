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
    EdtNrCelular1           : TEdit;
    EdtNmPessoa             : TEdit;
    EdtIdCliente            : TEdit;
    Label4                  : TLabel;
    DtsServico              : TDataSource;
    DtsProduto              : TDataSource;
    DtsTipoPagamento        : TDataSource;
    Label3                  : TLabel;
    MkeVlTotal              : TMaskEdit;
    BtnImprimir             : TcxButton;
    BtnEmpresaPesquisa      : TcxButton;
    BtnClientePesquisar     : TcxButton;
    CbbIdEmpresa            : TcxComboBox;
    PgcExtra: TcxPageControl;
    TbsEndereco: TcxTabSheet;
    Produto: TcxTabSheet;
    GroupBox3: TGroupBox;
    GroupBox5: TGroupBox;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label23: TLabel;
    Label25: TLabel;
    Label27: TLabel;
    EdtDescServico: TEdit;
    EdtVlServico: TEdit;
    EdtQtdNotaItemServico: TEdit;
    BtnCanServico: TcxButton;
    BtnAdiServico: TcxButton;
    BtnProfServicoPesquisar: TcxButton;
    BtnServiServicoPesquisar: TcxButton;
    CbbIdProfServico: TcxComboBox;
    CbbIdServico: TcxComboBox;
    GroupBox6: TGroupBox;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label18: TLabel;
    Label24: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    EdtNmProduto: TEdit;
    EdtNrEan: TEdit;
    EdtDescProduto: TEdit;
    EdtVlProduto: TEdit;
    EdtQtdNotaItemProduto: TEdit;
    BtnAdiProduto: TcxButton;
    BtnCanProduto: TcxButton;
    BtnProfProdutoPesquisar: TcxButton;
    BtnProdutoPesquisar: TcxButton;
    CbbIdProfProduto: TcxComboBox;
    Label6: TLabel;
    DbgServico: TDBGrid;
    DbgProduto: TDBGrid;
    cxPageControl1: TcxPageControl;
    cxTabSheet1: TcxTabSheet;
    GroupBox4: TGroupBox;
    Panel3: TPanel;
    Label2: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label14: TLabel;
    MkeVlPgtoCredito: TMaskEdit;
    MkeVlPgtoDebito: TMaskEdit;
    MkeVlPgtoDinheiro: TMaskEdit;
    MkeVlServicos: TMaskEdit;
    MkeVlProdutos: TMaskEdit;
    DbgPagamento: TDBGrid;
    BtnAdiTipoPagamento: TcxButton;
    BtnCanTipoPagamento: TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnProfServicoPesquisarClick(Sender: TObject);
    procedure BtnProfProdutoPesquisarClick(Sender: TObject);
    procedure BtnServiServicoPesquisarClick(Sender: TObject);
    procedure BtnProdutoPesquisarClick(Sender: TObject);
    procedure BtnClientePesquisarClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure EdtNrCelular1KeyPress(Sender: TObject; var Key: Char);
    procedure CbbIdServicoEnter(Sender: TObject);
    procedure CbbIdServicoClick(Sender: TObject);
    procedure BtnAdiServicoClick(Sender: TObject);
    procedure EdtNrEanKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAdiTipoPagamentoClick(Sender: TObject);
    procedure BtnEmpresaPesquisaClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CarregarTela;
    procedure CopulaTela;
    procedure ControleBotao;
  end;

var
  FrmNotaStarter: TFrmNotaStarter;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uNota, uNotaItem, uNotaPagamento, fAjuda, fPessoaPesquisa, fServicoPesquisa, fProdutoPesquisa,
    fTipoPagamentoPesquisa, dRelatorios, uEmpresa, fTipoServicoPesquisa, uPessoa, uServico, uProduto, uTipoPagamento, fEmpresaPesquisa, fPrincipal;

var
  unNota          : TNota;
  unNotaItem      : TNotaItem;
  unNotaPagamento : TNotaPagamento;
  unCarregaDados  : TCarregaDados;
  unEmpresa       : TEmpresa;
  unPessoa        : TPessoa;
  unServico       : TServico;
  unProduto       : TProduto;
  unTipoPagamento : TTipoPagamento;
  dnRelatorios    : TDtmRelatorios;

procedure TFrmNotaStarter.BtnServiServicoPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnServiServicoPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmTipoServicoPesquisa := TFrmTipoServicoPesquisa.Create(Application);
    FrmTipoServicoPesquisa.ShowModal;
  finally
    FrmTipoServicoPesquisa.Free;
    CbbIdProfServico.Properties.Items.Clear;
    CbbIdProfProduto.Properties.Items.Clear;
    CarregarTela;
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
      CdsServico.FieldByName('VlServico')      .AsCurrency  := (unServico.VlServico - (unServico.VlServico * StrToFloat(EdtDescServico.Text)/100)) * StrToFloat(EdtQtdNotaItemServico.Text);
      CdsServico.Post;
    end;
  finally

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

  if StrToFloat(MkeVlPgtoDinheiro.Text) > 1 then
  begin
    unTipoPagamento.Inicializar;
    unTipoPagamento.BuscarNmTpPagamento(DtmPrincipal.Conexao, 'DINHEIRO');

    if unTipoPagamento.IdTpPagamento > 0 then
    begin
      lIdTpPgtoDinheiro := unTipoPagamento.IdTpPagamento
    end;

    CdsTipoPagamento.Append;
    CdsTipoPagamento.FieldByName('IdTpPagamento') .AsInteger   := lIdTpPgtoDinheiro;
    CdsTipoPagamento.FieldByName('VlPagamento')   .AsCurrency  := StrToFloat(MkeVlPgtoDinheiro.Text);
    CdsTipoPagamento.Post;
  end;
  if StrToFloat(MkeVlPgtoDebito.Text) > 1 then
  begin
    unTipoPagamento.Inicializar;
    unTipoPagamento.BuscarNmTpPagamento(DtmPrincipal.Conexao, 'DEBITO');

    if unTipoPagamento.IdTpPagamento > 0 then
    begin
      lIdTpPgtoDebito := unTipoPagamento.IdTpPagamento
    end;

    CdsTipoPagamento.Append;
    CdsTipoPagamento.FieldByName('IdTpPagamento') .AsInteger   := lIdTpPgtoDebito;
    CdsTipoPagamento.FieldByName('VlPagamento')   .AsCurrency  := StrToFloat(MkeVlPgtoDinheiro.Text);
    CdsTipoPagamento.Post;
  end;
  if StrToFloat(MkeVlPgtoCredito.Text) > 1 then
  begin
    unTipoPagamento.Inicializar;
    unTipoPagamento.BuscarNmTpPagamento(DtmPrincipal.Conexao, 'CREDITO');

    if unTipoPagamento.IdTpPagamento > 0 then
    begin
      lIdTpPgtoCredito := unTipoPagamento.IdTpPagamento
    end;

    CdsTipoPagamento.Append;
    CdsTipoPagamento.FieldByName('IdTpPagamento') .AsInteger   := lIdTpPgtoCredito;
    CdsTipoPagamento.FieldByName('VlPagamento')   .AsCurrency  := StrToFloat(MkeVlPgtoDinheiro.Text);
    CdsTipoPagamento.Post;
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
    FrmAjuda.Caption        := 'Ajuda Sobre à Tela de ' +  Caption;
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
      EdtNrCelular1.Text      := FrmPessoaPesquisa.CdsPesquisa.FieldByName('NrCelular')  .AsString;
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
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmEmpresaPesquisa := TFrmEmpresaPesquisa.Create(Application);
    FrmEmpresaPesquisa.ShowModal;
  finally
    FrmEmpresaPesquisa.Free;
    CbbIdEmpresa.Properties.Items.Clear;
    CbbIdProfServico.Properties.Items.Clear;
    CbbIdProfProduto.Properties.Items.Clear;
    CarregarTela;
  end;
end;

procedure TFrmNotaStarter.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unNota.Free;
  unNotaItem.Free;
  unNotaPagamento.Free;
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
  DtmPrincipal.unLog.NmMetodo   := 'BtnLocalClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  PnlCampos.Enabled := True;
  InicializarTela;

  ShowMessage(Inttostr(clientHeight) + #13 + Inttostr(clientWidth));
  ShowMessage(Inttostr(Height) + #13 + Inttostr(Width));

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
      EdtNrEan.Text            := FrmProdutoPesquisa.CdsPesquisa.FieldByName('NrEan')     .AsString;
      EdtNmProduto.Text        := FrmProdutoPesquisa.CdsPesquisa.FieldByName('NmProduto') .AsString;
      EdtVlProduto.Text        := FrmProdutoPesquisa.CdsPesquisa.FieldByName('VlVenda')   .AsString;
    end;
    FrmProdutoPesquisa.Free;
  end;
end;

procedure TFrmNotaStarter.BtnProfProdutoPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProfProdutoPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmPessoaPesquisa := TFrmPessoaPesquisa.Create(Application);
    FrmPessoaPesquisa.ShowModal;
  finally
    FrmPessoaPesquisa.Free;
    CbbIdProfProduto.Properties.Items.Clear;
    CarregarTela;
  end;
end;

procedure TFrmNotaStarter.BtnProfServicoPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProfServicoPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmPessoaPesquisa := TFrmPessoaPesquisa.Create(Application);
    FrmPessoaPesquisa.ShowModal;
  finally
    FrmPessoaPesquisa.Free;
    CbbIdProfServico.Properties.Items.Clear;
    CbbIdProfProduto.Properties.Items.Clear;
    CarregarTela;
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

procedure TFrmNotaStarter.CarregarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', '', CbbIdEmpresa);
  unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Pessoa', 0, 'Profissional', '', '', CbbIdProfServico);
  unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Pessoa', 0, 'Profissional', '', '', CbbIdProfProduto);
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
      EdtVlServico.Text := RetornaValorEmReal(unServico.VlServico);
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

  PnlCampos.Enabled   := True;
  BtnIncluir.Enabled  := False;
  BtnSalvar.Enabled   := True;
  BtnCancelar.Enabled := True;
  BtnFechar.Enabled   := True;
end;

procedure TFrmNotaStarter.CopulaTela;
begin

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
    CbbIdEmpresa.Enabled    := False;
    CbbIdEmpresa.ItemIndex  := Integer(CbbIdEmpresa.Properties.Items.IndexOf(DtmPrincipal.NmFantasiaNmRazaoSocial));
  end
  else
  begin
    CbbIdEmpresa.Enabled := true;
  end;

  unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, False, 2, 0, 0, 0, '', CdsServico);
  unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, False, 2, 0, 0, 0, '', CdsProduto);
  unNotaPagamento.CarregaDbGrid(DtmPrincipal.Conexao, False, 2, 0, 0, 0, 0, '', CdsTipoPagamento);
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
  end;
  EdtNrCelular1.Clear;
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
  MkeVlPgtoDinheiro.Text          := '0,00';
  MkeVlPgtoDebito.Text            := '0,00';
  MkeVlPgtoCredito.Text           := '0,00';
  MkeVlServicos.Text              := '0,00';
  MkeVlProdutos.Text              := '0,00';
  MkeVlTotal.Text                 := '0,00';
end;

procedure TFrmNotaStarter.EdtNrCelular1KeyPress(Sender: TObject; var Key: Char);
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
    unPessoa.BuscarNrCelular(DtmPrincipal.Conexao, EdtNrCelular1.Text);

    if unPessoa.IdPessoa > 0 then
    begin
      EdtNmPessoa.Text  := unPessoa.NmPessoa;
      EdtIdCliente.Text := IntToStr(unPessoa.IdPessoa);
    end;
  end;
end;

procedure TFrmNotaStarter.EdtNrEanKeyPress(Sender: TObject; var Key: Char);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtNrEanKeyPress';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Key = #13 then
  begin
    unProduto.Inicializar;
    unProduto.BuscarNrEan(DtmPrincipal.Conexao, EdtNrEan.Text);

    if unProduto.IdProduto > 0 then
    begin
      EdtNrEan.Text     := unProduto.NrEan;
      EdtNmProduto.Text := unProduto.NmProduto;
      EdtVlProduto.Text := FloatToStr(unProduto.VlVenda);
    end;
  end;
end;

end.
