unit fOperacaoFinanceira;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fOperacao, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, cxTextEdit, Vcl.StdCtrls,
  cxButtons, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFrmOperacaoFinanceira = class(TFrmOperacao)
    GroupBox1: TGroupBox;
    Label3: TLabel;
    EdtVlGeral: TcxTextEdit;
    GrbOperacao: TGroupBox;
    LblValor: TLabel;
    cxTextEdit1: TcxTextEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOperacaoFinanceira: TFrmOperacaoFinanceira;

implementation

{$R *.dfm}

end.