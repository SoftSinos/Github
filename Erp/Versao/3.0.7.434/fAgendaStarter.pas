unit fAgendaStarter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils, dxSkinsCore, dxSkinsDefaultPainters, Data.DB, Datasnap.DBClient, Vcl.StdCtrls,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, cxSpinEdit, cxTimeEdit, Vcl.Grids, Vcl.DBGrids, Vcl.Menus, cxButtons, cxCheckBox, sPanel,
  sMonthCalendar;

type
  TFrmAgendaStarter = class(TFrmCadastro)
    PrbPesquisa             : TProgressBar;
    CdsProfissional         : TClientDataSet;
    DtsProfissional         : TDataSource;
    Panel1                  : TPanel;
    GroupBox1               : TGroupBox;
    Label2                  : TLabel;
    Label4                  : TLabel;
    Label5                  : TLabel;
    cxDateEdit1             : TcxDateEdit;
    cxTextEdit1             : TcxTextEdit;
    cxTextEdit2             : TcxTextEdit;
    cxCheckBox1             : TcxCheckBox;
    CldMesAtual             : TsMonthCalendar;
    Panel3                  : TPanel;
    Panel4                  : TPanel;
    BtnImprimir             : TcxButton;
    BtnPesquisar            : TcxButton;
    CdsAgenda               : TClientDataSet;
    DtsAgenda               : TDataSource;
    GroupBox2               : TGroupBox;
    DbgProfissional         : TDBGrid;
    GroupBox3               : TGroupBox;
    DbgAgenda               : TDBGrid;
    Panel2                  : TPanel;
    Label23                 : TLabel;
    CbbIdServico            : TcxComboBox;
    GroupBox4               : TGroupBox;
    Label11                 : TLabel;
    Label13                 : TLabel;
    Label6                  : TLabel;
    BtnClientePesquisar     : TcxButton;
    CbbIdEmpresa            : TcxComboBox;
    MkeNrCelular1           : TcxMaskEdit;
    EdtNmPessoa             : TcxTextEdit;
    EdtHrServico            : TcxTextEdit;
    BtnEmpresaPesquisa      : TcxButton;
    Panel5                  : TPanel;
    BtnDesfazerAgenda       : TcxButton;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure BtnClientePesquisarClick(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure MkeNrCelular1KeyPress(Sender: TObject; var Key: Char);
    procedure CbbIdServicoClick(Sender: TObject);
    procedure DbgAgendaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DbgProfissionalCellClick(Column: TColumn);
    procedure DbgAgendaDblClick(Sender: TObject);
    procedure CldMesAtualClick(Sender: TObject);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
    procedure MkeNrCelular1PropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure CldProximoMesClick(Sender: TObject);
    procedure CldMesAtualChange(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnDesfazerAgendaClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
    procedure Pesquisar(AIdEmpProfissional: Integer; AIdProfissional: Integer; ATpCalendario: Integer; AConsulta: String);
  public
    { Public declarations }
    procedure CarregarTela(ATpChamadaClasse:String);
    procedure CarregarAgenda;
    procedure SalvarAgenda(ATpChamadaClasse:String);
    procedure Edicao;
  end;

var
  FrmAgendaStarter: TFrmAgendaStarter;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uAgenda, fAjuda, fPrincipal, fPessoaPesquisa, dRelatorios, uEmpresa, uPessoa, uTipoServico, uServico;

var
  unAgenda         : TAgenda;
  unEmpresa        : TEmpresa;
  dnRelatorios     : TDtmRelatorios;
  unCarregaDados   : TCarregaDados;
  lTpChamadaClasse : Boolean;
  unPessoa         : TPessoa;
  unTipoServico    : TTipoServico;
  unServico        : TServico;
  lFormEdit        : Boolean;
  lIdEmpCliente    : Integer;
  lIdCliente       : Integer;
  lTpCalendario    : Integer;
  lDadosSalvos     : Boolean;

procedure TFrmAgendaStarter.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
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

procedure TFrmAgendaStarter.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  InicializarTela
end;

procedure TFrmAgendaStarter.BtnClientePesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnClientePesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmPessoaPesquisa         := TFrmPessoaPesquisa.Create(Application);
    FrmPessoaPesquisa.TpAcao  := 'CarregaDados';
    FrmPessoaPesquisa.ShowModal;
  finally
    if not FrmPessoaPesquisa.CdsPesquisa.IsEmpty then
    begin
      MkeNrCelular1.Text      := FrmPessoaPesquisa.CdsPesquisa.FieldByName('NrCelular').AsString;
      EdtNmPessoa.Text        := FrmPessoaPesquisa.CdsPesquisa.FieldByName('NmPessoa') .AsString;
      lIdCliente              := FrmPessoaPesquisa.CdsPesquisa.FieldByName('IdPessoa') .AsInteger;
      lIdEmpCliente           := FrmPessoaPesquisa.CdsPesquisa.FieldByName('IdEmpresa').AsInteger;
    end;
    FrmPessoaPesquisa.Free;
  end;
end;

procedure TFrmAgendaStarter.BtnDesfazerAgendaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnDesfazerAgendaClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  SalvarAgenda('Desfazer');
end;

procedure TFrmAgendaStarter.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if lFormEdit then
  begin
    if MsgConfirmacao(uMensagem.DesejaSairDaTelaSemSalvarOsDados) then
    begin
      inherited;
    end;
  end
  else
  begin
    inherited;
  end;
end;

procedure TFrmAgendaStarter.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
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
      unAgenda.CarregaDbGrid(DtmPrincipal.Conexao, 2, StrToInt(EdtIdRegistro.Text), 0, 0, 0, '', dnRelatorios.CDSRelPesquisa);
    end
    else
    begin
      unAgenda.CarregaDbGrid(DtmPrincipal.Conexao, 2, StrToInt(EdtIdRegistro.Text), 0, 0, 0, '', dnRelatorios.CDSRelPesquisa);
    end;

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\RelAgendaStarter.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmAgendaStarter.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmAgendaStarter.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  SalvarAgenda('Salvar');
end;

procedure TFrmAgendaStarter.CarregarAgenda;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarAgenda';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if not CdsProfissional.IsEmpty then
  begin
    if lTpCalendario = 0 then
    begin
      Pesquisar(CdsProfissional.FieldByName('IdEmpProfissional').AsInteger, CdsProfissional.FieldByName('IdProfissional').AsInteger, 0, '');
    end
    else
    if lTpCalendario = 1 then
    begin
      //Pesquisar(CdsProfissional.FieldByName('IdEmpProfissional').AsInteger, CdsProfissional.FieldByName('IdProfissional').AsInteger, 1, '');
    end;
  end;
end;

procedure TFrmAgendaStarter.CarregarTela(ATpChamadaClasse: String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  if ATpChamadaClasse = 'Geral' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', '', CbbIdEmpresa);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'TipoServico', 0, '', '', '', CbbIdServico);
  end
  else
  if ATpChamadaClasse = 'Empresa' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', '', CbbIdEmpresa);
  end
  else
  if ATpChamadaClasse = 'TipoServico' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'TipoServico', 0, '', '', '', CbbIdServico);
  end;

end;

procedure TFrmAgendaStarter.CbbIdServicoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdServicoClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((lIdCliente > 0) and (Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]) > 0) and (Integer(CbbIdServico.Properties.Items.Objects[CbbIdServico.ItemIndex]) > 0)) then
    begin
      unTipoServico.Buscar(DtmPrincipal.Conexao, Integer(CbbIdServico.Properties.Items.Objects[CbbIdServico.ItemIndex]));
      EdtHrServico.Text :=  TimeToStr(unTipoServico.HrServico);

      unServico.CarregaDbGrid(DtmPrincipal.Conexao, True, 1, 0, Integer(CbbIdServico.Properties.Items.Objects[CbbIdServico.ItemIndex]), '', CdsProfissional);

      if not CdsProfissional.IsEmpty then
      begin
        //Pesquisar(0, 0, 0, '');
      end;
    end;
  finally

  end;
