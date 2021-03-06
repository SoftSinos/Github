unit fPessoa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  dxSkinsCore, dxSkinsDefaultPainters, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, cxImage, cxDBEdit,
  Vcl.Mask, Vcl.Imaging.jpeg, Camera, Vcl.Grids, Vcl.DBGrids, dxSkinscxPCPainter, cxPC, Vcl.Menus, cxButtons, cxMemo, cxGroupBox, cxRadioGroup, cxCheckBox;

type
  TFrmPessoa = class(TFrmCadastro)
    Label2                  : TLabel;
    Label11                 : TLabel;
    LblNmCpfCnpj            : TLabel;
    Label4                  : TLabel;
    Label14                 : TLabel;
    Label23                 : TLabel;
    DtpDtNascimento         : TcxDateEdit;
    GroupBox2               : TGroupBox;
    OpdImPessoa             : TOpenDialog;
    LblNmRGIE               : TLabel;
    GrbNrCelular1           : TGroupBox;
    Label25                 : TLabel;
    RdgOperadorasCelular1   : TRadioGroup;
    GrbNrCelular2           : TGroupBox;
    RdgOperadorasCelular2   : TRadioGroup;
    Label6                  : TLabel;
    GrbNrWhatsApp           : TGroupBox;
    RdgOperadorasWhatsApp   : TRadioGroup;
    Label27                 : TLabel;
    PnlExtras               : TPanel;
    PgcExtra                : TcxPageControl;
    TbsRedeSocial           : TcxTabSheet;
    Label24                 : TLabel;
    Label28                 : TLabel;
    Label18                 : TLabel;
    TbsProfissional         : TcxTabSheet;
    TbsObservacao           : TcxTabSheet;
    Label3                  : TLabel;
    Panel1                  : TPanel;
    TbsEndereco             : TcxTabSheet;
    Label8                  : TLabel;
    Label15                 : TLabel;
    Label16                 : TLabel;
    Label13                 : TLabel;
    Label17                 : TLabel;
    Label5                  : TLabel;
    Label10                 :  TLabel;
    Label19                 : TLabel;
    Label22                 : TLabel;
    MkePcComissao           : TcxMaskEdit;
    DtsPesquisa             : TDataSource;
    CdsPesquisa             : TClientDataSet;
    DbgPesquisa             : TDBGrid;
    Panel2                  : TPanel;
    Label20                 : TLabel;
    Label21                 : TLabel;
    Label26                 : TLabel;
    BtnNovoServico          : TcxButton;
    BtnSalvarServico        : TcxButton;
    BtnEmpresaPesquisa      : TcxButton;
    BtnTipoPessoaPesquisa   : TcxButton;
    BtnChaveTabela          : TcxButton;
    BtnCepPesquisa          : TcxButton;
    BtnGrupoServicoPesquisa : TcxButton;
    BtnServicoPesquisa      : TcxButton;
    CbbIdEmpresa            : TcxComboBox;
    CbbIdTpPessoa           : TcxComboBox;
    LblPessoaRazaoSocial    : TLabel;
    ImgImPessoa             : TcxDBImage;
    Label7                  : TLabel;
    EdtImPessoa             : TcxTextEdit;
    BtnWebCam               : TcxButton;
    BtnLocal                : TcxButton;
    BtnSalvarImPessoa       : TcxButton;
    MkeNrFixo               : TcxMaskEdit;
    MkeNrWhatsApp           : TcxMaskEdit;
    MkeNrCelular2           : TcxMaskEdit;
    MkeNrCelular            : TcxMaskEdit;
    MkeNrCpfCnpj            : TcxMaskEdit;
    EdtNmPessoa             : TcxTextEdit;
    EdtNrRgIe               : TcxTextEdit;
    EdtNmApelido            : TcxTextEdit;
    EdtNmEmail              : TcxTextEdit;
    EdtNmFacebook           : TcxTextEdit;
    EdtNmInstagran          : TcxTextEdit;
    MemObservacao           : TcxMemo;
    EdtNmComplemento        : TcxTextEdit;
    MkeNrCep                : TcxMaskEdit;
    EdtNmCidade             : TcxTextEdit;
    EdtNmUf                 : TcxTextEdit;
    EdtNrNumero             : TcxTextEdit;
    EdtNmBairro             : TcxTextEdit;
    EdtNmEndereco           : TcxTextEdit;
    EdtIdServico            : TcxTextEdit;
    CbbIdGrupoServico       : TcxComboBox;
    CbbIdTpServico          : TcxComboBox;
    DtsRetorno              : TDataSource;
    RdgFisicoJuridico       : TcxRadioGroup;
    ChkServicoSnSituacao: TcxCheckBox;
    procedure BtnWebCamClick(Sender: TObject);
    procedure BtnLocalClick(Sender: TObject);
    procedure MkeNrCpfCnpjExit(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure MkeNrCepExit(Sender: TObject);
    procedure CbbIdEmpresaChange(Sender: TObject);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
    procedure BtnTipoPessoaPesquisaClick(Sender: TObject);
    procedure BtnCepPesquisaClick(Sender: TObject);
    procedure BtnEmpresaPesquisaClick(Sender: TObject);
    procedure BtnChaveTabelaClick(Sender: TObject);
    procedure CbbIdTpPessoaExit(Sender: TObject);
    procedure BtnServicoPesquisaClick(Sender: TObject);
    procedure BtnNovoServicoClick(Sender: TObject);
    procedure BtnSalvarServicoClick(Sender: TObject);
    procedure DbgPesquisaDblClick(Sender: TObject);
    procedure CbbIdGrupoServicoClick(Sender: TObject);
    procedure BtnGrupoServicoPesquisaClick(Sender: TObject);
    procedure BtnSalvarImPessoaClick(Sender: TObject);
    procedure RdgFisicoJuridicoClick(Sender: TObject);
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
  FrmPessoa: TFrmPessoa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uPessoa, uTipoPessoa, uCep, fAjuda, fWebCam, fTipoPessoaPesquisa, fCepPesquisa, fEmpresaPesquisa,
  fServicoPesquisa, uServico, fGrupoServicoPesquisa;

var
  unPessoa        : TPessoa;
  unTipoPessoa    : TTipoPessoa;
  unCarregaDados  : TCarregaDados;
  unCep           : TCep;
  unServico       : TServico;
  LimpaArquivo    : String;

procedure TFrmPessoa.BtnServicoPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnServicoPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmServicoPesquisa := TFrmServicoPesquisa.Create(Application);
    FrmServicoPesquisa.ShowModal;
  finally
    FrmServicoPesquisa.Free;
    CbbIdTpServico.Properties.Items.Clear;
    CbbIdTpPessoaExit(Sender);
  end;
end;

procedure TFrmPessoa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
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


procedure TFrmPessoa.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Pessoa', 'Anterior', CdsRetorno);

  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmPessoa.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmPessoa.BtnCepPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnTipoPessoaPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmCepPesquisa := TFrmCepPesquisa.Create(Application);
    FrmCepPesquisa.ShowModal;
  finally
    FrmCepPesquisa.Free;
  end;
end;

procedure TFrmPessoa.BtnChaveTabelaClick(Sender: TObject);
begin
  MsgInformacao(uMensagem.CampoChaveDaTabelaNaoSeraModificado);
end;

procedure TFrmPessoa.BtnEmpresaPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnEmpresaPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmEmpresaPesquisa := TFrmEmpresaPesquisa.Create(Application);
    FrmEmpresaPesquisa.ShowModal;
  finally
    FrmEmpresaPesquisa.Free;
    CbbIdEmpresa.Properties.Items.Clear;
    CbbIdTpPessoa.Properties.Items.Clear;
    CarregarTela;
  end;
end;

procedure TFrmPessoa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unPessoa.Free;
end;

procedure TFrmPessoa.BtnGrupoServicoPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnGrupoServicoPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmGrupoServicoPesquisa := TFrmGrupoServicoPesquisa.Create(Application);
    FrmGrupoServicoPesquisa.ShowModal;
  finally
    FrmGrupoServicoPesquisa.Free;
    CbbIdGrupoServico.Properties.Items.Clear;
    CarregarTela;
  end;
end;

procedure TFrmPessoa.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLocalClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  PnlCampos.Enabled := True;
  BtnWebCam.Enabled := False;
  BtnLocal.Enabled  := False;
  InicializarTela;
end;

procedure TFrmPessoa.BtnNovoServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirServicoClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
     CbbIdGrupoServico.ItemIndex := 0;
     CbbIdTpServico.ItemIndex    := 0;
     MkePcComissao.Clear;
  finally

  end;
end;

procedure TFrmPessoa.BtnLocalClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAbrirImLogoTipoClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    OpdImPessoa.Title            := 'Selecione Imagem Pessoa';
    OpdImPessoa.InitialDir       := '';
    OpdImPessoa.FileName         := '*.jpg';
    OpdImPessoa.DefaultExt       := '*.jpg';
    OpdImPessoa.Filter           := 'Arquivos JPG (*.jpg)|Todos os Arquivos (*.*)|*.*';
    if OpdImPessoa.Execute then
    begin
      ImgImPessoa.Visible        := True;
      ImgImPessoa.Picture.LoadFromFile(OpdImPessoa.FileName);
      EdtImPessoa.Text           := OpdImPessoa.FileName;
      BtnSalvarImPessoa.Enabled  := True;
    end;
  finally

  end;
end;

procedure TFrmPessoa.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Pessoa', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmPessoa.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]) > 0) and (Integer(CbbIdTpPessoa.Properties.Items.Objects[CbbIdTpPessoa.ItemIndex]) > 0) and (Trim(EdtNmPessoa.Text) <> '') and (RdgFisicoJuridico.ItemIndex >= 0) and (Trim(MkeNrCelular.Text) <> '') and (RdgOperadorasCelular1.ItemIndex > -1)) then
    begin
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unPessoa.IdPessoa     := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unPessoa.IdPessoa     := 0;
      end;
      unPessoa.IdUsuario      := DtmPrincipal.IdUsuarioLogado;
      unPessoa.DtCadastro     := Now;
      if ChkSnSituacao.Checked then
      begin
        unPessoa.SnSituacao   := 1;
      end
      else
      begin
        unPessoa.SnSituacao   := 0;
      end;
      unPessoa.IdEmpresa      := Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]);
      unPessoa.NmPessoa       := EdtNmPessoa.Text;
      unPessoa.NmApelido      := EdtNmApelido.Text;
      if RdgFisicoJuridico.ItemIndex = 0 then
      begin
        unPessoa.TpCadastro     := 'F';
      end
      else
      if RdgFisicoJuridico.ItemIndex = 1 then
      begin
        unPessoa.TpCadastro     := 'J';
      end;
      unPessoa.IdTpPessoa       := Integer(CbbIdTpPessoa.Properties.Items.Objects[CbbIdTpPessoa.ItemIndex]);
      unPessoa.NrCpfCnpj        := RemoveCaracteres(MkeNrCpfCnpj.Text);
      unPessoa.NrRgIe           := RemoveCaracteres(EdtNrRgIe.Text);
      unPessoa.NrCep            := RemoveCaracteres(MkeNrCep.Text);
      unPessoa.NrNumero         := EdtNrNumero.Text;
      unPessoa.NmComplemento    := EdtNmComplemento.Text;

      if RdgOperadorasCelular1.ItemIndex = 0 then
      begin
        unPessoa.NmOperCelular  := 'CLARO'
      end
      else if RdgOperadorasCelular1.ItemIndex = 1 then
      begin
        unPessoa.NmOperCelular  := 'OI'
      end
      else if RdgOperadorasCelular1.ItemIndex = 2 then
      begin
        unPessoa.NmOperCelular  := 'TIM'
      end
      else if RdgOperadorasCelular1.ItemIndex = 3 then
      begin
        unPessoa.NmOperCelular  := 'VIVO'
      end;

      if RdgOperadorasCelular2.ItemIndex = 0 then
      begin
        unPessoa.NmOperCelular2 := 'CLARO'
      end
      else if RdgOperadorasCelular2.ItemIndex = 1 then
      begin
        unPessoa.NmOperCelular2 := 'OI'
      end
      else if RdgOperadorasCelular2.ItemIndex = 2 then
      begin
        unPessoa.NmOperCelular2 := 'TIM'
      end
      else if RdgOperadorasCelular2.ItemIndex = 3 then
      begin
        unPessoa.NmOperCelular2 := 'VIVO'
      end;

      if RdgOperadorasWhatsApp.ItemIndex = 0 then
      begin
        unPessoa.NmOperWhatsApp := 'CLARO'
      end
      else if RdgOperadorasWhatsApp.ItemIndex = 1 then
      begin
        unPessoa.NmOperWhatsApp := 'OI'
      end
      else if RdgOperadorasWhatsApp.ItemIndex = 2 then
      begin
        unPessoa.NmOperWhatsApp := 'TIM'
      end
      else if RdgOperadorasWhatsApp.ItemIndex = 3 then
      begin
        unPessoa.NmOperWhatsApp := 'VIVO'
      end;

      unPessoa.NrFixo           := RemoveCaracteres(MkeNrFixo.Text);
      unPessoa.NrCelular        := RemoveCaracteres(MkeNrCelular.Text);
      unPessoa.NrCelular2       := RemoveCaracteres(MkeNrCelular2.Text);
      unPessoa.NrWhatsApp       := RemoveCaracteres(MkeNrWhatsApp.Text);
      if DtpDtNascimento.Text = '' then
      begin
        unPessoa.DtNascimento   := 0;
      end else
      begin
        unPessoa.DtNascimento   := StrToDate(DtpDtNascimento.Text);
      end;
      unPessoa.NmEmail          := EdtNmEmail.Text;
      unPessoa.NmFacebook       := EdtNmFacebook.Text;
      unPessoa.NmInstagran      := EdtNmInstagran.Text;
      unPessoa.NmObs            := MemObservacao.Text;

      if unPessoa.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unPessoa.Buscar(DtmPrincipal.Conexao, Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]), StrToInt(EdtIdRegistro.Text));
        end
        else
        begin
          unPessoa.Buscar(DtmPrincipal.Conexao, Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]), unPessoa.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text      := IntToStr(unPessoa.IdPessoa);
        DtpDtCadastro.Date      := unPessoa.DtCadastro;
        EdtNmUsuario.Text       := unPessoa.NmUsuarioCadastro;

        if unPessoa.SnSituacao = 1 then
        begin
          ChkSnSituacao.Checked := True;
        end
        else
        begin
          ChkSnSituacao.Checked := False;
        end;
        CbbIdTpPessoaExit(Sender);

        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        BtnWebCam.Enabled           := True;
        BtnLocal.Enabled            := True;
        inherited;

        CbbIdEmpresa.Style.Color      := clWindow;
        CbbIdTpPessoa.Style.Color     := clWindow;
        EdtNmPessoa.Style.Color       := clWindow;
        RdgFisicoJuridico.Style.Color := clWindow;
        MkeNrCelular.Style.Color      := clWindow;
      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      CbbIdEmpresa.Style.Color      := clHighlight;
      CbbIdTpPessoa.Style.Color     := clHighlight;
      EdtNmPessoa.Style.Color       := clHighlight;
      RdgFisicoJuridico.Style.Color := clHighlight;
      MkeNrCelular.Style.Color      := clHighlight;

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

