unit fAgendaStarter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  dxSkinsCore, dxSkinsDefaultPainters, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, cxSpinEdit,
  cxTimeEdit, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, cxButtons, cxCheckBox;

type
  TFrmAgendaStarter = class(TFrmCadastro)
    Label2: TLabel;
    CbbIdEmpresa: TComboBox;
    Panel1: TPanel;
    DbgPesquisa: TDBGrid;
    PrbPesquisa: TProgressBar;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    LbtTotalRegistros: TLabel;
    LbtInicial: TLabel;
    DtpDtCadastroInicial: TcxDateEdit;
    Label11: TLabel;
    EdtNrCelular1: TEdit;
    EdtNmPessoa: TEdit;
    Label4: TLabel;
    DtpHrATratar: TcxTimeEdit;
    Label5: TLabel;
    cxDateEdit1: TcxDateEdit;
    Label6: TLabel;
    cxDateEdit2: TcxDateEdit;
    Label7: TLabel;
    ComboBox1: TComboBox;
    BtnImprimir: TcxButton;
    BtnCepPesquisa: TcxButton;
    cxButton1: TcxButton;
    cxButton2: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAgendaStarter: TFrmAgendaStarter;

implementation

{$R *.dfm}

uses dPrincipal, fPrincipal;
//, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uPessoa, uCep, fAjuda, fWebCam, fTipoPessoaPesquisa, fCepPesquisa, fEmpresaPesquisa;

var
  lTpChamadaClasse : Boolean;
procedure TFrmAgendaStarter.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  FrmPrincipal.TasAgenda.TabVisible := False;
  FrmPrincipal.PgcVisivel;
end;

procedure TFrmAgendaStarter.FormShow(Sender: TObject);
begin
  inherited;

  if not DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.Enabled    := False;
    CbbIdEmpresa.ItemIndex  := Integer(CbbIdEmpresa.Items.IndexOf(DtmPrincipal.NmFantasiaNmRazaoSocial));
  end
  else
  begin
    CbbIdEmpresa.Enabled := true;
  end;
end;

end.
