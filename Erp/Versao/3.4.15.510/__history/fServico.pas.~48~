unit fServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, cxButtons,
  cxCheckBox;

type
  TFrmServico = class(TFrmCadastro)
    Label2                  : TLabel;
    Label3                  : TLabel;
    Label22                 : TLabel;
    MkePcComissao           : TcxMaskEdit;
    CbbIdTpServico          : TcxComboBox;
    CbbIdProfissional       : TcxComboBox;
    BtnPessoaPesquisa       : TcxButton;
    BtnTipoServicoPesquisa  : TcxButton;
    Label4                  : TLabel;
    CbbIdEmpresa            : TcxComboBox;
    BtnEmpresaPesquisa      : TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnPessoaPesquisaClick(Sender: TObject);
    procedure BtnTipoServicoPesquisaClick(Sender: TObject);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
    procedure BtnEmpresaPesquisaClick(Sender: TObject);
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
  FrmServico: TFrmServico;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uServico, fAjuda, fTipoServicoPesquisa, fPessoaPesquisa, fEmpresaPesquisa;

var
  unServico        : TServico;
  unCarregaDados   : TCarregaDados;
  lTpChamadaClasse : Boolean;

procedure TFrmServico.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
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

procedure TFrmServico.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmServico.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
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

procedure TFrmServico.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Servico', 'Anterior', CdsRetorno);

  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmServico.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmServico.BtnEmpresaPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnEmpresaPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmEmpresaPesquisa := TFrmEmpresaPesquisa.Create(Application);
    FrmEmpresaPesquisa.ShowModal;
  finally
    FrmEmpresaPesquisa.Free;
    CbbIdEmpresa.Properties.Items.Clear;
    CarregarTela('Empresa');
  end;
end;

procedure TFrmServico.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unServico.Free;
end;

procedure TFrmServico.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmServico.BtnPessoaPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPessoaPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmPessoaPesquisa := TFrmPessoaPesquisa.Create(Application);
    FrmPessoaPesquisa.ShowModal;
  finally
    FrmPessoaPesquisa.Free;
    CbbIdProfissional.Properties.Items.Clear;
    CarregarTela('Pessoa');
  end;
end;

procedure TFrmServico.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Servico', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmServico.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((Integer(CbbIdProfissional.Properties.Items.Objects[CbbIdProfissional.ItemIndex]) > 0) and (Integer(CbbIdTpServico.Properties.Items.Objects[CbbIdTpServico.ItemIndex]) > 0)) then
    begin
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unServico.IdServico           := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unServico.IdServico           := 0;
      end;
      unServico.IdUsuario             := DtmPrincipal.IdUsuarioLogado;
      unServico.DtCadastro            := Now;
      if ChkSnSituacao.Checked then
      begin
        unServico.SnSituacao          := 1;
      end
      else
      begin
        unServico.SnSituacao          := 0;
      end;
      unServico.IdProfissional        := Integer(CbbIdProfissional.Properties.Items.Objects[CbbIdProfissional.ItemIndex]);
      unServico.IdTpServico           := Integer(CbbIdTpServico.Properties.Items.Objects[CbbIdTpServico.ItemIndex]);
      unServico.IdEmpProfissional     := Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]);
      if Trim(MkePcComissao.Text) <> '' then
      begin
        unServico.PcComissao          := StrToFloat(Trim(MkePcComissao.Text));
      end
      else
      begin
        unServico.PcComissao          := 0;
      end;

      if unServico.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unServico.Buscar(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text));
        end
        else
        begin
          unServico.Buscar(DtmPrincipal.Conexao, unServico.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text            := IntToStr(unServico.IdServico);
        DtpDtCadastro.Date            := unServico.DtCadastro;
        EdtNmUsuario.Text             := unServico.NmUsuarioCadastro;

        if unServico.SnSituacao = 1 then
        begin
          ChkSnSituacao.Checked       := True;
        end
        else
        begin
          ChkSnSituacao.Checked       := False;
        end;
        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        inherited;

        CbbIdProfissional.Style.Color := clWindow;
        CbbIdTpServico.Style.Color    := clWindow;
      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      CbbIdProfissional.Style.Color  := clHighlight;
      CbbIdTpServico.Style.Color     := clHighlight;

      BtnIncluir.Enabled   := False;
      BtnSalvar.Enabled    := True;
      BtnCancelar.Enabled  := True;
      BtnFechar.Enabled    := True;

      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
      Abort;
    end;
  finally

  end;
end;

procedure TFrmServico.BtnTipoServicoPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnTipoServicoPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmTipoServicoPesquisa := TFrmTipoServicoPesquisa.Create(Application);
    FrmTipoServicoPesquisa.ShowModal;
  finally
    FrmTipoServicoPesquisa.Free;
    CbbIdTpServico.Properties.Items.Clear;
    CarregarTela('TipoServico');
  end;
end;

procedure TFrmServico.CarregarTela(ATpChamadaClasse:String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;

  if ATpChamadaClasse = 'Geral'then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', CbbIdEmpresa);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'PessoaTipoPessoa', 0, 'Profissional', '', CbbIdProfissional);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'TipoServico', 0, '', '', CbbIdTpServico);
  end
  else
  if ATpChamadaClasse = 'Pessoa'then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'PessoaTipoPessoa', 0, 'Profissional', '', CbbIdProfissional);
  end
  else
  if ATpChamadaClasse = 'Empresa' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', CbbIdEmpresa);
  end
  else
  if ATpChamadaClasse = 'TipoServico'then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'TipoServico', 0, '', '', CbbIdTpServico);
  end;
