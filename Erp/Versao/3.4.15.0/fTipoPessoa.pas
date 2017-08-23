unit fTipoPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, Data.DB, Datasnap.DBClient, Vcl.StdCtrls,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, cxButtons, cxCheckBox;

type
  TFrmTipoPessoa = class(TFrmCadastro)
    GroupBox1       : TGroupBox;
    Label2          : TLabel;
    EdtNmTpPessoa   : TcxTextEdit;
    ChkSnCliente    : TcxCheckBox;
    ChkSnFornecedor : TcxCheckBox;
    ChkSnFuncionario: TcxCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CarregarTela;
    procedure CopulaTela;
    procedure Edicao;
  end;

var
  FrmTipoPessoa: TFrmTipoPessoa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uProcedure, uMensagem, uTipoPessoa, uCarregaDados, fProcessando, fAjuda;

var
  unTipoPessoa     : TTipoPessoa;
  unCarregaDados   : TCarregaDados;
  lTpChamadaClasse : Boolean;

procedure TFrmTipoPessoa.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
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

procedure TFrmTipoPessoa.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmTipoPessoa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
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

procedure TFrmTipoPessoa.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'TipoPessoa', 'Anterior', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmTipoPessoa.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);
end;

procedure TFrmTipoPessoa.BtnFecharClick(Sender: TObject);
begin
  inherited;
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unTipoPessoa.Free;
end;

procedure TFrmTipoPessoa.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmTipoPessoa.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'TipoPessoa', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmTipoPessoa.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    if (Trim(EdtNmTpPessoa.Text) <> '') and ((ChkSnCliente.Checked) or (ChkSnFornecedor.Checked) or (ChkSnFuncionario.Checked)) then
    begin
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unTipoPessoa.IdTpPessoa    := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unTipoPessoa.IdTpPessoa    := 0;
      end;
      unTipoPessoa.IdUsuario       := DtmPrincipal.IdUsuarioLogado;
      unTipoPessoa.DtCadastro      := Now;
      if ChkSnSituacao.Checked then
      begin
        unTipoPessoa.SnSituacao    := 1;
      end
      else
      begin
        unTipoPessoa.SnSituacao    := 0;
      end;
      unTipoPessoa.NmTpPessoa      := EdtNmTpPessoa.Text;
      if ChkSnCliente.Checked then
      begin
        unTipoPessoa.SnCliente     := 1;
      end
      else
      begin
        unTipoPessoa.SnCliente     := 0;
      end;
      if ChkSnFornecedor.Checked then
      begin
        unTipoPessoa.SnFornecedor  := 1;
      end
      else
      begin
        unTipoPessoa.SnFornecedor  := 0;
      end;
      if ChkSnFuncionario.Checked then
      begin
        unTipoPessoa.SnFuncionario := 1;
      end
      else
      begin
        unTipoPessoa.SnFuncionario := 0;
      end;

      if unTipoPessoa.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unTipoPessoa.Buscar(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text));
        end
        else
        begin
          unTipoPessoa.Buscar(DtmPrincipal.Conexao, unTipoPessoa.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text      := IntToStr(unTipoPessoa.IdTpPessoa);
        DtpDtCadastro.Date      := unTipoPessoa.DtCadastro;
        EdtNmUsuario.Text       := unTipoPessoa.NmUsuarioCadastro;

        if unTipoPessoa.SnSituacao = 1 then
        begin
          ChkSnSituacao.Checked := True;
        end
        else
        begin
          ChkSnSituacao.Checked := False;
        end;
        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        EdtNmTpPessoa.Style.Color  := clWindow;
      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      EdtNmTpPessoa.Style.Color  := clHighlight;

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

procedure TFrmTipoPessoa.CarregarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);
end;

procedure TFrmTipoPessoa.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unTipoPessoa.CarregaDbGrid(DtmPrincipal.Conexao, 2, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', CdsCopula);

    lTpChamadaClasse := True;

    EdtIdRegistro.Text        := CdsCopula.FieldByName('IdTpPessoa').AsString;
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
    EdtNmTpPessoa.Text        := CdsCopula.FieldByName('NmTpPessoa').AsString;
    if CdsCopula.FieldByName('SnCliente').AsString = 'ATIVO' then
    begin
      ChkSnCliente.Checked    := True;
    end
    else
    begin
      ChkSnCliente.Checked    := False;
    end;
    if CdsCopula.FieldByName('SnFornecedor').AsString = 'ATIVO' then
    begin
      ChkSnFornecedor.Checked := True;
    end
    else
    begin
      ChkSnFornecedor.Checked := False;
    end;
    if CdsCopula.FieldByName('SnFuncionario').AsString = 'ATIVO' then
    begin
      ChkSnFuncionario.Checked:= True;
    end
    else
    begin
      ChkSnFuncionario.Checked:= False;
    end;
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmTipoPessoa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmTipoPessoa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;
  unTipoPessoa   := TTipoPessoa.Create;
end;

procedure TFrmTipoPessoa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  EdtNmTpPessoa.SetFocus;
end;

procedure TFrmTipoPessoa.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unTipoPessoa.IdTpPessoa   := 0;
  EdtNmUsuario.Clear;
  EdtNmTpPessoa.Clear;
  ChkSnCliente.Checked      := False;
  ChkSnFornecedor.Checked   := False;
  ChkSnFuncionario.Checked  := False;
  DtpDtCadastro.Date        := Now;
  EdtNmTpPessoa.SetFocus;
end;

end.
