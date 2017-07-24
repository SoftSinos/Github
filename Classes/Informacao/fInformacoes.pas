unit fInformacoes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fOperacao, cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, Vcl.ComCtrls;

type
  TFrmInformacoes = class(TFrmOperacao)
    MemInformacoes: TMemo;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInformacoes: TFrmInformacoes;

implementation

{$R *.dfm}

uses dPrincipal, uConfiguracao, uFuncao;

var
  unConfiguracao : TConfiguracao;

procedure TFrmInformacoes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmInformacoes';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmInformacoes.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmInformacoes';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unConfiguracao := TConfiguracao.Create;
end;

procedure TFrmInformacoes.FormShow(Sender: TObject);
var
  NrExpiracao : String;
  DtExpiracao : String;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmInformacoes';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  //TEMPO DE DURACAO CONTRA SENHA "SAFERY OPEN"
  unConfiguracao.Buscar(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada, 'TDCS');
  NrExpiracao := Copy(unConfiguracao.NmValor, 6, 5);
  DtExpiracao := DateTimeToStr(StrToInt(NrExpiracao));

  MemInformacoes.Lines.Add('INFORMA��ES DO SISTEMA');
  MemInformacoes.Lines.Add('');
  MemInformacoes.Lines.Add('');
  MemInformacoes.Lines.Add('Vers�o do Programa: ' + DtmPrincipal.NrVersaoApp);
  MemInformacoes.Lines.Add('Local do Programa: ' + DtmPrincipal.NmCaminhoExecutavel);
  MemInformacoes.Lines.Add('Data da Vers�o: ' +  DtmPrincipal.DtVersaoApp);
  MemInformacoes.Lines.Add('');
  MemInformacoes.Lines.Add('Servidor: ' + DtmPrincipal.NmHost);
  MemInformacoes.Lines.Add('Bando de Dados: ' + DtmPrincipal.NmBanco);
  MemInformacoes.Lines.Add('Vers�o do Banco de Dados: ' + VersaoBd(DtmPrincipal.Conexao));
  MemInformacoes.Lines.Add('');
  MemInformacoes.Lines.Add('Certificado Valido at�: ' + DtExpiracao);
end;

end.
