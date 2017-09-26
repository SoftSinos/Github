unit fAgendaPremium;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fBase, Vcl.ExtCtrls, Vcl.ComCtrls, Planner, DBPlanner, Data.DB, Datasnap.DBClient, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters,
  Vcl.Menus, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, Vcl.StdCtrls, cxButtons, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TFrmAgendaPremium = class(TFrmBase)
    DtsAgenda             : TDataSource;
    PrbPesquisa           : TProgressBar;
    Panel1                : TPanel;
    Panel2                : TPanel;
    BtnAgendaExtra        : TcxButton;
    BtnFaltar             : TcxButton;
    BtnAjuda              : TcxButton;
    PnlPrincipal          : TPanel;
    BtnIncluir            : TcxButton;
    BtnPesquisar          : TcxButton;
    PnlCalendario         : TPanel;
    CldMeses              : TMonthCalendar;
    PaintBox1             : TPaintBox;
    Panel3                : TPanel;
    BtnImprimir           : TcxButton;
    BtnDesfazerAgenda     : TcxButton;
    BtnFechar             : TcxButton;
    CdsProfissional: TClientDataSet;
    cAgendaPremium: TFDTable;
    DBPAgendaPremium: TDBPlanner;
    DBDaySource: TDBDaySource;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnFaltarClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure DBPAgendaPremiumPrintHeader(Sender: TObject; ACanvas: TCanvas; DrawRect: TRect);
//    procedure DBDaySourceInsertItem(Sender: TObject; APlannerItem: TPlannerItem);
    procedure DBDaySourceUpdateItem(Sender: TObject; APlannerItem: TPlannerItem);
    procedure DBDaySourceInsertItem(Sender: TObject; APlannerItem: TPlannerItem);
    procedure CldMesesClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CarregarProfissional;
  end;

var
  FrmAgendaPremium: TFrmAgendaPremium;

implementation

{$R *.dfm}


uses dPrincipal, uConfiguracao, uAgendaPremium, fPrincipal, uPessoa, uFuncao;

{ TFrmAgendaProfissional }

var
  unAgendaPremium  : TAgendaPremium;
  unConfiguracao   : TConfiguracao;
  unPessoa         : TPessoa;

procedure TFrmAgendaPremium.BtnFaltarClick(Sender: TObject);
begin
  try
    Close;
  finally

  end;
end;

procedure TFrmAgendaPremium.BtnIncluirClick(Sender: TObject);
begin
  inherited;

  with DbpAgendaPremium.CreateItemAtSelection do
  begin
    Text.Text:='Item created at runtime on '+Formatdatetime('hh:nn dd/mm/yyyy',Now);
    Update;
  end;
end;

procedure TFrmAgendaPremium.CarregarProfissional;
var
  I : Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarProfissional';
  DtmPrincipal.unLog.NmTabela   := 'AgendaProfissional';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    DbpAgendaPremium.Positions := AtendimentoProfissionalDia(DtmPrincipal.Conexao, CldMeses.Date, 'ProfissionalPremium');
    unPessoa.CarregaDbGridProfissionais(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada, CdsProfissional);

    CdsProfissional.First;

    for I := 1 to DbpAgendaPremium.Positions do
    begin
      DbpAgendaPremium.Header.Captions.Strings[I] := CdsProfissional.FieldByName('NmProfissional').AsString;

      CdsProfissional.Next;
    end;
  finally

  end;
end;

procedure TFrmAgendaPremium.CldMesesClick(Sender: TObject);
begin
  inherited;
  DBDaySource.Day                        := CldMeses.Date;
  CarregarProfissional;
end;

{procedure TFrmAgendaPremium.DBDaySourceInsertItem(Sender: TObject; APlannerItem: TPlannerItem);
begin
  inherited;

  APlannerItem.CaptionText := 'Captulo';
  APlannerItem.Text.Text   := 'Nota';
  ShowMessage(IntToStr(APlannerItem.itemBegin));
  ShowMessage(IntToStr(APlannerItem.itemEnd));
  ShowMessage(IntToStr(APlannerItem.itemPos));

  ShowMessage('KeyField' + APlannerItem.DBKey);
  ShowMessage('StartTime ' + APlannerItem.ItemStartTimeStr);
  ShowMessage('EndTime ' + APlannerItem.ItemEndTimeStr);
  ShowMessage('Subject ' + APlannerItem.CaptionText );
  ShowMessage('Notes ' + APlannerItem.NotesText );
//  ShowMessage('MinTime' + APlannerItem.ItemBegin);
//  ShowMessage('MaxTime ' + APlannerItem.ItemEnd);


      qryAgendaPremium.SQL.Add('  Color,');
      qryAgendaPremium.SQL.Add('  Image,');
      qryAgendaPremium.SQL.Add('  Caption,');
      qryAgendaPremium.SQL.Add('  Recurrency,');
      qryAgendaPremium.SQL.Add('  Resource,');

end;
}

