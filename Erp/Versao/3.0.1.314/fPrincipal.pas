unit fPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Classes, Vcl.Graphics, Vcl.Dialogs, Vcl.Touch.Keyboard, Vcl.ExtCtrls, Vcl.Mask, Vcl.DBCtrls, Vcl.ComCtrls, dPrincipal, uFuncao, Vcl.Menus,
  Vcl.ImgList, Vcl.ToolWin, Vcl.Buttons, Jpeg, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Contnrs, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.Imaging.pngimage, ShellApi, dxGDIPlusClasses, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, cxButtons, Vcl.ButtonGroup, JvExComCtrls, JvToolBar, Vcl.Themes;

type
  TFrmPrincipal = class(TForm)
    StbPrincipal                : TStatusBar;
    ImgPrincipal                : TImage;
    MenPrincipal                : TMainMenu;
    MenAvancados                : TMenuItem;
    MenCadConfiguracaoSistema   : TMenuItem;
    MenAjudas                   : TMenuItem;
    MenPessoas                  : TMenuItem;
    MenCadPessoa                : TMenuItem;
    MenCadCalendario            : TMenuItem;
    MenServicos                 : TMenuItem;
    MenRelatorios               : TMenuItem;
    MenProdutos                 : TMenuItem;
    MenAgendas                  : TMenuItem;
    MenCadUsuario               : TMenuItem;
    MenTelLogin                 : TMenuItem;
    MenSaiSair                  : TMenuItem;
    MenComPessoas               : TMenuItem;
    MenSobSobre                 : TMenuItem;
    MenSupAtenderRemoto         : TMenuItem;
    TimPrincipal                : TTimer;
    MenCadEmpresa               : TMenuItem;
    MenBkpBackupSistema         : TMenuItem;
    PgcPrincipal                : TPageControl;
    ToolBar1                    : TToolBar;
    ToolButton1                 : TToolButton;
    MenSupBaixaSuporte          : TMenuItem;
    MenRelPessoas               : TMenuItem;
    ImgListPrincipal            : TImageList;
    MenSupLiberarAcesso         : TMenuItem;
    MenPapPapelParede           : TMenuItem;
    MenInfInformacoes           : TMenuItem;
    MenLogLogSistema            : TMenuItem;
    MenCadTipoPessoa            : TMenuItem;
    MenCadCidade                : TMenuItem;
    MenCadCep                   : TMenuItem;
    MenRelServicos              : TMenuItem;
    MenRelProdutos              : TMenuItem;
    MenRelOperacoes             : TMenuItem;
    MenComServicos              : TMenuItem;
    MenComProdutos              : TMenuItem;
    MenSqlBancoDados            : TMenuItem;
    MenSqlEditorBancoDados      : TMenuItem;
    MenCadTipoServico           : TMenuItem;
    MenCadServico               : TMenuItem;
    FrmToolBar                  : TToolBar;
    ImgPessoas                  : TcxButton;
    ToolButton12                : TToolButton;
    ImgProdutos                 : TcxButton;
    ToolButton4                 : TToolButton;
    ImgNotaStarter              : TcxButton;
    ToolButton6                 : TToolButton;
    ImgAgendaStarter            : TcxButton;
    ToolButton10                : TToolButton;
    ImgConexao                  : TcxButton;
    ToolButton5                 : TToolButton;
    ImgBackup                   : TcxButton;
    ToolButton9                 : TToolButton;
    ImgLoginSistema             : TcxButton;
    ToolButton11                : TToolButton;
    ImgSair                     : TcxButton;
    ToolButton13                : TToolButton;
    MenCadMarca                 : TMenuItem;
    MenCadGrupoProduto          : TMenuItem;
    MenCadProduto               : TMenuItem;
    MenOperacoes                : TMenuItem;
    MenRelAgendas               : TMenuItem;
    MenComOperacoes             : TMenuItem;
    MenCadTipoPagamento         : TMenuItem;
    MenCadOperacoesStarter      : TMenuItem;
    MenPesNotas                 : TMenuItem;
    MenCadAgendaStarter         : TMenuItem;
    MenAtiSistema               : TMenuItem;
    N10                         : TMenuItem;
    MenCadGrupoServico          : TMenuItem;
    MenCargaDados               : TMenuItem;
    N11                         : TMenuItem;
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
    procedure ImgSoftSinosDblClick(Sender: TObject);
    procedure MenSupBaixaSuporteClick(Sender: TObject);
    procedure MenBkpBackupSistemaClick(Sender: TObject);
    procedure ImgSairClick(Sender: TObject);
    procedure ImgConexaoClick(Sender: TObject);
    procedure MenSupLiberarAcessoClick(Sender: TObject);
    procedure ImgBackupClick(Sender: TObject);
    procedure MenCarregaTabelasClick(Sender: TObject);
    procedure MenPastaCopiaSegurancaClick(Sender: TObject);
    procedure MenPapPapelParedeClick(Sender: TObject);
    procedure MenInfInformacoesClick(Sender: TObject);
    procedure MenLogLogSistemaClick(Sender: TObject);
    procedure MenCadTipoPessoaClick(Sender: TObject);
    procedure MenCadCidadeClick(Sender: TObject);
    procedure MenCadPessoaClick(Sender: TObject);
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
   private
    { Private declarations }
    procedure InicializarTela;
    procedure PermissaoAcesso;
  public
    { Public declarations }
    TasConsumo: TTabSheet;
    TasAgenda : TTabSheet;
    procedure PgcVisivel;
    procedure UsuarioAdministrador(Verificar :Boolean);
    function CaptureTela( ARect: TRect ): TBitmap;
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
  fMarcaPesquisa, fGrupoProdutoPesquisa, fProdutoPesquisa, fTipoPagamentoPesquisa, fNotaStarter, fNotaPesquisa, fAgendaStarter, fAtivacaoSistema, uLicenca, uAtivacao,
  fGrupoServicoPesquisa;

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

