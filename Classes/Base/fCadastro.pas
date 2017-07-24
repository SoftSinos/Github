unit fCadastro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ImgList, Data.DBXMsSQL, Data.FMTBcd, Vcl.ComCtrls, Datasnap.DBClient, Data.DB, Datasnap.Provider, Data.SqlExpr, Vcl.Mask, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxMemo, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Menus, cxButtons,
  cxCheckBox;

type
  TFrmCadastro = class(TForm)
    PnlPrincipal    : TPanel;
    PnlCampos       : TPanel;
    CdsCopula       : TClientDataSet;
    CdsRetorno      : TClientDataSet;
    StbPrincipal    : TStatusBar;
    BtnIncluir      : TcxButton;
    BtnSalvar       : TcxButton;
    BtnAnterior     : TcxButton;
    BtnProximo      : TcxButton;
    BtnCancelar     : TcxButton;
    BtnFechar       : TcxButton;
    BtnAjuda        : TcxButton;
    GrbIdentificador: TGroupBox;
    Label1          : TLabel;
    Label9          : TLabel;
    Label12         : TLabel;
    DtpDtCadastro   : TcxDateEdit;
    EdtNmUsuario    : TcxTextEdit;
    EdtIdRegistro   : TcxTextEdit;
    ChkSnSituacao   : TcxCheckBox;
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure ChkSnSituacaoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InicializarTela;
  end;

var
  FrmCadastro: TFrmCadastro;

implementation

{$R *.dfm}

uses uMensagem, uFuncao;

procedure TFrmCadastro.BtnCancelarClick(Sender: TObject);
var
  I: Integer;
begin
  try
    BtnIncluir.Enabled    := True;
    BtnSalvar.Enabled     := False;
    BtnCancelar.Enabled   := False;
    BtnFechar.Enabled     := True;
    BtnAnterior.Enabled   := False;
    BtnProximo.Enabled    := False;
    ChkSnSituacao.Checked := True;
  finally

  end;
end;

procedure TFrmCadastro.BtnFecharClick(Sender: TObject);
begin
  try
    Close;
  finally

  end;
end;

procedure TFrmCadastro.BtnIncluirClick(Sender: TObject);
begin
  try
    BtnIncluir.Enabled    := False;
    BtnSalvar.Enabled     := True;
    BtnCancelar.Enabled   := True;
    BtnFechar.Enabled     := True;
    BtnAnterior.Enabled   := False;
    BtnProximo.Enabled    := False;
    ChkSnSituacao.Checked := True;
    DtpDtCadastro.Date    := Now;
    EdtIdRegistro.Clear;
  finally

  end;
end;

procedure TFrmCadastro.BtnProximoClick(Sender: TObject);
begin
  try
    // Heran�a
  finally

  end;
end;

procedure TFrmCadastro.BtnSalvarClick(Sender: TObject);
begin
  try
    BtnIncluir.Enabled  := True;
    BtnSalvar.Enabled   := False;
    BtnCancelar.Enabled := False;
    BtnFechar.Enabled   := True;
    BtnAnterior.Enabled := True;
    BtnProximo.Enabled  := True;
  finally

  end;
end;

procedure TFrmCadastro.ChkSnSituacaoClick(Sender: TObject);
begin
  try
    if ChkSnSituacao.Checked then
    begin
      ChkSnSituacao.Caption := 'Cadastro Ativo';
    end
    else
    begin
      ChkSnSituacao.Caption := 'Cadastro Inativo';
    end;
  finally

  end;
end;

procedure TFrmCadastro.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    Action := caFree;
  finally

  end;
end;

procedure TFrmCadastro.FormCreate(Sender: TObject);
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
     InicializarTela;
  end;
end;

procedure TFrmCadastro.FormShow(Sender: TObject);
begin
  try
    // Heran�a
  finally

  end;
end;

procedure TFrmCadastro.InicializarTela;
begin
  try
    EdtIdRegistro.Clear;
    DtpDtCadastro.Date := Now;
    if ChkSnSituacao.Checked then
    begin
      ChkSnSituacao.Caption := 'Cadastro Ativo';
    end
    else
    begin
      ChkSnSituacao.Caption := 'Cadastro Inativo';
    end;

  finally

  end;
end;

procedure TFrmCadastro.BtnAjudaClick(Sender: TObject);
begin
  try
    // Heran�a
  finally

  end;
end;

procedure TFrmCadastro.BtnAlterarClick(Sender: TObject);
begin
  try
    BtnIncluir.Enabled  := False;
    BtnSalvar.Enabled   := True;
    BtnCancelar.Enabled := True;
    BtnFechar.Enabled   := True;
  finally

  end;
end;

procedure TFrmCadastro.BtnAnteriorClick(Sender: TObject);
begin
  try
    // Heran�a
  finally

  end;
end;

end.
