unit fExecutaScriptSQL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fOperacao, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, Vcl.ComCtrls, cxControls, cxContainer, cxEdit, cxTextEdit, cxMemo,
  TLHelp32, DateUtils, WinInet, MaskUtils, DbTables, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Comp.ScriptCommands, FireDAC.Stan.Util, FireDAC.Comp.Script, cxCheckBox;

type
  TFrmExecutaScriptSQL = class(TFrmOperacao)
    MemSQL                : TcxMemo;
    OpdSQL                : TOpenDialog;
    Panel2                : TPanel;
    GroupBox2             : TGroupBox;
    Label1                : TLabel;
    LbtTotalRegistros     : TLabel;
    GroupBox1             : TGroupBox;
    PrbPesquisa           : TProgressBar;
    ExeSQL                : TFDScript;
    ChkGerarLog           : TcxCheckBox;
    ChkExcluirScriptSQL   : TcxCheckBox;
    ChkExecutarSemSalvar  : TcxCheckBox;
    procedure BtnCarregarClick(Sender: TObject);
    procedure BtnExecutarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
    procedure ChkExecutarSemSalvarClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
    procedure Edicao;
  public
    { Public declarations }
    procedure ListarArquivos(AOrigem: String; ADestino: String; Sub: Boolean);
    function TemAtributo(Attr, Val: Integer): Boolean;
  end;

var
  FrmExecutaScriptSQL: TFrmExecutaScriptSQL;

implementation

uses dPrincipal, uFuncao, fProcessando, uMensagem, uProcedure, fAjuda;

{$R *.dfm}

var
  lConsulta : Integer;

procedure TFrmExecutaScriptSQL.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
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

procedure TFrmExecutaScriptSQL.BtnCarregarClick(Sender: TObject);
var
  Arq   : TextFile;
  Linha : String;
  I     : Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLerClick';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  InicializarTela;
  ListarArquivos(DtmPrincipal.NmCaminhoExecutavel, DtmPrincipal.NmCaminhoAtualizacao,  True);

  try
    lConsulta            := 0;

    OpdSQL.Title       := 'Selecione o Script SQL';
    OpdSQL.InitialDir  := DtmPrincipal.NmCaminhoAtualizacao;
    OpdSQL.FileName    := '*.sql';
    OpdSQL.DefaultExt  := '*.sql';
    OpdSQL.Filter      := 'Arquivos SQL (*.sql)|Todos os Arquivos (*.*)|*.*';

    if OpdSQL.Execute then
    begin
      Application.CreateForm(TFrmProcessando, FrmProcessando);
      FrmProcessando.Show;
      Application.ProcessMessages;

      for I := 1 to 100 do
      begin
        Sleep(10);
        PrbPesquisa.Position := PrbPesquisa.Position + 1;
        if lConsulta = 0 then
        begin
          lConsulta := 1;
          MemSQL.Lines.LoadFromFile(OpdSQL.FileName);
        end;
      end;
      FrmProcessando.Destroy;
      LbtTotalRegistros.Caption  := IntToStr(MemSQL.Lines.Count);
    end;
  finally
    BtnExecutar.Enabled := True;
    BtnSalvar.Enabled   := False;
  end;
end;

procedure TFrmExecutaScriptSQL.BtnExecutarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'BtnExecutarClick';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    ExeSQL.Connection :=  DtmPrincipal.Conexao;

    if MemSQL.Lines.Count > 0 then
    begin
      if not ChkExecutarSemSalvar.Checked then
      begin
        if OpdSQL.FileName <> '' then
        begin
          ExeSQL.SQLScriptFileName := OpdSQL.FileName;
        end;
      end
      else
      if ChkExecutarSemSalvar.Checked then
      begin
        ExeSQL.SQLScripts.Add.SQL.Add(MemSQL.Text);
      end;
      ExeSQL.ValidateAll;
      ExeSQL.ExecuteAll;
    end;
  finally
    FrmProcessando.Destroy;
    ListarArquivos(DtmPrincipal.NmCaminhoAtualizacao, DtmPrincipal.NmCaminhoAtualizacao + 'Executados\',  True);
    InicializarTela;
    MsgInformacao(uMensagem.ScriptSQLExecutadoComSucesso);
  end;
end;

procedure TFrmExecutaScriptSQL.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  InicializarTela;
end;

procedure TFrmExecutaScriptSQL.BtnSalvarClick(Sender: TObject);
var
  NomeArquivo : String;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  NomeArquivo := Inputbox('Salvando Arquivo','Nome do Script SQL','');

  try
    if trim(NomeArquivo) <> '' then
    begin
      MemSQL.Lines.SaveToFile(DtmPrincipal.NmCaminhoAtualizacao + NomeArquivo + '.sql');
    end;
  finally
    MsgInformacao(uMensagem.ArquivoGeradoComSucesso);
    BtnExecutar.Enabled := True;
    BtnSalvar.Enabled   := False;
  end;
end;

procedure TFrmExecutaScriptSQL.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    BtnSalvar.Enabled   := True;
    BtnExecutar.Enabled := False;
  finally

  end;
end;

procedure TFrmExecutaScriptSQL.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmExecutaScriptSQL.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmExecutaScriptSQL.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  InicializarTela;
end;

procedure TFrmExecutaScriptSQL.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'TimerBarraTimer';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  LbtTotalRegistros.Caption     := '0';
  ChkGerarLog.Checked           := True;
  ChkExcluirScriptSQL.Checked   := True;
  PrbPesquisa.Position          := 0;
  BtnSalvar.Enabled             := False;
  BtnExecutar.Enabled           := False;
  MemSQL.Clear;

  if ChkExecutarSemSalvar.Checked then
  begin
    ChkExecutarSemSalvar.Checked := False;
    BtnExecutar.Enabled          := False;
  end;
end;

procedure TFrmExecutaScriptSQL.ListarArquivos(AOrigem: String; ADestino: String; Sub: Boolean);
var
  F: TSearchRec;
  Ret: Integer;
  TempNome: string;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'ListarArquivos';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Ret := FindFirst(AOrigem + '*.sql', faAnyFile, F);

  try
    while Ret = 0 do
    begin
      if TemAtributo(F.Attr, faDirectory) then
      begin
        if (F.Name <> '.') And (F.Name <> '..') then
        begin
          if Sub = True then
          begin
            TempNome := AOrigem + F.Name;
            ListarArquivos(TempNome, '', True);
          end;
        end;
      end
      else
      begin
        if ChkExcluirScriptSQL.Checked then
        begin
          DeletarArquivo(ADestino, F.Name);
          MoverArquivo(AOrigem, ADestino, F.Name);
        end;
      end;
      Ret := FindNext(F);
    end;
  finally
    begin
      FindClose(F);
    end;
  end;
end;

function TFrmExecutaScriptSQL.TemAtributo(Attr, Val: Integer): Boolean;
begin
  Result := Attr and Val = Val;
end;

procedure TFrmExecutaScriptSQL.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmExecutaScriptSQL.ChkExecutarSemSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmExecutaScriptSQL';
  DtmPrincipal.unLog.NmMetodo   := 'ChkExecutarSemSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'SQL Server';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if not BtnExecutar.Enabled then
  begin
    BtnExecutar.Enabled := True;
  end
  else
  begin
    BtnExecutar.Enabled := False;
  end;
end;


end.
