unit fConfiguracaoPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  Vcl.Menus, cxButtons;

type
  TFrmConfiguracaoPesquisa = class(TFrmPesquisa)
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure DbgPesquisaDblClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar(AConsulta: String);
    procedure ControleBotao;
  public
    { Public declarations }
  end;

var
  FrmConfiguracaoPesquisa: TFrmConfiguracaoPesquisa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uMensagem, uConfiguracao, fConfiguracao, dRelatorios, uEmpresa, fAjuda;

var
  unConfiguracao: TConfiguracao;
  unEmpresa     : TEmpresa;
  dnRelatorios  : TDtmRelatorios;

procedure TFrmConfiguracaoPesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
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

procedure TFrmConfiguracaoPesquisa.BtnAlterarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  if (CdsPesquisa.FieldCount > 0) then
  begin
    if CdsPesquisa.RecordCount > 0 then
    begin
      try
        FrmConfiguracao := TFrmConfiguracao.Create(Application);
        FrmConfiguracao.CarregarTela('Geral');

        FrmConfiguracao.EdtIdRegistro.Text      := CdsPesquisa.FieldByName('IdConfiguracao'   ).AsString;
        FrmConfiguracao.DtpDtCadastro.Date      := CdsPesquisa.FieldByName('DtCadastro'       ).AsDateTime;
        FrmConfiguracao.CbbIdEmpresa.ItemIndex  := RetornaZeroI(Integer(FrmConfiguracao.CbbIdEmpresa.Properties.Items.IndexOf(CdsPesquisa.FieldByName('NmRazaoSocialNmFantasia').AsString)));
        if CdsPesquisa.FieldByName('SnSituacao').AsString = 'ATIVO' then
        begin
          FrmConfiguracao.ChkSnSituacao.Checked := True;
          FrmConfiguracao.ChkSnSituacao.Caption := 'Cadastro Ativo';
        end
        else
        begin
          FrmConfiguracao.ChkSnSituacao.Checked := False;
          FrmConfiguracao.ChkSnSituacao.Caption := 'Cadastro Inativo';
        end;
        FrmConfiguracao.EdtNmUsuario.Text       := CdsPesquisa.FieldByName('NmUsuarioCadastro'  ).AsString;
        FrmConfiguracao.EdtNmConfiguracao.Text  := CdsPesquisa.FieldByName('NmConfiguracao'     ).AsString;
        FrmConfiguracao.EdtNmSigla.Text         := CdsPesquisa.FieldByName('NmSigla'            ).AsString;
        FrmConfiguracao.EdtNmValor.Text         := CdsPesquisa.FieldByName('NmValor'            ).AsString;

        ControleBotao;
        FrmConfiguracao.ShowModal;
      finally
        FrmConfiguracao.Free;
      end;
    end
    else
    begin
      MsgAtencao(uMensagem.NaoExistemDadosParaSeremAlterados);
    end;
  end
  else
  begin
    MsgAtencao(uMensagem.NaoExistemDadosParaSeremAlterados);
  end;
end;

procedure TFrmConfiguracaoPesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmConfiguracaoPesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    dnRelatorios := TDtmRelatorios.Create(Self);
    unEmpresa    := TEmpresa.Create;
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelEmpresa);

    unConfiguracao.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, 0, EdtPesquisa.Text, dnRelatorios.CDSRelPesquisa);

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\RelPesqImpConfiguracao.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmConfiguracaoPesquisa.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    FrmConfiguracao := TFrmConfiguracao.Create(Application);
    ControleBotao;
    FrmConfiguracao.ShowModal;
  finally
    FrmConfiguracao.Free;
  end;
end;

procedure TFrmConfiguracaoPesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmConfiguracaoPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text);

  inherited;
end;

procedure TFrmConfiguracaoPesquisa.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmConfiguracao.BtnIncluir.Enabled   := False;
  FrmConfiguracao.BtnSalvar.Enabled    := False;
  FrmConfiguracao.BtnCancelar.Enabled  := False;
  FrmConfiguracao.BtnFechar.Enabled    := True;

  if Trim(FrmConfiguracao.EdtIdRegistro.Text) <> '' then
  begin
    FrmConfiguracao.BtnIncluir.Enabled := True;
    FrmConfiguracao.BtnAnterior.Enabled:= True;
    FrmConfiguracao.BtnProximo.Enabled := True;
  end
  else
  begin
    FrmConfiguracao.BtnSalvar.Enabled  := True;
    FrmConfiguracao.BtnCancelar.Enabled:= True;
  end;
end;

procedure TFrmConfiguracaoPesquisa.DbgPesquisaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'DbgPesquisaDblClick';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnAlterarClick(Sender);
  inherited;
end;

procedure TFrmConfiguracaoPesquisa.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
    DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Configuracao';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    BtnPesquisarClick(Sender);
  end;
  inherited;
end;

procedure TFrmConfiguracaoPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmConfiguracaoPesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmConfiguracaoPesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmConfiguracaoPesquisa.Pesquisar(AConsulta: String);
var
  I: Integer;
  lConsulta: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmConfiguracaoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Configuracao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  PrbPesquisa.Position := 0;
  lConsulta := 0;
  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    for I := 1 to 100 do
    begin
      Sleep(15);
      PrbPesquisa.Position := PrbPesquisa.Position + 1;
      if lConsulta = 0 then
      begin
        lConsulta       := 1;
        unConfiguracao  := TConfiguracao.Create;

        unConfiguracao.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, 0, EdtPesquisa.Text, CdsPesquisa);
      end;
    end;
  finally
    unConfiguracao.Free;
    FrmProcessando.Destroy;
  end;
  inherited;
end;

end.
