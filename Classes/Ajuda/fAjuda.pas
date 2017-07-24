unit fAjuda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, Data.DB, Datasnap.DBClient,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, cxTextEdit, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Menus, cxButtons;

type
  TFrmAjuda = class(TFrmPesquisa)
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar(AConsulta: String; ANmTela: String);
  public
    { Public declarations }
    gNmTelaChamada : String;
  end;

var
  FrmAjuda: TFrmAjuda;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uMensagem, uAjuda, dRelatorios, uEmpresa;

var
  unAjuda       : TAjuda;
  unEmpresa     : TEmpresa;
  dnRelatorios  : TDtmRelatorios;

procedure TFrmAjuda.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAjuda';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Ajuda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Close;
end;

procedure TFrmAjuda.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAjuda';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'Ajuda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if CdsPesquisa.FieldCount > 0 then
  begin
    CdsPesquisa.EmptyDataSet;
  end;
  LbtTotalRegistros.Caption := '0';
  EdtPesquisa.Clear;
  PrbPesquisa.Position      := 0;
end;

procedure TFrmAjuda.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAjuda';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Ajuda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text, gNmTelaChamada);

  inherited;
end;

procedure TFrmAjuda.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmAjuda';
    DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Ajuda';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    BtnPesquisarClick(Sender);
  end;

  inherited;
end;

procedure TFrmAjuda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAjuda';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Ajuda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmAjuda.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAtivacaoSistema';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Ajuda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unAjuda       := TAjuda.Create;
end;

procedure TFrmAjuda.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAjuda';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Ajuda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Pesquisar('', gNmTelaChamada);
end;

procedure TFrmAjuda.Pesquisar(AConsulta, ANmTela: String);
var
  I: Integer;
  lConsulta: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAjuda';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Ajuda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  PrbPesquisa.Position := 0;
  lConsulta := 0;
  try
    for I := 1 to 100 do
    begin
      Sleep(15);
      PrbPesquisa.Position := PrbPesquisa.Position + 1;
      if lConsulta = 0 then
      begin
        lConsulta := 1;
        unAjuda := TAjuda.Create;
        unAjuda.CarregaDbGrid(DtmPrincipal.Conexao, 0, EdtPesquisa.Text, ANmTela, CdsPesquisa);
      end;
    end;
  finally
    unAjuda.Free;
  end;
  inherited;
end;

end.
