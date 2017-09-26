unit fFechamentoCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fOperacao, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  cxDropDownEdit, cxCalendar, cxTextEdit, cxMaskEdit, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFrmFechamentoCaixa = class(TFrmOperacao)
    GroupBox1: TGroupBox;
    Label2: TLabel;
    CbbIdEmpresa: TcxComboBox;
    BtnEmpresaPesquisa: TcxButton;
    Label9: TLabel;
    DtpDtPeriodoInicio: TcxDateEdit;
    GroupBox2: TGroupBox;
    DbgPagamento: TDBGrid;
    LblSnFinalizada: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFechamentoCaixa: TFrmFechamentoCaixa;

implementation

{$R *.dfm}

end.