procedure TFrmPessoa.BtnSalvarImPessoaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarImPessoaClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if Trim(EdtIdRegistro.Text) <> '' then
  begin
    if SalvaImagem(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada, 'Pessoa', EdtImPessoa.Text) then
    begin
      MsgInformacao(uMensagem.ImagemAdicionadaComSucesso);
      BtnSalvarImPessoa.Enabled := False;
      DeleteFile(DtmPrincipal.NmCaminhoImgPessoa + RemoveCaracteres(MkeNrCpfCnpj.Text) + '.jpg');
    end;
  end
  else
  begin
    MsgAtencao(uMensagem.UmaEmpresaDeveSerSelecionada);
  end;
end;

procedure TFrmPessoa.BtnSalvarServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmServico';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unServico.CarregaDbGrid(DtmPrincipal.Conexao, False, 2, 0, '', CdsPesquisa);

    if (Integer(CbbIdGrupoServico.Properties.Items.Objects[CbbIdGrupoServico.ItemIndex]) > 0) and (Integer(CbbIdTpServico.Properties.Items.Objects[CbbIdTpServico.ItemIndex]) > 0) and (Trim(MkePcComissao.EditText) <> '') then
    begin
      if Trim(EdtIdServico.Text) <> '' then
      begin
        unServico.IdServico     := StrToInt(EdtIdServico.Text);
      end
      else
      begin
        unServico.IdServico     := 0;
      end;
      unServico.IdUsuario       := DtmPrincipal.IdUsuarioLogado;
      unServico.DtCadastro      := Now;
      if ChkServicoSnSituacao.Checked then
      begin
        unServico.SnSituacao    := 1;
      end
      else
      begin
        unServico.SnSituacao    := 0;
      end;
      unServico.IdProfissional  := StrToInt(EdtIdRegistro.Text);
      unServico.IdTpServico     := Integer(CbbIdTpServico.Properties.Items.Objects[CbbIdTpServico.ItemIndex]);
      unServico.PcComissao      := StrToFloat(MkePcComissao.Text);

      if unServico.Salvar(DtmPrincipal.Conexao) then
      begin
        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);
        unServico.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, EdtNmPessoa.Text, CdsPesquisa);
        EdtIdServico.Clear;
        CbbIdGrupoServico.ItemIndex := 0;
        CbbIdTpServico.Properties.Items.Clear;
        CbbIdTpServico.Enabled      := False;
        MkePcComissao.Clear;
      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
    end;
  finally

  end;
