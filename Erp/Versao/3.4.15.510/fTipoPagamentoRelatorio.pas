unit fTipoPagamentoRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fRelatorio, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, cxDropDownEdit, cxCalendar, cxTextEdit, cxMaskEdit, Vcl.StdCtrls, cxButtons,
  Vcl.ExtCtrls;

type
  TFrmTipoPagamentoRelatorio = class(TFrmRelatorio)
    LblPagamento: TLabel;
    Label4              : TLabel;
    CbbIdCarregar: TcxComboBox;
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
  FrmTipoPagamentoRelatorio: TFrmTipoPagamentoRelatorio;

implementation

{$R *.dfm}

uses dPrincipal, uCarregaDados, uFuncao, uMensagem, fProcessando, dRelatorios, uEmpresa, uProcedure, uRelatorio, fAjuda;

{ TFrmTipoPagamentoRelatorio }

var
  unCarregaDados : TCarregaDados;
  unEmpresa      : TEmpresa;
  dnRelatorios   : TDtmRelatorios;
  unRelatorio    : TRelatorio;

procedure TFrmTipoPagamentoRelatorio.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamentoRelatorio';
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

procedure TFrmTipoPagamentoRelatorio.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamentoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoPagamentoRelatorio.BtnGerarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'BtnGerarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamentoRelatorio';
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

      unRelatorio.BuscarNomeRelatorio(DtmPrincipal.Conexao, CbbIdRelatorio.Text);

      if unRelatorio.NmProcedure = 'FastCurvaABCTipoPagamento' then
      begin
        uProcedure.FastCurvaABCTipoPagamento(Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]), DtpDtInicio.Date, DtpDtFinal.Date, 'Periodo', dnRelatorios.CDSRelPesquisa);
      end
      else
      if unRelatorio.NmProcedure = 'FastComissaoProfissional' then
      begin
        uProcedure.FastComissaoProfissional(Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]), DtpDtInicio.Date, DtpDtFinal.Date, 'Servico', 'Periodo', dnRelatorios.CDSRelPesquisa);
      end;

      dnRelatorios.CDSRelPesquisa.IndexFieldNames := CbbIdRelatorioOrdem.Text;

      if CbbIdCarregar.Text <> '[TODOS]' then
      begin
        dnRelatorios.CDSRelPesquisa.Filtered  := False;

        if unRelatorio.NmProcedure = 'FastCurvaABCTipoPagamento' then
        begin
          dnRelatorios.CDSRelPesquisa.Filter    := '(NmTpPagamento = ' + QuotedStr(CbbIdCarregar.Text) + ')';
        end
        else
        if unRelatorio.NmProcedure = 'FastComissaoProfissional' then
        begin
          dnRelatorios.CDSRelPesquisa.Filter    := '(NmProfissional = ' + QuotedStr(CbbIdCarregar.Text) + ')';
        end;

        dnRelatorios.CDSRelPesquisa.Filtered  := True;
      end;

      FrmProcessando.Destroy;

      dnRelatorios.frxPDFExport.ShowDialog    := True;

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

procedure TFrmTipoPagamentoRelatorio.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamentoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmTipoPagamentoRelatorio.CarregarTela(ATpChamadaClasse: String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamentoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  if ATpChamadaClasse = 'Geral' then
  begin
    CbbIdEmpresa.Properties.Items.Clear;
    CbbIdRelatorio.Properties.Items.Clear;

    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', CbbIdEmpresa);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Relatorio', 0, 'Financeiro', '', CbbIdRelatorio);
  end
  else
  if ATpChamadaClasse = 'RelatorioOrdem' then
  begin
    unRelatorio.Inicializar;
    unRelatorio.BuscarNomeRelatorio(DtmPrincipal.Conexao, CbbIdRelatorio.Text);

    if unRelatorio.NmProcedure = 'FastCurvaABCTipoPagamento' then
    begin
      CbbIdCarregar.Properties.Items.Clear;
      unCarregaDados.gCarregarSelecionar := 3;
      unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'TipoPagamento', 0, '', '', CbbIdCarregar);
    end
    else
    if unRelatorio.NmProcedure = 'FastComissaoProfissional' then
    begin
      CbbIdCarregar.Properties.Items.Clear;
      unCarregaDados.gCarregarSelecionar := 3;
      unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'PessoaTipoPessoa', 0, 'Cliente', 'SemIds', CbbIdCarregar);
    end;

    CbbIdRelatorioOrdem.Properties.Items.Clear;
    unCarregaDados.gCarregarSelecionar := 1;
    if CbbIdRelatorio.Text <> '[SELECIONE]' then
    begin
      unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'RelatorioOrdem', Integer(CbbIdRelatorio.Properties.Items.Objects[CbbIdRelatorio.ItemIndex]), '', '',  CbbIdRelatorioOrdem);
    end
    else
    if CbbIdRelatorio.Text = '[SELECIONE]' then
    begin
      CbbIdCarregar.Properties.Items.AddObject('[TODOS]', TObject(0));
      CbbIdCarregar.ItemIndex := 0;

      CbbIdRelatorioOrdem.Properties.Items.AddObject('[SELECIONE]', TObject(0));
      CbbIdRelatorioOrdem.ItemIndex := 0;
    end;
  end;
end;

procedure TFrmTipoPagamentoRelatorio.CbbIdRelatorioClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdRelatorioClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamentoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  CarregarTela('RelatorioOrdem');
end;

procedure TFrmTipoPagamentoRelatorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamentoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;


procedure TFrmTipoPagamentoRelatorio.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamentoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;
  unRelatorio    := TRelatorio.Create;
end;

procedure TFrmTipoPagamentoRelatorio.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamentoRelatorio';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmTipoPagamentoRelatorio.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoRelatorio';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamentoRelatorio';
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