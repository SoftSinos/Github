unit fCidade;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, cxButtons,
  cxCheckBox;

type
  TFrmCidade = class(TFrmCadastro)
    Label2        : TLabel;
    Label3        : TLabel;
    Label6        : TLabel;
    EdtNmCidade   : TcxTextEdit;
    CbbIdUf       : TcxComboBox;
    EdtNrIbge     : TcxTextEdit;
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
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CarregarTela(AIdUf: Integer);
    procedure CopulaTela;
    procedure Edicao;
  end;

var
  FrmCidade: TFrmCidade;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uProcedure, uMensagem, uCidade, uCarregaDados, fProcessando, fAjuda;

var
  unCidade         : TCidade;
  unCarregaDados   : TCarregaDados;
  lTpChamadaClasse : Boolean;

{ TFrmCidade }

procedure TFrmCidade.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
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


procedure TFrmCidade.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmCidade.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Click';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
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

procedure TFrmCidade.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Cidade', 'Anterior', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmCidade.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);
end;


procedure TFrmCidade.BtnFecharClick(Sender: TObject);
begin
  inherited;
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCidade.Free;
end;

procedure TFrmCidade.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmCidade.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Cidade', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmCidade.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'TFrmCidade';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if (Trim(EdtNmCidade.Text) <> '') and (Trim(EdtNrIbge.Text) <> '') and (Integer(CbbIdUf.Properties.Items.Objects[CbbIdUf.ItemIndex]) > 0) then
    begin
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unCidade.IdCidade      := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unCidade.IdCidade      := 0;
      end;
      unCidade.IdUsuario       := DtmPrincipal.IdUsuarioLogado;
      unCidade.DtCadastro      := Now;
      if ChkSnSituacao.Checked then
      begin
        unCidade.SnSituacao    := 1;
      end
      else
      begin
        unCidade.SnSituacao    := 0;
      end;
      unCidade.NmCidade        := EdtNmCidade.Text;
      unCidade.NrIbge          := EdtNrIbge.Text;
      unCidade.IdUf            := Integer(CbbIdUf.Properties.Items.Objects[CbbIdUf.ItemIndex]);

      if unCidade.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unCidade.Buscar(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text));
        end
        else
        begin
          unCidade.Buscar(DtmPrincipal.Conexao, unCidade.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text        := IntToStr(unCidade.IdCidade);
        DtpDtCadastro.Date        := unCidade.DtCadastro;
        EdtNmUsuario.Text         := unCidade.NmUsuarioCadastro;

        if unCidade.SnSituacao = 1 then
        begin
          ChkSnSituacao.Checked   := True;
        end
        else
        begin
          ChkSnSituacao.Checked   := False;
        end;
        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        EdtNmCidade.Style.Color := clWindow;
        EdtNrIbge.Style.Color   := clWindow;
        CbbIdUf.Style.Color     := clWindow;

      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      EdtNmCidade.Style.Color := clHighlight;
      EdtNrIbge.Style.Color   := clHighlight;
      CbbIdUf.Style.Color     := clHighlight;

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

procedure TFrmCidade.CarregarTela(AIdUf: Integer);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Uf', 0, '', '', CbbIdUf);

end;

procedure TFrmCidade.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unCidade.CarregaDbGrid(DtmPrincipal.Conexao, 2, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', CdsCopula);

    lTpChamadaClasse := True;

    EdtIdRegistro.Text        := CdsCopula.FieldByName('IdCidade').AsString;
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
    EdtNmCidade.Text          := CdsCopula.FieldByName('NmCidade').AsString;
    EdtNrIbge.Text            := CdsCopula.FieldByName('NrIbge').AsString;
    CbbIdUf.ItemIndex         := Integer(CbbIdUf.Properties.Items.IndexOf(CdsCopula.FieldByName('NmSiglaUf').AsString));
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmCidade.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmCidade.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;
end;

procedure TFrmCidade.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  EdtNmCidade.SetFocus
end;

procedure TFrmCidade.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidade';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCidade.IdCidade   := 0;
  EdtNmUsuario.Clear;
  CbbIdUf.ItemIndex   := 0;
  EdtNmCidade.Clear;
  EdtNrIbge.Clear;
  EdtNmCidade.SetFocus
end;

end.
