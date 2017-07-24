unit fCidadePesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit, Vcl.Menus, cxButtons;

type
  TFrmCidadePesquisa = class(TFrmPesquisa)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
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
  FrmCidadePesquisa: TFrmCidadePesquisa;

implementation

{$R *.dfm}
uses dPrincipal, uFuncao, fProcessando, uMensagem, uCidade, fCidade, dRelatorios, uEmpresa, fAjuda;

var
  unCidade     : TCidade;
  unEmpresa    : TEmpresa;
  dnRelatorios : TDtmRelatorios;

procedure TFrmCidadePesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
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

procedure TFrmCidadePesquisa.BtnAlterarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  if (CdsPesquisa.FieldCount > 0) then
  begin
    if CdsPesquisa.RecordCount > 0 then
    begin
      try
        FrmCidade := TFrmCidade.Create(Application);
        FrmCidade.PnlCampos.Enabled           := True;
        FrmCidade.EdtIdRegistro.Text          := CdsPesquisa.FieldByName('IdCidade'         ).AsString;
        FrmCidade.EdtNmUsuario.Text           := CdsPesquisa.FieldByName('NmUsuarioCadastro').AsString;
        FrmCidade.DtpDtCadastro.Date          := CdsPesquisa.FieldByName('DtCadastro'       ).AsDateTime;
        if CdsPesquisa.FieldByName('SnSituacao').AsString = 'ATIVO' then
        begin
          FrmCidade.ChkSnSituacao.Checked     := True;
          FrmCidade.ChkSnSituacao.Caption     := 'Cadastro Ativo';
        end
        else
        begin
          FrmCidade.ChkSnSituacao.Checked     := False;
          FrmCidade.ChkSnSituacao.Caption     := 'Cadastro Inativo';
        end;
        FrmCidade.EdtNmCidade.Text            := CdsPesquisa.FieldByName('NmCidade'         ).AsString;
        FrmCidade.EdtNrIbge.Text              := CdsPesquisa.FieldByName('NrIbge'           ).AsString;
        FrmCidade.EdtNmCidade.Text            := CdsPesquisa.FieldByName('NmCidade'         ).AsString;

        FrmCidade.CarregarTela(0);

        FrmCidade.CbbIdUf.ItemIndex           := RetornaZeroI(Integer(FrmCidade.CbbIdUf.Properties.Items.IndexOf(CdsPesquisa.FieldByName('NmSiglaUf').AsString)));

        ControleBotao;
        FrmCidade.ShowModal;
      finally
        FrmCidade.Free;
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

procedure TFrmCidadePesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmCidadePesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    dnRelatorios := TDtmRelatorios.Create(Self);
    unEmpresa    := TEmpresa.Create;
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelEmpresa);

    unCidade.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, dnRelatorios.CDSRelPesquisa);

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\RelPesqImpCidade.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmCidadePesquisa.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  try
    FrmCidade := TFrmCidade.Create(Application);
    ControleBotao;
    FrmCidade.ShowModal;
  finally
    FrmCidade.Free;
  end;
end;

procedure TFrmCidadePesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmCidadePesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text);

  inherited;
end;

procedure TFrmCidadePesquisa.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmCidade.BtnIncluir.Enabled   := False;
  FrmCidade.BtnSalvar.Enabled    := False;
  FrmCidade.BtnCancelar.Enabled  := False;
  FrmCidade.BtnFechar.Enabled    := True;

  if Trim(FrmCidade.EdtIdRegistro.Text) <> '' then
  begin
    FrmCidade.BtnIncluir.Enabled := True;
    FrmCidade.BtnAnterior.Enabled:= True;
    FrmCidade.BtnProximo.Enabled := True;
  end
  else
  begin
    FrmCidade.BtnSalvar.Enabled  := True;
    FrmCidade.BtnCancelar.Enabled:= True;
  end;
end;

procedure TFrmCidadePesquisa.DbgPesquisaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'DbgPesquisaDblClick';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnAlterarClick(Sender);
  inherited;
end;

procedure TFrmCidadePesquisa.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
    DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Cidade';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    BtnPesquisarClick(Sender);
  end;
  inherited;
end;

procedure TFrmCidadePesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmCidadePesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmCidadePesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmCidadePesquisa.Pesquisar(AConsulta: String);
var
  I: Integer;
  lConsulta: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCidadePesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Cidade';
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
        unCidade  := TCidade.Create;

        unCidade.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, CdsPesquisa);
      end;
    end;
  finally
    unCidade.Free;
    FrmProcessando.Destroy;
  end;
  inherited;
end;

end.