end;

procedure TFrmAgendaStarter.CldMesAtualChange(Sender: TObject);
begin
  //Quando clicado no bot�o de avan�ar do calend�rio.
end;

procedure TFrmAgendaStarter.CldMesAtualClick(Sender: TObject);
var
  a,
  p: TDateTime;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CldMesAtualClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  lTpCalendario := 0;

  //CldProximoMes.Month := CldMesAtual.Month + 1;

  //Pesquisar(0, 0, 0, '');
end;

procedure TFrmAgendaStarter.CldProximoMesClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CldProximoMesClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  lTpCalendario := 1;

  //Pesquisar(0, 0, 1, '');
end;

procedure TFrmAgendaStarter.DbgAgendaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'DbgAgendaDblClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if not CdsAgenda.IsEmpty then
  begin
    if DbgAgenda.Columns.Grid.SelectedField.FieldName = 'SnSelecao' then
    begin
      if CdsAgenda.FieldByName('SnSelecao').AsBoolean then
      begin
        CdsAgenda.Edit;
        CdsAgenda.FieldByName('SnSelecao').AsBoolean := False;
        CdsAgenda.Post;
      end
      else
      begin
        CdsAgenda.Edit;
        CdsAgenda.FieldByName('SnSelecao').AsBoolean := True;
        CdsAgenda.Post;
      end;
    end;
  end;
  BtnSalvar.Enabled := True;

