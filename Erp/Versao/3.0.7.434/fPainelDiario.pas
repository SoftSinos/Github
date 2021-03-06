unit fPainelDiario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fOperacao, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, Vcl.Grids, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, Datasnap.DBClient, Vcl.DBGrids;

type
  TFrmPainelDiario = class(TFrmOperacao)
    StgGrid           : TStringGrid;
    BtnAtualizar      : TcxButton;
    CdsHorarios       : TClientDataSet;
    CdsProfissionais  : TClientDataSet;
    CdsAgenda         : TClientDataSet;
    PrbPesquisa       : TProgressBar;
    BtnAgenda         : TcxButton;
    BtnPeriodo        : TcxButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnAtualizarClick(Sender: TObject);
    procedure StgGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure BtnAgendaClick(Sender: TObject);
    procedure BtnPeriodoClick(Sender: TObject);
  private
    { Private declarations }
    procedure InicializarTela;
    procedure Pesquisar(AConsulta: String);
  public
    { Public declarations }
    procedure DesenhaGrid;
    procedure CarregarCabecalhos;
    procedure CarregarTela(ATpChamadaClasse:String);
  end;

var
  FrmPainelDiario: TFrmPainelDiario;

implementation

{$R *.dfm}

uses uFuncao, dPrincipal, fPrincipal, uConfiguracao, uPessoa, uAgenda, fProcessando, fAgendaStarter, uMensagem;

var
  unConfiguracao : TConfiguracao;
  unPessoa       : TPessoa;
  unAgenda       : TAgenda;
  lDataEntrada   : String;
  lNrColuna      : Integer;
  lNrLinha       : Integer;

procedure TFrmPainelDiario.BtnAgendaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAgendaClick';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if FrmPrincipal.TasAgenda = Nil then
    begin
      FrmPrincipal.TasAgenda             := TTabSheet.Create(FrmPrincipal.PgcPrincipal);
      FrmPrincipal.TasAgenda.Caption     := 'Agenda do Profissional';
      FrmPrincipal.TasAgenda.PageControl := FrmPrincipal.PgcPrincipal;
    end
    else
    begin
      FrmPrincipal.TasAgenda.TabVisible  := True;
    end;

    FrmPrincipal.PgcPrincipal.Visible    := True;
    FrmPrincipal.PgcPrincipal.ActivePage := FrmPrincipal.TasAgenda;
    Application.CreateForm(TFrmAgendaStarter, FrmAgendaStarter);
    FrmAgendaStarter.Parent              := FrmPrincipal.TasAgenda;
    FrmAgendaStarter.CarregarTela('Geral');
    FrmAgendaStarter.Show;
  finally

  end;
end;

procedure TFrmPainelDiario.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmPainelDiario.BtnAtualizarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAtualizarClick';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmPainelDiario.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmPainelDiario.BtnPeriodoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPeriodoClick';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  MsgAtencao(uMensagem.TelaASerImplementada);
  //lDataEntrada := Inputbox('Periodo','Pesquisar Data','DD/MM/YYYY');

  //Pesquisar(lDataEntrada);
end;

procedure TFrmPainelDiario.CarregarCabecalhos;
var
  I : Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarCabecalhos';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unAgenda.CarregaDbGridHorarios(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada, CdsHorarios);
  unPessoa.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, '', 0, 'Funcionario', CdsProfissionais);

  CdsHorarios.First;

  while not CdsHorarios.Eof do
  begin
    for I := 1 to CdsHorarios.RecordCount do
    begin
      StgGrid.Cells[0, I] := 'Hor�rio' + #13 + #13 + CdsHorarios.FieldByName('HrAgenda').AsString ;
      CdsHorarios.Next;
    end;
  end;

  CdsProfissionais.First;

  while not CdsProfissionais.Eof do
  begin
    for I := 1 to CdsProfissionais.RecordCount do
    begin
      StgGrid.Cells[I, 0] := 'Profissional' + #13 + #13 + CdsProfissionais.FieldByName('NmApelido').AsString ;
      CdsProfissionais.Next;
    end;
  end;
end;

