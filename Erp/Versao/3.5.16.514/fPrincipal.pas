unit fPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Graphics, Vcl.Dialogs, Vcl.Touch.Keyboard, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, dPrincipal, uFuncao, Vcl.Menus,
  Vcl.ImgList, Vcl.ToolWin, Vcl.Buttons, Jpeg, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Contnrs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Imaging.pngimage, ShellApi, dxGDIPlusClasses, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, Vcl.ButtonGroup, Vcl.Themes, ClipBrd;

type
  TFrmPrincipal = class(TForm)
    StbPrincipal                  : TStatusBar;
    ImgPrincipal                  : TImage;
    MenPrincipal                  : TMainMenu;
    MenAvancados                  : TMenuItem;
    MenCadConfiguracaoSistema     : TMenuItem;
    MenAjudas                     : TMenuItem;
    MenPessoas                    : TMenuItem;
    MenCadPessoa                  : TMenuItem;
    MenCadCalendario              : TMenuItem;
    MenServicos                   : TMenuItem;
    MenRelatorios                 : TMenuItem;
    MenProdutos                   : TMenuItem;
    MenAgendas                    : TMenuItem;
    MenCadUsuario                 : TMenuItem;
    MenTelLogin                   : TMenuItem;
    MenSaiSair                    : TMenuItem;
    MenComPessoas                 : TMenuItem;
    MenSobSobre                   : TMenuItem;
    MenSupAtenderRemoto           : TMenuItem;
    TimPrincipal                  : TTimer;
    MenCadEmpresa                 : TMenuItem;
    MenBkpBackupSistema           : TMenuItem;
    PgcPrincipal                  : TPageControl;
    ToolBar1                      : TToolBar;
    ToolButton1                   : TToolButton;
    MenSupBaixaSuporte            : TMenuItem;
    MenRelPessoas                 : TMenuItem;
    ImgListPrincipal              : TImageList;
    MenSupLiberarAcesso           : TMenuItem;
    MenPapPapelParede             : TMenuItem;
    MenInfInformacoes             : TMenuItem;
    MenLogLogSistema              : TMenuItem;
    MenCadTipoPessoa              : TMenuItem;
    MenCadCidade                  : TMenuItem;
    MenCadCep                     : TMenuItem;
    MenRelServicos                : TMenuItem;
    MenRelProdutos                : TMenuItem;
    MenRelOperacoes               : TMenuItem;
    MenComServicos                : TMenuItem;
    MenComProdutos                : TMenuItem;
    MenSqlBancoDados              : TMenuItem;
    MenSqlEditorBancoDados        : TMenuItem;
    MenCadTipoServico             : TMenuItem;
    MenCadServico                 : TMenuItem;
    FrmToolBar                    : TToolBar;
    ImgPessoas                    : TcxButton;
    ToolButton12                  : TToolButton;
    ImgProdutos                   : TcxButton;
    ToolButton4                   : TToolButton;
    ImgNotaStarter                : TcxButton;
    ToolButton6                   : TToolButton;
    ImgAgendaStarter              : TcxButton;
    ToolButton10                  : TToolButton;
    ImgConexao                    : TcxButton;
    ToolButton5                   : TToolButton;
    ImgBackup                     : TcxButton;
    ToolButton9                   : TToolButton;
    ImgLoginSistema               : TcxButton;
    ToolButton11                  : TToolButton;
    ImgSair                       : TcxButton;
    ToolButton13                  : TToolButton;
    MenCadMarca                   : TMenuItem;
    MenCadGrupoProduto            : TMenuItem;
    MenCadProduto                 : TMenuItem;
    MenOperacoes                  : TMenuItem;
    MenComOperacoes               : TMenuItem;
    MenCadTipoPagamento           : TMenuItem;
    MenCadOperacoesStarter        : TMenuItem;
    MenPesNotas                   : TMenuItem;
    MenCadAgendaStarter           : TMenuItem;
    MenAtiSistema                 : TMenuItem;
    N10                           : TMenuItem;
    MenCadGrupoServico            : TMenuItem;
    MenCargaDados                 : TMenuItem;
    N11                           : TMenuItem;
    MenExecutarScriptSQL          : TMenuItem;
    MenManManualSginERP           : TMenuItem;
    N14                           : TMenuItem;
    N25                           : TMenuItem;
    MenComAgenda                  : TMenuItem;
    N40                           : TMenuItem;
    MenCadAgendaGeral             : TMenuItem;
    N41                           : TMenuItem;
    ImgPainel                     : TcxButton;
    ToolButton3                   : TToolButton;
    MenPnlPainelDiario            : TMenuItem;
    RelClientes                   : TMenuItem;
    RelServicos                   : TMenuItem;
    RelProdutos                   : TMenuItem;
    RelFinanceiros                : TMenuItem;
    ImgNotaPesquisa               : TcxButton;
    ToolButton7                   : TToolButton;
    MenCadNotaEntradaEstoque: TMenuItem;
    N13: TMenuItem;
    MenContas: TMenuItem;
    MenCadDespesas: TMenuItem;
    N31: TMenuItem;
    MenCadBaixaParcelas: TMenuItem;
    MenCaixa: TMenuItem;
    MenCadSuprimento: TMenuItem;
    MenCadSangria: TMenuItem;
    N37: TMenuItem;
    MenCadFecharCaixa: TMenuItem;
    MenCadPessoaCompleto: TMenuItem;
    MenCadClienteRapido: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure BtnSairClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure MenSaiSairClick(Sender: TObject);
    procedure MenSenhaClick(Sender: TObject);
    procedure MenCadEmpresaClick(Sender: TObject);
    procedure MenCadUsuarioClick(Sender: TObject);
    procedure MenTelLoginClick(Sender: TObject);
    procedure MenSobSobreClick(Sender: TObject);
    procedure MenCadCalendarioClick(Sender: TObject);
    procedure TimPrincipalTimer(Sender: TObject);
    procedure ImgLoginSistemaClick(Sender: TObject);
    procedure MenCadConfiguracaoSistemaClick(Sender: TObject);
    procedure MenSupBaixaSuporteClick(Sender: TObject);
    procedure MenBkpBackupSistemaClick(Sender: TObject);
    procedure ImgSairClick(Sender: TObject);
    procedure ImgConexaoClick(Sender: TObject);
    procedure MenSupLiberarAcessoClick(Sender: TObject);
    procedure ImgBackupClick(Sender: TObject);
    procedure MenPastaCopiaSegurancaClick(Sender: TObject);
    procedure MenPapPapelParedeClick(Sender: TObject);
    procedure MenInfInformacoesClick(Sender: TObject);
    procedure MenLogLogSistemaClick(Sender: TObject);
    procedure MenCadTipoPessoaClick(Sender: TObject);
    procedure MenCadCidadeClick(Sender: TObject);
    procedure MenRelatoriosCadastroClick(Sender: TObject);
    procedure MenCadCepClick(Sender: TObject);
    procedure ImgPessoasClick(Sender: TObject);
    procedure MenSqlEditorBancoDadosClick(Sender: TObject);
    procedure MenCadTipoServicoClick(Sender: TObject);
    procedure MenCadServicoClick(Sender: TObject);
    procedure MenCadMarcaClick(Sender: TObject);
    procedure MenCadGrupoProdutoClick(Sender: TObject);
    procedure MenCadProdutoClick(Sender: TObject);
    procedure ImgProdutosClick(Sender: TObject);
    procedure MenCadTipoPagamentoClick(Sender: TObject);
    procedure MenCadOperacoesStarterClick(Sender: TObject);
    procedure MenPesNotasClick(Sender: TObject);
    procedure MenCadAgendaStarterClick(Sender: TObject);
    procedure ImgNotaStarterClick(Sender: TObject);
    procedure ImgAgendaStarterClick(Sender: TObject);
    procedure MenAtiSistemaClick(Sender: TObject);
    procedure MenCadGrupoServicoClick(Sender: TObject);
    procedure MenCargaDadosClick(Sender: TObject);
    procedure MenExecutarScriptSQLClick(Sender: TObject);
    procedure MenManManualSginERPClick(Sender: TObject);
    procedure MenCadAgendaGeralClick(Sender: TObject);
    procedure MenPnlPainelDiarioClick(Sender: TObject);
    procedure ImgPainelClick(Sender: TObject);
    procedure RelClientesClick(Sender: TObject);
    procedure RelServicosClick(Sender: TObject);
    procedure RelProdutosClick(Sender: TObject);
    procedure RelFinanceirosClick(Sender: TObject);
    procedure ImgNotaPesquisaClick(Sender: TObject);
    procedure MenCadNotaEntradaEstoqueClick(Sender: TObject);
    procedure MenCadDespesasClick(Sender: TObject);
    procedure MenCadBaixaParcelasClick(Sender: TObject);
    procedure MenCadPessoaCompletoClick(Sender: TObject);
    procedure MenCadClienteRapidoClick(Sender: TObject);
   private
    { Private declarations }
    procedure InicializarTela;
    procedure PermissaoAcesso;
  public
    { Public declarations }
    TasConsumo      : TTabSheet;
    TasAgenda       : TTabSheet;
    TasLog          : TTabSheet;
    TasPainel       : TTabSheet;
    TasConsultaNota : TTabSheet;
    procedure PgcVisivel;
    procedure Relatorios(NmTpMenu: String; NmTpRelatorio: String; NmTitulo: String; NmLabel1: String);
    procedure UsuarioAdministrador(Verificar :Boolean);
    Procedure ManipulaErros(Sender: TObject; E: Exception);
  published
    property Menu;
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses dRelatorios, uMensagem, uEmpresa, uProcedure, fCopiaSeguranca, fEmpresa, fLogin, fSplash, fSobre, fInformacoes, fProcessando, fConfiguracaoPesquisa, fLogPesquisa,
  fCalendarioPesquisa, fEmpresaPesquisa, fUsuarioPesquisa, fTipoPessoaPesquisa, fCepPesquisa, fCidadePesquisa, fPessoaPesquisa, fTipoServicoPesquisa, fServicoPesquisa,
  fMarcaPesquisa, fGrupoProdutoPesquisa, fProdutoPesquisa, fTipoPagamentoPesquisa, fNotaConsumoStarter, fNotaPesquisa, fAgendaStarter, fAtivacaoSistema, uLicenca, uAtivacao,
  fGrupoServicoPesquisa, fExecutaScriptSQL, fAbrirAgendaGeral, fPainelDiario, fPessoaRelatorio, fServicoRelatorio, fProdutoRelatorio, fTipoPagamentoRelatorio, dMail,
  fNotaEntradaEstoque, fDespesas, fBaixaParcelas, fPessoaRapido;

