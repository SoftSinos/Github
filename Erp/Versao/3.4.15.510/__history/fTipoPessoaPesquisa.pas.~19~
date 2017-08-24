unit fTipoPessoaPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, Vcl.Menus, cxButtons;

type
  TFrmTipoPessoaPesquisa = class(TFrmPesquisa)
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure DbgPesquisaDblClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
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
  FrmTipoPessoaPesquisa: TFrmTipoPessoaPesquisa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uMensagem, uTipoPessoa, fTipoPessoa, dRelatorios, uEmpresa, fAjuda;

var
  unTipoPessoa : TTipoPessoa;
  unEmpresa    : TEmpresa;
  dnRelatorios : TDtmRelatorios;

procedure TFrmTipoPessoaPesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
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

procedure TFrmTipoPessoaPesquisa.BtnAlterarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if (CdsPesquisa.FieldCount > 0) then
  begin
    if CdsPesquisa.RecordCount > 0 then
    begin
      try
        FrmTipoPessoa := TFrmTipoPessoa.Create(Application);
        FrmTipoPessoa.PnlCampos.Enabled          := True;
        FrmTipoPessoa.EdtIdRegistro.Text         := CdsPesquisa.FieldByName('IdTpPessoa').AsString;
        FrmTipoPessoa.EdtNmUsuario.Text          := CdsPesquisa.FieldByName('NmUsuarioCadastro').AsString;
        FrmTipoPessoa.DtpDtCadastro.Date         := CdsPesquisa.FieldByName('DtCadastro').AsDateTime;
        if CdsPesquisa.FieldByName('SnSituacao').AsString = 'Ativo' then
        begin
          FrmTipoPessoa.ChkSnSituacao.Checked    := True;
          FrmTipoPessoa.ChkSnSituacao.Caption    := 'Cadastro Ativo';
        end
        else
        begin
          FrmTipoPessoa.ChkSnSituacao.Checked    := False;
          FrmTipoPessoa.ChkSnSituacao.Caption    := 'Cadastro Inativo';
        end;
        FrmTipoPessoa.EdtNmTpPessoa.Text         := CdsPesquisa.FieldByName('NmTpPessoa').AsString;
        if CdsPesquisa.FieldByName('SnCliente').AsString = 'Ativo' then
        begin
          FrmTipoPessoa.ChkSnCliente.Checked     := True;
        end
        else
        begin
          FrmTipoPessoa.ChkSnCliente.Checked     := False;
        end;
        if CdsPesquisa.FieldByName('SnFornecedor').AsString = 'Ativo' then
        begin
          FrmTipoPessoa.ChkSnFornecedor.Checked  := True;
        end
        else
        begin
          FrmTipoPessoa.ChkSnFornecedor.Checked  := False;
        end;
        if CdsPesquisa.FieldByName('SnFuncionario').AsString = 'Ativo' then
        begin
          FrmTipoPessoa.ChkSnFuncionario.Checked:= True;
        end
        else
        begin
          FrmTipoPessoa.ChkSnFuncionario.Checked := False;
        end;

        ControleBotao;
        FrmTipoPessoa.ShowModal;
      finally
        FrmTipoPessoa.Free;
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

procedure TFrmTipoPessoaPesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmTipoPessoaPesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    dnRelatorios := TDtmRelatorios.Create(Self);
    unEmpresa    := TEmpresa.Create;
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelEmpresa);

    if not DtmPrincipal.UsuarioAdministrador then
    begin
      unTipoPessoa.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, dnRelatorios.CDSRelPesquisa);
    end
    else
    begin
      unTipoPessoa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, EdtPesquisa.Text, dnRelatorios.CDSRelPesquisa);
    end;

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\RelPesqImpTipoPessoa.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmTipoPessoaPesquisa.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    FrmTipoPessoa := TFrmTipoPessoa.Create(Application);
    ControleBotao;
    FrmTipoPessoa.ShowModal;
  finally
    FrmTipoPessoa.Free;
  end;
end;

procedure TFrmTipoPessoaPesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmTipoPessoaPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text);

  inherited;

end;

procedure TFrmTipoPessoaPesquisa.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmTipoPessoa.BtnIncluir.Enabled   := False;
  FrmTipoPessoa.BtnSalvar.Enabled    := False;
  FrmTipoPessoa.BtnCancelar.Enabled  := False;
  FrmTipoPessoa.BtnFechar.Enabled    := True;

  if Trim(FrmTipoPessoa.EdtIdRegistro.Text) <> '' then
  begin
    FrmTipoPessoa.BtnIncluir.Enabled := True;
    FrmTipoPessoa.BtnAnterior.Enabled:= True;
    FrmTipoPessoa.BtnProximo.Enabled := True;
  end
  else
  begin
    FrmTipoPessoa.BtnSalvar.Enabled  := True;
    FrmTipoPessoa.BtnCancelar.Enabled:= True;
  end;
end;

procedure TFrmTipoPessoaPesquisa.DbgPesquisaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'DbgPesquisaDblClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnAlterarClick(Sender);

  inherited;

end;

procedure TFrmTipoPessoaPesquisa.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
    DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    BtnPesquisarClick(Sender);
  end;

  inherited;

end;

procedure TFrmTipoPessoaPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmTipoPessoaPesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmTipoPessoaPesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmTipoPessoaPesquisa.Pesquisar(AConsulta: String);
var
  I: Integer;
  lConsulta: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'TipoPessoa';
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
        unTipoPessoa  := TTipoPessoa.Create;

        unTipoPessoa.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, CdsPesquisa);
      end;
    end;
  finally
    unTipoPessoa.Free;
    FrmProcessando.Destroy;
  end;

  inherited;
end;

end.
