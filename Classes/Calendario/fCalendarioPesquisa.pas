unit fCalendarioPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient,
  Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore,
  cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Menus, cxButtons;

type
  TFrmCalendarioPesquisa = class(TFrmPesquisa)
    Label13         : TLabel;
    RdbCalendario   : TRadioButton;
    RdbDiaNominal   : TRadioButton;
    DtpDtCalendario : TcxDateEdit;
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure DbgPesquisaDblClick(Sender: TObject);
    procedure RdbCalendarioClick(Sender: TObject);
    procedure RdbDiaNominalClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure DtpDtCalendarioKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure Pesquisar(AConsulta: String);
    procedure ControleBotao;
  public
    { Public declarations }
  end;

var
  FrmCalendarioPesquisa: TFrmCalendarioPesquisa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uMensagem, uCalendario, fCalendario, dRelatorios, uEmpresa, fAjuda;

var
  unCalendario: TCalendario;
  unEmpresa   : TEmpresa;
  dnRelatorios: TDtmRelatorios;

procedure TFrmCalendarioPesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmAjuda := TFrmAjuda.Create(Application);
    FrmAjuda.Caption        := 'Ajuda Sobre � Tela de ' +  Caption;;
    FrmAjuda.gNmTelaChamada := Name;
    FrmAjuda.ShowModal;
  finally
    FrmAjuda.Free;
  end;
end;

procedure TFrmCalendarioPesquisa.BtnAlterarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  if (CdsPesquisa.FieldCount > 0) then
  begin
    if CdsPesquisa.RecordCount > 0 then
    begin
      try
        FrmCalendario := TFrmCalendario.Create(Application);

        FrmCalendario.EdtIdRegistro.Text          := CdsPesquisa.FieldByName('IdCalendario').AsString;
        FrmCalendario.EdtNmUsuario.Text           := CdsPesquisa.FieldByName('NmUsuarioCadastro').AsString;
        FrmCalendario.DtpDtCalendario.Date        := CdsPesquisa.FieldByName('DtCalendario').AsDateTime;
        FrmCalendario.EdtNrAno.Text               := CdsPesquisa.FieldByName('NrAno').AsString;
        FrmCalendario.EdtNmMes.Text               := CdsPesquisa.FieldByName('NmMes').AsString;
        FrmCalendario.EdtNrMes.Text               := CdsPesquisa.FieldByName('NrMes').AsString;
        FrmCalendario.EdtNrDia.Text               := CdsPesquisa.FieldByName('NrDia').AsString;
        FrmCalendario.EdtNmDiaSemana.Text         := CdsPesquisa.FieldByName('NmDiaSemana').AsString;
        FrmCalendario.DtpDtInicioSemana.Date      := CdsPesquisa.FieldByName('DtInicioSemana').AsDateTime;
        FrmCalendario.DtpDtFinalSemana.Date       := CdsPesquisa.FieldByName('DtFinalSemana').AsDateTime;
        FrmCalendario.DtpDtInicioMes.Date         := CdsPesquisa.FieldByName('DtInicioMes').AsDateTime;
        FrmCalendario.DtpDtFinalMes.Date          := CdsPesquisa.FieldByName('DtFinalMes').AsDateTime;
        FrmCalendario.DtpDtInicioTrimestre.Date   := CdsPesquisa.FieldByName('DtInicioTrimestre').AsDateTime;
        FrmCalendario.DtpDtFinalTrimestre.Date    := CdsPesquisa.FieldByName('DtFinalTrimestre').AsDateTime;
        FrmCalendario.DtpDtInicioAno.Date         := CdsPesquisa.FieldByName('DtInicioAno').AsDateTime;
        FrmCalendario.DtpDtFinalAno.Date          := CdsPesquisa.FieldByName('DtFinalAno').AsDateTime;
        if CdsPesquisa.FieldByName('SnDiaUtil').AsInteger = 1 then
        begin
          FrmCalendario.ChkSnDiaUtil.Checked      := True;
        end
        else
        begin
          FrmCalendario.ChkSnDiaUtil.Checked      := False;
        end;
        if CdsPesquisa.FieldByName('SnDiaNaoUtil').AsInteger = 1 then
        begin
          FrmCalendario.ChkSnDiaNaoUtil.Checked   := True;
        end
        else
        begin
          FrmCalendario.ChkSnDiaNaoUtil.Checked   := False;
        end;
        if CdsPesquisa.FieldByName('SnFinalSemana').AsInteger = 1 then
        begin
          FrmCalendario.ChkSnFinalSemana.Checked  := True;
        end
        else
        begin
          FrmCalendario.ChkSnFinalSemana.Checked  := False;
        end;
        if CdsPesquisa.FieldByName('SnFeriado').AsInteger = 1 then
        begin
          FrmCalendario.ChkSnFeriado.Checked      := True;
        end
        else
        begin
          FrmCalendario.ChkSnFeriado.Checked      := False;
        end;
        if CdsPesquisa.FieldByName('SnDiaSemana').AsInteger = 1 then
        begin
          FrmCalendario.ChkSnDiaSemana.Checked    := True;
        end
        else
        begin
          FrmCalendario.ChkSnDiaSemana.Checked    := False;
        end;
        FrmCalendario.EdtNmDescricaoFeriado.Text  := CdsPesquisa.FieldByName('NmDescricaoFeriado').AsString;
        FrmCalendario.DtpDtCadastro.Date          := CdsPesquisa.FieldByName('DtCadastro').AsDateTime;

        ControleBotao;
        FrmCalendario.ShowModal;
      finally
        FrmCalendario.Free;
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

