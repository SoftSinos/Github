unit fUsuario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit,
  cxDropDownEdit, cxCalendar, Data.DB, Datasnap.DBClient, Vcl.Menus, cxButtons, cxCheckBox;

type
  TFrmUsuario = class(TFrmCadastro)
    Label2                : TLabel;
    Label4                : TLabel;
    Label5                : TLabel;
    Label6                : TLabel;
    Label7                : TLabel;
    Label8                : TLabel;
    EdtNmSenhaConfere     : TcxTextEdit;
    EdtNmSenha            : TcxTextEdit;
    EdtNmLogin            : TcxTextEdit;
    EdtNmUsuarioCompleto  : TcxTextEdit;
    MkeNrCpf              : TcxMaskEdit;
    CbbIdEmpresa          : TcxComboBox;
    BtnEmpresaPesquisa: TcxButton;
    ChkSnAdministrador    : TcxCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure CbbIdEmpresaChange(Sender: TObject);
    procedure EdtNmUsuarioChange(Sender: TObject);
    procedure EdtNmLoginChange(Sender: TObject);
    procedure MkeNrCpfChange(Sender: TObject);
    procedure EdtNmSenhaChange(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure MkeNrCpfExit(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnEmpresaPesquisaClick(Sender: TObject);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
    procedure MkeNrCpfPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
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
  FrmUsuario: TFrmUsuario;

implementation

{$R *.dfm}

uses uCarregaDados, dPrincipal, uMensagem, uUsuario, uFuncao, uProcedure, fAjuda, fEmpresaPesquisa;

var
  unCarregaDados   : TCarregaDados;
  unUsuario        : TUsuario;
  lTpChamadaClasse : Boolean;

  { TFrmUsuario }

procedure TFrmUsuario.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
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

procedure TFrmUsuario.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmUsuario.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
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

procedure TFrmUsuario.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Usuario', 'Anterior', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmUsuario.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmUsuario.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unUsuario.Free;
end;

procedure TFrmUsuario.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmUsuario.BtnEmpresaPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnEmpresaPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
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

procedure TFrmUsuario.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Usuario', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmUsuario.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    if ((Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]) > 0) and (Trim(EdtNmUsuarioCompleto.Text) <> '') and (Trim(EdtNmLogin.Text) <> '') and (Trim(MkeNrCpf.Text) <> '') and (Trim(EdtNmSenha.Text) <> '')) then
    begin
      if Trim(EdtNmSenha.Text) <> Trim(EdtNmSenhaConfere.Text) then
      begin
        MsgInformacao(uMensagem.ASenhaNaoConfere);
        Abort;
      end;

      unUsuario.IdEmpresa         := Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]);
      unUsuario.IdUsuarioCadastro := DtmPrincipal.IdUsuarioLogado;
      unUsuario.DtCadastro        := Now;
      if ChkSnSituacao.Checked then
      begin
        unUsuario.SnSituacao      := 1;
      end
      else
      begin
        unUsuario.SnSituacao      := 0;
      end;
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unUsuario.IdUsuario       := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unUsuario.IdUsuario       := 0;
      end;
      unUsuario.NmUsuario         := EdtNmUsuarioCompleto.Text;
      unUsuario.NmLogin           := EdtNmLogin.Text;
      unUsuario.NmSenha           := EdtNmSenha.Text;
      unUsuario.NrCpf             := MkeNrCpf.Text;
      if ChkSnAdministrador.Checked then
      begin
        unUsuario.SnAdministrador := 1;
      end
      else
      begin
        unUsuario.SnAdministrador := 0;
      end;

      if unUsuario.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unUsuario.Buscar(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text));
        end
        else
        begin
          unUsuario.Buscar(DtmPrincipal.Conexao, unUsuario.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text  := IntToStr(unUsuario.IdUsuario);
        EdtNmUsuario.Text   := unUsuario.NmUsuarioCadastro;

        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        CbbIdEmpresa.Style.Color  := clWindow;
        EdtNmUsuario.Style.Color  := clWindow;
        EdtNmLogin.Style.Color    := clWindow;
        EdtNmSenha.Style.Color    := clWindow;
        MkeNrCpf.Style.Color      := clWindow;

      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      CbbIdEmpresa.Style.Color  := clHighlight;
      EdtNmUsuario.Style.Color  := clHighlight;
      EdtNmLogin.Style.Color    := clHighlight;
      EdtNmSenha.Style.Color    := clHighlight;
      MkeNrCpf.Style.Color      := clHighlight;

      BtnIncluir.Enabled  := False;
      BtnSalvar.Enabled   := True;
      BtnCancelar.Enabled := True;
      BtnFechar.Enabled   := True;

      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);

      Abort;
    end;
  finally

  end;