procedure TFrmAgendaPremium.DBDaySourceInsertItem(Sender: TObject; APlannerItem: TPlannerItem);
begin
  inherited;
  unAgendaPremium.KeyField  := APlannerItem.DBKey;
  unAgendaPremium.StartTime := APlannerItem.ItemStartTime;
  unAgendaPremium.EndTime   := APlannerItem.ItemEndTime;
  unAgendaPremium.Notes     := APlannerItem.NotesText;
  unAgendaPremium.Subject   := APlannerItem.CaptionText;
  unAgendaPremium.Resource  := APlannerItem.ItemPos;

  unAgendaPremium.Salvar(DtmPrincipal.Conexao);
end;

procedure TFrmAgendaPremium.DBDaySourceUpdateItem(Sender: TObject; APlannerItem: TPlannerItem);
begin
  inherited;
  unAgendaPremium.KeyField  := APlannerItem.DBKey;
  unAgendaPremium.StartTime := APlannerItem.ItemStartTime;
  unAgendaPremium.EndTime   := APlannerItem.ItemEndTime;
  unAgendaPremium.Notes     := APlannerItem.NotesText;
  unAgendaPremium.Subject   := APlannerItem.CaptionText;
  unAgendaPremium.Resource  := APlannerItem.ItemPos;

  unAgendaPremium.Salvar(DtmPrincipal.Conexao);
end;

procedure TFrmAgendaPremium.DBPAgendaPremiumPrintHeader(Sender: TObject; ACanvas: TCanvas; DrawRect: TRect);
var
  sz: integer;
  txt: string;
  r: TRect;
begin
  r := DrawRect;
  //r.Right := r.Left + Image1.Width * 3;
  //ACanvas.StretchDraw(r,Image1.Picture.Graphic);
  txt := 'TMS Planner';
  sz := ACanvas.TextWidth(txt);
  ACanvas.Brush.Style := bsClear;
  ACanvas.TextOut(DrawRect.Right - sz, DrawRect.Top, txt);
end;

procedure TFrmAgendaPremium.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaProfissional';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  begin
    try
      Action := caFree;
    finally

    end;
  end;
  FrmPrincipal.TasAgendaPremium.TabVisible := False;
  FrmPrincipal.PgcVisivel;
end;

procedure TFrmAgendaPremium.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaPremium';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'AgendaPremium';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);
  inherited;

  unConfiguracao        := TConfiguracao.Create;
  unAgendaPremium       := TAgendaPremium.Create;

  cAgendaPremium.Active := True;
end;

procedure TFrmAgendaPremium.FormShow(Sender: TObject);
begin
  inherited;
  CldMeses.Date                          := Now;
  InicializarTela;
end;

procedure TFrmAgendaPremium.InicializarTela;
var
  I         : Integer;
  FatoFinal : Extended;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaProfissional';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'AgendaProfissional';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  //AGENDA - TEMPO DE INTERVALO ENTRE ATENDIMENTOS - 00:30
  unConfiguracao.BuscarSigla(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada, 'TIEA');

  FatoFinal := 60 / (StrToInt(Copy(unConfiguracao.NmValor, 4, 2)));

  DbpAgendaPremium.Display.DisplayUnit   := StrToInt(Copy(unConfiguracao.NmValor, 4, 2));
  DbpAgendaPremium.Display.DisplayStart  := 0;
  DbpAgendaPremium.Display.DisplayEnd    := DbpAgendaPremium.Display.DisplayEnd -  Trunc(FatoFinal);

  DBDaySource.Day                        := CldMeses.Date;
  try
    CarregarProfissional;
  finally

  end;
end;

end.