end;

procedure TFrmAgendaStarter.DbgAgendaDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  Check: Integer;
  R: TRect;
begin
  if Column.FieldName = 'SnSelecao' then
  begin
   DbgAgenda.Canvas.FillRect(Rect);
   Check := 0;
    if CdsAgenda.FieldByName('SnSelecao').AsBoolean then
    begin
      Check := DFCS_CHECKED
    end
    else
    begin
      Check := 0;
    end;
    R := Rect;
    InflateRect(R, -2, -2);
    DrawFrameControl(DbgAgenda.Canvas.Handle, R, DFC_BUTTON, DFCS_BUTTONCHECK or Check);
  end;
end;

procedure TFrmAgendaStarter.DbgProfissionalCellClick(Column: TColumn);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'DbgProfissionalCellClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  CarregarAgenda;
end;

procedure TFrmAgendaStarter.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPessoa';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'Pessoa';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if not lTpChamadaClasse then
  begin
    BtnIncluir.Enabled   := False;
    BtnSalvar.Enabled    := True;
    BtnCancelar.Enabled  := True;
    BtnFechar.Enabled    := True;
    BtnAnterior.Enabled  := False;
    BtnProximo.Enabled   := False;
  end;
  lFormEdit := True
end;

procedure TFrmAgendaStarter.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unAgenda.Free;
  FrmPrincipal.TasAgenda.TabVisible := False;
  FrmPrincipal.PgcVisivel;
end;

procedure TFrmAgendaStarter.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;
  unAgenda       := TAgenda.Create;
  unPessoa       := TPessoa.Create;
  unTipoServico  := TTipoServico.Create;
end;

procedure TFrmAgendaStarter.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if not DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.Enabled        := False;
    CbbIdEmpresa.ItemIndex      := Integer(CbbIdEmpresa.Properties.Items.IndexOf(DtmPrincipal.NmFantasiaNmRazaoSocial));
    MkeNrCelular1.SetFocus;
  end
  else
  begin
    CbbIdEmpresa.Enabled        := True;
    CbbIdEmpresa.SetFocus;
  end;

  InicializarTela;
end;

procedure TFrmAgendaStarter.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unAgenda.IdAgenda          := 0;
  EdtNmUsuario.Clear;
  ChkSnSituacao.Caption      := 'Cadastro Ativo';
  if DtmPrincipal.UsuarioAdministrador then
  begin
    CbbIdEmpresa.ItemIndex   := 0;
  end
  else
  begin
    MkeNrCelular1.SetFocus;
  end;
  MkeNrCelular1.Clear;
  lIdCliente                 := 0;
  lIdEmpCliente              := 0;
  EdtNmPessoa.Clear;
  EdtHrServico.Clear;

  if CdsProfissional.FieldCount > 0 then
  begin
    CdsProfissional.EmptyDataSet;
  end;

  if CdsAgenda.FieldCount > 0 then
  begin
    CdsAgenda.EmptyDataSet;
  end;

  CldMesAtual.Day     := StrToInt(FormatDateTime('DD', Now));
  CldMesAtual.Month   := StrToInt(FormatDateTime('MM', Now));
  CldMesAtual.Year    := StrToInt(FormatDateTime('YYYY', Now));

  //CldProximoMes.Month := StrToInt(FormatDateTime('MM', Now)) + 1;
  lFormEdit := False;
end;

