unit fNotaPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxTextEdit,
  Vcl.Menus, cxButtons, dxCore, cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar;

type
  TFrmNotaPesquisa = class(TFrmPesquisa)
    CdsProduto        : TClientDataSet;
    DtsProduto        : TDataSource;
    CdsServico        : TClientDataSet;
    DtsServico        : TDataSource;
    CdsTipoPagamento  : TClientDataSet;
    DtsTipoPagamento  : TDataSource;
    PgcExtra          : TPageControl;
    TabServico        : TTabSheet;
    GrbServico        : TGroupBox;
    DbgServico        : TDBGrid;
    TabProduto        : TTabSheet;
    GrbProduto        : TGroupBox;
    DbgProduto        : TDBGrid;
    TabTipoPagamento  : TTabSheet;
    GrbTipoPagamento  : TGroupBox;
    DbgPagamento      : TDBGrid;
    BtnCancelar       : TcxButton;
    Label13           : TLabel;
    DtpDtCalendario   : TcxDateEdit;
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
    procedure DbgPesquisaCellClick(Column: TColumn);
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
    procedure Pesquisar(AConsulta: String);
    procedure ControleBotao;
    procedure CriaTelaNota;
    procedure CopulaTelaNota;
    procedure CopulaTelaNotaItem;
    procedure CopulaTelaNotaPagamento;
  public
    TpAcao   : String;
    TpPessoa : Integer;
    { Public declarations }
    procedure CopulaTela;
  end;

var
  FrmNotaPesquisa: TFrmNotaPesquisa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uMensagem, uNota, uNotaItem, uNotaPagamento, dRelatorios, uEmpresa, fAjuda, fPrincipal, fNotaConsumoStarter;

var
  unNota          : TNota;
  unNotaItem      : TNotaItem;
  unNotaPagamento : TNotaPagamento;
  unEmpresa       : TEmpresa;
  dnRelatorios    : TDtmRelatorios;
  lSnSituacao     : Integer;

procedure TFrmNotaPesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
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

procedure TFrmNotaPesquisa.BtnAlterarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if (CdsPesquisa.FieldCount > 0) and (CdsProduto.FieldCount > 0) and (CdsServico.FieldCount > 0) and (CdsTipoPagamento.FieldCount > 0) then
  begin
    if (CdsPesquisa.RecordCount > 0) and ((CdsProduto.RecordCount > 0) or (CdsServico.RecordCount > 0)) then
    begin
      try
        CriaTelaNota;
        CopulaTelaNota;
        CopulaTelaNotaItem;
        CopulaTelaNotaPagamento;
      finally
         FrmNotaConsumoStarter.SetaFoco;
         FrmNotaConsumoStarter.CarregarTela('Pessoa');

         if CdsServico.RecordCount > 0 then
         begin
           FrmNotaConsumoStarter.AtualizaVlServicos;
         end;
         if CdsProduto.RecordCount > 0 then
         begin
           FrmNotaConsumoStarter.AtualizaVlProdutos;
         end;
         if (CdsProduto.RecordCount > 0) or (CdsServico.RecordCount > 0) then
         begin
           FrmNotaConsumoStarter.AtualizaVlGeral;
           FrmNotaConsumoStarter.CbbIdProfServicoClick(Sender);
         end;
      end;
    end;
  end;
end;

procedure TFrmNotaPesquisa.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if MsgConfirmacao(uMensagem.DesejaCancelarOLancamento) then
  begin
    unNota.Inativar(DtmPrincipal.Conexao, CdsPesquisa.FieldByName('IdNota').AsInteger, CdsPesquisa.FieldByName('IdEmpresa').AsInteger);
    unNotaItem.Inativar(DtmPrincipal.Conexao, 0, CdsPesquisa.FieldByName('IdEmpresa').AsInteger, CdsPesquisa.FieldByName('IdNota').AsInteger);
    unNotaPagamento.Inativar(DtmPrincipal.Conexao, 0, CdsPesquisa.FieldByName('IdEmpresa').AsInteger, CdsPesquisa.FieldByName('IdNota').AsInteger, 0)
  end;
