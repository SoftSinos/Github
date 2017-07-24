unit fOperacao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ImgList, Data.DBXMsSQL, Data.FMTBcd, Vcl.ComCtrls, Datasnap.DBClient, Data.DB, Datasnap.Provider, Data.SqlExpr, Vcl.Mask, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxMemo, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Menus, cxButtons,
  cxCheckBox;

type
  TFrmOperacao = class(TForm)
    StbPrincipal  : TStatusBar;
    PnlPrincipal  : TPanel;
    BtnFechar     : TcxButton;
    BtnAjuda      : TcxButton;
    PnlCampos     : TPanel;
    BtnInicializar: TcxButton;
    BtnSalvar     : TcxButton;
    BtnExecutar   : TcxButton;
    BtnLimpar     : TcxButton;
    BtnCarregar   : TcxButton;
    BtnAgenda     : TcxButton;
    BtnPeriodo    : TcxButton;
    BtnAtualizar  : TcxButton;
    BtnGerar      : TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOperacao: TFrmOperacao;

implementation

{$R *.dfm}

procedure TFrmOperacao.BtnFecharClick(Sender: TObject);
begin

  try
    Close;
  finally

  end;
end;

procedure TFrmOperacao.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  try
    Action := caFree;
  finally

  end;
end;

procedure TFrmOperacao.FormCreate(Sender: TObject);
var
  I : Integer;
begin

  try
    for I := 0 to ComponentCount - 1 do
    begin
      if Components[I] is TcxTextEdit then
      begin
        (Components[I] as TcxTextEdit).Properties.CharCase := ecUpperCase;
      end;
    end;

    for I := 0 to ComponentCount - 1 do
    begin
      if Components[I] is TcxMemo then
      begin
        (Components[I] as TcxMemo).Properties.CharCase := ecUpperCase;
      end;
    end;

    for I := 0 to ComponentCount - 1 do
    begin
      if Components[I] is TcxComboBox then
      begin
        (Components[I] as TcxComboBox).Properties.DropDownListStyle := lsFixedList;
      end;
    end;

  finally

  end;
end;

procedure TFrmOperacao.FormShow(Sender: TObject);
begin

  try
    //Heran�a
  finally

  end;
end;

end.