procedure TFrmAgendaStarter.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPeTFrmAgendaStarterssoa';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmAgendaStarter.MkeNrCelular1KeyPress(Sender: TObject; var Key: Char);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'EdtNrCelular1KeyPress';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Key = #13) then
  begin
    lIdCliente    := 0;
    lIdEmpCliente := 0;
    EdtNmPessoa.Clear;
    unPessoa.Inicializar;
    unPessoa.BuscarNrCelular(DtmPrincipal.Conexao, RemoveCaracteres(MkeNrCelular1.Text));

    if unPessoa.IdPessoa > 0 then
    begin
      EdtNmPessoa.Text          := unPessoa.NmPessoa;
      lIdCliente                := unPessoa.IdPessoa;
      lIdEmpCliente             := unPessoa.IdEmpresa;

      CbbIdServico.SetFocus;
    end;
  end;
end;

procedure TFrmAgendaStarter.MkeNrCelular1PropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Length(Trim(RemoveCaracteres(TcxMaskEdit(Sender).Text))) < 11) then
  begin
    MsgAtencao(uMensagem.OValorDeveCompletarTodaAMascaraDoCampo);
    Error := False;
  end;
end;

procedure TFrmAgendaStarter.Pesquisar(AIdEmpProfissional: Integer; AIdProfissional: Integer; ATpCalendario: Integer; AConsulta: String);
var
  I: Integer;
  lConsulta: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
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
        lConsulta  := 1;
        unAgenda   := TAgenda.Create;

        if ATpCalendario = 0 then
        begin
          unAgenda.CarregaDbGrid(DtmPrincipal.Conexao, 1, 0, AIdEmpProfissional, AIdProfissional, CldMesAtual.CalendarDate, AConsulta, CdsAgenda);
        end
        else
        if ATpCalendario = 1 then
        begin
          //unAgenda.CarregaDbGrid(DtmPrincipal.Conexao, 1, 0, AIdEmpProfissional, AIdProfissional, CldProximoMes.CalendarDate, AConsulta, CdsAgenda);
        end;
      end;
    end;
  finally
    FrmProcessando.Destroy;
  end;

  inherited;
end;

procedure TFrmAgendaStarter.SalvarAgenda(ATpChamadaClasse: String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'SalvarAgenda';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    unAgenda.Inicializar;

    if CdsAgenda.RecordCount > 0 then
    begin
      CdsAgenda.DisableControls;
      CdsProfissional.DisableControls;
      CdsAgenda.First;

      while not CdsAgenda.Eof do
      begin
        if CdsAgenda.FieldByName('SnSelecao').AsBoolean then
        begin
          unAgenda.IdAgenda     := CdsAgenda.FieldByName('IdAgenda'    ).AsInteger;
          unAgenda.IdEmpresa    := Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]);
          unAgenda.SnSituacao   := 1;
          unAgenda.SnRealizada  := 0;
          unAgenda.IdUsuario    := DtmPrincipal.IdUsuarioLogado;

          if ATpChamadaClasse = 'Salvar' then
          begin
            unAgenda.IdTpServico  := Integer(CbbIdServico.Properties.Items.Objects[CbbIdServico.ItemIndex]);
            unAgenda.IdEmpCliente := lIdEmpCliente;
            unAgenda.IdCliente    := lIdCliente;

            try
              unAgenda.Salvar(DtmPrincipal.Conexao);
            finally
              MsgInformacao(uMensagem.AgendaGeradaComSucesso);
            end;
          end
          else
          if ATpChamadaClasse = 'Desfazer' then
          begin
            try
              uProcedure.Agendar(DtmPrincipal.IdEmpresaLogada, 0, 0, '', CdsAgenda.FieldByName('IdAgenda').AsInteger, 'DesfazerAgenda');
            finally
              MsgInformacao(uMensagem.AnuladaAgenda);
            end;
          end;

          try
            CarregarAgenda;
          finally
            lDadosSalvos := True;
          end;
        end;
        CdsAgenda.Next;
      end;
    end;
   finally
     if lDadosSalvos then
     begin
       CdsAgenda.First;
       CdsAgenda.EnableControls;
       CdsProfissional.EnableControls;
       lDadosSalvos        := False;
       BtnAnterior.Enabled := False;
       BtnProximo.Enabled  := False;
     end;
  end;

end;

end.