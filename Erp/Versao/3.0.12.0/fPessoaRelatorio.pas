unit fPessoaRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fRelatorio, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxDropDownEdit, cxCalendar, cxTextEdit, cxMaskEdit, Vcl.StdCtrls, cxButtons,
  Vcl.ExtCtrls;

type
  TFrmPessoaRelatorio = class(TFrmRelatorio)
    LblPessoa           : TLabel;
    CbbIdPessoa         : TcxComboBox;
    Label4              : TLabel;
    CbbIdRelatorioOrdem : TcxComboBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CbbIdRelatorioClick(Sender: TObject);
    procedure BtnGerarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CarregarTela(ATpChamadaClasse:String);
  end;

var
  FrmPessoaRelatorio: TFrmPessoaRelatorio;

implementation

{$R *.dfm}

uses dPrincipal, uCarregaDados, uFuncao, uMensagem, fProcessando, dRelatorios, uEmpresa, uProcedure, uRelatorio, fAjuda;

{ TFrmPessoaRelatorio }

var
  unCarregaDados : TCarregaDados;
  unEmpresa      : TEmpresa;
  dnRelatorios   : TDtmRelatorios;
  unRelatorio    : TRelatorio;

procedure TFrmPessoaRelatorio.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoaRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'PessoaRelatorio';
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

procedure TFrmPessoaRelatorio.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoaRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'PessoaRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmPessoaRelatorio.BtnGerarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoaRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'BtnGerarClick';
  DtmPrincipal.unLog.NmTabela   := 'PessoaRelatorio';
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

      uProcedure.FastCurvaABCCliente(Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]), DtpDtInicio.Date, DtpDtFinal.Date, 'Periodo', dnRelatorios.CDSRelPesquisa);


      dnRelatorios.CDSRelPesquisa.IndexFieldNames := CbbIdRelatorioOrdem.Text;


      if CbbIdPessoa.Text <> '[TODOS]' then
      begin
        dnRelatorios.CDSRelPesquisa.Filtered  := False;
        dnRelatorios.CDSRelPesquisa.Filter    := '(NmCliente = ' + QuotedStr(CbbIdPessoa.Text) + ')';
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

procedure TFrmPessoaRelatorio.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoaRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'PessoaRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmPessoaRelatorio.CarregarTela(ATpChamadaClasse: String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoaRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'PessoaRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  if ATpChamadaClasse = 'Geral' then
  begin
    CbbIdEmpresa.Properties.Items.Clear;
    CbbIdRelatorio.Properties.Items.Clear;
    CbbIdPessoa.Properties.Items.Clear;

    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', CbbIdEmpresa);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Relatorio', 0, 'Cliente', '', CbbIdRelatorio);
    unCarregaDados.gCarregarSelecionar := 3;
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'PessoaTipoPessoa', 0, 'Cliente', 'SemIds', CbbIdPessoa);
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

procedure TFrmPessoaRelatorio.CbbIdRelatorioClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoaRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdRelatorioClick';
  DtmPrincipal.unLog.NmTabela   := 'PessoaRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  CarregarTela('RelatorioOrdem');
end;

procedure TFrmPessoaRelatorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoaRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'PessoaRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmPessoaRelatorio.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoaRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'PessoaRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;
  unRelatorio    := TRelatorio.Create;
end;

procedure TFrmPessoaRelatorio.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoaRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'PessoaRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmPessoaRelatorio.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoaRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'PessoaRelatorio';
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
