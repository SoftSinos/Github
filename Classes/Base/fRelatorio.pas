unit fRelatorio;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fOperacao, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, Vcl.StdCtrls, Vcl.ComCtrls, cxButtons, Vcl.ExtCtrls, dxCore,
  cxDateUtils, cxCalendar;

type
  TFrmRelatorio = class(TFrmOperacao)
    PrbPesquisa     : TProgressBar;
    GroupBox1       : TGroupBox;
    Label3          : TLabel;
    CbbIdRelatorio: TcxComboBox;
    Label2          : TLabel;
    CbbIdEmpresa    : TcxComboBox;
    Label13         : TLabel;
    DtpDtInicio: TcxDateEdit;
    DtpDtFinal: TcxDateEdit;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InicializarTela;
  end;

var
  FrmRelatorio: TFrmRelatorio;

implementation

{$R *.dfm}

uses dPrincipal, uEmpresa;

procedure TFrmRelatorio.FormCreate(Sender: TObject);
begin
  inherited;
  //Heran�a
end;

procedure TFrmRelatorio.FormShow(Sender: TObject);
begin
  inherited;

  InicializarTela;
end;

procedure TFrmRelatorio.InicializarTela;
begin
  inherited;
  CbbIdRelatorio.SetFocus;

  DtpDtInicio.Date              := Now;
  DtpDtFinal.Date               := Now;
end;

end.
