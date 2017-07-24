unit fEmpresaPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, Vcl.ExtCtrls, fEmpresa, Vcl.ComCtrls, Vcl.Imaging.jpeg, Vcl.DBCtrls,  MaskUtils, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, Vcl.Menus, cxButtons;

type
  TFrmEmpresaPesquisa = class(TFrmPesquisa)
    procedure EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure DbgPesquisaDblClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnAjudaClick(Sender: TObject);
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
  FrmEmpresaPesquisa: TFrmEmpresaPesquisa;

implementation

{$R *.dfm}

uses uEmpresa, dPrincipal, fProcessando, uFuncao, uMensagem, dRelatorios, fAjuda;

var
  unEmpresa   : TEmpresa;
  dnRelatorios: TDtmRelatorios;

procedure TFrmEmpresaPesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
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

procedure TFrmEmpresaPesquisa.BtnAlterarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if (CdsPesquisa.FieldCount > 0) then
  begin
    if CdsPesquisa.RecordCount > 0 then
    begin
      try
        FrmEmpresa := TFrmEmpresa.Create(Application);
        FrmEmpresa.PnlCampos.Enabled          := True;
        FrmEmpresa.EdtIdRegistro.Text         := CdsPesquisa.FieldByName('IdEmpresa').AsString;
        FrmEmpresa.EdtNmUsuario.Text          := CdsPesquisa.FieldByName('NmUsuarioCadastro').AsString;
        FrmEmpresa.DtpDtCadastro.Date         := CdsPesquisa.FieldByName('DtCadastro').AsDateTime;
        if CdsPesquisa.FieldByName('SnSituacao').AsString = 'Ativo' then
        begin
          FrmEmpresa.ChkSnSituacao.Checked    := True;
          FrmEmpresa.ChkSnSituacao.Caption    := 'Cadastro Ativo';
        end
        else
        begin
          FrmEmpresa.ChkSnSituacao.Checked    := False;
          FrmEmpresa.ChkSnSituacao.Caption    := 'Cadastro Inativo';
        end;
        FrmEmpresa.EdtNmRazaoSocial.Text      := CdsPesquisa.FieldByName('NmRazaoSocial').AsString;
        FrmEmpresa.EdtNmFantasia.Text         := CdsPesquisa.FieldByName('NmFantasia').AsString;
        FrmEmpresa.MkeNrCnpj.Text             := CdsPesquisa.FieldByName('NrCnpj').AsString;
        FrmEmpresa.EdtNrIE.Text               := CdsPesquisa.FieldByName('NrIE').AsString;
        FrmEmpresa.EdtNmEndereco.Text         := CdsPesquisa.FieldByName('NmEndereco').AsString;
        FrmEmpresa.EdtNmBairro.Text           := CdsPesquisa.FieldByName('NmBairro').AsString;
        FrmEmpresa.EdtNrNumero.Text           := CdsPesquisa.FieldByName('NrNumero').AsString;
        FrmEmpresa.EdtNmComplemento.Text      := CdsPesquisa.FieldByName('NmComplemento').AsString;
        FrmEmpresa.MkeNrTelefone.Text         := CdsPesquisa.FieldByName('NrTelefone').AsString;
        FrmEmpresa.EdtNmEmail.Text            := CdsPesquisa.FieldByName('NmEmail').AsString;
        FrmEmpresa.EdtNmSitio.Text            := CdsPesquisa.FieldByName('NmSitio').AsString;
        FrmEmpresa.MemObservacao.Text         := CdsPesquisa.FieldByName('NmObs').AsString;
        FrmEmpresa.EdtNmCidade.Text           := CdsPesquisa.FieldByName('NmCidade').AsString;
        FrmEmpresa.EdtNmUf.Text               := CdsPesquisa.FieldByName('NmSiglaUf').AsString;
        FrmEmpresa.MkeNrCep.Text              := CdsPesquisa.FieldByName('NrCep').AsString;

        ControleBotao;
        FrmEmpresa.ShowModal;
      finally
        FrmEmpresa.Free;
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

procedure TFrmEmpresaPesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmEmpresaPesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    dnRelatorios := TDtmRelatorios.Create(Self);
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelEmpresa);
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelPesquisa);

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel + 'Relatorio\RelPesqImpEmpresa.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally

  end;
end;

procedure TFrmEmpresaPesquisa.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    FrmEmpresa := TFrmEmpresa.Create(Application);
    ControleBotao;
    FrmEmpresa.ShowModal;
  finally
    FrmEmpresa.Free;
  end;
end;

procedure TFrmEmpresaPesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmEmpresaPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text);
  inherited;
end;

procedure TFrmEmpresaPesquisa.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmEmpresa.BtnIncluir.Enabled       := False;
  FrmEmpresa.BtnSalvar.Enabled        := False;
  FrmEmpresa.BtnCancelar.Enabled      := False;
  FrmEmpresa.BtnFechar.Enabled        := True;

  if Trim(FrmEmpresa.EdtIdRegistro.Text) <> '' then
  begin
    FrmEmpresa.EdtIdRegistro.Enabled  := False;
    FrmEmpresa.BtnIncluir.Enabled     := True;
    FrmEmpresa.BtnAnterior.Enabled    := True;
    FrmEmpresa.BtnProximo.Enabled     := True;
  end
  else
  begin
    FrmEmpresa.EdtIdRegistro.Enabled  := True;
    FrmEmpresa.BtnSalvar.Enabled      := True;
    FrmEmpresa.BtnCancelar.Enabled    := True;
  end;
end;

procedure TFrmEmpresaPesquisa.DbgPesquisaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'DbgPesquisaDblClick';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnAlterarClick(Sender);
  inherited;
end;

procedure TFrmEmpresaPesquisa.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Key = #13 then
  begin
    BtnPesquisarClick(Sender);
  end;
  inherited;
end;

procedure TFrmEmpresaPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unEmpresa.Free;
end;

procedure TFrmEmpresaPesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmEmpresaPesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmEmpresaPesquisa.Pesquisar(AConsulta: String);
var
  I         : Integer;
  lConsulta : Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmEmpresaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Empresa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  PrbPesquisa.Position  := 0;
  lConsulta             := 0;
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
        lConsulta := 1;
        unEmpresa := TEmpresa.Create;

        if not DtmPrincipal.UsuarioAdministrador then
        begin
          unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, EdtPesquisa.Text, CdsPesquisa);
        end
        else
        begin
          unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, CdsPesquisa);
        end;
        BtnIncluir.Enabled := False;
      end;
    end;
  finally
    FrmProcessando.Destroy;
  end;
  inherited;
end;

end.
