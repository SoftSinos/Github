unit fEmpresa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, Data.DBXMsSQL, Data.FMTBcd,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ComCtrls, Data.DB, Datasnap.DBClient, Datasnap.Provider, Data.SqlExpr, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask,Vcl.Imaging.jpeg, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxImage, cxDBEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar,
  Vcl.Menus, cxButtons, cxMemo, cxCheckBox;

type
  TFrmEmpresa = class(TFrmCadastro)
    Label2              : TLabel;
    Label4              : TLabel;
    LblNmCpfCnpj        : TLabel;
    Label10             : TLabel;
    Label11             : TLabel;
    Label13             : TLabel;
    Label15             : TLabel;
    Label16             : TLabel;
    Label17             : TLabel;
    Label18             : TLabel;
    OpdImEmpresa        : TOpenDialog;
    CdsPesquisa         : TClientDataSet;
    DtsPesquisa         : TDataSource;
    Label5              : TLabel;
    Label7              : TLabel;
    Label8              : TLabel;
    Label6              : TLabel;
    Label3              : TLabel;
    BtnCepPesquisa      : TcxButton;
    BtnAbrirImEmpresa   : TcxButton;
    BtnSalvarImEmpresa  : TcxButton;
    GroupBox2           : TGroupBox;
    Label26             : TLabel;
    ImgImEmpresa        : TcxDBImage;
    EdtNmRazaoSocial    : TcxTextEdit;
    EdtNmFantasia       : TcxTextEdit;
    EdtNrIE             : TcxTextEdit;
    EdtNmEndereco       : TcxTextEdit;
    EdtNrNumero         : TcxTextEdit;
    EdtNmBairro         : TcxTextEdit;
    EdtNmComplemento    : TcxTextEdit;
    EdtNmCidade         : TcxTextEdit;
    EdtNmUf             : TcxTextEdit;
    EdtNmSitio          : TcxTextEdit;
    EdtNmEmail          : TcxTextEdit;
    EdtImEmpresa        : TcxTextEdit;
    MemObservacao       : TcxMemo;
    MkeNrCnpj           : TcxMaskEdit;
    MkeNrCep            : TcxMaskEdit;
    MkeNrTelefone       : TcxMaskEdit;
    DrsRetorno          : TDataSource;
    BtnWebCam           : TcxButton;
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MkeNrCepKeyPress(Sender: TObject; var Key: Char);
    procedure BtnAbrirImEmpresaClick(Sender: TObject);
    procedure BtnSalvarImEmpresaClick(Sender: TObject);
    procedure EdtIdRegistroExit(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure EdtIdRegistroChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnCepPesquisaClick(Sender: TObject);
    procedure MkeNrCnpjKeyPress(Sender: TObject; var Key: Char);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
    procedure MkeNrCnpjPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure MkeNrTelefonePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure MkeNrCepPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure MkeNrCepExit(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CopulaTela;
    procedure Edicao;
  end;

var
  FrmEmpresa: TFrmEmpresa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uMensagem, uProcedure, uEmpresa, fAjuda, fCepPesquisa, uCep;

var
  unEmpresa        : TEmpresa;
  unCep            : TCep;
  lTpChamadaClasse : Boolean;

procedure TFrmEmpresa.BtnAbrirImEmpresaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAbrirImLogoTipoClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    OpdImEmpresa.Title            := 'Selecione Logo Marca';
    OpdImEmpresa.InitialDir       := '';
    OpdImEmpresa.FileName         := '*.jpg';
    OpdImEmpresa.DefaultExt       := '*.jpg';
    OpdImEmpresa.Filter           := 'Arquivos JPG (*.jpg)|Todos os Arquivos (*.*)|*.*';
    if OpdImEmpresa.Execute then
    begin
      ImgImEmpresa.Visible        := True;
      ImgImEmpresa.Picture.LoadFromFile(OpdImEmpresa.FileName);
      EdtImEmpresa.Text           := OpdImEmpresa.FileName;
      BtnSalvarImEmpresa.Enabled  := True;
    end;
  finally

  end;
end;

procedure TFrmEmpresa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
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

procedure TFrmEmpresa.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Empresa', 'Anterior', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmEmpresa.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmEmpresa.BtnCepPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnTipoPessoaPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmCepPesquisa := TFrmCepPesquisa.Create(Application);
    FrmCepPesquisa.TpAcao := 'CarregaDados';
    FrmCepPesquisa.ShowModal;
  finally
    if not FrmCepPesquisa.CdsPesquisa.IsEmpty then
    begin
      MkeNrCep.Text       := FrmCepPesquisa.CdsPesquisa.FieldByName('NrCep').AsString;;
      MkeNrCepExit(Sender);
      Edicao;
    end;
    FrmCepPesquisa.Free;
  end;
end;

procedure TFrmEmpresa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unEmpresa.Free;
end;

procedure TFrmEmpresa.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmEmpresa.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Empresa', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmEmpresa.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    if (Trim(EdtIdRegistro.Text) <> '') and (Trim(EdtNmRazaoSocial.Text) <> '') and (Trim(EdtNmFantasia.Text) <> '') and (Trim(MkeNrCnpj.Text) <> '') and (Trim(EdtNrIE.Text) <> '') then
    begin
      unEmpresa.IdEmpresa         := StrToInt(EdtIdRegistro.Text);
      unEmpresa.IdUsuario         := DtmPrincipal.IdUsuarioLogado;
      unEmpresa.DtCadastro        := Now;
      if ChkSnSituacao.Checked then
      begin
        unEmpresa.SnSituacao      := 1;
      end
      else
      begin
        unEmpresa.SnSituacao      := 0;
      end;
      unEmpresa.NmRazaoSocial     := EdtNmRazaoSocial.Text;
      unEmpresa.NmFantasia        := EdtNmFantasia.Text;
      unEmpresa.NrCnpj            := RemoveCaracteres(MkeNrCnpj.Text);
      unEmpresa.NrIE              := EdtNrIE.Text;
      unEmpresa.NrCep             := RemoveCaracteres(MkeNrCep.Text);
      unEmpresa.NrNumero          := EdtNrNumero.Text;
      unEmpresa.NmComplemento     := EdtNmComplemento.Text;
      unEmpresa.NrTelefone        := RemoveCaracteres(MkeNrTelefone.Text);
      unEmpresa.NmEmail           := EdtNmEmail.Text;
      unEmpresa.NmObs             := MemObservacao.Text;
      unEmpresa.NmSitio           := EdtNmSitio.Text;

      if unEmpresa.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unEmpresa.Buscar(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text));
        end
        else
        begin
          unEmpresa.Buscar(DtmPrincipal.Conexao, unEmpresa.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text        := IntToStr(unEmpresa.IdEmpresa);
        DtpDtCadastro.Date        := unEmpresa.DtCadastro;
        if unEmpresa.SnSituacao = 1 then
        begin
          ChkSnSituacao.Checked   := True;
        end
        else
        begin
          ChkSnSituacao.Checked   := False;
        end;
        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        EdtIdRegistro.Style.Color       := clWindow;
        EdtNmRazaoSocial.Style.Color    := clWindow;
        EdtNmFantasia.Style.Color       := clWindow;
        MkeNrCnpj.Style.Color           := clWindow;
      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      EdtIdRegistro.Style.Color         := clHighlight;
      EdtNmRazaoSocial.Style.Color      := clHighlight;
      EdtNmFantasia.Style.Color         := clHighlight;
      MkeNrCnpj.Style.Color             := clHighlight;

      BtnIncluir.Enabled                := False;
      BtnSalvar.Enabled                 := True;
      BtnCancelar.Enabled               := True;
      BtnFechar.Enabled                 := True;

      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
      Abort;
    end;
  finally

  end;
end;

procedure TFrmEmpresa.BtnSalvarImEmpresaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarImEmpresaClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if Trim(EdtIdRegistro.Text) <> '' then
  begin
    if SalvaImagem(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada, 'Empresa', EdtImEmpresa.Text) then
    begin
      MsgInformacao(uMensagem.ImagemAdicionadaComSucesso);
      BtnSalvarImEmpresa.Enabled := False;
    end;
  end
  else
  begin
    MsgAtencao(uMensagem.UmaEmpresaDeveSerSelecionada);
  end;
end;

procedure TFrmEmpresa.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', CdsCopula);

    lTpChamadaClasse := True;

    EdtIdRegistro.Text        := CdsCopula.FieldByName('IdEmpresa').AsString;
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
    EdtNmRazaoSocial.Text     := CdsCopula.FieldByName('NmRazaoSocial').AsString;
    EdtNmFantasia.Text        := CdsCopula.FieldByName('NmFantasia').AsString;
    MkeNrCnpj.Text            := CdsCopula.FieldByName('NrCnpj').AsString;
    EdtNrIE.Text              := CdsCopula.FieldByName('NrIE').AsString;
    EdtNmEndereco.Text        := CdsCopula.FieldByName('NmEndereco').AsString;
    EdtNmBairro.Text          := CdsCopula.FieldByName('NmBairro').AsString;
    EdtNrNumero.Text          := CdsCopula.FieldByName('NrNumero').AsString;
    EdtNmComplemento.Text     := CdsCopula.FieldByName('NmComplemento').AsString;
    MkeNrTelefone.Text        := CdsCopula.FieldByName('NrTelefone').AsString;
    EdtNmEmail.Text           := CdsCopula.FieldByName('NmEmail').AsString;
    EdtNmSitio.Text           := CdsCopula.FieldByName('NmSitio').AsString;
    MemObservacao.Text        := CdsCopula.FieldByName('NmObs').AsString;
    EdtNmCidade.Text          := CdsCopula.FieldByName('NmCidade').AsString;
    EdtNmUf.Text              := CdsCopula.FieldByName('NmSiglaUf').AsString;
    MkeNrCep.Text             := CdsCopula.FieldByName('NrCep').AsString;

    if Trim(EdtIdRegistro.Text) <> '' then
    begin
      if unEmpresa.BuscarImagem(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text), CdsRetorno) then
      begin
        ImgImEmpresa.DataBinding.DataField := 'ImLogoTipo';
      end;
    end;
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmEmpresa.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
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

procedure TFrmEmpresa.EdtIdRegistroChange(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'EdtIdRegistroChange';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if Trim(EdtIdRegistro.Text) <> '' then
  begin
    BtnAbrirImEmpresa.Enabled  := True;
    BtnSalvarImEmpresa.Enabled  := True;
  end;
end;

procedure TFrmEmpresa.EdtIdRegistroExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'EdtIdRegistroExit';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);
end;

procedure TFrmEmpresa.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmEmpresa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCnpjExit';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmEmpresa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unEmpresa := TEmpresa.Create;
  unCep     := TCep.Create;
end;

procedure TFrmEmpresa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if Trim(EdtIdRegistro.Text) <> '' then
  begin
    if unEmpresa.BuscarImagem(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text), CdsRetorno) then
    begin
      ImgImEmpresa.DataBinding.DataField := 'ImLogoTipo';
    end;
  end;
  EdtNmEmail.Properties.CharCase   := ecLowerCase;
  EdtNmSitio.Properties.CharCase   := ecLowerCase;
  EdtIdRegistro.Enabled            := True;
  EdtIdRegistro.SetFocus;
