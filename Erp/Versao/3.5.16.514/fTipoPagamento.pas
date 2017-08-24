unit fTipoPagamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, cxButtons,
  cxCheckBox;

type
  TFrmTipoPagamento = class(TFrmCadastro)
    Label7            : TLabel;
    EdtNmTpPagamento  : TcxTextEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CopulaTela;
    procedure Edicao;
  end;

var
  FrmTipoPagamento: TFrmTipoPagamento;

implementation

{$R *.dfm}
uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uTipoPagamento, fAjuda;

var
  unTipoPagamento  : TTipoPagamento;
  lTpChamadaClasse : Boolean;

procedure TFrmTipoPagamento.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamento';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
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


procedure TFrmTipoPagamento.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamento';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmTipoPagamento.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamento';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
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

procedure TFrmTipoPagamento.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamento';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'TipoPagamento', 'Anterior', CdsRetorno);

  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmTipoPagamento.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamento';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoPagamento.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmMarca';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unTipoPagamento.Free;
end;

procedure TFrmTipoPagamento.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamento';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLocalClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmTipoPagamento.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamento';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'TipoPagamento', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmTipoPagamento.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamento';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((Trim(EdtNmTpPagamento.Text) <> '')) then
    begin
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unTipoPagamento.IdTpPagamento    := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unTipoPagamento.IdTpPagamento    := 0;
      end;
      unTipoPagamento.IdUsuario     := DtmPrincipal.IdUsuarioLogado;
      unTipoPagamento.DtCadastro    := Now;
      if ChkSnSituacao.Checked then
      begin
        unTipoPagamento.SnSituacao  := 1;
      end
      else
      begin
        unTipoPagamento.SnSituacao  := 0;
      end;
      unTipoPagamento.NmTpPagamento       := EdtNmTpPagamento.Text;

      if unTipoPagamento.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unTipoPagamento.Buscar(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text));
        end
        else
        begin
          unTipoPagamento.Buscar(DtmPrincipal.Conexao, unTipoPagamento.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text      := IntToStr(unTipoPagamento.IdTpPagamento);
        DtpDtCadastro.Date      := unTipoPagamento.DtCadastro;
        EdtNmUsuario.Text       := unTipoPagamento.NmUsuarioCadastro;

        if unTipoPagamento.SnSituacao = 1 then
        begin
          ChkSnSituacao.Checked := True;
        end
        else
        begin
          ChkSnSituacao.Checked := False;
        end;
        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        inherited;

        EdtNmTpPagamento.Style.Color    := clWindow;
      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      EdtNmTpPagamento.Style.Color    := clHighlight;

      BtnIncluir.Enabled   := False;
      BtnSalvar.Enabled    := True;
      BtnCancelar.Enabled  := True;
      BtnFechar.Enabled    := True;

      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
      Abort;
    end;
  finally
    BtnIncluirClick(Sender);
  end;
end;

procedure TFrmTipoPagamento.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmMarca';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unTipoPagamento.CarregaDbGrid(DtmPrincipal.Conexao, 2, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', CdsCopula);

    lTpChamadaClasse := True;

    EdtIdRegistro.Text        := CdsCopula.FieldByName('IdTpPagamento').AsString;
    DtpDtCadastro.Date        := CdsCopula.FieldByName('DtCadastro').AsDateTime;
    EdtNmUsuario.Text         := CdsCopula.FieldByName('NmUsuarioCadastro').AsString;
    if CdsCopula.FieldByName('SnSituacao').AsString = 'ATIVO' then
    begin
      ChkSnSituacao.Checked   := True;
      ChkSnSituacao.Caption   := 'Cadastro Ativo';
    end
    else
    begin
      ChkSnSituacao.Checked   := False;
      ChkSnSituacao.Caption   := 'Cadastro Inativo';
    end;
    EdtNmTpPagamento.Text           := CdsCopula.FieldByName('NmTpPagamento').AsString;
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmTipoPagamento.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamento';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoPagamento.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamento';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unTipoPagamento       := TTipoPagamento.Create;
end;
procedure TFrmTipoPagamento.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamento';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  EdtNmTpPagamento.SetFocus;
end;

procedure TFrmTipoPagamento.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamento';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unTipoPagamento.IdTpPagamento               := 0;
  EdtNmUsuario.Clear;
  EdtNmTpPagamento.Clear;
  EdtNmTpPagamento.SetFocus;
end;

end.