end;

procedure TFrmPessoa.BtnTipoPessoaPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnTipoPessoaPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmTipoPessoaPesquisa := TFrmTipoPessoaPesquisa.Create(Application);
    FrmTipoPessoaPesquisa.ShowModal;
  finally
    FrmTipoPessoaPesquisa.Free;
    CbbIdEmpresa.Properties.Items.Clear;
    CbbIdTpPessoa.Properties.Items.Clear;
    CarregarTela;
  end;
end;

procedure TFrmPessoa.BtnWebCamClick(Sender: TObject);
var
  DirNomeFoto: string;
  NomeFoto: string;
  procedure ConverteParaJpeg(ANomeFoto: string);
  var
    cjBmp: TBitmap;
    cjJpg: TJpegImage;
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
    DtmPrincipal.unLog.NmMetodo   := 'BtnWebCamClick';
    DtmPrincipal.unLog.NmTabela   := 'Pessoa';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    ImgImPessoa.Visible := False;
    ImgImPessoa.Picture.Bitmap.LoadFromFile(DtmPrincipal.NmCaminhoImgPessoa + ANomeFoto + '.bmp');

    cjJpg := TJpegImage.Create;
    cjBmp := TBitmap.Create;

    cjBmp.Assign(ImgImPessoa.Picture.Bitmap);
    cjJpg.Assign(cjBmp);

    cjJpg.SaveToFile(DtmPrincipal.NmCaminhoImgPessoa + ANomeFoto + '.jpg');
    ImgImPessoa.Visible := True;
    ImgImPessoa.Picture.LoadFromFile(DtmPrincipal.NmCaminhoImgPessoa + ANomeFoto + '.jpg');

    if FileExists(DtmPrincipal.NmCaminhoImgPessoa + RemoveCaracteres(MkeNrCpfCnpj.Text) + '.bmp') then
    begin
      DeleteFile(DtmPrincipal.NmCaminhoImgPessoa + RemoveCaracteres(MkeNrCpfCnpj.Text) + '.bmp');
      EdtImPessoa.Text           := DtmPrincipal.NmCaminhoImgPessoa + ANomeFoto + '.jpg';
      BtnSalvarImPessoa.Enabled  := True;
    end;

    cjJpg.Free;
    cjBmp.Free;
  end;

begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnWebCamClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmWebCam        := TFrmWebCam.Create(Self);
  try
    with FrmWebCam, CamCamera do
    begin
      NomeFoto     := RemoveCaracteres(MkeNrCpfCnpj.Text);
      LimpaArquivo := NomeFoto;

      DirNomeFoto  := DtmPrincipal.NmCaminhoImgPessoa + NomeFoto + '.bmp';

      FichierImage := DirNomeFoto;
      if FrmWebCam.ShowModal = mrOk then
      begin
        CaptureImageDisque(FichierImage);
        ConverteParaJpeg(NomeFoto);
      end;
    end;
  finally
    FreeAndNil(FrmWebCam);
  end;
end;

procedure TFrmPessoa.CarregarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', '', CbbIdEmpresa);
  unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'TipoPessoa', 0, '', '', '',  CbbIdTpPessoa);
end;

procedure TFrmPessoa.CbbIdEmpresaChange(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdEmpresaChange';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  BtnSalvar.Enabled := True;
  BtnWebCam.Enabled := True;
  BtnLocal.Enabled := True;
end;

procedure TFrmPessoa.CbbIdGrupoServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdTpPessoaExit';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unCarregaDados.gCarregarSelecionar := 1;
    CbbIdTpServico.Properties.Items.Clear;
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'TipoServico', 0, 'GrupoServico', IntToStr(Integer(CbbIdGrupoServico.Properties.Items.Objects[CbbIdGrupoServico.ItemIndex])), '',  CbbIdTpServico);
    CbbIdTpServico.Enabled             := True;
  finally

  end;