end;

procedure TFrmNotaPesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unNota.Free;
  unNotaItem.Free;
  unNotaPagamento.Free;
end;

procedure TFrmNotaPesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
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
      unNota.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, 0, EdtPesquisa.Text, '0', 0, 0, dnRelatorios.CDSRelPesquisa);
    end
    else
    begin
      unNota.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, DtmPrincipal.IdEmpresaLogada, EdtPesquisa.Text,  '0', 0, 0, dnRelatorios.CDSRelPesquisa);
    end;

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\RelPesqImpNotaItemPagamentos.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmNotaPesquisa.BtnIncluirClick(Sender: TObject);
begin
  inherited;
  //Herança
end;

procedure TFrmNotaPesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;

  DtpDtCalendario.Date  := Now;
  DtpDtCalendario.SetFocus;
end;

procedure TFrmNotaPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text);

  inherited;
end;

procedure TFrmNotaPesquisa.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    BtnIncluir.Enabled := False;
  finally

  end;

end;

procedure TFrmNotaPesquisa.CopulaTela;

begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, True, lSnSituacao, 0, CdsPesquisa.FieldByName('IdEmpresa').AsInteger, CdsPesquisa.FieldByName('IdNota').AsInteger, 'Servico', '', CdsServico);
    unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, True, lSnSituacao, 0, CdsPesquisa.FieldByName('IdEmpresa').AsInteger, CdsPesquisa.FieldByName('IdNota').AsInteger, 'Produto', '', CdsProduto);
    unNotaPagamento.CarregaDbGrid(DtmPrincipal.Conexao, True, lSnSituacao, 0, CdsPesquisa.FieldByName('IdEmpresa').AsInteger, CdsPesquisa.FieldByName('IdNota').AsInteger, 0, '', CdsTipoPagamento);
  finally

  end;
end;

procedure TFrmNotaPesquisa.CopulaTelaNota;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTelaNota';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmNotaConsumoStarter.EdtIdRegistro.Text      := CdsPesquisa.FieldByName('IdNota').AsString;
    FrmNotaConsumoStarter.DtpDtCadastro.Date      := CdsPesquisa.FieldByName('DtCadastro').AsDateTime;
    FrmNotaConsumoStarter.EdtNmUsuario.Text       := CdsPesquisa.FieldByName('NmUsuarioCadastro').AsString;

    FrmNotaConsumoStarter.LblSnFinalizada.Caption := CdsPesquisa.FieldByName('SnFinalizada').AsString;

    FrmNotaConsumoStarter.CbbIdEmpresa.ItemIndex  := RetornaZeroI(Integer(FrmNotaConsumoStarter.CbbIdEmpresa.Properties.Items.IndexOf(CdsPesquisa.FieldByName('NmFantasiaNmRazaoSocial').AsString)));
    FrmNotaConsumoStarter.MkeNrCelular1.Text      := CdsPesquisa.FieldByName('NrCelular').AsString;
    FrmNotaConsumoStarter.EdtNmPessoa.Text        := CdsPesquisa.FieldByName('NmCliente').AsString;
    FrmNotaConsumoStarter.lIdCliente              := CdsPesquisa.FieldByName('IdCliente').AsInteger;
    FrmNotaConsumoStarter.lIdEmpCliente           := CdsPesquisa.FieldByName('IdEmpCliente').AsInteger;
  finally

  end;

end;

procedure TFrmNotaPesquisa.CopulaTelaNotaItem;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTelaNotaItem';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, True, lSnSituacao, 0, CdsPesquisa.FieldByName('IdEmpresa').AsInteger, CdsPesquisa.FieldByName('IdNota').AsInteger, 'Servico', '', FrmNotaConsumoStarter.CdsServico);
    unNotaItem.CarregaDbGrid(DtmPrincipal.Conexao, True, lSnSituacao, 0, CdsPesquisa.FieldByName('IdEmpresa').AsInteger, CdsPesquisa.FieldByName('IdNota').AsInteger, 'Produto', '', FrmNotaConsumoStarter.CdsProduto);
  finally

  end;