procedure TFrmPainelDiario.CarregarTela(ATpChamadaClasse: String);
var
  I         : Integer;
  lNrCol    : Integer;
  lPesquisa : String;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  lNrCol := 0;

  CdsProfissionais.First;

  while not CdsProfissionais.Eof do
  begin
    lPesquisa := 'IdProfissional = ' + CdsProfissionais.FieldByName('IdPessoa').AsString;

    CdsAgenda.Filtered := False;
    CdsAgenda.Filter   := lPesquisa;
    CdsAgenda.Filtered := True;

    lNrCol := lNrCol + 1;

    CdsAgenda.First;

    while not CdsAgenda.Eof do
    begin
      for I := 1 to CdsAgenda.RecordCount do
      begin
        StgGrid.Cells[lNrCol, I] := (CdsAgenda.FieldByName('StAgenda').AsString + #13 +
                                     CdsAgenda.FieldByName('NmTpServico').AsString + #13 +
                                     CdsAgenda.FieldByName('NmCliente').AsString + #13 +
                                     CdsAgenda.FieldByName('NrCelular').AsString);
        CdsAgenda.Next;
      end;
    end;

    CdsProfissionais.Next;
  end;
end;

procedure TFrmPainelDiario.DesenhaGrid;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'DesenhaGrid';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  StgGrid.RowCount := StrToInt(unConfiguracao.NmValor) + 2 {Gera��o da linha de titulo};
  StgGrid.ColCount := unPessoa.NumeroPessoaTipoPessoa(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada, 'Funcionario') + 1 {Gera��o da coluna de titulo};

  lNrLinha  := StgGrid.RowCount;
  lNrColuna := StgGrid.ColCount;
end;

procedure TFrmPainelDiario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmPrincipal.TasPainel.TabVisible := False;
  FrmPrincipal.PgcVisivel;
end;

procedure TFrmPainelDiario.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unConfiguracao := TConfiguracao.Create;
  unPessoa       := TPessoa.Create;
  unAgenda       := TAgenda.Create;
end;

procedure TFrmPainelDiario.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unConfiguracao.Buscar(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada, 'NTTA');

  InicializarTela;
end;

procedure TFrmPainelDiario.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  DesenhaGrid;
  CarregarCabecalhos;
  Pesquisar('');
  CarregarTela('');
end;

procedure TFrmPainelDiario.Pesquisar(AConsulta: String);
var
  I: Integer;
  lConsulta: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAgendaStarter';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
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

        if AConsulta = '' then
        begin
          unAgenda.CarregaDbGrid(DtmPrincipal.Conexao, 1, 0, DtmPrincipal.IdEmpresaLogada, 0, StrToDate(FormatDateTime('DD/MM/YYYY', Now)), '', CdsAgenda);
        end
        else
        begin
          unAgenda.CarregaDbGrid(DtmPrincipal.Conexao, 1, 0, DtmPrincipal.IdEmpresaLogada, 0, StrToDate(lDataEntrada), '', CdsAgenda);

        end;
      end;
    end;
  finally
    FrmProcessando.Destroy;
  end;

  inherited;
end;

procedure TFrmPainelDiario.StgGridDrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  sTexto: String;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmPainelDiario';
  DtmPrincipal.unLog.NmMetodo   := 'StgGridDrawCell';
  DtmPrincipal.unLog.NmTabela   := 'Painel';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  //Pinta a coluna 0 X todas as linhas
  if (ACol = 0) then
  begin
    with TStringGrid(Sender) do
    begin
      Canvas.Brush.Color := clSilver;
      Canvas.FillRect(Rect);
    end;
  end;

  //Pinta a linha 0 X todas as Colunas
  if (ARow = 0) then
  begin
    with TStringGrid(Sender) do
    begin
      Canvas.Brush.Color := clSilver;
      Canvas.FillRect(Rect);
    end;
  end;

  //Pint�o celula sim, celula n�o, coluna sim, coluna n�o.
  if (ACol > 0) and (ARow > 0) then
  begin
    with TStringGrid(Sender) do
    begin
      if Odd(ACol) and Odd(ARow) then
      begin
        Canvas.Brush.Color := $0080FF80;
      end
      else
      if not Odd(ARow) and Odd(ACol) then
      begin
        Canvas.Brush.Color := $00BBBBFF;
      end
      else
      if not Odd(ARow) then
      begin
        Canvas.Brush.Color := $0080FFFF;
      end
      else
      if not Odd(ACol) then
      begin
        Canvas.Brush.Color := $00FFFF80;
      end;

      Canvas.FillRect(Rect);
    end;
  end;

  //Quebra de linha para o texto.
  if (ARow > -1) and (ACol > -1) then
  begin
    with TStringGrid(Sender) do
    begin
      Canvas.FillRect(Rect);
      sTexto := Cells[ACol, ARow];
      Canvas.TextRect(Rect, sTexto, [tfWordBreak,tfVerticalCenter,tfCenter]);
    end;
  end;
end;

end.
