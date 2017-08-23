unit fNotaEntradaEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Data.DB, Datasnap.DBClient, cxCheckBox, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFrmNotaEntrada = class(TFrmCadastro)
    GroupBox2: TGroupBox;
    Label11: TLabel;
    Label13: TLabel;
    CbbIdEmpresa: TcxComboBox;
    BtnEmpresaPesquisa: TcxButton;
    cxComboBox1: TcxComboBox;
    cxButton1: TcxButton;
    PgcExtra: TPageControl;
    TabProduto: TTabSheet;
    GrbProduto: TGroupBox;
    GroupBox6: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    BtnProdutoPesquisar: TcxButton;
    EdtNrEan: TcxTextEdit;
    EdtNmProduto: TcxTextEdit;
    Panel2: TPanel;
    BtnAdiProduto: TcxButton;
    BtnCanProduto: TcxButton;
    EdtQtdNotaItemProduto: TcxTextEdit;
    EdtVlProduto: TcxTextEdit;
    DbgProduto: TDBGrid;
    Label2: TLabel;
    Label3: TLabel;
    cxTextEdit1: TcxTextEdit;
    Label5: TLabel;
    DtpDtPeriodoInicio: TcxDateEdit;
    Panel1: TPanel;
    Label24: TLabel;
    MkeVlProdutos: TcxTextEdit;
    Label4: TLabel;
    cxTextEdit2: TcxTextEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNotaEntrada: TFrmNotaEntrada;

implementation

{$R *.dfm}

end.
