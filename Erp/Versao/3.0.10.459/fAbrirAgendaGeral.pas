unit fAbrirAgendaGeral;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fOperacao, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit,
  Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxButtons, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFrmAbrirAgendaGeral = class(TFrmOperacao)
    GroupBox1: TGroupBox;
    Label26: TLabel;
    CbbNrAno: TcxComboBox;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnGerarClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CarregarTela(ATpChamadaClasse:String);
  end;

var
  FrmAbrirAgendaGeral: TFrmAbrirAgendaGeral;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, fAjuda;

{ TFrmAbrirAgendaGeral }

var
  unCarregaDados : TCarregaDados;

procedure TFrmAbrirAgendaGeral.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAbrirAgendaGeral';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmAjuda := TFrmAjuda.Create(Application);
    FrmAjuda.Caption        := 'Ajuda Sobre � Tela de ' +  Caption;
    FrmAjuda.gNmTelaChamada := Name;
    FrmAjuda.ShowModal;
  finally
    FrmAjuda.Free;
  end;
end;

procedure TFrmAbrirAgendaGeral.BtnGerarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAbrirAgendaGeral';
  DtmPrincipal.unLog.NmMetodo   := 'BtnGerarClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    if (Integer(CbbNrAno.Properties.Items.Objects[CbbNrAno.ItemIndex]) > 0) then
    begin
        if ((Integer(CbbNrAno.Properties.Items.Objects[CbbNrAno.ItemIndex]) > 0) and (CbbNrAno.Text = FormatDateTime('YYYY', Now))) then
        begin
          try
            uProcedure.Agendar(DtmPrincipal.IdEmpresaLogada, DtmPrincipal.IdEmpresaLogada, 0, '', 0, 'GeralAnoAtual');
          finally
            MsgInformacao(uMensagem.AgendaGeradaComSucesso);
          end;
        end
        else
        if True then
        begin
          try
            uProcedure.Agendar(DtmPrincipal.IdEmpresaLogada, DtmPrincipal.IdEmpresaLogada, 0, CbbNrAno.Text, 0, 'GeralProximoAAno');
          finally
            MsgInformacao(uMensagem.AgendaGeradaComSucesso);
          end;
        end;
    end
    else
    begin
      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
    end;
  finally

  end;
end;

procedure TFrmAbrirAgendaGeral.CarregarTela(ATpChamadaClasse: String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAbrirAgendaGeral';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  if ATpChamadaClasse = 'Geral' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Calendario', 0, 'Ano', 'MaiorIgual', '2017', CbbNrAno);
  end;
end;

procedure TFrmAbrirAgendaGeral.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAbrirAgendaGeral';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmAbrirAgendaGeral.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAbrirAgendaGeral';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;
end;

procedure TFrmAbrirAgendaGeral.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAbrirAgendaGeral';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmAbrirAgendaGeral.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAbrirAgendaGeral';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  CarregarTela('Geral');
end;

end.