var
  FrmLogin   : TFrmLogin;
  FrmEmpresa : TFrmEmpresa;
  unLicenca  : TLicenca;
  unAtivacao : TAtivacao;

procedure TFrmPrincipal.BtnSairClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSairClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if MsgConfirmacao(uMensagem.DesejaFinalizarOSistema) then
  begin
    FinalizarAplicacao(DtmPrincipal.NmExecutavel);
  end;
end;

procedure TFrmPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if MsgConfirmacao(uMensagem.DesejaFinalizarOSistema) then
  begin
    if DebugHook = 0 then
    begin
      DtmPrincipal.unLog.NmOperacao := 'Entrou';
      DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
      DtmPrincipal.unLog.NmMetodo   := 'FncEnvioEmail';
      DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
      DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

      DtmEmail.GerarEmail('log@softsinos.com.br',
                           DtmPrincipal.NmFantasiaNmRazaoSocial,
                          'Finaliza��o da Aplica��o',
                          'Cliente: ' + DtmPrincipal.NmFantasiaNmRazaoSocial + #13 + 'Usu�rio: ' + DtmPrincipal.NmUsuario + #13 + 'Opera��o: Autentica��o de Usu�rio' + #13 + 'Dia: ' + DateToStr(Now) + #13 + 'Hor�rio: ' + TimeToStr(Now),
                           False,
                           False);
    end;
    FinalizarAplicacao(DtmPrincipal.NmExecutavel);
  end;
  abort;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
