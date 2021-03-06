unit fTipoServico;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  dxSkinsCore, dxSkinsDefaultPainters, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, cxButtons,
  cxCheckBox, cxSpinEdit, cxTimeEdit;

type
  TFrmTipoServico = class(TFrmCadastro)
    Label7                  : TLabel;
    MkeVlServico            : TcxMaskEdit;
    Label22                 : TLabel;
    Label2                  : TLabel;
    EdtNmTpServico          : TcxTextEdit;
    CbbIdGrupoServico       : TcxComboBox;
    BtnGrupoServicoPesquisa : TcxButton;
    DtpHrServico            : TcxTimeEdit;
    Label3                  : TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure PnlPrincipalClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnGrupoServicoPesquisaClick(Sender: TObject);
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
  FrmTipoServico: TFrmTipoServico;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uTipoServico, fAjuda, fGrupoServicoPesquisa;

var
  unTipoServico    : TTipoServico;
  unCarregaDados   : TCarregaDados;
  lTpChamadaClasse : Boolean;

procedure TFrmTipoServico.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmTipoServico.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
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

procedure TFrmTipoServico.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'TipoServico', 'Anterior', CdsRetorno);

  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmTipoServico.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unTipoServico.Free;
end;

procedure TFrmTipoServico.BtnGrupoServicoPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnGrupoServicoPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmGrupoServicoPesquisa := TFrmGrupoServicoPesquisa.Create(Application);
    FrmGrupoServicoPesquisa.ShowModal;
  finally
    FrmGrupoServicoPesquisa.Free;
    CbbIdGrupoServico.Properties.Items.Clear;
    CarregarTela('Geral');
  end;
end;

procedure TFrmTipoServico.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLocalClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;


procedure TFrmTipoServico.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'TipoServico', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmTipoServico.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((Integer(CbbIdGrupoServico.Properties.Items.Objects[CbbIdGrupoServico.ItemIndex]) > 0) and (Trim(EdtNmTpServico.Text) <> '') and (Trim(MkeVlServico.Text) <> '')) then
    begin
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unTipoServico.IdTpServico  := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unTipoServico.IdTpServico  := 0;
      end;
      unTipoServico.IdUsuario      := DtmPrincipal.IdUsuarioLogado;
      unTipoServico.DtCadastro     := Now;
      if ChkSnSituacao.Checked then
      begin
        unTipoServico.SnSituacao   := 1;
      end
      else
      begin
        unTipoServico.SnSituacao   := 0;
      end;
      unTipoServico.NmTpServico    := EdtNmTpServico.Text;
      unTipoServico.IdGrupoServico := Integer(CbbIdGrupoServico.Properties.Items.Objects[CbbIdGrupoServico.ItemIndex]);
      unTipoServico.VlServico      := StrToFloat(MkeVlServico.Text);
      unTipoServico.HrServico      := DtpHrServico.Time;

      if unTipoServico.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unTipoServico.Buscar(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text));
        end
        else
        begin
          unTipoServico.Buscar(DtmPrincipal.Conexao, unTipoServico.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text        := IntToStr(unTipoServico.IdTpServico);
        DtpDtCadastro.Date        := unTipoServico.DtCadastro;
        EdtNmUsuario.Text         := unTipoServico.NmUsuarioCadastro;

        if unTipoServico.SnSituacao = 1 then
        begin
          ChkSnSituacao.Checked   := True;
        end
        else
        begin
          ChkSnSituacao.Checked   := False;
        end;
        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        inherited;

        EdtNmTpServico.Style.Color     := clWindow;
        MkeVlServico.Style.Color := clWindow;
      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      EdtNmTpServico.Style.Color      := clHighlight;
      MkeVlServico.Style.Color  := clHighlight;

      BtnIncluir.Enabled        := False;
      BtnSalvar.Enabled         := True;
      BtnCancelar.Enabled       := True;
      BtnFechar.Enabled         := True;

      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
      Abort;
    end;
  finally

  end;
end;

procedure TFrmTipoServico.CarregarTela(ATpChamadaClasse:String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  if ATpChamadaClasse = 'Geral' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'GrupoServico', 0, '', '', '', CbbIdGrupoServico);
  end;
end;


procedure TFrmTipoServico.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unTipoServico.CarregaDbGrid(DtmPrincipal.Conexao, 2, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', CdsCopula);

    lTpChamadaClasse := True;

    EdtIdRegistro.Text        := CdsCopula.FieldByName('IdTpServico').AsString;
    DtpDtCadastro.Date        := CdsCopula.FieldByName('DtCadastro').AsDateTime;
    EdtNmUsuario.Text         := CdsCopula.FieldByName('NmUsuarioCadastro').AsString;
    if CdsCopula.FieldByName('SnSituacao').AsString = 'Ativo' then
    begin
      ChkSnSituacao.Checked   := True;
      ChkSnSituacao.Caption   := 'Cadastro Ativo';
    end
    else
    begin
      ChkSnSituacao.Checked   := False;
      ChkSnSituacao.Caption   := 'Cadastro Inativo';
    end;
    EdtNmTpServico.Text       := CdsCopula.FieldByName('NmTpServico').AsString;
    MkeVlServico.Text         := CdsCopula.FieldByName('VlServico').AsString;
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmTipoServico.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
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

procedure TFrmTipoServico.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoServico.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unTipoServico  := TTipoServico.Create;
  unCarregaDados := TCarregaDados.Create;
end;

procedure TFrmTipoServico.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  CbbIdGrupoServico.SetFocus;
end;

procedure TFrmTipoServico.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unTipoServico.IdTpServico       := 0;
  EdtNmUsuario.Clear;
  ChkSnSituacao.Caption           := 'Cadastro Ativo';
  EdtNmTpServico.Text             := '';
  MkeVlServico.Clear;
  DtpHrServico.Time               := 0;
  CbbIdGrupoServico.SetFocus;
end;

procedure TFrmTipoServico.PnlPrincipalClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

end.