end;

procedure TFrmUsuario.CarregarTela(ATpChamadaClasse:String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  if ATpChamadaClasse = 'Geral' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', CbbIdEmpresa);
  end;
end;

procedure TFrmUsuario.CbbIdEmpresaChange(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdEmpresaChange';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnSalvar.Enabled := True;
end;

procedure TFrmUsuario.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unUsuario.CarregaDbGrid(DtmPrincipal.Conexao, 2, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', CdsCopula);

    lTpChamadaClasse := True;

    CbbIdEmpresa.ItemIndex := Integer(FrmUsuario.CbbIdEmpresa.Properties.Items.IndexOf(CdsCopula.FieldByName('NmRazaoSocialNmFantasia').AsString));
    EdtIdRegistro.Text := CdsCopula.FieldByName('IdUsuario').AsString;
    DtpDtCadastro.Date := CdsCopula.FieldByName('DtCadastro').AsDateTime;
    EdtNmUsuario.Text         := CdsCopula.FieldByName('NmUsuarioCadastro').AsString;
    if CdsCopula.FieldByName('SnSituacao').AsString = 'ATIVO' then
    begin
      ChkSnSituacao.Checked := True;
    end
    else
    begin
      ChkSnSituacao.Checked := False;
    end;
    EdtNmUsuario.Text := CdsCopula.FieldByName('NmUsuario').AsString;
    EdtNmLogin.Text := CdsCopula.FieldByName('NmLogin').AsString;
    MkeNrCpf.Text := CdsCopula.FieldByName('NrCpf').AsString;
    if CdsCopula.FieldByName('SnAdministrador').AsString = 'Sim' then
    begin
      ChkSnAdministrador.Checked := True;
    end
    else
    begin
      ChkSnAdministrador.Checked := False;
    end;
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmUsuario.EdtNmLoginChange(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'EdtNmLoginChange';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnSalvar.Enabled := True;
end;

procedure TFrmUsuario.EdtNmSenhaChange(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'EdtNmSenhaChange';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnSalvar.Enabled := True;
end;

procedure TFrmUsuario.EdtNmUsuarioChange(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'EdtNmUsuarioChange';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnSalvar.Enabled := True;
end;

procedure TFrmUsuario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmUsuario.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados  := TCarregaDados.Create;
  unUsuario       := TUsuario.Create;
end;

procedure TFrmUsuario.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  EdtNmSenha.Properties.CharCase          := ecNormal;
  EdtNmSenhaConfere.Properties.CharCase   := ecNormal;

  if not DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.Enabled       := False;
    CbbIdEmpresa.ItemIndex     := Integer(CbbIdEmpresa.Properties.Items.IndexOf(DtmPrincipal.NmFantasiaNmRazaoSocial));
    ChkSnAdministrador.Enabled := False;
    EdtNmUsuarioCompleto.SetFocus;
    BtnEmpresaPesquisa.Enabled := False;
  end
  else
  begin
    CbbIdEmpresa.Enabled       := True;
    CbbIdEmpresa.SetFocus;
    BtnEmpresaPesquisa.Enabled := False;
  end;
end;

procedure TFrmUsuario.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unUsuario.IdUsuario           := 0;
  if DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.ItemIndex      := 0;
    CbbIdEmpresa.SetFocus;
    BtnEmpresaPesquisa.Enabled  := False;
  end
  else
  begin
    EdtNmUsuarioCompleto.SetFocus;
    BtnEmpresaPesquisa.Enabled  := True;
  end;
  EdtNmUsuario.Clear;
  EdtNmLogin.Clear;
  EdtNmSenha.Clear;
  MkeNrCpf.Clear;

end;

procedure TFrmUsuario.MkeNrCpfChange(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCpfChange';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnSalvar.Enabled := True;
end;

procedure TFrmUsuario.MkeNrCpfExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCpfExit';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if not VerificaCpfCnpj(MkeNrCpf.EditText) then
  begin
    MsgAtencao(uMensagem.OCPFInformadoEInvalido);
    MkeNrCpf.Clear;
    MkeNrCpf.SetFocus;
  end;
end;

procedure TFrmUsuario.MkeNrCpfPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuario';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCpfPropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 11) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end
end;

end.