var
  ExisteCadastroEmpresa : TEmpresa;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Application.OnException := ManipulaErros;

  unLicenca  := TLicenca.Create;
  unAtivacao := TAtivacao.Create;

  if Trim(DtmPrincipal.NmStylesApp) <> '' then
  begin
    TStyleManager.TrySetStyle(DtmPrincipal.NmStylesApp);
  end;

  PermissaoAcesso;

  ExisteCadastroEmpresa := TEmpresa.Create;

  try
    FrmSplash                         := TFrmSplash.Create(Application);
    DtmPrincipal.NrVersaoBd           := VersaoBd(DtmPrincipal.Conexao);
    FrmSplash.LblVersaoSplash.Caption := 'Aplica��o: ' + VersaoExecutavel(DtmPrincipal.NmCaminhoExecutavel + DtmPrincipal.NmExecutavel) + #13 + 'Banco de Dados: ' + DtmPrincipal.NrVersaoBd;

    FrmSplash.ShowModal;
  finally
    FrmSplash.Free;
  end;

  if FileExists('Imagem/Sistema/Principal.jpg') then
  begin
    ImgPrincipal.Picture.LoadFromFile('Imagem/Sistema/Principal.jpg');
  end;

  if ExisteCadastroEmpresa.ExisteCadastro(DtmPrincipal.Conexao) then
  begin
    try
      FrmLogin := TFrmLogin.Create(Self);
      FrmLogin.LblLicencaLogin.Caption:= DtmPrincipal.NmSubModulo;
    finally

    end;
  end
  else
  begin
    if MsgConfirmacao(uMensagem.NaoExisteCadastroDeEmpresa) then
    begin
      try
        FrmEmpresa := TFrmEmpresa.Create(Application);
        FrmEmpresa.BtnIncluir.Enabled   := False;
        FrmEmpresa.BtnSalvar.Enabled    := True;
        FrmEmpresa.BtnCancelar.Enabled  := True;
        FrmEmpresa.BtnFechar.Enabled    := True;
        FrmEmpresa.ShowModal;
        MsgAtencao(uMensagem.OSistemaSeraFinalizado);
        FinalizarAplicacao(DtmPrincipal.NmExecutavel);
      finally
        FrmEmpresa.Free;
      end;
    end
    else
    begin
      FinalizarAplicacao(DtmPrincipal.NmExecutavel);
    end;
  end;
