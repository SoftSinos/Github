unit fTipoServicoPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, Vcl.Menus, cxButtons;

type
  TFrmTipoServicoPesquisa = class(TFrmPesquisa)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure DbgPesquisaDblClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar(AConsulta: String);
    procedure ControleBotao;
  public
    { Public declarations }
  end;

var
  FrmTipoServicoPesquisa: TFrmTipoServicoPesquisa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uMensagem, uTipoServico, fTipoServico, dRelatorios, uEmpresa, fAjuda;

var
  unTipoServico: TTipoServico;
  unEmpresa    : TEmpresa;
  dnRelatorios : TDtmRelatorios;


procedure TFrmTipoServicoPesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServicoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
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

procedure TFrmTipoServicoPesquisa.BtnAlterarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServicoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if (CdsPesquisa.FieldCount > 0) then
  begin
    if CdsPesquisa.RecordCount > 0 then
    begin
      try
        FrmTipoServico := TFrmTipoServico.Create(Application);
        FrmTipoServico.CarregarTela('Geral');

        FrmTipoServico.PnlCampos.Enabled            := True;
        FrmTipoServico.EdtIdRegistro.Text           := CdsPesquisa.FieldByName('IdTpServico'        ).AsString;
        FrmTipoServico.EdtNmUsuario.Text            := CdsPesquisa.FieldByName('NmUsuarioCadastro'  ).AsString;
        FrmTipoServico.DtpDtCadastro.Date           := CdsPesquisa.FieldByName('DtCadastro'         ).AsDateTime;
        if CdsPesquisa.FieldByName('SnSituacao').AsString = 'Ativo' then
        begin
          FrmTipoServico.ChkSnSituacao.Checked      := True;
          FrmTipoServico.ChkSnSituacao.Caption      := 'Cadastro Ativo';
        end
        else
        begin
          FrmTipoServico.ChkSnSituacao.Checked      := False;
          FrmTipoServico.ChkSnSituacao.Caption      := 'Cadastro Inativo';
        end;
        FrmTipoServico.EdtNmTpServico.Text          := CdsPesquisa.FieldByName('NmTpServico'        ).AsString;
        FrmTipoServico.CbbIdGrupoServico.ItemIndex  := RetornaZeroI(Integer(FrmTipoServico.CbbIdGrupoServico.Properties.Items.IndexOf(CdsPesquisa.FieldByName('NmGrupoServico').AsString)));
        FrmTipoServico.MkeVlServico.Text            := FormatFloat('0.00' , CdsPesquisa.FieldByName('VlServico').AsCurrency);
        FrmTipoServico.DtpHrServico.Time            := CdsPesquisa.FieldByName('HrServico').AsDateTime;

        ControleBotao;
        FrmTipoServico.ShowModal;
      finally
        FrmTipoServico.Free;
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

procedure TFrmTipoServicoPesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServicoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoServicoPesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServicoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
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
      unTipoServico.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, dnRelatorios.CDSRelPesquisa);
    end
    else
    begin
      unTipoServico.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, EdtPesquisa.Text, dnRelatorios.CDSRelPesquisa);
    end;

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\RelPesqImpTipoServico.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmTipoServicoPesquisa.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServicoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    FrmTipoServico := TFrmTipoServico.Create(Application);
    ControleBotao;
    FrmTipoServico.CarregarTela('Geral');
    FrmTipoServico.ShowModal;
  finally
    FrmTipoServico.Free;
  end;
end;

procedure TFrmTipoServicoPesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServicoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoServicoPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServicoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text);

  inherited;
end;

procedure TFrmTipoServicoPesquisa.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmTipoServico.BtnIncluir.Enabled   := False;
  FrmTipoServico.BtnSalvar.Enabled    := False;
  FrmTipoServico.BtnCancelar.Enabled  := False;
  FrmTipoServico.BtnFechar.Enabled    := True;

  if Trim(FrmTipoServico.EdtIdRegistro.Text) <> '' then
  begin
    FrmTipoServico.BtnIncluir.Enabled := True;
    FrmTipoServico.BtnAnterior.Enabled:= True;
    FrmTipoServico.BtnProximo.Enabled := True;
  end
  else
  begin
    FrmTipoServico.BtnSalvar.Enabled  := True;
    FrmTipoServico.BtnCancelar.Enabled:= True;
  end;
end;

procedure TFrmTipoServicoPesquisa.DbgPesquisaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServicoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'DbgPesquisaDblClick';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnAlterarClick(Sender);

  inherited;
end;

procedure TFrmTipoServicoPesquisa.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServicoPesquisa';
    DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'TipoServico';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    BtnPesquisarClick(Sender);
  end;

  inherited;
end;
procedure TFrmTipoServicoPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServicoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoServicoPesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServicoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoServicoPesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoServicoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmTipoServicoPesquisa.Pesquisar(AConsulta: String);
var
  I: Integer;
  lConsulta: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'TipoServico';
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
        unTipoServico   := TTipoServico.Create;

        unTipoServico.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, CdsPesquisa);
      end;
    end;
  finally
    unTipoServico.Free;
    FrmProcessando.Destroy;
  end;

  inherited;
end;

end.