end;

procedure TFrmPessoa.CbbIdTpPessoaExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdTpPessoaExit';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if (Integer(CbbIdTpPessoa.Properties.Items.Objects[CbbIdTpPessoa.ItemIndex]) > 0) and (Trim(EdtIdRegistro.Text)<> '') then
    begin
      unTipoPessoa.BuscarNmTpPessoa(DtmPrincipal.Conexao, CbbIdTpPessoa.Text);
      if unTipoPessoa.SnFuncionario = 1 then
      begin
        TbsProfissional.Enabled := True;
        unCarregaDados.gCarregarSelecionar := 1;
        unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'GrupoServico', 0, '', '', '', CbbIdGrupoServico);
        unServico.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, EdtNmPessoa.Text, CdsPesquisa);
      end;
    end;
  finally

  end;
end;

procedure TFrmPessoa.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unPessoa.CarregaDbGrid(DtmPrincipal.Conexao, 2, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', 0, CdsCopula);

    EdtIdRegistro.Text        := CdsCopula.FieldByName('IdPessoa').AsString;
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
    CbbIdEmpresa.ItemIndex    := Integer(FrmPessoa.CbbIdEmpresa.Properties.Items.IndexOf(CdsCopula.FieldByName('NmRazaoSocialNmFantasia').AsString));
    EdtNmPessoa.Text          := CdsCopula.FieldByName('NmPessoa').AsString;
    EdtNmApelido.Text         := CdsCopula.FieldByName('NmApelido').AsString;
    if CdsCopula.FieldByName('TpCadastro').AsString = 'F' then
    begin
      RdgFisicoJuridico.ItemIndex  := 0;
    end
    else if CdsCopula.FieldByName('TpCadastro').AsString = 'J' then
    begin
      RdgFisicoJuridico.ItemIndex  := 1;
    end;
    CbbIdTpPessoa.ItemIndex   := Integer(FrmPessoa.CbbIdTpPessoa.Properties.Items.IndexOf(CdsCopula.FieldByName('NmTpPessoa').AsString));
    MkeNrCpfCnpj.Text         := CdsCopula.FieldByName('NrCpfCnpj').AsString;
    MkeNrCep.Text             := CdsCopula.FieldByName('NrCep').AsString;
    MkeNrCepExit(Self);
    EdtNrNumero.Text          := CdsCopula.FieldByName('NrNumero').AsString;
    EdtNmComplemento.Text     := CdsCopula.FieldByName('NmComplemento').AsString;
    MkeNrFixo.Text            := CdsCopula.FieldByName('NrFixo').AsString;
    MkeNrCelular.Text         := CdsCopula.FieldByName('NrCelular').AsString;
    MkeNrWhatsApp.Text        := CdsCopula.FieldByName('NrWhatsApp').AsString;
    if ConverteDataPorNumero(DtmPrincipal.Conexao, (CdsCopula.FieldByName('DtNascimento').AsDateTime)) > 0 then
    begin
      DtpDtNascimento.Date    := CdsCopula.FieldByName('DtNascimento').AsDateTime;
    end
    else
    begin
      DtpDtNascimento.Clear;
    end;
    EdtNmEmail.Text           := CdsCopula.FieldByName('NmEmail').AsString;
    EdtNmFacebook.Text        := CdsCopula.FieldByName('NmFacebook').AsString;
    EdtNmInstagran.Text       := CdsCopula.FieldByName('NmInstagran').AsString;
    MemObservacao.Text        := CdsCopula.FieldByName('NmObs').AsString;

    if Trim(EdtIdRegistro.Text) <> '' then
    begin
      if unPessoa.BuscarImagem(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text), CdsRetorno) then
      begin
        ImgImPessoa.DataBinding.DataField := 'ImPessoa';
      end;
    end;
  finally

  end;