end;

procedure TFrmPrincipal.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmLogin.ShowModal;
  InicializarTela;
end;

procedure TFrmPrincipal.ImgConexaoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ImgConexaoClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  MenSupLiberarAcessoClick(Sender);
end;

procedure TFrmPrincipal.ImgBackupClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ImgBackupClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  MenBkpBackupSistemaClick(Sender);
end;

procedure TFrmPrincipal.ImgAgendaStarterClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ImgAgendaStarterClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  MenCadAgendaStarterClick(Sender);
end;

procedure TFrmPrincipal.ImgPainelClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ImgPainelClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  MenPnlPainelDiarioClick(Sender);
end;

procedure TFrmPrincipal.ImgPessoasClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ImgPessoaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  MenCadClienteRapidoClick(Sender);
end;


procedure TFrmPrincipal.ImgProdutosClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ImgProdutosClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  MenCadProdutoClick(Sender);
end;

procedure TFrmPrincipal.ImgLoginSistemaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ImgLoginSistemaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  MenTelLoginClick(Sender);
end;

procedure TFrmPrincipal.ImgNotaPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ImgNotaPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  MenPesNotasClick(Sender);
end;

procedure TFrmPrincipal.ImgNotaStarterClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ImgNotaStarterClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  MenCadOperacoesStarterClick(Sender);
end;

procedure TFrmPrincipal.ImgSairClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ImgSairClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if MsgConfirmacao(uMensagem.DesejaFinalizarOSistema) then
  begin
    if DebugHook = 0 then
    begin
      DtmPrincipal.unLog.NmOperacao := 'Entrou';
      DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
      DtmPrincipal.unLog.NmMetodo   := 'FncEnvioEmail';
      DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
      DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

      DtmEmail.GerarEmail('log@softsinos.com.br',
                           DtmPrincipal.NmFantasiaNmRazaoSocial,
                          'Finaliza��o da Aplica��o',
                          'Cliente: ' + DtmPrincipal.NmFantasiaNmRazaoSocial + #13 + 'Usu�rio: ' + DtmPrincipal.NmUsuario + #13 + 'Opera��o: Autentica��o de Usu�rio' + #13 + 'Dia: ' + DateToStr(Now) + #13 + 'Hor�rio: ' + TimeToStr(Now),
                           False,
                           False);
    end;
    FinalizarAplicacao(DtmPrincipal.NmExecutavel);
  end;
end;

procedure TFrmPrincipal.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  StbPrincipal.Panels[2].Text := 'Servidor: ' + DtmPrincipal.NmHost + '\' + DtmPrincipal.NmBanco;
end;

procedure TFrmPrincipal.MenSqlEditorBancoDadosClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenEditorBancoDadosClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  WinExec('Ssms.exe', SW_NORMAL);
end;

procedure TFrmPrincipal.MenCadEmpresaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadEmpresaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmEmpresaPesquisa := TFrmEmpresaPesquisa.Create(Application);
    FrmEmpresaPesquisa.ShowModal;
  finally
    FrmEmpresaPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadGrupoProdutoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadGrupoProdutoClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmGrupoProdutoPesquisa := TFrmGrupoProdutoPesquisa.Create(Application);
    FrmGrupoProdutoPesquisa.ShowModal;
  finally
    FrmGrupoProdutoPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadGrupoServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadGrupoServicoClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmGrupoServicoPesquisa := TFrmGrupoServicoPesquisa.Create(Application);
    FrmGrupoServicoPesquisa.ShowModal;
  finally
    FrmGrupoServicoPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadUsuarioClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadUsuarioClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmUsuarioPesquisa := TFrmUsuarioPesquisa.Create(Application);
    FrmUsuarioPesquisa.ShowModal;
  finally
    FrmUsuarioPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadTipoPagamentoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadTipoPagamentoClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmTipoPagamentoPesquisa := TFrmTipoPagamentoPesquisa.Create(Application);
    FrmTipoPagamentoPesquisa.ShowModal;
  finally
    FrmTipoPagamentoPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadCalendarioClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadCalendarioClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmCalendarioPesquisa := TFrmCalendarioPesquisa.Create(Application);
    FrmCalendarioPesquisa.ShowModal;
  finally
    FrmCalendarioPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadConfiguracaoSistemaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadConfiguracaoSistemaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmConfiguracaoPesquisa := TFrmConfiguracaoPesquisa.Create(Application);
    FrmConfiguracaoPesquisa.ShowModal;
  finally
    FrmConfiguracaoPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadDespesasClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadDespesasClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmDespesas := TFrmDespesas.Create(Application);
    FrmDespesas.ShowModal;
  finally
    FrmDespesas.Free;
  end;
