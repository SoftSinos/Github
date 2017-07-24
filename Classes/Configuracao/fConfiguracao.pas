unit fConfiguracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, Data.DB, Datasnap.DBClient, Vcl.Menus, cxButtons, cxCheckBox;

type
  TFrmConfiguracao = class(TFrmCadastro)
    Label2            : TLabel;
    Label7            : TLabel;
    Label14           : TLabel;
    Label4            : TLabel;
    EdtNmValor        : TcxTextEdit;
    EdtNmSigla        : TcxTextEdit;
    EdtNmConfiguracao : TcxTextEdit;
    CbbIdEmpresa      : TcxComboBox;
    BtnEmpresaPesquisa: TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnEmpresaPesquisaClick(Sender: TObject);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CarregarTela(ATpChamadaClasse:String);
    procedure CopulaTela;
    procedure Edicao;
  end;

var
  FrmConfiguracao: TFrmConfiguracao;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uMensagem, uProcedure, uConfiguracao, uCarregaDados, fAjuda, fEmpresaPesquisa;

var
  unConfiguracao   : TConfiguracao;
  unCarregaDados   : TCarregaDados;
  lTpChamadaClasse : Boolean;

  { TFrmConfiguracao }

procedure TFrmConfiguracao.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if not lTpChamadaClasse then
  begin
    BtnIncluir.Enabled   := False;
    BtnSalvar.Enabled    := True;
    BtnCancelar.Enabled  := True;
    BtnFechar.Enabled    := True;
    BtnAnterior.Enabled  := False;
    BtnProximo.Enabled   := False;
  end;
end;


procedure TFrmConfiguracao.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmConfiguracao.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
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

procedure TFrmConfiguracao.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Configuracao', 'Anterior', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmConfiguracao.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmConfiguracao.BtnEmpresaPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'BtnEmpresaPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmEmpresaPesquisa := TFrmEmpresaPesquisa.Create(Application);
    FrmEmpresaPesquisa.ShowModal;
  finally
    FrmEmpresaPesquisa.Free;
    CbbIdEmpresa.Properties.Items.Clear;
    CarregarTela('Geral');
  end;
end;

procedure TFrmConfiguracao.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unConfiguracao.Free;
end;

procedure TFrmConfiguracao.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmConfiguracao.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Configuracao', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmConfiguracao.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    if ((Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]) > 0) and (Trim(EdtNmConfiguracao.Text) <> '') and (Trim(EdtNmSigla.Text) <> '') and (Trim(EdtNmValor.Text) <> '') and
      (Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]) > 0)) then
    begin
      unConfiguracao.IdEmpresa        := Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]);
      unConfiguracao.IdUsuario        := DtmPrincipal.IdUsuarioLogado;
      unConfiguracao.DtCadastro       := Now;
      if ChkSnSituacao.Checked then
      begin
        unConfiguracao.SnSituacao     := 1;
      end
      else
      begin
        unConfiguracao.SnSituacao     := 0;
      end;
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unConfiguracao.IdConfiguracao := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unConfiguracao.IdConfiguracao := 0;
      end;
      unConfiguracao.NmConfiguracao   := EdtNmConfiguracao.Text;
      unConfiguracao.NmSigla          := EdtNmSigla.Text;
      unConfiguracao.NmValor          := EdtNmValor.Text;
      if unConfiguracao.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unConfiguracao.BuscarConfiguracao(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text));

        end
        else
        begin
          unConfiguracao.BuscarConfiguracao(DtmPrincipal.Conexao, unConfiguracao.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text      := IntToStr(unConfiguracao.IdConfiguracao);

        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        CbbIdEmpresa.Style.Color      := clWindow;
        EdtNmConfiguracao.Style.Color := clWindow;
        EdtNmSigla.Style.Color        := clWindow;
        EdtNmValor.Style.Color        := clWindow;

      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      CbbIdEmpresa.Style.Color      := clHighlight;
      EdtNmConfiguracao.Style.Color := clHighlight;
      EdtNmSigla.Style.Color        := clHighlight;
      EdtNmValor.Style.Color        := clHighlight;

      BtnIncluir.Enabled      := False;
      BtnSalvar.Enabled       := True;
      BtnCancelar.Enabled     := True;
      BtnFechar.Enabled       := True;

      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);

      Abort;
    end;
  finally

  end;
end;

procedure TFrmConfiguracao.CarregarTela(ATpChamadaClasse:String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  if ATpChamadaClasse = 'Geral' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', CbbIdEmpresa);
  end;
end;

procedure TFrmConfiguracao.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unConfiguracao.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', CdsCopula);

    lTpChamadaClasse := True;

    EdtIdRegistro.Text        := CdsCopula.FieldByName('IdConfiguracao').AsString;
    DtpDtCadastro.Date        := CdsCopula.FieldByName('DtCadastro').AsDateTime;
    EdtNmUsuario.Text         := CdsCopula.FieldByName('NmUsuarioCadastro').AsString;
    if CdsCopula.FieldByName('SnSituacao').AsString = 'ATIVO' then
    begin
      ChkSnSituacao.Checked   := True;
    end
    else
    begin
      ChkSnSituacao.Checked   := False;
    end;
    CbbIdEmpresa.ItemIndex := Integer(CbbIdEmpresa.Properties.Items.IndexOf(CdsCopula.FieldByName('NmRazaoSocialNmFantasia').AsString));
    EdtNmConfiguracao.Text    := CdsCopula.FieldByName('NmConfiguracao').AsString;
    EdtNmSigla.Text           := CdsCopula.FieldByName('NmSigla').AsString;
    EdtNmValor.Text           := CdsCopula.FieldByName('NmValor').AsString;
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmConfiguracao.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmConfiguracao.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;
  unConfiguracao := TConfiguracao.Create;
end;

procedure TFrmConfiguracao.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if not DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.Enabled       := False;
    CbbIdEmpresa.ItemIndex     := Integer(CbbIdEmpresa.Properties.Items.IndexOf(DtmPrincipal.NmFantasiaNmRazaoSocial));
    EdtNmConfiguracao.SetFocus;
    BtnEmpresaPesquisa.Enabled := False;
  end
  else
  begin
    CbbIdEmpresa.Enabled       := True;
    CbbIdEmpresa.SetFocus;
    BtnEmpresaPesquisa.Enabled := False;
  end;
end;

procedure TFrmConfiguracao.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracao';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unConfiguracao.IdConfiguracao := 0;
  EdtNmUsuario.Clear;
  if DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.ItemIndex      := 0;
    CbbIdEmpresa.SetFocus;
  end
  else
  begin
    EdtNmConfiguracao.SetFocus;
  end;
  EdtNmConfiguracao.Clear;
  EdtNmSigla.Clear;
  EdtNmValor.Clear;
  DtpDtCadastro.Date := Now;
end;

end.
