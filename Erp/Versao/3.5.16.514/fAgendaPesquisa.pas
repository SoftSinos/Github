unit fAgendaPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.Menus, Data.DB, Datasnap.DBClient,
  Vcl.ComCtrls, Vcl.StdCtrls, cxButtons, Vcl.Grids, Vcl.DBGrids, cxTextEdit, Vcl.ExtCtrls, dxCore, cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TFrmAgendaPesquisa = class(TFrmPesquisa)
    Label13: TLabel;
    DtpDtBase: TcxDateEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure Pesquisar(AConsulta: String);
  public
    { Public declarations }
  end;

var
  FrmAgendaPesquisa: TFrmAgendaPesquisa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uMensagem, uAgenda, dRelatorios, uEmpresa, fAjuda;

var
  unAgenda     : TAgenda;
  unEmpresa    : TEmpresa;
  dnRelatorios : TDtmRelatorios;


procedure TFrmAgendaPesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmAjuda := TFrmAjuda.Create(Application);
    FrmAjuda.Caption        := 'Ajuda Sobre à Tela de ' +  Caption;
    FrmAjuda.gNmTelaChamada := Name;
    FrmAjuda.ShowModal;
  finally
    FrmAjuda.Free;
  end;
end;

procedure TFrmAgendaPesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmAgendaPesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    dnRelatorios := TDtmRelatorios.Create(Self);
    unEmpresa    := TEmpresa.Create;
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelEmpresa);


    unAgenda.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, DtmPrincipal.IdEmpresaLogada, 0, StrToDate(FormatDateTime('DD/MM/YYYY', DtpDtBase.Date)), 'AgendaPesquisa', EdtPesquisa.Text, dnRelatorios.CDSRelPesquisa);

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\RelPesqImpAgenda.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmAgendaPesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmAgendaPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text);

  inherited;
end;

procedure TFrmAgendaPesquisa.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaPesquisa';
    DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Agenda';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    BtnPesquisarClick(Sender);
  end;

  inherited;
end;

procedure TFrmAgendaPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmAgendaPesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmAgendaPesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  DtpDtBase.SetFocus;
  DtpDtBase.Date := Now;
end;

procedure TFrmAgendaPesquisa.Pesquisar(AConsulta: String);
var
  I           : Integer;
  lConsulta   : Integer;
  lSnSituacao : Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  PrbPesquisa.Position := 0;
  lConsulta := 0;
  lSnSituacao := -1;
  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    for I := 1 to 100 do
    begin
      Sleep(15);
      PrbPesquisa.Position := PrbPesquisa.Position + 1;
      if lConsulta = 0 then
      begin
        lConsulta       := 1;
        unAgenda  := TAgenda.Create;

        if RdbSnAtivo.Checked then
        begin
          lSnSituacao := 1;
        end
        else
        if RdbSnInativo.Checked then
        begin
          lSnSituacao := 0;
        end
        else
        if RdbSnTodos.Checked then
        begin
          lSnSituacao := 2;
        end;

        unAgenda.CarregaDbGrid(DtmPrincipal.Conexao, lSnSituacao, 0, 0, 0, StrToDate(FormatDateTime('DD/MM/YYYY', DtpDtBase.Date)), 'AgendaPesquisa', EdtPesquisa.Text, CdsPesquisa);

      end;
    end;
  finally
    unAgenda.Free;
    FrmProcessando.Destroy;
  end;

  inherited;
end;

end.