end;

procedure TFrmPrincipal.MenLogLogSistemaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenLogLogSistemaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if TasLog = Nil then
    begin
      TasLog             := TTabSheet.Create(PgcPrincipal);
      TasLog.Caption     := 'Log do Sistema';
      TasLog.PageControl := FrmPrincipal.PgcPrincipal;
    end
    else
    begin
      TasLog.TabVisible  := True;
    end;

    PgcPrincipal.Visible    := True;
    PgcPrincipal.ActivePage := TasLog;
    Application.CreateForm(TFrmLogPesquisa, FrmLogPesquisa);
    FrmLogPesquisa.Parent := FrmPrincipal.TasLog;
    FrmLogPesquisa.Show;
  finally

  end;
end;

procedure TFrmPrincipal.MenManManualSginERPClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenManManualSginERPClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);


  if FileExists(DtmPrincipal.NmCaminhoExecutavel + 'SginERPHelp.chm') then
  begin
    HtmlHelp(Screen.ActiveForm.Handle, PChar('SginERPHelp.chm'), $F, Screen.ActiveForm.HelpContext )
  end
  else
  begin
    MsgErro(uMensagem.OArquivoNaoExisteOuNaoLocalizado);
  end;
end;

procedure TFrmPrincipal.MenPapPapelParedeClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenPapPapelParedeClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  AbrirExplorer(DtmPrincipal.NmCaminhoExecutavel + 'Imagem\Sistema', True, True);
end;

procedure TFrmPrincipal.MenInfInformacoesClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenInfInformacoesClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmInformacoes := TFrmInformacoes.Create(Application);
    FrmInformacoes.ShowModal;
  finally
    FrmInformacoes.Free;
  end;
end;

