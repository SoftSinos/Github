unit fCopiaSeguranca;

interface

uses TLHelp32, DateUtils, WinInet, MaskUtils, DbTables, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
     FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
     FireDAC.Comp.UI, Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fOperacao, cxGraphics,
     cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls;

type
  TFrmCopiaSeguranca = class(TFrmOperacao)
    GroupBox1       : TGroupBox;
    RdbReduzir      : TRadioButton;
    Label1          : TLabel;
    LblCaminhoCopia : TLabel;
    PrbPesquisa     : TProgressBar;
    procedure BtnGerarClick(Sender: TObject);
    procedure BtnLocalClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    DuracaoTempo : TTime;
  end;

var
  FrmCopiaSeguranca: TFrmCopiaSeguranca;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uMensagem, fAjuda, uProcedure;


procedure TFrmCopiaSeguranca.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCopiaSeguranca';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    FrmAjuda := TFrmAjuda.Create(Application);
    FrmAjuda.Caption        := 'Ajuda Sobre � Tela de ' +  Caption;;
    FrmAjuda.gNmTelaChamada := Name;
    FrmAjuda.ShowModal;
  finally
    FrmAjuda.Free;
  end;
end;

procedure TFrmCopiaSeguranca.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCopiaSeguranca';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmCopiaSeguranca.BtnLocalClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCopiaSeguranca';
  DtmPrincipal.unLog.NmMetodo   := 'BtnGravadoClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  AbrirExplorer(LblCaminhoCopia.Caption, True, True);
end;

procedure TFrmCopiaSeguranca.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCopiaSeguranca';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmCopiaSeguranca.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCopiaSeguranca';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmCopiaSeguranca.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCopiaSeguranca';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmCopiaSeguranca.BtnGerarClick(Sender: TObject);
var
  qryReduzir : TFDQuery;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCopiaSeguranca';
  DtmPrincipal.unLog.NmMetodo   := 'BtnGerarClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    Application.ProcessMessages;
    BtnGerar.Cursor     := crHourGlass;

    uProcedure.CopiaSeguranca;

    if RdbReduzir.Checked then
    begin
      qryReduzir   := TFDQuery.Create(nil);
      qryReduzir.Sql.Clear;
      qryReduzir.Connection := DtmPrincipal.Conexao;
      qryReduzir.Sql.Add('Exec PC_ShrinkFile       ');

      qryReduzir.ExecSQL;
      qryReduzir.FreeOnRelease;
    end;

  finally
    BtnGerar.Cursor     := crDefault;
    MsgInformacao(uMensagem.CopiaSegurancaRealizadaComSucesso)
  end;
end;

procedure TFrmCopiaSeguranca.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Call';
  DtmPrincipal.unLog.NmClasse   := 'InicializarTela';
  DtmPrincipal.unLog.NmMetodo   := 'TFrmCopiaSeguranca';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  LblCaminhoCopia.Caption := DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\' + uFuncao.DiaDaSemana(DayofWeek(Date), 0);
end;

end.
