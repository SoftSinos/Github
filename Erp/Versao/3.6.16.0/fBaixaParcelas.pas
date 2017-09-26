unit fBaixaParcelas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Data.DB, Datasnap.DBClient, cxCheckBox, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TFrmBaixaParcelas = class(TFrmCadastro)
    GroupBox1: TGroupBox;
    Label6: TLabel;
    cxComboBox2: TcxComboBox;
    cxButton2: TcxButton;
    GroupBox3: TGroupBox;
    DbgPagamento: TDBGrid;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    CbbIdEmpresa: TcxComboBox;
    BtnEmpresaPesquisa: TcxButton;
    cxComboBox1: TcxComboBox;
    cxButton1: TcxButton;
    cxTextEdit1: TcxTextEdit;
    DtpDtPeriodoInicio: TcxDateEdit;
    cxComboBox3: TcxComboBox;
    cxButton3: TcxButton;
    Label4: TLabel;
    cxComboBox4: TcxComboBox;
    cxButton4: TcxButton;
    cxComboBox5: TcxComboBox;
    cxButton5: TcxButton;
    Label7: TLabel;
    Label8: TLabel;
    cxDateEdit1: TcxDateEdit;
    Panel1: TPanel;
    BtnPesquisar: TcxButton;
    Label10: TLabel;
    EdtVlPgtoCheque: TcxTextEdit;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBaixaParcelas: TFrmBaixaParcelas;

implementation

{$R *.dfm}

end.
