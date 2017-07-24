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
    Panel5                  : TPanel;
    Label11                 : TLabel;
    BtnClientePesquisar     : TcxButton;
    MkeNrCelular1           : TcxMaskEdit;
    EdtNmPessoa             : TcxTextEdit;
    EdtIdCliente            : TcxTextEdit;
    GroupBox2               : TGroupBox;
    DbgProfissional         : TDBGrid;
    GroupBox3               : TGroupBox;
    DbgAgenda               : TDBGrid;
    Panel2                  : TPanel;
    Label23                 : TLabel;
    Label7                  : TLabel;
    Label3                  : TLabel;
    CbbIdServico            : TcxComboBox;
    CbbIdEmpresa            : TcxComboBox;
    DtpHrServico            : TcxTimeEdit;
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
  private
    { Private declarations }
    procedure InicializarTela;
    procedure Pesquisar(AIdEmpProfissional: Integer; AIdProfissional: Integer; AConsulta: String);
  public
    { Public declarations }
    procedure CarregarTela(ATpChamadaClasse:String);
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

procedure TFrmAgendaStarter.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
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
      MkeNrCelular1.Text      := FrmPessoaPesquisa.CdsPesquisa.FieldByName('NrCelular')  .AsString;
      EdtNmPessoa.Text        := FrmPessoaPesquisa.CdsPesquisa.FieldByName('NmPessoa')   .AsString;
      EdtIdCliente.Text       := FrmPessoaPesquisa.CdsPesquisa.FieldByName('IdPessoa')   .AsString;
    end;
    FrmPessoaPesquisa.Free;
  end;
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
    if ((Trim(EdtIdCliente.Text) <> '') and (Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]) > 0) and (Integer(CbbIdServico.Properties.Items.Objects[CbbIdServico.ItemIndex]) > 0)) then
    begin
      unTipoServico.Buscar(DtmPrincipal.Conexao, Integer(CbbIdServico.Properties.Items.Objects[CbbIdServico.ItemIndex]));
      DtpHrServico.Time := unTipoServico.HrServico;

      unServico.CarregaDbGrid(DtmPrincipal.Conexao, True, 1, 0, Integer(CbbIdServico.Properties.Items.Objects[CbbIdServico.ItemIndex]), '', CdsProfissional);

      if not CdsProfissional.IsEmpty then
      begin
        Pesquisar(0, 0, '');
      end;
    end;
  finally

  end;
end;

procedure TFrmAgendaStarter.CldMesAtualClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'CldMesAtualClick';
  DtmPrincipal.unLog.NmTabela   := 'Agenda';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  Pesquisar(0, 0, '');
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

  if not CdsProfissional.IsEmpty then
  begin
    Pesquisar(CdsProfissional.FieldByName('IdEmpProfissional').AsInteger, CdsProfissional.FieldByName('IdProfissional').AsInteger, '');
  end;
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
  EdtIdCliente.Clear;
  EdtNmPessoa.Clear;
  DtpHrServico.Time := 0;

  if CdsProfissional.FieldCount > 0 then
  begin
    CdsProfissional.EmptyDataSet;
  end;

  if CdsAgenda.FieldCount > 0 then
  begin
    CdsAgenda.EmptyDataSet;
  end;

  CldMesAtual.Day   := StrToInt(FormatDateTime('DD', Now));
  CldMesAtual.Month := StrToInt(FormatDateTime('MM', Now));
  CldMesAtual.Year  := StrToInt(FormatDateTime('YYYY', Now));

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
    EdtIdCliente.Clear;
    EdtNmPessoa.Clear;
    unPessoa.Inicializar;
    unPessoa.BuscarNrCelular(DtmPrincipal.Conexao, RemoveCaracteres(MkeNrCelular1.Text));

    if unPessoa.IdPessoa > 0 then
    begin
      EdtNmPessoa.Text          := unPessoa.NmPessoa;
      EdtIdCliente.Text         := IntToStr(unPessoa.IdPessoa);

      if DtmPrincipal.UsuarioAdministrador then
      begin
        CbbIdEmpresa.SetFocus;
      end
      else
      begin
        CbbIdServico.SetFocus;
      end;
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

procedure TFrmAgendaStarter.Pesquisar(AIdEmpProfissional: Integer; AIdProfissional: Integer; AConsulta: String);
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

        unAgenda.CarregaDbGrid(DtmPrincipal.Conexao, 1, 0, AIdEmpProfissional, AIdProfissional, CldMesAtual.CalendarDate,
                               AConsulta, CdsAgenda);
      end;
    end;
  finally
    unAgenda.Free;
    FrmProcessando.Destroy;
  end;

  inherited;
end;

end.
