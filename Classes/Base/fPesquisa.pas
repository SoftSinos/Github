unit fPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore,
  cxTextEdit, Vcl.Menus, cxButtons, cxDropDownEdit, cxMemo;

type
  TFrmPesquisa = class(TForm)
    Panel1            : TPanel;
    GroupBox1         : TGroupBox;
    DbgPesquisa       : TDBGrid;
    Panel2            : TPanel;
    GroupBox2         : TGroupBox;
    Label1            : TLabel;
    LbtTotalRegistros : TLabel;
    PnlPrincipal      : TPanel;
    CdsPesquisa       : TClientDataSet;
    DtsPesquisa       : TDataSource;
    PrbPesquisa       : TProgressBar;
    StbPrincipal      : TStatusBar;
    Label2            : TLabel;
    EdtPesquisa       : TcxTextEdit;
    BtnIncluir        : TcxButton;
    BtnAlterar        : TcxButton;
    BtnPesquisar      : TcxButton;
    BtnImprimir       : TcxButton;
    BtnLimpar         : TcxButton;
    BtnFechar         : TcxButton;
    BtnAjuda          : TcxButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DbgPesquisaDblClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
  end;

var
  FrmPesquisa: TFrmPesquisa;

implementation

{$R *.dfm}

procedure TFrmPesquisa.BtnAjudaClick(Sender: TObject);
begin
  //Heran�a
end;

procedure TFrmPesquisa.BtnAlterarClick(Sender: TObject);
begin
  // Heran�a
end;

procedure TFrmPesquisa.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TFrmPesquisa.BtnImprimirClick(Sender: TObject);
begin
  // Heran�a
end;

procedure TFrmPesquisa.BtnIncluirClick(Sender: TObject);
begin
  // Heran�a
end;

procedure TFrmPesquisa.BtnLimparClick(Sender: TObject);
begin
  if CdsPesquisa.FieldCount > 0 then
  begin
    CdsPesquisa.EmptyDataSet;
    BtnImprimir.Enabled     := False;
  end;
  LbtTotalRegistros.Caption := '0';
  EdtPesquisa.Clear;
  PrbPesquisa.Position      := 0;
end;

procedure TFrmPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  if CdsPesquisa.FieldCount > 0 then
  begin
    LbtTotalRegistros.Caption := IntToStr(CdsPesquisa.RecordCount);
    BtnImprimir.Enabled := True;
  end;
  Application.ProcessMessages;
end;

procedure TFrmPesquisa.DbgPesquisaDblClick(Sender: TObject);
begin
  // Heran�a
end;

procedure TFrmPesquisa.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    LbtTotalRegistros.Caption := IntToStr(CdsPesquisa.RecordCount);
    Application.ProcessMessages;
  end;
end;

procedure TFrmPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmPesquisa.FormCreate(Sender: TObject);
var
  I      : Integer;
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

procedure TFrmPesquisa.FormShow(Sender: TObject);
begin
  EdtPesquisa.SetFocus;
  InicializarTela;
end;

procedure TFrmPesquisa.InicializarTela;
begin
  LbtTotalRegistros.Caption := '0';
end;

end.