end;

procedure TFrmPessoa.DbgPesquisaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'DbgPesquisaDblClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  EdtIdServico.Text              := CdsPesquisa.FieldByName('IdServico'          ).AsString;
  if CdsPesquisa.FieldByName('SnSituacao').AsString = 'Ativo' then
  begin
    ChkServicoSnSituacao.Checked := True;
    ChkServicoSnSituacao.Caption := 'Cadastro Ativo';
  end
  else
  begin
    ChkServicoSnSituacao.Checked := False;
    ChkServicoSnSituacao.Caption := 'Cadastro Inativo';
  end;
  CbbIdGrupoServico.ItemIndex    := RetornaZeroI(Integer(CbbIdGrupoServico.Properties.Items.IndexOf(CdsPesquisa.FieldByName('NmGrupoServico').AsString)));
  CbbIdGrupoServicoClick(Sender);
  CbbIdTpServico.ItemIndex       := RetornaZeroI(Integer(CbbIdTpServico.Properties.Items.IndexOf(CdsPesquisa.FieldByName('NmTpServico').AsString)));
  MkePcComissao.Text             := CdsPesquisa.FieldByName('PcComissao'        ).AsString;
end;

procedure TFrmPessoa.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmPessoa.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnIncluir.Enabled   := False;
  BtnSalvar.Enabled    := True;
  BtnCancelar.Enabled  := True;
  BtnFechar.Enabled    := True;
  BtnAnterior.Enabled  := False;
  BtnProximo.Enabled   := False;
