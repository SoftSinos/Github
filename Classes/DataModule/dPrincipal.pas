unit dPrincipal;

interface

uses
  System.SysUtils, System.IniFiles, System.Classes, Vcl.Forms, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL, Data.DB, FireDAC.Comp.Client, uLog;

type
  TDtmPrincipal = class(TDataModule)
    Conexao: TFDConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure CarregaLog;
    procedure DataModuleDestroy(Sender: TObject);
    procedure ConexaoError(ASender: TObject; const AInitiator: IFDStanObject; var AException: Exception);
  private
    { Private declarations }
  public
    { Public declarations }
    IniConexao                : TIniFile;
    NmHost                    : String;
    NmBanco                   : String;

    NmCaminhoImgPessoa        : String;
    NmCaminhoImgProduto       : String;
    NmCaminhoLog              : String;
    NmCaminhoAtualizacao      : String;

    IdEmpresaLogada           : Integer;
    IdUsuarioLogado           : Integer;
    NmUsuario                 : String;
    NmRazaoSocial             : String;
    NmFantasia                : String;
    NmFantasiaNmRazaoSocial   : String;

    NmExecutavel              : String;
    NmCaminhoExecutavel       : String;
    NrVersaoApp               : String;
    NrVersaoAtu               : String;
    NrVersaoBd                : String;
    DtVersaoApp               : String;

    UsuarioAdministrador      : Boolean;
    UsuarioSuporte            : Boolean;
    NrContadoRegistro         : Integer;

    DtDataInicio              : TDate;
    DtDataFinal               : TDate;
    TpRelatorio               : String;

    NmModulo                  : String;
    NmSubModulo               : String;
    NmStylesApp               : String;

    unLog                     : TLog;

    ResolucaoX                : Integer;
    ResolucaoY                : Integer;

  end;

var
  DtmPrincipal: TDtmPrincipal;

implementation

{ %CLASSGROUP 'System.Classes.TPersistent' }

uses uCriaPastas, uFuncao, uMensagem;

{$R *.dfm}
{ TDtmPrincipal }

procedure TDtmPrincipal.CarregaLog;
begin
  unLog.IdEmpresa     := IdEmpresaLogada;
  unLog.IdUsuario     := IdUsuarioLogado;
  unLog.NmModulo      := NmExecutavel;
  unLog.NmComputador  := NomeComputador;
  unLog.NmVersao      := NrVersaoApp;
end;

procedure TDtmPrincipal.ConexaoError(ASender: TObject; const AInitiator: IFDStanObject; var AException: Exception);
begin
  try
    unLog.LogConexao := True;

    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TDtmPrincipal';
    DtmPrincipal.unLog.NmMetodo   := 'ConexaoError';
    DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
    DtmPrincipal.unLog.NmMensagem := AException.Message;
    DtmPrincipal.unLog.GerarLog(Conexao);
  finally
    DtmPrincipal.unLog.NmMensagem := '';
    unLog.LogConexao := False;
  end;
end;

procedure TDtmPrincipal.DataModuleCreate(Sender: TObject);
begin
  if not FileExists(NmCaminhoExecutavel + 'Configuracao\Conexao.ini') then
  begin
    MsgErro(uMensagem.ArquivoDeConexaoNaoEncontrado);
    FinalizarAplicacao(NmExecutavel);
  end;

  try
    IniConexao                          := TIniFile.Create(NmCaminhoExecutavel + 'Configuracao\Conexao.ini');

    Conexao.Connected                   := false;

    Conexao.Params.Clear;
    Conexao.DriverName                  := 'MSSQL';

    Conexao.Params.Values['SERVER']     := IniConexao.ReadString('SERVER', 'HOSTNAME', '');
    Conexao.Params.Values['DATABASE']   := IniConexao.ReadString('SERVER', 'BANCO', '');
    Conexao.Params.Values['USER_NAME']  := 'SoftSinos';
    Conexao.Params.Values['PASSWORD']   := '.SS@2017';
  finally

  end;

  while True do
  begin
    try
      Conexao.Connected    := True;

      NmHost               := IniConexao.ReadString('SERVER', 'HOSTNAME', '');
      NmBanco              := IniConexao.ReadString('SERVER', 'BANCO', '');
      NmModulo             := IniConexao.ReadString('MODULO', 'MODULO', '');
      NmSubModulo          := IniConexao.ReadString('MODULO', 'SUB-MODULO', '');
      NmStylesApp          := IniConexao.ReadString('STYLES', 'STYLES', '');


      NmCaminhoExecutavel := ExtractFilePath(Application.ExeName);
      uCriaPastas.CriarPastas;

      NmExecutavel         := ExtractFileName(Application.ExeName);
      NmCaminhoImgPessoa   := NmCaminhoExecutavel + 'Imagem\Pessoal\';
      NmCaminhoImgProduto  := NmCaminhoExecutavel + 'Imagem\Produto\';
      NmCaminhoLog         := NmCaminhoExecutavel + 'Log\' + FormatDateTime('YYYY',Date) + '\' + FormatDateTime('MM',Date) + '\' + FormatDateTime('DD',Date) + '\';
      NmCaminhoAtualizacao := NmCaminhoExecutavel + 'Atualizacao\';
      NrVersaoApp          := VersaoExe(NmCaminhoExecutavel + NmExecutavel);
      NrVersaoAtu          := VersaoAtu(NmCaminhoExecutavel + NmExecutavel);
      DtVersaoApp          := DataVersaoApp;

      unLog                := TLog.Create;
      NrVersaoBd           := VersaoBd(Conexao);
      CarregaLog;

      DtmPrincipal.unLog.NmOperacao := 'Entrou';
      DtmPrincipal.unLog.NmClasse   := 'TDtmPrincipal';
      DtmPrincipal.unLog.NmMetodo   := 'DataModuleCreate';
      DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
      DtmPrincipal.unLog.GerarLog(Conexao);
      Break;
    except
      on E: Exception do
      begin
        MsgErro(uMensagem.OcorreuUmProblemaNoConectarAoBancoDeDados);
        FinalizarAplicacao(NmExecutavel);
      end;
    end;
  end;
end;

procedure TDtmPrincipal.DataModuleDestroy(Sender: TObject);
begin
  FinalizarAplicacao(NmExecutavel);
end;

end.
