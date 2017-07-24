unit fSplash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Graphics, Vcl.Dialogs, Vcl.Touch.Keyboard, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, dPrincipal, uFuncao, Vcl.Menus,
  Vcl.ImgList, Vcl.ToolWin, Vcl.Buttons, Jpeg, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Contnrs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Imaging.pngimage, ShellApi, dxGDIPlusClasses, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, Vcl.ButtonGroup, Vcl.Themes, ClipBrd, cxControls, cxContainer, cxEdit, cxLabel;

type
  TFrmSplash = class(TForm)
    ProgressBarSplash : TProgressBar;
    TimerSplash       : TTimer;
    LblCopyright      : TcxLabel;
    LblCarregando     : TcxLabel;
    LblVersaoSplash   : TcxLabel;
    LblSoft           : TcxLabel;
    LblSinos          : TcxLabel;
    cxLabel2          : TcxLabel;
    ImgSplash         : TImage;
    ImgLogoInfinito   : TImage;
    LblAlerta         : TcxLabel;
    procedure TimerSplashTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSplash: TFrmSplash;

implementation

{$R *.dfm}

procedure TFrmSplash.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmSplash';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Action := caFree;
end;

procedure TFrmSplash.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmSplash';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if FileExists('Imagem/Sistema/Splash.jpg') then
  begin
    ImgSplash.Picture.LoadFromFile('Imagem/Sistema/Splash.jpg');
  end;
end;

procedure TFrmSplash.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmSplash';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if VersaoExecutavel(DtmPrincipal.NmCaminhoExecutavel + DtmPrincipal.NmExecutavel) <> DtmPrincipal.NrVersaoBd then
  begin
    LblAlerta.Visible := True;
  end;
end;

procedure TFrmSplash.TimerSplashTimer(Sender: TObject);
var
  I: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmSplash';
  DtmPrincipal.unLog.NmMetodo   := 'TimerSplashTimer';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    for I := 1 to 100 do
    begin
      Sleep(40);
      ProgressBarSplash.Position := ProgressBarSplash.Position + 1;
    end;
  finally
    Close;
  end;
end;

end.
