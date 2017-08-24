unit fDespesas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Data.DB, Datasnap.DBClient, cxCheckBox, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, cxMemo;

type
  TFrmDespesas = class(TFrmCadastro)
    GroupBox2: TGroupBox;
    Label11: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    CbbIdEmpresa: TcxComboBox;
    BtnEmpresaPesquisa: TcxButton;
    cxComboBox1: TcxComboBox;
    cxButton1: TcxButton;
    cxTextEdit1: TcxTextEdit;
    DtpDtPeriodoInicio: TcxDateEdit;
    GroupBox1: TGroupBox;
    MemObservacao: TcxMemo;
    Label2: TLabel;
    cxComboBox2: TcxComboBox;
    cxButton2: TcxButton;
    PgcExtra2: TPageControl;
    TabParcelas: TTabSheet;
    Panel3: TPanel;
    Label4: TLabel;
    Panel4: TPanel;
    BtnAdiTipoPagamento: TcxButton;
    BtnCanTipoPagamento: TcxButton;
    cxComboBox3: TcxComboBox;
    cxButton3: TcxButton;
    DbgPagamento: TDBGrid;
    cxTextEdit2: TcxTextEdit;
    Label6: TLabel;
    Label7: TLabel;
    EdtVlPgtoCheque: TcxTextEdit;
    Label8: TLabel;
    cxTextEdit3: TcxTextEdit;
    Label10: TLabel;
    EdtVlRestante: TcxTextEdit;
    Label14: TLabel;
    EdtVlTroco: TcxTextEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDespesas: TFrmDespesas;

implementation

{$R *.dfm}

end.