end;

procedure TFrmPessoa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmPessoa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;
  unPessoa       := TPessoa.Create;
  unTipoPessoa   := TTipoPessoa.Create;
  unCep          := TCep.Create;
  unServico      := TServico.Create;
end;

procedure TFrmPessoa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if Trim(EdtIdRegistro.Text) <> '' then
  begin
    if unPessoa.BuscarImagem(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text), CdsRetorno) then
    begin
      ImgImPessoa.DataBinding.DataField := 'ImPessoa';
    end;
  end;

  EdtNmEmail.Properties.CharCase     := ecLowerCase;
  EdtNmFacebook.Properties.CharCase  := ecLowerCase;
  EdtNmInstagran.Properties.CharCase := ecLowerCase;

  if not DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.Enabled    := False;
    CbbIdEmpresa.ItemIndex  := Integer(CbbIdEmpresa.Properties.Items.IndexOf(DtmPrincipal.NmFantasiaNmRazaoSocial));
  end
  else
  begin
    CbbIdEmpresa.Enabled := true;
  end;

  PgcExtra.ActivePage := TbsEndereco;
end;

procedure TFrmPessoa.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unPessoa.IdPessoa               := 0;
  EdtNmUsuario.Clear;
  ChkSnSituacao.Caption           := 'Cadastro Ativo';
  if DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.ItemIndex        := 0;
    CbbIdEmpresa.SetFocus;
  end;
  EdtNmPessoa.Clear;
  EdtNmApelido.Clear;
  CbbIdTpPessoa.ItemIndex         := 0;
  CbbIdGrupoServico.ItemIndex     := 0;
  MkeNrCep.Clear;
  MkeNrCpfCnpj.Clear;
  EdtNrRgIe.Clear;
  EdtNmEndereco.Clear;
  EdtNrNumero.Clear;
  EdtNmBairro.Clear;
  EdtNmComplemento.Clear;
  EdtNmCidade.Clear;
  EdtNmUf.Clear;
  MkeNrFixo.Clear;
  MkeNrCelular.Clear;
  MkeNrCelular2.Clear;
  MkeNrWhatsApp.Clear;
  DtpDtNascimento.Clear;
  EdtNmEmail.Clear;
  EdtNmFacebook.Clear;
  EdtNmInstagran.Clear;
  MemObservacao.Clear;
  RdgFisicoJuridico.ItemIndex     := -1;
  RdgOperadorasCelular1.ItemIndex := -1;
  CbbIdTpServico.Properties.Items.Clear;
  MkePcComissao.Clear;
  EdtIdServico.Clear;
