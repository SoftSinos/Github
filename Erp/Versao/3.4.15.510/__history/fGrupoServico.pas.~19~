unit fGrupoServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, cxButtons,
  cxCheckBox;

type
  TFrmGrupoServico = class(TFrmCadastro)
    Label7            : TLabel;
    EdtNmGrupoServico : TcxTextEdit;
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
  FrmGrupoServico: TFrmGrupoServico;

implementation

{$R *.dfm}
uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uGrupoServico, fAjuda;

var
  unGrupoServico   : TGrupoServico;
  lTpChamadaClasse : Boolean;

procedure TFrmGrupoServico.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
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


procedure TFrmGrupoServico.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmGrupoServico.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
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

procedure TFrmGrupoServico.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'GrupoServico', 'Anterior', CdsRetorno);

  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmGrupoServico.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmGrupoServico.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unGrupoServico.Free;
end;

procedure TFrmGrupoServico.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLocalClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmGrupoServico.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'GrupoServico', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmGrupoServico.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((Trim(EdtNmGrupoServico.Text) <> '')) then
    begin
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unGrupoServico.IdGrupoServico := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unGrupoServico.IdGrupoServico := 0;
      end;
      unGrupoServico.IdUsuario        := DtmPrincipal.IdUsuarioLogado;
      unGrupoServico.DtCadastro       := Now;
      if ChkSnSituacao.Checked then
      begin
        unGrupoServico.SnSituacao     := 1;
      end
      else
      begin
        unGrupoServico.SnSituacao     := 0;
      end;
      unGrupoServico.NmGrupoServico   := EdtNmGrupoServico.Text;

      if unGrupoServico.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unGrupoServico.Buscar(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text));
        end
        else
        begin
          unGrupoServico.Buscar(DtmPrincipal.Conexao, unGrupoServico.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text            := IntToStr(unGrupoServico.IdGrupoServico);
        DtpDtCadastro.Date            := unGrupoServico.DtCadastro;
        EdtNmUsuario.Text             := unGrupoServico.NmUsuarioCadastro;

        if unGrupoServico.SnSituacao = 1 then
        begin
          ChkSnSituacao.Checked       := True;
        end
        else
        begin
          ChkSnSituacao.Checked       := False;
        end;
        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        inherited;

        EdtNmGrupoServico.Style.Color       := clWindow;
      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      EdtNmGrupoServico.Style.Color       := clHighlight;

      BtnIncluir.Enabled            := False;
      BtnSalvar.Enabled             := True;
      BtnCancelar.Enabled           := True;
      BtnFechar.Enabled             := True;

      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
      Abort;
    end;
  finally

  end;
end;

procedure TFrmGrupoServico.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unGrupoServico.CarregaDbGrid(DtmPrincipal.Conexao, 2, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', CdsCopula);

    lTpChamadaClasse := True;

    EdtIdRegistro.Text        := CdsCopula.FieldByName('IdGrupoServico').AsString;
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
    EdtNmGrupoServico.Text    := CdsCopula.FieldByName('NmGrupoServico').AsString;
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmGrupoServico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmGrupoServico.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unGrupoServico       := TGrupoServico.Create;
end;

procedure TFrmGrupoServico.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  EdtNmGrupoServico.SetFocus;
end;

procedure TFrmGrupoServico.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoServico';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'GrupoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unGrupoServico.IdGrupoServico := 0;
  EdtNmUsuario.Clear;
  EdtNmGrupoServico.Clear;
  EdtNmGrupoServico.SetFocus;
end;

end.
