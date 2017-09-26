unit fProdutoRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fRelatorio, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxDropDownEdit, cxCalendar, cxTextEdit, cxMaskEdit, Vcl.StdCtrls, cxButtons,
  Vcl.ExtCtrls;

type
  TFrmProdutoRelatorio = class(TFrmRelatorio)
    LblProduto          : TLabel;
    Label4              : TLabel;
    CbbIdProduto        : TcxComboBox;
    CbbIdRelatorioOrdem : TcxComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnGerarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure CbbIdRelatorioClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CarregarTela(ATpChamadaClasse:String);
  end;

var
  FrmProdutoRelatorio: TFrmProdutoRelatorio;

implementation

{$R *.dfm}

uses dPrincipal, uCarregaDados, uFuncao, uMensagem, fProcessando, dRelatorios, uEmpresa, uProcedure, uRelatorio, fAjuda;

{ TFrmProdutoRelatorio }

var
  unCarregaDados : TCarregaDados;
  unEmpresa      : TEmpresa;
  dnRelatorios   : TDtmRelatorios;
  unRelatorio    : TRelatorio;

procedure TFrmProdutoRelatorio.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'ProdutoRelatorio';
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

procedure TFrmProdutoRelatorio.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'ProdutoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmProdutoRelatorio.BtnGerarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'BtnGerarClick';
  DtmPrincipal.unLog.NmTabela   := 'ProdutoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if (CbbIdEmpresa.Text <> '[SELECIONE]') and (CbbIdRelatorio.Text <> '[SELECIONE]') and (CbbIdRelatorioOrdem.Text <> '[SELECIONE]') then
  begin
    try
      Application.CreateForm(TFrmProcessando, FrmProcessando);
      FrmProcessando.Show;
      Application.ProcessMessages;

      dnRelatorios := TDtmRelatorios.Create(Self);
      unEmpresa    := TEmpresa.Create;
      unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelEmpresa);

      uProcedure.FastCurvaABCProfissional(Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]), DtpDtInicio.Date, DtpDtFinal.Date, 'Produto', 'Periodo', dnRelatorios.CDSRelPesquisa);


      dnRelatorios.CDSRelPesquisa.IndexFieldNames := CbbIdRelatorioOrdem.Text;


      if CbbIdProduto.Text <> '[TODOS]' then
      begin
        dnRelatorios.CDSRelPesquisa.Filtered  := False;
        dnRelatorios.CDSRelPesquisa.Filter    := '(NmProduto = ' + QuotedStr(CbbIdProduto.Text) + ')';
        dnRelatorios.CDSRelPesquisa.Filtered  := True;
      end;

      FrmProcessando.Destroy;

      dnRelatorios.frxPDFExport.ShowDialog    := True;

      unRelatorio.BuscarNomeRelatorio(DtmPrincipal.Conexao, CbbIdRelatorio.Text);

      dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\' + unRelatorio.NmArquivoRelatorio);
      dnRelatorios.frxReport.ShowReport();
    finally
      dnRelatorios.Destroy;
    end;
  end
  else
  begin
    MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
  end;
end;

procedure TFrmProdutoRelatorio.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'ProdutoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmProdutoRelatorio.CarregarTela(ATpChamadaClasse: String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'ProdutoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  if ATpChamadaClasse = 'Geral' then
  begin
    CbbIdEmpresa.Properties.Items.Clear;
    CbbIdRelatorio.Properties.Items.Clear;
    CbbIdProduto.Properties.Items.Clear;

    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', CbbIdEmpresa);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Relatorio', 0, 'Produto', '', CbbIdRelatorio);
    unCarregaDados.gCarregarSelecionar := 3;
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Produto', 0, '', '', CbbIdProduto);
  end
  else
  if ATpChamadaClasse = 'RelatorioOrdem' then
  begin
    CbbIdRelatorioOrdem.Properties.Items.Clear;
    unCarregaDados.gCarregarSelecionar := 1;
    if CbbIdRelatorio.Text <> '[SELECIONE]' then
    begin
      unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'RelatorioOrdem', Integer(CbbIdRelatorio.Properties.Items.Objects[CbbIdRelatorio.ItemIndex]), '', '',  CbbIdRelatorioOrdem);
    end
    else
    if CbbIdRelatorio.Text = '[SELECIONE]' then
    begin
      CbbIdRelatorioOrdem.Properties.Items.AddObject('[SELECIONE]', TObject(0));
      CbbIdRelatorioOrdem.ItemIndex := 0;
    end;
  end;
end;

procedure TFrmProdutoRelatorio.CbbIdRelatorioClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdRelatorioClick';
  DtmPrincipal.unLog.NmTabela   := 'ProdutoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  CarregarTela('RelatorioOrdem');
end;

procedure TFrmProdutoRelatorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'ProdutoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmProdutoRelatorio.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'ProdutoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;
  unRelatorio    := TRelatorio.Create;
end;

procedure TFrmProdutoRelatorio.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'ProdutoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmProdutoRelatorio.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'ProdutoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if not DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.Enabled       := False;
    CbbIdEmpresa.ItemIndex     := Integer(CbbIdEmpresa.Properties.Items.IndexOf(DtmPrincipal.NmFantasiaNmRazaoSocial));
    DtpDtInicio.SetFocus;
  end
  else
  begin
    CbbIdEmpresa.Enabled       := true;
    CbbIdEmpresa.ItemIndex      := 0;
    CbbIdEmpresa.SetFocus;
  end;

  DtpDtInicio.Date := Now;
  DtpDtFinal.Date  := Now;

  CarregarTela('Geral');

  CbbIdRelatorioOrdem.Properties.Items.Clear;
  CbbIdRelatorioOrdem.Properties.Items.AddObject('[SELECIONE]', TObject(0));
  CbbIdRelatorioOrdem.ItemIndex := 0;
end;

end.