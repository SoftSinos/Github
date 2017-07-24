unit fUsuarioPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, fUsuario, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit,
  cxTextEdit, Vcl.Menus, cxButtons;

type
  TFrmUsuarioPesquisa = class(TFrmPesquisa)
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
  FrmUsuarioPesquisa: TFrmUsuarioPesquisa;

implementation

{$R *.dfm}

uses dPrincipal, uUsuario, fProcessando, uFuncao, uMensagem, dRelatorios, uEmpresa, fAjuda;

var
  unUsuario    : TUsuario;
  unEmpresa    : TEmpresa;
  dnRelatorios : TDtmRelatorios;

procedure TFrmUsuarioPesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
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

procedure TFrmUsuarioPesquisa.BtnAlterarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if (CdsPesquisa.FieldCount > 0) then
  begin
    if CdsPesquisa.RecordCount > 0 then
    begin
      try
        FrmUsuario := TFrmUsuario.Create(Application);
        FrmUsuario.CarregarTela('Geral');

        FrmUsuario.CbbIdEmpresa.ItemIndex       := RetornaZeroI(Integer(FrmUsuario.CbbIdEmpresa.Properties.Items.IndexOf(CdsPesquisa.FieldByName('NmRazaoSocialNmFantasia').AsString)));
        FrmUsuario.EdtIdRegistro.Text           := CdsPesquisa.FieldByName('IdUsuario'        ).AsString;
        FrmUsuario.DtpDtCadastro.Date           := CdsPesquisa.FieldByName('DtCadastro'       ).AsDateTime;
        if CdsPesquisa.FieldByName('SnSituacao').AsString = 'ATIVO' then
        begin
          FrmUsuario.ChkSnSituacao.Checked      := True;
          FrmUsuario.ChkSnSituacao.Caption      := 'Cadastro Ativo';
        end
        else
        begin
          FrmUsuario.ChkSnSituacao.Checked      := False;
          FrmUsuario.ChkSnSituacao.Caption      := 'Cadastro Inativo';
        end;
        FrmUsuario.EdtNmUsuario.Text            := CdsPesquisa.FieldByName('NmUsuarioCadastro'  ).AsString;
        FrmUsuario.EdtNmUsuarioCompleto.Text    := CdsPesquisa.FieldByName('NmUsuario'          ).AsString;
        FrmUsuario.EdtNmLogin.Text              := CdsPesquisa.FieldByName('NmLogin'            ).AsString;
        FrmUsuario.MkeNrCpf.Text                := CdsPesquisa.FieldByName('NrCpf'              ).AsString;
        if CdsPesquisa.FieldByName('SnAdministrador').AsString = 'Sim' then
        begin
          FrmUsuario.ChkSnAdministrador.Checked := True;
        end
        else
        begin
          FrmUsuario.ChkSnAdministrador.Checked := False;
        end;

        ControleBotao;
        FrmUsuario.ShowModal;
      finally
        FrmUsuario.Free;
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

procedure TFrmUsuarioPesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmUsuarioPesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    dnRelatorios := TDtmRelatorios.Create(Self);
    unEmpresa    := TEmpresa.Create;
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelEmpresa);

    unUsuario.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, dnRelatorios.CDSRelPesquisa);

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel + 'Relatorio\RelPesqImpUsuario.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmUsuarioPesquisa.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    FrmUsuario := TFrmUsuario.Create(Application);
    ControleBotao;
    FrmUsuario.CarregarTela('Geral');
    FrmUsuario.ShowModal;
  finally
    FrmUsuario.Free;
  end;
end;

procedure TFrmUsuarioPesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmUsuarioPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text);

  inherited;
end;

procedure TFrmUsuarioPesquisa.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmUsuario.BtnIncluir.Enabled   := False;
  FrmUsuario.BtnSalvar.Enabled    := False;
  FrmUsuario.BtnCancelar.Enabled  := False;
  FrmUsuario.BtnFechar.Enabled    := True;

  if Trim(FrmUsuario.EdtIdRegistro.Text) <> '' then
  begin
    FrmUsuario.BtnIncluir.Enabled := True;
    FrmUsuario.BtnAnterior.Enabled:= True;
    FrmUsuario.BtnProximo.Enabled := True;
  end
  else
  begin
    FrmUsuario.BtnSalvar.Enabled  := True;
    FrmUsuario.BtnCancelar.Enabled:= True;
  end;
end;

procedure TFrmUsuarioPesquisa.DbgPesquisaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'DbgPesquisaDblClick';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnAlterarClick(Sender);

  inherited;
end;

procedure TFrmUsuarioPesquisa.EdtPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
    DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Usuario';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    BtnPesquisarClick(Sender);
  end;

  inherited;
end;

procedure TFrmUsuarioPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmUsuarioPesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmUsuarioPesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmUsuarioPesquisa.Pesquisar(AConsulta: String);
var
  I: Integer;
  lConsulta: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmUsuarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Usuario';
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
        lConsulta := 1;
        unUsuario := TUsuario.Create;

        unUsuario.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, CdsPesquisa);
      end;
    end;
  finally
    unUsuario.Free;
    FrmProcessando.Destroy;
  end;

  inherited;
end;

end.