function TFrmPrincipal.CaptureTela(ARect: TRect): TBitmap;
var
  ScreenDC: HDC;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'CaptureTela';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Result := TBitmap.Create;
  with Result, ARect do
  begin
    Width := Right - Left;
    Height := Bottom - Top;
    ScreenDC := GetDC( 0 );
    try
      BitBlt( Canvas.Handle, 0, 0, Width, Height, ScreenDC, Left, Top, SRCCOPY );
    finally
      ReleaseDC( 0, ScreenDC );
    end;
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
    FrmSplash.LblVersaoSplash.Caption := VersaoExecutavel(DtmPrincipal.NmCaminhoExecutavel + DtmPrincipal.NmExecutavel) + ' - ' + DtmPrincipal.NrVersaoBd;

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
      FrmLogin.LblLicencaLogin.Caption      := DtmPrincipal.NmSubModulo;
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

procedure TFrmPrincipal.ImgSoftSinosDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ImgSoftSinosDblClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  ShellExecute(Handle, 'open', pchar('http://softsinos.com.br'), nil, nil, SW_SHOW);
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

procedure TFrmPrincipal.ImgPessoasClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ImgPessoaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  MenCadPessoaClick(Sender);
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

procedure TFrmPrincipal.MenLogLogSistemaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenLogLogSistemaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmLogPesquisa := TFrmLogPesquisa.Create(Application);
    FrmLogPesquisa.ShowModal;
  finally
    FrmLogPesquisa.Free;
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
    FrmNotaPesquisa := TFrmNotaPesquisa.Create(Application);
    FrmNotaPesquisa.ShowModal;
  finally
    FrmNotaPesquisa.Free;
  end;
end;

procedure TFrmPrincipal.MenCadPessoaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCadPessoaClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmPessoaPesquisa := TFrmPessoaPesquisa.Create(Application);
    FrmPessoaPesquisa.ShowModal;
  finally
    FrmPessoaPesquisa.Free;
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
  Arquivo : String;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'ManipulaErros';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    BitMap := TBitmap.Create;
    BitMap := CaptureTela(Bounds(0,0,Screen.Width,Screen.Height));

    Arquivo := FormatDateTime('HH-MM-ss',Time);

    BitMap.SaveToFile(DtmPrincipal.NmCaminhoLog + '\' + Arquivo + '.bmp') ;
    BitMap.Free;

    MsgErro(uMensagem.EntrarEmContatoComOSuporte);
  finally

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
      TasConsumo.Caption     := 'Lanšamento de Consumo';
      TasConsumo.PageControl := FrmPrincipal.PgcPrincipal;
    end
    else
    begin
      TasConsumo.TabVisible  := True;
    end;

    PgcPrincipal.Visible := True;
    PgcPrincipal.ActivePage := TasConsumo;
    Application.CreateForm(TFrmNotaStarter, FrmNotaStarter);
    FrmNotaStarter.Parent := FrmPrincipal.TasConsumo;
    FrmNotaStarter.CarregarTela;
    FrmNotaStarter.ControleBotao;
    FrmNotaStarter.Show;
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

  if FileExists(DtmPrincipal.NmCaminhoExecutavel + 'Suporte.exe') then
  begin
    WinExec('Suporte.exe', SW_NORMAL);
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
      uProcedure.Inicializacao;
    finally
      FrmProcessando.Destroy;
    end;
  end;
end;

procedure TFrmPrincipal.MenCarregaTabelasClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPrincipal';
  DtmPrincipal.unLog.NmMetodo   := 'MenCarregaTabelasClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if MsgConfirmacao(uMensagem.DesejaRodarProcedureDeInicializacao) then
  begin
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;
    try
      uProcedure.Inicializacao;
    finally
      FrmProcessando.Destroy;
    end;
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

    PgcPrincipal.Visible := True;
    PgcPrincipal.ActivePage := TasAgenda;
    Application.CreateForm(TFrmAgendaStarter, FrmAgendaStarter);
    FrmAgendaStarter.Parent := FrmPrincipal.TasAgenda;
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

  ShellExecute(Handle, 'open', pchar('http://softsinos.com.br/suporte.exe'), nil, nil, SW_SHOW);
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
  finally

  end;
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

end.