end;

procedure TFrmNotaPesquisa.CopulaTelaNotaPagamento;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTelaNotaPagamento';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unNotaPagamento.CarregaDbGrid(DtmPrincipal.Conexao, True, 2, 0, CdsPesquisa.FieldByName('IdEmpresa').AsInteger, CdsPesquisa.FieldByName('IdNota').AsInteger, 0, '', FrmNotaConsumoStarter.CdsTipoPagamento);
  finally

  end;
end;

procedure TFrmNotaPesquisa.CriaTelaNota;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'CriaTelaNota';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if FrmPrincipal.TasConsumo = Nil then
    begin
      FrmPrincipal.TasConsumo             := TTabSheet.Create(FrmPrincipal.PgcPrincipal);
      FrmPrincipal.TasConsumo.Caption     := 'Lançamento de Consumo';
      FrmPrincipal.TasConsumo.PageControl := FrmPrincipal.PgcPrincipal;
    end
    else
    begin
      FrmPrincipal.TasConsumo.TabVisible  := True;
    end;

    FrmPrincipal.PgcPrincipal.Visible := True;
    FrmPrincipal.PgcPrincipal.ActivePage := FrmPrincipal.TasConsumo;
    Application.CreateForm(TFrmNotaConsumoStarter, FrmNotaConsumoStarter);
    FrmNotaConsumoStarter.Parent := FrmPrincipal.TasConsumo;
    FrmNotaConsumoStarter.CarregarTela('Empresa');
    FrmNotaConsumoStarter.ControleBotao;
    FrmNotaConsumoStarter.Show;
  finally

  end;
end;

procedure TFrmNotaPesquisa.DbgPesquisaCellClick(Column: TColumn);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'DbgPesquisaCellClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  CopulaTela;
end;

procedure TFrmNotaPesquisa.DbgPesquisaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'DbgPesquisaDblClick';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnAlterarClick(Sender);

  inherited;
end;

procedure TFrmNotaPesquisa.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
    DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Nota';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    InicializarTela;
    BtnPesquisarClick(Sender);
  end;

  inherited;
end;

procedure TFrmNotaPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmPrincipal.TasConsultaNota.TabVisible := False;
  FrmPrincipal.PgcVisivel;
  inherited;
end;

procedure TFrmNotaPesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unNota          := TNota.Create;
  unNotaItem      := TNotaItem.Create;
  unNotaPagamento := TNotaPagamento.Create;
end;

procedure TFrmNotaPesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;

  DtpDtCalendario.Date  := Now;
  DtpDtCalendario.SetFocus;
end;

procedure TFrmNotaPesquisa.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if CdsServico.FieldCount > 0 then
  begin
    CdsServico.EmptyDataSet;
  end;
  if CdsProduto.FieldCount > 0 then
  begin
    CdsProduto.EmptyDataSet;
  end;
  if CdsTipoPagamento.FieldCount > 0 then
  begin
    CdsTipoPagamento.EmptyDataSet;
  end;

  PgcExtra.ActivePage   := TabServico;

  ControleBotao;
end;

procedure TFrmNotaPesquisa.Pesquisar(AConsulta: String);
var
  I           : Integer;
  lConsulta   : Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmNotaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Nota';
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
        unNota  := TNota.Create;

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

        unNota.CarregaDbGrid(DtmPrincipal.Conexao, lSnSituacao, 0, 0, EdtPesquisa.Text,  '1', StrToDateTime(FormatDateTime('DD/MM/YYYY', DtpDtCalendario.Date) + ' 00:00:00'), StrToDateTime(FormatDateTime('DD/MM/YYYY', DtpDtCalendario.Date) + ' 23:59:59'), CdsPesquisa);
      end;
    end;
  finally
    FrmProcessando.Destroy;
  end;

  inherited;
end;

end.