end;

procedure TFrmEmpresa.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  EdtIdRegistro.Enabled     := True;
  EdtNmUsuario.Clear;
  EdtNmEndereco.Enabled     := False;
  EdtNmBairro.Enabled       := False;
  EdtNmRazaoSocial.Clear;
  EdtNmFantasia.Clear;
  MkeNrCnpj.Clear;
  EdtNrIE.Clear;
  EdtNmEndereco.Clear;
  EdtNmBairro.Clear;
  EdtNrNumero.Clear;
  EdtNmComplemento.Clear;
  MkeNrTelefone.Clear;
  EdtNmEmail.Clear;
  EdtNmSitio.Clear;
  MemObservacao.Clear;
  EdtNmCidade.Clear;
  EdtNmUf.Clear;
  MkeNrCep.Clear;
  EdtIdRegistro.SetFocus;
end;

procedure TFrmEmpresa.MkeNrCepExit(Sender: TObject);
var
  Key : Char;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCepExit';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  Key := #13;
  MkeNrCepKeyPress(Sender, Key)
end;

procedure TFrmEmpresa.MkeNrCepKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
    DtmPrincipal.unLog.NmMetodo   := 'MkeNrCepKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Empresa';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    unCep.BuscarNrCep(DtmPrincipal.Conexao, RemoveCaracteres(MkeNrCep.EditText));
    if unCep.NrCep = RemoveCaracteres(MkeNrCep.EditText) then
    begin
      EdtNmEndereco.Text  := unCep.NmEndereco;
      EdtNmBairro.Text    := unCep.NmBairro;
      EdtNmCidade.Text    := unCep.NmCidade;
      EdtNmUf.Text        := unCep.NmSiglaUf;

      EdtNrNumero.SetFocus;
    end
    else
    begin
      MkeNrCep.Clear;
    end;
  end;
end;

procedure TFrmEmpresa.MkeNrCepPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCepPropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 8) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end;
end;

procedure TFrmEmpresa.MkeNrCnpjKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
    DtmPrincipal.unLog.NmMetodo   := 'MkeNrCnpjKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Empresa';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    if not VerificaCpfCnpj(MkeNrCnpj.EditText) then
    begin
      MsgAtencao(uMensagem.OCNPJInformadoEInvalido);
      MkeNrCnpj.Clear;
    end;
    EdtNrIE.SetFocus;
  end;
end;
procedure TFrmEmpresa.MkeNrCnpjPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCnpjPropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 14) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end;
end;

procedure TFrmEmpresa.MkeNrTelefonePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrTelefonePropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 10) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end;
end;

end.
