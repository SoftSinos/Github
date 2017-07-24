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
    Label14                 : TLabel;
    LblDtNascFund           : TLabel;
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
    DtsPesquisa             : TDataSource;
    CdsPesquisa             : TClientDataSet;
    BtnEmpresaPesquisa      : TcxButton;
    BtnTipoPessoaPesquisa   : TcxButton;
    CbbIdEmpresa            : TcxComboBox;
    CbbIdTpPessoa           : TcxComboBox;
    LblPessoaRazaoSocial    : TLabel;
    ImgImPessoa             : TcxDBImage;
    BtnWebCam               : TcxButton;
    BtnLocal                : TcxButton;
    BtnSalvarImPessoa       : TcxButton;
    MkeNrFixo               : TcxMaskEdit;
    MkeNrWhatsApp           : TcxMaskEdit;
    MkeNrCelular2           : TcxMaskEdit;
    MkeNrCelular            : TcxMaskEdit;
    EdtNmPessoa             : TcxTextEdit;
    EdtNrRgIe               : TcxTextEdit;
    EdtNmApelido            : TcxTextEdit;
    DtsRetorno              : TDataSource;
    MkeNrCpfCnpj            : TcxMaskEdit;
    PgcExtra                : TPageControl;
    TbsEndereco             : TTabSheet;
    GroupBox1               : TGroupBox;
    Label8                  : TLabel;
    Label15                 : TLabel;
    Label16                 : TLabel;
    Label13                 : TLabel;
    Label17                 : TLabel;
    Label5                  : TLabel;
    Label10                 : TLabel;
    BtnCepPesquisa: TcxButton;
    EdtNmComplemento: TcxTextEdit;
    MkeNrCep: TcxMaskEdit;
    EdtNmCidade: TcxTextEdit;
    EdtNmUf: TcxTextEdit;
    EdtNrNumero: TcxTextEdit;
    EdtNmBairro: TcxTextEdit;
    EdtNmEndereco: TcxTextEdit;
    TbsRedeSocial: TTabSheet;
    GroupBox3: TGroupBox;
    Label24: TLabel;
    Label28: TLabel;
    Label18: TLabel;
    Label7: TLabel;
    EdtImPessoa: TcxTextEdit;
    EdtNmEmail: TcxTextEdit;
    EdtNmFacebook: TcxTextEdit;
    EdtNmInstagran: TcxTextEdit;
    TbsObservacao: TTabSheet;
    GroupBox4: TGroupBox;
    Label3: TLabel;
    MemObservacao: TcxMemo;
    TbsProfissional: TTabSheet;
    GroupBox5: TGroupBox;
    Panel1: TPanel;
    Label19: TLabel;
    Label22: TLabel;
    Label20: TLabel;
    Label26: TLabel;
    MkePcComissao: TcxMaskEdit;
    BtnGrupoServicoPesquisa: TcxButton;
    BtnServicoPesquisa: TcxButton;
    EdtIdServico: TcxTextEdit;
    CbbIdGrupoServico: TcxComboBox;
    CbbIdTpServico: TcxComboBox;
    ChkServicoSnSituacao: TcxCheckBox;
    Panel3: TPanel;
    BtnSalvarServico: TcxButton;
    BtnAgendar: TcxButton;
    BtnAnularAgenda: TcxButton;
    DbgPesquisa: TDBGrid;
    RdgFisicoJuridico: TRadioGroup;
    LblNmApelido: TLabel;
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
    procedure BtnSalvarServicoClick(Sender: TObject);
    procedure DbgPesquisaDblClick(Sender: TObject);
    procedure CbbIdGrupoServicoClick(Sender: TObject);
    procedure BtnGrupoServicoPesquisaClick(Sender: TObject);
    procedure BtnSalvarImPessoaClick(Sender: TObject);
    procedure RdgFisicoJuridicoClick(Sender: TObject);
    procedure MkeNrCpfCnpjPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure MkeNrFixoPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure MkeNrCelularPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure MkeNrCelular2PropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure MkeNrWhatsAppPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure MkeNrCepPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure BtnAgendarClick(Sender: TObject);
    procedure BtnAnularAgendaClick(Sender: TObject);
    procedure EdtNmApelidoExit(Sender: TObject);
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
  FrmPessoa: TFrmPessoa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, fAjuda, uPessoa, uTipoPessoa, uCep, fWebCam, fTipoPessoaPesquisa, fCepPesquisa, fEmpresaPesquisa,
  fServicoPesquisa, uServico, fGrupoServicoPesquisa;

