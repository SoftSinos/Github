unit fLogPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  Vcl.Menus, cxButtons;

type
  TFrmLogPesquisa = class(TFrmPesquisa)
    Label13     : TLabel;
    DtpDtInicial: TcxDateEdit;
    Label3      : TLabel;
    DtpDtFinal  : TcxDateEdit;
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar(AConsulta: String);
    procedure ControleBotao;
  public
    { Public declarations }
  end;

var
  FrmLogPesquisa: TFrmLogPesquisa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uLog, uMensagem, dRelatorios, uEmpresa, fAjuda, fPrincipal;

var
  unLog         : TLog;
  unEmpresa     : TEmpresa;
  dnRelatorios  : TDtmRelatorios;

procedure TFrmLogPesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Log';
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

procedure TFrmLogPesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Log';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmLogPesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'Log';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    dnRelatorios := TDtmRelatorios.Create(Self);
    unEmpresa    := TEmpresa.Create;
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelEmpresa);

    unLog.CarregaDbGrid(DtmPrincipal.Conexao, 0, 0, EdtPesquisa.Text, DtpDtInicial.Date, DtpDtFinal.Date, 1, dnRelatorios.CDSRelPesquisa);

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel + 'Relatorio\RelPesqImpLog.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmLogPesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'Log';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  ControleBotao;
end;

procedure TFrmLogPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Log';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text);

  inherited;
end;

procedure TFrmLogPesquisa.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'Log';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnIncluir.Enabled := False;
  BtnAlterar.Enabled := False;
end;

procedure TFrmLogPesquisa.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmLogPesquisa';
    DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Log';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    BtnPesquisarClick(Sender);
  end;
  inherited;
end;

procedure TFrmLogPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Log';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unLog.Free;
  FrmPrincipal.TasLog.TabVisible := False;
  FrmPrincipal.PgcVisivel;
end;

procedure TFrmLogPesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Log';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmLogPesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Log';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  DtpDtInicial.Date := Now;
  DtpDtFinal.Date   := Now;

  ControleBotao;
end;

procedure TFrmLogPesquisa.Pesquisar(AConsulta: String);
var
  I: Integer;
  lConsulta: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Log';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  PrbPesquisa.Position := 0;
  lConsulta := 0;
  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    for I := 1 to 100 do
    begin
      Sleep(15);
      PrbPesquisa.Position := PrbPesquisa.Position + 1;
      if lConsulta = 0 then
      begin
        lConsulta := 1;
        unLog := TLog.Create;
        unLog.CarregaDbGrid(DtmPrincipal.Conexao, 0, 0, EdtPesquisa.Text, DtpDtInicial.Date, DtpDtFinal.Date, 1, CdsPesquisa);
      end;
    end;
  finally
    FrmProcessando.Destroy;
  end;
end;

end.