procedure TFrmPrincipal.MenPastaCopiaSegurancaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenPastaCopiaSegurancaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  AbrirExplorer(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca', True, True);
end;

procedure TFrmPrincipal.MenPesNotasClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenPesNotasClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if TasConsultaNota = Nil then
    begin
      TasConsultaNota             := TTabSheet.Create(PgcPrincipal);
      TasConsultaNota.Caption     := 'Consultar Lan�amentos';
      TasConsultaNota.PageControl := FrmPrincipal.PgcPrincipal;
    end
    else
    begin
      TasConsultaNota.TabVisible  := True;
    end;

    PgcPrincipal.Visible    := True;
    PgcPrincipal.ActivePage := TasConsultaNota;
    Application.CreateForm(TFrmNotaPesquisa, FrmNotaPesquisa);
    FrmNotaPesquisa.Parent  := FrmPrincipal.TasConsultaNota;
    FrmNotaPesquisa.Show;
  finally

  end;
end;

procedure TFrmPrincipal.MenPnlPainelDiarioClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadAgendaStarterClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if TasPainel = Nil then
    begin
      TasPainel             := TTabSheet.Create(PgcPrincipal);
      TasPainel.Caption     := 'Painel Di�rio';
      TasPainel.PageControl := FrmPrincipal.PgcPrincipal;
    end
    else
    begin
      TasPainel.TabVisible  := True;
    end;

    PgcPrincipal.Visible    := True;
    PgcPrincipal.ActivePage := TasPainel;
    Application.CreateForm(TFrmPainelDiario, FrmPainelDiario);
    FrmPainelDiario.Parent := FrmPrincipal.TasPainel;
    FrmPainelDiario.Show;
  finally

  end;
end;

procedure TFrmPrincipal.MenCadBaixaParcelasClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadPagamentoClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmBaixaParcelas := TFrmBaixaParcelas.Create(Application);
    FrmBaixaParcelas.ShowModal;
  finally
    FrmBaixaParcelas.Free;
  end;
end;


procedure TFrmPrincipal.MenCadProdutoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadProdutoClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmProdutoPesquisa := TFrmProdutoPesquisa.Create(Application);
    FrmProdutoPesquisa.ShowModal;
  finally
    FrmProdutoPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadServicoClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmServicoPesquisa := TFrmServicoPesquisa.Create(Application);
    FrmServicoPesquisa.ShowModal;
  finally
    FrmServicoPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenRelatoriosCadastroClick(Sender: TObject);
begin
  MsgAtencao(uMensagem.TelaASerImplementada);
end;

procedure TFrmPrincipal.MenSaiSairClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenSaiSairClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if MsgConfirmacao(uMensagem.DesejaFinalizarOSistema) then
  begin
    FinalizarAplicacao(DtmPrincipal.NmExecutavel);
  end;
end;

procedure TFrmPrincipal.ManipulaErros(Sender: TObject; E: Exception);
var
  BitMap  : TBitmap;
  JPeg    : TJPEGImage;
  Arquivo : String;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ManipulaErros';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    BitMap  := TBitmap.Create;
    Clipboard.Clear;
    Keybd_event(vk_snapshot,0, 0, 0);
    Application.ProcessMessages;
    BitMap.LoadFromClipboardFormat(CF_BITMAP,clipboard.GetAsHandle(CF_BITMAP),0);
    JPeg    := TJPEGImage.Create;
    JPeg.Assign(BitMap);

    Arquivo := FormatDateTime('HHMMss',Time);

    JPeg.SaveToFile(DtmPrincipal.NmCaminhoLog + '\' + Arquivo + '_' + E.Message + '.jpg');
  finally
    MsgErro(uMensagem.EntrarEmContatoComOSuporte + #13 + #13 + E.Message);
  end;
end;

procedure TFrmPrincipal.MenAtiSistemaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenAtiSistemaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmAtivacaoSistema                    := TFrmAtivacaoSistema.Create(Application);
    FrmAtivacaoSistema.BtnIncluir.Enabled := False;
    FrmAtivacaoSistema.ShowModal;
  finally
    FrmSobre.Free;
  end;
end;

procedure TFrmPrincipal.MenBkpBackupSistemaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenBkpBackupSistemaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmCopiaSeguranca := TFrmCopiaSeguranca.Create(Application);
    FrmCopiaSeguranca.ShowModal;
  finally
    FrmCopiaSeguranca.Free;
  end;
end;

procedure TFrmPrincipal.MenSenhaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenSenhaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmLogin := TFrmLogin.Create(Application);
    FrmLogin.ShowModal;
  finally
    FrmLogin.Free;
  end;
end;

procedure TFrmPrincipal.MenSobSobreClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenSobSobreClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmSobre := TFrmSobre.Create(Application);
    FrmSobre.ShowModal;
  finally
    FrmSobre.Free;
  end;
end;

procedure TFrmPrincipal.MenCadTipoPessoaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadTipoPessoaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmTipoPessoaPesquisa := TFrmTipoPessoaPesquisa.Create(Application);
    FrmTipoPessoaPesquisa.ShowModal;
  finally
    FrmTipoPessoaPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadTipoServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadTipoServicoClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmTipoServicoPesquisa := TFrmTipoServicoPesquisa.Create(Application);
    FrmTipoServicoPesquisa.ShowModal;
  finally
    FrmTipoServicoPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.TimPrincipalTimer(Sender: TObject);
begin
  StbPrincipal.Panels[0].Text := FormatDateTime('hh:mm:ss', Now);
end;

procedure TFrmPrincipal.UsuarioAdministrador(Verificar: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'UsuarioAdministrador';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

end;

procedure TFrmPrincipal.MenCadOperacoesStarterClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadOperacoesStarterClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if TasConsumo = Nil then
    begin
      TasConsumo             := TTabSheet.Create(PgcPrincipal);
      TasConsumo.Caption     := 'Lan�amento de Consumo';
      TasConsumo.PageControl := FrmPrincipal.PgcPrincipal;
    end
    else
    begin
      TasConsumo.TabVisible  := True;
    end;

    PgcPrincipal.Visible := True;
    PgcPrincipal.ActivePage := TasConsumo;
    Application.CreateForm(TFrmNotaConsumoStarter, FrmNotaConsumoStarter);
    FrmNotaConsumoStarter.Parent := FrmPrincipal.TasConsumo;
    FrmNotaConsumoStarter.CarregarTela('Empresa');
    FrmNotaConsumoStarter.ControleBotao;
    FrmNotaConsumoStarter.Show;
  finally

  end;
end;

procedure TFrmPrincipal.MenSupLiberarAcessoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenSupLiberarAcessoClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if FileExists(DtmPrincipal.NmCaminhoExecutavel + 'SginSuporte.exe') then
  begin
    WinExec('SginSuporte.exe', SW_NORMAL);
  end
  else
  begin
    MsgErro(uMensagem.OArquivoNaoExisteOuNaoLocalizado);
  end;
end;

procedure TFrmPrincipal.MenCargaDadosClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCargaDadosClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if MsgConfirmacao(uMensagem.DesejaRodarProcedureDeInicializacao) then
  begin
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;
    try
      uProcedure.Inicializacao(DtmPrincipal.IdEmpresaLogada);
    finally
      FrmProcessando.Destroy;
    end;
  end;
end;

procedure TFrmPrincipal.MenExecutarScriptSQLClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenExecutarScriptSQLClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmExecutaScriptSQL := TFrmExecutaScriptSQL.Create(Application);
    FrmExecutaScriptSQL.ShowModal;
  finally
    FrmExecutaScriptSQL.Free;
  end;
end;

procedure TFrmPrincipal.MenCadCepClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadCepClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmCepPesquisa := TFrmCepPesquisa.Create(Application);
    FrmCepPesquisa.ShowModal;
  finally
    FrmCepPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadCidadeClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadCidadeClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmCidadePesquisa := TFrmCidadePesquisa.Create(Application);
    FrmCidadePesquisa.ShowModal;
  finally
    FrmCidadePesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadClienteRapidoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadPessoaCompleto';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmPessoaRapido := TFrmPessoaRapido.Create(Application);
    FrmPessoaRapido.ShowModal;
  finally
    FrmPessoaRapido.Free;
  end;
end;

procedure TFrmPrincipal.MenCadAgendaGeralClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadAgendaGeralClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmAbrirAgendaGeral := TFrmAbrirAgendaGeral.Create(Application);
    FrmAbrirAgendaGeral.ShowModal;
  finally
    FrmAbrirAgendaGeral.Free;
  end;
end;

procedure TFrmPrincipal.MenCadAgendaStarterClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadAgendaStarterClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if TasAgenda = Nil then
    begin
      TasAgenda             := TTabSheet.Create(PgcPrincipal);
      TasAgenda.Caption     := 'Agenda do Profissional';
      TasAgenda.PageControl := FrmPrincipal.PgcPrincipal;
    end
    else
    begin
      TasAgenda.TabVisible  := True;
    end;

    PgcPrincipal.Visible    := True;
    PgcPrincipal.ActivePage := TasAgenda;
    Application.CreateForm(TFrmAgendaStarter, FrmAgendaStarter);
    FrmAgendaStarter.Parent := FrmPrincipal.TasAgenda;
    FrmAgendaStarter.CarregarTela('Geral');
    FrmAgendaStarter.Show;
  finally

  end;
end;

procedure TFrmPrincipal.MenSupBaixaSuporteClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenSupBaixaSuporteClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  ShellExecute(Handle, 'open', pchar('http://softsinos.com.br/SginSuporte.exe'), nil, nil, SW_SHOW);
end;

procedure TFrmPrincipal.PermissaoAcesso;
var
  I: Integer;
  J: Integer;
  K: Integer;
  L: Integer;
  T: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'PermissaoAcesso';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unAtivacao.Buscar(DtmPrincipal.Conexao);

  for I := 0 to self.ComponentCount -1 do
  begin
    //Verifica a ToolBar
    if Self.Components[i] is TToolBar  then
    begin
      for T := 0 to TToolBar(Self.Components[I]).ButtonCount - 1 do
      begin
        if unLicenca.BuscarMenu(DtmPrincipal.Conexao, TToolBar(Self.Components[I]).Buttons[T].Name, unAtivacao.NmLicenca) then
        begin
          TToolBar(Self.Components[I]).Buttons[T].Enabled := True;
        end
        else
        begin
          TToolBar(Self.Components[I]).Buttons[T].Enabled := False;
        end;
      end;
    end;

    //Verifica o MainMenu
    if Self.Components[i] is TMainMenu then
    begin
      for J := 0 to TMainMenu(Self.Components[I]).Items.Count - 1 do
      begin
        if unLicenca.BuscarMenu(DtmPrincipal.Conexao, TMainMenu(Self.Components[I]).Items[J].Name, unAtivacao.NmLicenca) then
        begin
          TMainMenu(Self.Components[I]).Items[J].Enabled := True;
        end
        else
        begin
          TMainMenu(Self.Components[I]).Items[J].Enabled := False;
        end;

        for K := 0 to TMainMenu(Self.Components[I]).Items[J].Count -1 do
        begin
          if unLicenca.BuscarMenu(DtmPrincipal.Conexao,  TMainMenu(Self.Components[I]).Items[J].Items[K].Name, unAtivacao.NmLicenca) then
          begin
             TMainMenu(Self.Components[I]).Items[J].Items[K].Enabled := True;
          end
          else
          begin
            TMainMenu(Self.Components[I]).Items[J].Items[K].Enabled := False;
          end;

          for L := 0 to TMainMenu(Self.Components[I]).Items[J].Items[K].Count -1 do
          begin
            if unLicenca.BuscarMenu(DtmPrincipal.Conexao,  TMainMenu(Self.Components[I]).Items[J].Items[K].Items[L].Name, unAtivacao.NmLicenca) then
            begin
               TMainMenu(Self.Components[I]).Items[J].Items[K].Items[L].Enabled := True;
            end
            else
            begin
              TMainMenu(Self.Components[I]).Items[J].Items[K].Items[L].Enabled := False;
            end;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmPrincipal.PgcVisivel;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'PgcVisivel';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    PgcPrincipal.Visible    := False;

    if TasConsumo <> nil then
    begin
      PgcPrincipal.Visible := TasConsumo.TabVisible;
      if TasConsumo.TabVisible then
      begin
        Abort;
      end
      else
      begin
        TasConsumo := nil;
      end;
    end;

    if TasAgenda <> nil then
    begin
      PgcPrincipal.Visible := TasAgenda.TabVisible;
      if TasAgenda.TabVisible then
      begin
        Abort;
      end
      else
      begin
        TasAgenda := nil;
      end;
    end;

    if TasPainel <> nil then
    begin
      PgcPrincipal.Visible := TasPainel.TabVisible;
      if TasPainel.TabVisible then
      begin
        Abort;
      end
      else
      begin
        TasPainel := nil;
      end;
    end;

    if TasLog <> nil then
    begin
      PgcPrincipal.Visible := TasLog.TabVisible;
      if TasLog.TabVisible then
      begin
        Abort;
      end
      else
      begin
        TasLog := nil;
      end;
    end;

    if TasConsultaNota <> nil then
    begin
      PgcPrincipal.Visible := TasConsultaNota.TabVisible;
      if TasConsultaNota.TabVisible then
      begin
        Abort;
      end
      else
      begin
        TasConsultaNota := nil;
      end;
    end;

  finally

  end;
end;

procedure TFrmPrincipal.Relatorios(NmTpMenu: String; NmTpRelatorio, NmTitulo, NmLabel1: String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'Relatorios';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if NmTpMenu = 'Pessoas' then
  begin
    try
      FrmPessoaRelatorio := TFrmPessoaRelatorio.Create(Application);
      FrmPessoaRelatorio.Caption           := NmTitulo;
      FrmPessoaRelatorio.LblPessoa.Caption := NmLabel1;
      FrmPessoaRelatorio.ShowModal;
    finally
      FrmPessoaRelatorio.Free;
    end;
  end
  else
  if NmTpMenu = 'Servicos' then
  begin
    try
      FrmServicoRelatorio := TFrmServicoRelatorio.Create(Application);
      FrmServicoRelatorio.Caption           := NmTitulo;
      FrmServicoRelatorio.LblPessoa.Caption := NmLabel1;
      FrmServicoRelatorio.ShowModal;
    finally
      FrmServicoRelatorio.Free;
    end;
  end
  else
  if NmTpMenu = 'Produtos' then
  begin
    try
      FrmProdutoRelatorio := TFrmProdutoRelatorio.Create(Application);
      FrmProdutoRelatorio.Caption            := NmTitulo;
      FrmProdutoRelatorio.LblProduto.Caption := NmLabel1;
      FrmProdutoRelatorio.ShowModal;
    finally
      FrmProdutoRelatorio.Free;
    end;
  end
  else
  if NmTpMenu = 'Financeiros' then
  begin
    try
      FrmTipoPagamentoRelatorio := TFrmTipoPagamentoRelatorio.Create(Application);
      FrmTipoPagamentoRelatorio.Caption              := NmTitulo;
      FrmTipoPagamentoRelatorio.LblPagamento.Caption := NmLabel1;
      FrmTipoPagamentoRelatorio.ShowModal;
    finally
      FrmTipoPagamentoRelatorio.Free;
    end;
  end
end;

procedure TFrmPrincipal.RelClientesClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'RelClientesClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Relatorios('Pessoas', 'Clientes', 'Relat�rios Clientes', 'Clientes:');
end;

procedure TFrmPrincipal.RelFinanceirosClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'RelFinanceirosClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Relatorios('Financeiros', 'Financeiros', 'Relat�rios Tipos de Pagamentos', 'Pagamentos:');
end;

procedure TFrmPrincipal.RelProdutosClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'RelProdutosClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Relatorios('Produtos', 'Produtos', 'Relat�rios Produtos', 'Produtos:');
end;

procedure TFrmPrincipal.RelServicosClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'RelServicosClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Relatorios('Servicos', 'Servicos', 'Relat�rios Servi�os', 'Servi�os:');
end;

procedure TFrmPrincipal.MenTelLoginClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenTelLoginClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmLogin := TFrmLogin.Create(Application);
    FrmLogin.EdtNmUsuario.Clear;
    FrmLogin.EdtNmSenha.Clear;
    FrmLogin.ShowModal;
  finally
    FrmLogin.Free;
  end;
end;

procedure TFrmPrincipal.MenCadPessoaCompletoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadPessoaCompleto';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmPessoaPesquisa := TFrmPessoaPesquisa.Create(Application);
    FrmPessoaPesquisa.ShowModal;
  finally
    FrmPessoaPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadMarcaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadMarcaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmMarcaPesquisa := TFrmMarcaPesquisa.Create(Application);
    FrmMarcaPesquisa.ShowModal;
  finally
    FrmMarcaPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadNotaEntradaEstoqueClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadNotaEntradaEstoqueClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmNotaEntrada := TFrmNotaEntrada.Create(Application);
    FrmNotaEntrada.ShowModal;
  finally
    FrmNotaEntrada.Free;
  end;
end;

end.