var
  unPessoa         : TPessoa;
  unTipoPessoa     : TTipoPessoa;
  unCarregaDados   : TCarregaDados;
  unCep            : TCep;
  unServico        : TServico;
  LimpaArquivo     : String;
  lTpChamadaClasse : Boolean;

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
    CbbIdGrupoServicoClick(Sender)
  end;
end;

procedure TFrmPessoa.BtnAgendarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAgendaRClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    uProcedure.Agendar(Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]), Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]), StrToInt(EdtIdRegistro.Text), FormatDateTime('YYYY', Now), 0, 'Profissional');
  finally
    MsgInformacao(uMensagem.AgendaGeradaComSucesso);
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
    FrmAjuda.Caption        := 'Ajuda Sobre à Tela de ' +  Caption;
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

procedure TFrmPessoa.BtnAnularAgendaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnularAgendaClick';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    uProcedure.Agendar(0, Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]), StrToInt(EdtIdRegistro.Text), '', 0, 'DeletaProfissional');
  finally
    MsgInformacao(uMensagem.AnuladaAgenda);
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
    CarregarTela('Empresa');
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
    CarregarTela('GrupoServico');
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

  InicializarTela;
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
        MkeNrCelular.Enabled        := False;
        inherited;

        CbbIdEmpresa.Style.Color      := clWindow;
        CbbIdTpPessoa.Style.Color     := clWindow;
        EdtNmPessoa.Style.Color       := clWindow;
        RdgFisicoJuridico.Color       := clWindow;
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
      RdgFisicoJuridico.Color       := clHighlight;
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
    unServico.CarregaDbGrid(DtmPrincipal.Conexao, False, 2, 0, 0, '', CdsPesquisa);

    if (Integer(CbbIdGrupoServico.Properties.Items.Objects[CbbIdGrupoServico.ItemIndex]) > 0) and (Integer(CbbIdTpServico.Properties.Items.Objects[CbbIdTpServico.ItemIndex]) > 0) and (Trim(MkePcComissao.EditText) <> '') then
    begin
      if Trim(EdtIdServico.Text) <> '' then
      begin
        unServico.IdServico         := StrToInt(EdtIdServico.Text);
      end
      else
      begin
        unServico.IdServico         := 0;
      end;
      unServico.IdUsuario           := DtmPrincipal.IdUsuarioLogado;
      unServico.DtCadastro          := Now;
      if ChkServicoSnSituacao.Checked then
      begin
        unServico.SnSituacao        := 1;
      end
      else
      begin
        unServico.SnSituacao        := 0;
      end;
      unServico.IdProfissional      := StrToInt(EdtIdRegistro.Text);
      unServico.IdEmpProfissional   := Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]);
      unServico.IdTpServico         := Integer(CbbIdTpServico.Properties.Items.Objects[CbbIdTpServico.ItemIndex]);
      unServico.PcComissao          := StrToFloat(MkePcComissao.Text);

      if unServico.Salvar(DtmPrincipal.Conexao) then
      begin
        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);
        unServico.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, 0, EdtNmPessoa.Text, CdsPesquisa);
        CbbIdTpServico.ItemIndex    := 0;
        CbbIdGrupoServico.ItemIndex := 0;
        CbbIdTpServico.Properties.Items.Clear;
        CbbIdTpServico.Enabled      := False;
        MkePcComissao.Clear;
        EdtIdServico.Clear;
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
    CbbIdTpPessoa.Properties.Items.Clear;
    CarregarTela('TipoPessoa');
  end;
end;

procedure TFrmPessoa.BtnWebCamClick(Sender: TObject);
var
  DirNomeFoto : string;
  NomeFoto    : string;
  procedure ConverteParaJpeg(ANomeFoto: string);
  var
    cjBmp : TBitmap;
    cjJpg : TJpegImage;
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

procedure TFrmPessoa.CarregarTela(ATpChamadaClasse:String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  if ATpChamadaClasse = 'Geral' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', '', CbbIdEmpresa);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'TipoPessoa', 0, '', '', '',  CbbIdTpPessoa);
  end
  else
  if ATpChamadaClasse = 'Empresa' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', '', CbbIdEmpresa);
  end
  else
  if ATpChamadaClasse = 'TipoPessoa' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'TipoPessoa', 0, '', '', '',  CbbIdTpPessoa);
  end
  else
  if ATpChamadaClasse = 'GrupoServico' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'GrupoServico', 0, '', '', '', CbbIdGrupoServico);
  end;
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
        CarregarTela('GrupoServico');
        unServico.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, 0, EdtNmPessoa.Text, CdsPesquisa);
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

    lTpChamadaClasse := True;

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
      if unPessoa.BuscarImagem(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text), CdsCopula) then
      begin
        ImgImPessoa.DataBinding.DataField := 'ImPessoa';
      end;
    end;
  finally
    lTpChamadaClasse := False;
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