end;

procedure TFrmPessoa.MkeNrCepExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCpfExit';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCep.BuscarNrCep(DtmPrincipal.Conexao, RemoveCaracteres(MkeNrCep.EditText));
  if unCep.NrCep = RemoveCaracteres(MkeNrCep.EditText) then
  begin
    EdtNmEndereco.Text  := unCep.NmEndereco;
    EdtNmBairro.Text    := unCep.NmBairro;
    EdtNmCidade.Text    := unCep.NmCidade;
    EdtNmUf.Text        := unCep.NmSiglaUf;
  end;
end;

procedure TFrmPessoa.MkeNrCpfCnpjExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCpfExit';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if not (VerificaCpfCnpj(MkeNrCpfCnpj.Text)) and (Trim(MkeNrCpfCnpj.Text) <> '') then
  begin
    if RdgFisicoJuridico.ItemIndex = 0 then
    begin
      MsgAtencao(uMensagem.OCPFInformadoEInvalido);
    end
    else
    if RdgFisicoJuridico.ItemIndex = 1 then
    begin
      MsgAtencao(uMensagem.OCNPJInformadoEInvalido);
    end;
    MkeNrCpfCnpj.Clear;
  end;
end;

procedure TFrmPessoa.RdgFisicoJuridicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'RdgFisicoJuridicoClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  MkeNrCpfCnpj.Clear;

  if RdgFisicoJuridico.ItemIndex = 0 then
  begin
    LblNmCpfCnpj.Caption            := 'N� CPF:';
    LblPessoaRazaoSocial.Caption    := 'Pessoa:';
    LblNmRGIE.Caption               := 'N� RG:';
    MkeNrCpfCnpj.Properties.EditMask := '000\.000\.000\-00;1;_';
  end
  else
  if RdgFisicoJuridico.ItemIndex = 1 then
  begin
    LblNmCpfCnpj.Caption          := 'N� CNPJ:';
    LblPessoaRazaoSocial.Caption  := 'Raz�o Social:';
    LblNmRGIE.Caption             := 'N� IE:';
    MkeNrCpfCnpj.Properties.EditMask := '00\.000\.000\/0000\-00;1;_';
  end;
end;

end.
