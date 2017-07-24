unit fContraSenha;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fOperacao, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxLabel, dxGDIPlusClasses, Vcl.ExtCtrls, Vcl.StdCtrls, cxButtons, Vcl.ComCtrls;

type
  TFrmContraSenha = class(TFrmOperacao)
    Image1        : TImage;
    cxLabel4      : TcxLabel;
    cxLabel1      : TcxLabel;
    EdtNrAtivacao : TcxTextEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnInicializarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmContraSenha: TFrmContraSenha;

implementation

{$R *.dfm}
uses dPrincipal, uFuncao, uMensagem, fProcessando, uProcedure, uConfiguracao, fAjuda;

var
  unConfiguracao : TConfiguracao;

procedure TFrmContraSenha.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmContraSenha';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    FrmAjuda := TFrmAjuda.Create(Application);
    FrmAjuda.Caption        := 'Ajuda Sobre � Tela de ' +  Caption;
    FrmAjuda.gNmTelaChamada := Name;
    FrmAjuda.ShowModal;
  finally
    FrmAjuda.Free;
  end;
end;

procedure TFrmContraSenha.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmContraSenha';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if MsgConfirmacao(uMensagem.DesejaFinalizarOSistema) then
  begin
    FinalizarAplicacao(DtmPrincipal.NmExecutavel);
  end;
end;

procedure TFrmContraSenha.BtnInicializarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmContraSenha';
  DtmPrincipal.unLog.NmMetodo   := 'BtnInicializarClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if MsgConfirmacao(uMensagem.DesejaRodarProcedureDeInicializacao) then
  begin
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;
    try
      uProcedure.Inicializacao(DtmPrincipal.IdEmpresaLogada);
    finally
      FrmProcessando.Destroy;
      BtnInicializar.Enabled := False;
      BtnSalvar.Enabled      := True;
    end;
  end;
end;

procedure TFrmContraSenha.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmContraSenha';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  //TEMPO DE DURACAO CONTRA SENHA "SAFERY OPEN"
  unConfiguracao.BuscarSigla(DtmPrincipal.Conexao, 'TDCS');
  if unConfiguracao.IdConfiguracao = 0 then
  begin
    unConfiguracao.IdEmpresa      := DtmPrincipal.IdEmpresaLogada;
    unConfiguracao.IdUsuario      := 0;
    unConfiguracao.DtCadastro     := Now;
    unConfiguracao.SnSituacao     := 1;
    unConfiguracao.NmSigla        := 'TDCS';
    unConfiguracao.NmConfiguracao := 'TEMPO DE DURACAO CONTRA SENHA "SAFERY OPEN"';
    unConfiguracao.NmValor        := '';
    unConfiguracao.Salvar(DtmPrincipal.Conexao);
  end;

  try
    if ((Copy(EdtNrAtivacao.Text, 1, 5)) = '29305') And (Length(EdtNrAtivacao.Text) = 15) then
    begin
      //TEMPO DE DURACAO CONTRA SENHA "SAFERY OPEN"
      if unConfiguracao.Buscar(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada, 'TDCS') then
      begin
        unConfiguracao.NmValor := EdtNrAtivacao.Text;
        if unConfiguracao.Salvar(DtmPrincipal.Conexao) then
        begin
          MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);
          MsgAtencao(uMensagem.OSistemaSeraFinalizado);
          FinalizarAplicacao(DtmPrincipal.NmExecutavel);
        end;
      end
      else begin
        MsgErro(uMensagem.ParametroNaoConfigurado + ' "TDCS"');
        MsgAtencao(uMensagem.OSistemaSeraFinalizado);
        FinalizarAplicacao(DtmPrincipal.NmExecutavel);
      end;
    end
    else begin
      MsgAtencao(uMensagem.ASenhaNaoConfere);
    end;
  finally
    unConfiguracao.Free;
  end;
end;

procedure TFrmContraSenha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmContraSenha';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmContraSenha.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmContraSenha';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unConfiguracao := TConfiguracao.Create;

  inherited;
end;

procedure TFrmContraSenha.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmContraSenha';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  EdtNrAtivacao.SetFocus;

  //TEMPO DE DURACAO CONTRA SENHA "SAFERY OPEN"
  unConfiguracao.BuscarSigla(DtmPrincipal.Conexao, 'TDCS');
  if unConfiguracao.IdConfiguracao = 0 then
  begin
    BtnInicializar.Enabled := True;
    BtnSalvar.Enabled      := False;
  end
  else
  begin
    BtnSalvar.Enabled      := True;
  end;
end;

end.