procedure TFrmPessoa.EdtNmApelidoExit(Sender: TObject);
begin
  inherited;
  if RdgFisicoJuridico.ItemIndex <= -1 then
  begin
    MsgAtencao(uMensagem.InformarOTipoCadastro)
  end;
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
    CbbIdEmpresa.Enabled       := False;
    CbbIdEmpresa.ItemIndex     := Integer(CbbIdEmpresa.Properties.Items.IndexOf(DtmPrincipal.NmFantasiaNmRazaoSocial));
    EdtNmPessoa.SetFocus;
    BtnEmpresaPesquisa.Enabled := False;
  end
  else
  begin
    CbbIdEmpresa.Enabled       := true;
    CbbIdEmpresa.SetFocus;
    BtnEmpresaPesquisa.Enabled := True;
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
  end
  else
  begin
    EdtNmPessoa.SetFocus;
  end;
  EdtNmPessoa.Clear;
  EdtNmApelido.Clear;
  CbbIdTpPessoa.ItemIndex         := 0;
  CbbIdGrupoServico.ItemIndex     := 0;
  BtnWebCam.Enabled               := False;
  BtnLocal.Enabled                := False;
  MkeNrCelular.Enabled            := True;
  MkeNrCep.Clear;
  MkeNrCpfCnpj.Clear;
  MkeNrCpfCnpj.Enabled            := False;
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

procedure TFrmPessoa.MkeNrCelular2PropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCelular2PropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 11) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end;
end;

procedure TFrmPessoa.MkeNrCelularPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCelularPropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 11) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end;
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

procedure TFrmPessoa.MkeNrCepPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCepPropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 8) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end;
end;

procedure TFrmPessoa.MkeNrCpfCnpjExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCpfExit';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if not (VerificaCpfCnpj(MkeNrCpfCnpj.Text)) and (Trim(MkeNrCpfCnpj.Text) <> '') then
  begin
    if RdgFisicoJuridico.ItemIndex = 0 then
    begin
      MsgAtencao(uMensagem.OCPFInformadoEInvalido);
      MkeNrCpfCnpj.Clear;
    end
    else
    if RdgFisicoJuridico.ItemIndex = 1 then
    begin
      MsgAtencao(uMensagem.OCNPJInformadoEInvalido);
      MkeNrCpfCnpj.Clear;
    end;
  end;
end;

procedure TFrmPessoa.MkeNrCpfCnpjPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrCpfCnpjPropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 11) and (RdgFisicoJuridico.ItemIndex = 0) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end
  else
  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 14) and (RdgFisicoJuridico.ItemIndex = 1) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end;
end;

procedure TFrmPessoa.MkeNrFixoPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrFixoPropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 10) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end;
end;

procedure TFrmPessoa.MkeNrWhatsAppPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'MkeNrWhatsAppPropertiesValidate';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 11) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
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
    LblNmCpfCnpj.Caption             := 'Nº CPF:';
    LblPessoaRazaoSocial.Caption     := 'Pessoa:';
    LblNmRGIE.Caption                := 'Nº RG:';
    LblDtNascFund.Caption            := 'Dt Nasc.:';
    LblNmApelido.Caption             := 'Apelido:';
    MkeNrCpfCnpj.Properties.EditMask := '000\.000\.000\-00;1;_';
    MkeNrCpfCnpj.Enabled             := True;
    Edicao;
  end
  else
  if RdgFisicoJuridico.ItemIndex = 1 then
  begin
    LblNmCpfCnpj.Caption             := 'Nº CNPJ:';
    LblPessoaRazaoSocial.Caption     := 'Razão Social:';
    LblNmRGIE.Caption                := 'Nº IE:';
    LblDtNascFund.Caption            := 'Dt Fund.:';
    LblNmApelido.Caption             := 'Fantasia:';
    MkeNrCpfCnpj.Properties.EditMask := '00\.000\.000\/0000\-00;1;_';
    MkeNrCpfCnpj.Enabled             := True;
    Edicao;
  end;
end;

end.