end;

procedure TFrmServico.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unServico.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, CdsRetorno.FieldByName('IdRetorno').AsInteger, 0, '', CdsCopula);

    lTpChamadaClasse := True;

    EdtIdRegistro.Text          := CdsCopula.FieldByName('IdServico').AsString;
    DtpDtCadastro.Date          := CdsCopula.FieldByName('DtCadastro').AsDateTime;
    EdtNmUsuario.Text           := CdsCopula.FieldByName('NmUsuarioCadastro').AsString;
    if CdsCopula.FieldByName('SnSituacao').AsString = 'ATIVO' then
    begin
      ChkSnSituacao.Checked     := True;
      ChkSnSituacao.Caption     := 'Cadastro Ativo';
    end
    else
    begin
      ChkSnSituacao.Checked     := False;
      ChkSnSituacao.Caption     := 'Cadastro Inativo';
    end;
    CbbIdProfissional.ItemIndex := Integer(CbbIdProfissional.Properties.Items.IndexOf(CdsCopula.FieldByName('NmProfissional').AsString));
    CbbIdTpServico.ItemIndex    := Integer(CbbIdTpServico.Properties.Items.IndexOf(CdsCopula.FieldByName('NmTpServico').AsString));
    MkePcComissao.Text          := CdsCopula.FieldByName('PcComissao').AsString;
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmServico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmServico.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;
  unServico      := TServico.Create;
end;

procedure TFrmServico.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if not DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.Enabled       := False;
    CbbIdEmpresa.ItemIndex     := Integer(CbbIdEmpresa.Properties.Items.IndexOf(DtmPrincipal.NmFantasiaNmRazaoSocial));
    BtnEmpresaPesquisa.Enabled := False;
    CbbIdProfissional.SetFocus;
  end
  else
  begin
    CbbIdEmpresa.Enabled       := True;
    BtnEmpresaPesquisa.Enabled := True;
    CbbIdEmpresa.SetFocus;
  end;

end;

procedure TFrmServico.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Servico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.ItemIndex        := 0;
    CbbIdEmpresa.SetFocus;
  end
  else
  begin
    CbbIdProfissional.SetFocus;
  end;
  unServico.IdServico             := 0;
  EdtNmUsuario.Clear;
  ChkSnSituacao.Caption           := 'Cadastro Ativo';
  CbbIdProfissional.ItemIndex     := 0;
  CbbIdTpServico.ItemIndex        := 0;
  CbbIdProfissional.SetFocus;
end;

end.