procedure TFrmCalendarioPesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmCalendarioPesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    dnRelatorios := TDtmRelatorios.Create(Self);
    unEmpresa    := TEmpresa.Create;
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelEmpresa);

    if RdbCalendario.Checked then
    begin
      unCalendario.CarregaDbGrid(DtmPrincipal.Conexao, 0, '', '0', DtpDtCalendario.Date, 0, dnRelatorios.CDSRelPesquisa);
    end
    else if RdbDiaNominal.Checked then
    begin
      unCalendario.CarregaDbGrid(DtmPrincipal.Conexao, 0, EdtPesquisa.Text, '-1', DtpDtCalendario.Date, 0, dnRelatorios.CDSRelPesquisa);
    end;

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel + 'Relatorio\RelPesqImpCalendario.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmCalendarioPesquisa.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  try
    FrmCalendario := TFrmCalendario.Create(Application);
    ControleBotao;
    FrmCalendario.ShowModal;
  finally
    FrmCalendario.Free;
  end;
end;

procedure TFrmCalendarioPesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmCalendarioPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text);
  inherited;
end;

procedure TFrmCalendarioPesquisa.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmCalendario.BtnIncluir.Enabled   := False;
  FrmCalendario.BtnSalvar.Enabled    := False;
  FrmCalendario.BtnCancelar.Enabled  := False;
  FrmCalendario.BtnFechar.Enabled    := True;

  if Trim(FrmCalendario.EdtIdRegistro.Text) <> '' then
  begin
    FrmCalendario.BtnIncluir.Enabled := True;
    FrmCalendario.BtnAnterior.Enabled:= True;
    FrmCalendario.BtnProximo.Enabled := True;
  end
  else
  begin
    FrmCalendario.BtnSalvar.Enabled  := True;
    FrmCalendario.BtnCancelar.Enabled:= True;
  end;
end;

procedure TFrmCalendarioPesquisa.DbgPesquisaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'DbgPesquisaDblClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  BtnAlterarClick(Sender);
  inherited;
end;

procedure TFrmCalendarioPesquisa.DtpDtCalendarioKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    EdtPesquisa.SetFocus;
  end;
end;

procedure TFrmCalendarioPesquisa.EdtPesquisaKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
    DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Calendario';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    BtnPesquisarClick(Sender);
  end;
  inherited;
end;

procedure TFrmCalendarioPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmCalendarioPesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmCalendarioPesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  RdbCalendario.SetFocus;
end;

procedure TFrmCalendarioPesquisa.Pesquisar(AConsulta: String);
var
  I: Integer;
  lConsulta: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
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
        unCalendario := TCalendario.Create(DtmPrincipal.Conexao);
        if RdbCalendario.Checked then
        begin
          unCalendario.CarregaDbGrid(DtmPrincipal.Conexao, 0, '', '0', DtpDtCalendario.Date, 0, CdsPesquisa);
        end
        else if RdbDiaNominal.Checked then
        begin
          unCalendario.CarregaDbGrid(DtmPrincipal.Conexao, 0, EdtPesquisa.Text, '-1', DtpDtCalendario.Date, 0, CdsPesquisa);
        end
        else
        begin
          MsgAtencao(uMensagem.UmFiltroDeveSerSelecionado);
        end;
      end;
    end;
  finally
    unCalendario.Free;
    FrmProcessando.Destroy;
  end;
  inherited;
end;

procedure TFrmCalendarioPesquisa.RdbCalendarioClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'RdbCalendarioClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  if RdbCalendario.Checked then
  begin
    RdbDiaNominal.Checked := False;
  end;
end;

procedure TFrmCalendarioPesquisa.RdbDiaNominalClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendarioPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'RdbDiaNominalClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  if RdbDiaNominal.Checked then
  begin
    RdbCalendario.Checked := False;
  end;
end;

end.
