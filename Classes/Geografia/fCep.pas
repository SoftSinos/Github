unit fCep;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.Menus,
  cxButtons, cxCheckBox;

type
  TFrmCep = class(TFrmCadastro)
    Label8            : TLabel;
    Label2            : TLabel;
    Label3            : TLabel;
    Label4            : TLabel;
    Label5            : TLabel;
    Label6            : TLabel;
    EdtNmBairro       : TcxTextEdit;
    EdtNmTpLogradouro : TcxTextEdit;
    EdtNmLogradouro   : TcxTextEdit;
    CbbIdUf           : TcxComboBox;
    CbbIdCidade       : TcxComboBox;
    MkeNrCep          : TcxMaskEdit;
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CbbIdUfExit(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
    procedure MkeNrCepPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CarregarTela(AIdUf: Integer; AIdCidade: Integer);
    procedure CopulaTela;
    procedure Edicao;
  end;

var
  FrmCep: TFrmCep;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uProcedure, uMensagem, uCep, uCarregaDados, fProcessando, fAjuda;

var
  unCep            : TCep;
  unCarregaDados   : TCarregaDados;
  lTpChamadaClasse : Boolean;

{ TFrmCep }

procedure TFrmCep.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
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


procedure TFrmCep.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmCep.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Click';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
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

procedure TFrmCep.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Cep', 'Anterior', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmCep.BtnCancelarClick(Sender: TObject);
begin
  inherited;
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);
end;

procedure TFrmCep.BtnFecharClick(Sender: TObject);
begin
  inherited;
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCep.Free;
end;

procedure TFrmCep.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  InicializarTela;
end;

procedure TFrmCep.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Cep', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmCep.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if (Trim(MkeNrCep.Text) <> '') and (Trim(EdtNmTpLogradouro.Text) <> '') and (Trim(EdtNmLogradouro.Text) <> '') and (Trim(EdtNmBairro.Text) <> '')  and (Integer(CbbIdCidade.Properties.Items.Objects[CbbIdCidade.ItemIndex]) > 0) then
    begin
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unCep.IdCep         := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unCep.IdCep         := 0;
      end;
      unCep.IdUsuario       := DtmPrincipal.IdUsuarioLogado;
      unCep.DtCadastro      := Now;
      if ChkSnSituacao.Checked then
      begin
        unCep.SnSituacao    := 1;
      end
      else
      begin
        unCep.SnSituacao    := 0;
      end;
      unCep.NrCep           := MkeNrCep.Text;
      unCep.NmTpLogradouro  := EdtNmTpLogradouro.Text;
      unCep.NmLogradouro    := EdtNmLogradouro.Text;
      unCep.NmBairro        := EdtNmBairro.Text;
      unCep.IdCidade        := Integer(CbbIdCidade.Properties.Items.Objects[CbbIdCidade.ItemIndex]);

      if unCep.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unCep.Buscar(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text));
        end
        else
        begin
          unCep.Buscar(DtmPrincipal.Conexao, unCep.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text        := IntToStr(unCep.IdCep);
        DtpDtCadastro.Date        := unCep.DtCadastro;
        EdtNmUsuario.Text         := unCep.NmUsuarioCadastro;

        if unCep.SnSituacao = 1 then
        begin
          ChkSnSituacao.Checked   := True;
        end
        else
        begin
          ChkSnSituacao.Checked   := False;
        end;
        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        MkeNrCep.Style.Color            := clWindow;
        EdtNmTpLogradouro.Style.Color   := clWindow;
        EdtNmLogradouro.Style.Color     := clWindow;
        EdtNmBairro.Style.Color         := clWindow;

      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      MkeNrCep.Style.Color            := clHighlight;
      EdtNmTpLogradouro.Style.Color   := clHighlight;
      EdtNmLogradouro.Style.Color     := clHighlight;
      EdtNmBairro.Style.Color         := clHighlight;

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

procedure TFrmCep.CarregarTela(AIdUf: Integer; AIdCidade: Integer);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Uf', 0, '', '', CbbIdUf);

  if (AIdUf > 0) and (AIdCidade > 0) then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Cidade', AIdUf, 'Uf', '', CbbIdCidade);
  end;

end;

procedure TFrmCep.CbbIdUfExit(Sender: TObject);
var
  iTemp : Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdUfExit';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if CbbIdUf.Text <> '[SELECIONE]' then
  begin
    iTemp := Integer(CbbIdUf.Properties.Items.Objects[CbbIdUf.ItemIndex]);

    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Cidade', iTemp, 'Uf', '', CbbIdCidade);

    if CbbIdCidade.Text = '[SELECIONE]' then
    begin
       CbbIdCidade.SetFocus;
    end;
  end;
end;

procedure TFrmCep.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unCep.CarregaDbGrid(DtmPrincipal.Conexao, 2, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', 0, 0,  CdsCopula);

    lTpChamadaClasse := True;

    EdtIdRegistro.Text        := CdsCopula.FieldByName('IdCep').AsString;
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
    MkeNrCep.Text             := CdsCopula.FieldByName('NrCep').AsString;
    EdtNmTpLogradouro.Text    := CdsCopula.FieldByName('NmTpLogradouro').AsString;
    EdtNmLogradouro.Text      := CdsCopula.FieldByName('NmLogradouro').AsString;
    EdtNmBairro.Text          := CdsCopula.FieldByName('NmBairro').AsString;
    CbbIdUf.ItemIndex         := Integer(CbbIdUf.Properties.Items.IndexOf(CdsCopula.FieldByName('NmSiglaUf').AsString));
    CbbIdCidade.ItemIndex     := Integer(CbbIdCidade.Properties.Items.IndexOf(CdsCopula.FieldByName('NmCidade').AsString));
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmCep.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmCep.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;

end;

procedure TFrmCep.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  MkeNrCep.SetFocus;
end;

procedure TFrmCep.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCep.IdCep         := 0;
  EdtNmUsuario.Clear;
  CbbIdUf.ItemIndex   := 0;
  MkeNrCep.Clear;
  EdtNmTpLogradouro.Clear;
  EdtNmLogradouro.Clear;
  EdtNmBairro.Clear;
  CbbIdCidade.Properties.Items.Clear;
  MkeNrCep.SetFocus;
end;

procedure TFrmCep.MkeNrCepPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCep';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCepPropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 8) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end;
end;

end.
