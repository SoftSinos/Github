unit fTipoPagamentoPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient, Vcl.ComCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, Vcl.Menus, cxButtons;

type
  TFrmTipoPagamentoPesquisa = class(TFrmPesquisa)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure DbgPesquisaDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar(AConsulta: String);
    procedure ControleBotao;
  public
    { Public declarations }
  end;

var
  FrmTipoPagamentoPesquisa: TFrmTipoPagamentoPesquisa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uMensagem, uTipoPagamento, fTipoPagamento, dRelatorios, uEmpresa, fAjuda;

var
  unTipoPagamento  : TTipoPagamento;
  unEmpresa        : TEmpresa;
  dnRelatorios     : TDtmRelatorios;

procedure TFrmTipoPagamentoPesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
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

procedure TFrmTipoPagamentoPesquisa.BtnAlterarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if (CdsPesquisa.FieldCount > 0) then
  begin
    if CdsPesquisa.RecordCount > 0 then
    begin
      try
        FrmTipoPagamento := TFrmTipoPagamento.Create(Application);

        FrmTipoPagamento.PnlCampos.Enabled          := True;
        FrmTipoPagamento.EdtIdRegistro.Text         := CdsPesquisa.FieldByName('IdTpPagamento').AsString;
        FrmTipoPagamento.EdtNmUsuario.Text          := CdsPesquisa.FieldByName('NmUsuarioCadastro').AsString;
        FrmTipoPagamento.DtpDtCadastro.Date         := CdsPesquisa.FieldByName('DtCadastro').AsDateTime;
        if CdsPesquisa.FieldByName('SnSituacao').AsString = 'ATIVO' then
        begin
          FrmTipoPagamento.ChkSnSituacao.Checked    := True;
          FrmTipoPagamento.ChkSnSituacao.Caption    := 'Cadastro Ativo';
        end
        else
        begin
          FrmTipoPagamento.ChkSnSituacao.Checked    := False;
          FrmTipoPagamento.ChkSnSituacao.Caption    := 'Cadastro Inativo';
        end;
        FrmTipoPagamento.EdtNmTpPagamento.Text            := CdsPesquisa.FieldByName('NmTpPagamento').AsString;

        ControleBotao;
        FrmTipoPagamento.ShowModal;
      finally
        FrmTipoPagamento.Free;
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

procedure TFrmTipoPagamentoPesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoPagamentoPesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    dnRelatorios := TDtmRelatorios.Create(Self);
    unEmpresa    := TEmpresa.Create;
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelEmpresa);

    unTipoPagamento.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, dnRelatorios.CDSRelPesquisa);

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\RelPesqImpTipoPagamento.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmTipoPagamentoPesquisa.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    FrmTipoPagamento := TFrmTipoPagamento.Create(Application);
    ControleBotao;
    FrmTipoPagamento.ShowModal;
  finally
    FrmTipoPagamento.Free;
  end;
end;

procedure TFrmTipoPagamentoPesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoPagamentoPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text);

  inherited;
end;

procedure TFrmTipoPagamentoPesquisa.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmTipoPagamento.BtnIncluir.Enabled   := False;
  FrmTipoPagamento.BtnSalvar.Enabled    := False;
  FrmTipoPagamento.BtnCancelar.Enabled  := False;
  FrmTipoPagamento.BtnFechar.Enabled    := True;

  if Trim(FrmTipoPagamento.EdtIdRegistro.Text) <> '' then
  begin
    FrmTipoPagamento.BtnIncluir.Enabled := True;
    FrmTipoPagamento.BtnAnterior.Enabled:= True;
    FrmTipoPagamento.BtnProximo.Enabled := True;
  end
  else
  begin
    FrmTipoPagamento.BtnSalvar.Enabled  := True;
    FrmTipoPagamento.BtnCancelar.Enabled:= True;
  end;
end;

procedure TFrmTipoPagamentoPesquisa.DbgPesquisaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'DbgPesquisaDblClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnAlterarClick(Sender);

  inherited;
end;

procedure TFrmTipoPagamentoPesquisa.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
    DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    BtnPesquisarClick(Sender);
  end;

  inherited;
end;

procedure TFrmTipoPagamentoPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoPagamentoPesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoPagamentoPesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoPagamentoPesquisa.Pesquisar(AConsulta: String);
var
  I           : Integer;
  lConsulta   : Integer;
  lSnSituacao : Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPagamentoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'TipoPagamento';
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
        unTipoPagamento  := TTipoPagamento.Create;

        if RdbSnAtivo.Checked then
        begin
          lSnSituacao := 1;
        end
        else
        if RdbSnInativo.Checked then
        begin
          lSnSituacao := 0;
        end
        else
        if RdbSnTodos.Checked then
        begin
          lSnSituacao := 2;
        end;

        unTipoPagamento.CarregaDbGrid(DtmPrincipal.Conexao, lSnSituacao, 0, EdtPesquisa.Text, CdsPesquisa);
      end;
    end;
  finally
    unTipoPagamento.Free;
    FrmProcessando.Destroy;
  end;

  inherited;
end;

end.
