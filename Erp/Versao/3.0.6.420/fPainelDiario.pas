unit fPainelDiario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fOperacao, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFrmPainelDiario = class(TFrmOperacao)
    StgGrid: TStringGrid;
    BtnAtualizar: TcxButton;
    procedure StgGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPainelDiario: TFrmPainelDiario;

implementation

{$R *.dfm}

uses uFuncao, dPrincipal, fPrincipal;

procedure TFrmPainelDiario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmPrincipal.TasPainel.TabVisible := False;
  FrmPrincipal.PgcVisivel;
end;

procedure TFrmPainelDiario.StgGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
{  if gdSelected in State then
   if  (acol = 2) and (arow = 2) then
     with (Sender as TstringGrid).Canvas do
        begin
           Brush.Color:=clRed;
           FillRect(Rect);
        end;
}


if (ACol = 1) and (ARow = 2) then
begin
StgGrid.Canvas.Brush.Color := 0;
StgGrid.Canvas.FillRect(Rect);
StgGrid.Canvas.TextOut(Rect.Left+2, Rect.Top+2, StgGrid.Cells[1,2]);
end;
end;


end.
