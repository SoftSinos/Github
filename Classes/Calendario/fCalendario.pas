unit fCalendario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxCore, cxDateUtils, cxTextEdit, cxMaskEdit, cxDropDownEdit,
  cxCalendar, Data.DB, Datasnap.DBClient, Vcl.Menus, cxButtons, cxCheckBox;

type
  TFrmCalendario = class(TFrmCadastro)
    GroupBox1             : TGroupBox;
    DtpDtInicioSemana     : TDateTimePicker;
    Label2                : TLabel;
    Label4                : TLabel;
    Label7                : TLabel;
    Label8                : TLabel;
    Label10               : TLabel;
    Label11               : TLabel;
    DtpDtFinalSemana      : TDateTimePicker;
    DtpDtInicioMes        : TDateTimePicker;
    DtpDtFinalMes         : TDateTimePicker;
    DtpDtInicioAno        : TDateTimePicker;
    DtpDtFinalAno         : TDateTimePicker;
    DtpDtInicioTrimestre  : TDateTimePicker;
    DtpDtFinalTrimestre   : TDateTimePicker;
    Label13               : TLabel;
    Label14               : TLabel;
    Label15               : TLabel;
    Label16               : TLabel;
    Label17               : TLabel;
    Label18               : TLabel;
    Label19               : TLabel;
    Label20               : TLabel;
    Label21               : TLabel;
    DtpDtCalendario       : TcxDateEdit;
    EdtNmDiaSemana        : TcxTextEdit;
    EdtNmMes              : TcxTextEdit;
    EdtNrDia              : TcxTextEdit;
    EdtNrMes              : TcxTextEdit;
    EdtNrAno              : TcxTextEdit;
    EdtNmDescricaoFeriado : TcxTextEdit;
    EdtNmFeriadoTrocado   : TcxTextEdit;
    ChkSnDiaSemana        : TcxCheckBox;
    ChkSnFinalSemana      : TcxCheckBox;
    ChkSnDiaUtil          : TcxCheckBox;
    ChkSnDiaNaoUtil       : TcxCheckBox;
    ChkSnFeriado          : TcxCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CopulaTela;
    procedure Edicao;
  end;

var
  FrmCalendario: TFrmCalendario;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uMensagem, uCalendario, uProcedure, fAjuda;

var
  unCalendario     : TCalendario;
  lTpChamadaClasse : Boolean;

  { TFrmCalendario }

procedure TFrmCalendario.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
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
end;


procedure TFrmCalendario.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmCalendario.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
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

procedure TFrmCalendario.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Calendario', 'Anterior', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmCalendario.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmCalendario.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmCalendario.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmCalendario.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Calendario', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmCalendario.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    if Trim(EdtIdRegistro.Text) <> '' then
    begin
      unCalendario.IdCalendario     := StrToInt(EdtIdRegistro.Text);
    end
    else
    begin
      unCalendario.IdCalendario     := 0;
    end;
    unCalendario.DtCalendario       := DtpDtCalendario.Date;
    unCalendario.IdUsuario          := DtmPrincipal.IdUsuarioLogado;
    unCalendario.NrAno              := StrToInt(EdtNrAno.Text);
    unCalendario.NmMes              := EdtNmMes.Text;
    unCalendario.NrMes              := StrToInt(EdtNrMes.Text);
    unCalendario.NrDia              := StrToInt(EdtNrDia.Text);
    unCalendario.NmDiaSemana        := EdtNmDiaSemana.Text;
    unCalendario.DtInicioSemana     := DtpDtInicioSemana.Date;
    unCalendario.DtFinalSemana      := DtpDtFinalSemana.Date;
    unCalendario.DtInicioMes        := DtpDtInicioMes.Date;
    unCalendario.DtFinalMes         := DtpDtFinalMes.Date;
    unCalendario.DtInicioTrimestre  := DtpDtInicioTrimestre.Date;
    unCalendario.DtFinalTrimestre   := DtpDtFinalTrimestre.Date;
    unCalendario.DtInicioAno        := DtpDtInicioAno.Date;
    unCalendario.DtFinalAno         := DtpDtFinalAno.Date;
    if ChkSnDiaUtil.Checked then
    begin
      unCalendario.SnDiaUtil        := 1;
    end
    else
    begin
      unCalendario.SnDiaUtil        := 0;
    end;
    if ChkSnDiaNaoUtil.Checked then
    begin
      unCalendario.SnDiaNaoUtil     := 1;
    end
    else
    begin
      unCalendario.SnDiaNaoUtil     := 0;
    end;
    if ChkSnFinalSemana.Checked then
    begin
      unCalendario.SnFinalSemana    := 1;
    end
    else
    begin
      unCalendario.SnFinalSemana    := 0;
    end;
    if ChkSnFeriado.Checked then
    begin
      unCalendario.SnFeriado        := 1;
    end
    else
    begin
      unCalendario.SnFeriado        := 0;
    end;
    if ChkSnDiaSemana.Checked then
    begin
      unCalendario.SnDiaSemana      := 1;
    end
    else
    begin
      unCalendario.SnDiaSemana      := 0;
    end;
    unCalendario.NmDescricaoFeriado := EdtNmDescricaoFeriado.Text;
    unCalendario.DtCadastro         := Now;
    unCalendario.NmFeriadoTrocado   := EdtNmFeriadoTrocado.Text;

    if unCalendario.Salvar(DtmPrincipal.Conexao) then
    begin
      MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);
    end;
  finally

  end;
end;

procedure TFrmCalendario.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unCalendario.CarregaDbGrid(DtmPrincipal.Conexao, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', '', 0, 0, CdsCopula);

    lTpChamadaClasse := True;

    EdtIdRegistro.Text        := CdsCopula.FieldByName('IdCalendario').AsString;
    DtpDtCalendario.Date      := CdsCopula.FieldByName('DtCalendario').AsDateTime;
    EdtNmUsuario.Text         := CdsCopula.FieldByName('NmUsuarioCadastro').AsString;
    EdtNrAno.Text             := CdsCopula.FieldByName('NrAno').AsString;
    EdtNmMes.Text             := CdsCopula.FieldByName('NmMes').AsString;
    EdtNrMes.Text             := CdsCopula.FieldByName('NrMes').AsString;
    EdtNrDia.Text             := CdsCopula.FieldByName('NrDia').AsString;
    EdtNmDiaSemana.Text       := CdsCopula.FieldByName('NmDiaSemana').AsString;
    DtpDtInicioSemana.Date    := CdsCopula.FieldByName('DtInicioSemana').AsDateTime;
    DtpDtFinalSemana.Date     := CdsCopula.FieldByName('DtFinalSemana').AsDateTime;
    DtpDtInicioMes.Date       := CdsCopula.FieldByName('DtInicioMes').AsDateTime;
    DtpDtFinalMes.Date        := CdsCopula.FieldByName('DtFinalMes').AsDateTime;
    DtpDtInicioTrimestre.Date := CdsCopula.FieldByName('DtInicioTrimestre').AsDateTime;
    DtpDtFinalTrimestre.Date  := CdsCopula.FieldByName('DtFinalTrimestre').AsDateTime;
    DtpDtInicioAno.Date       := CdsCopula.FieldByName('DtInicioAno').AsDateTime;
    DtpDtFinalAno.Date        := CdsCopula.FieldByName('DtFinalAno').AsDateTime;
    if CdsCopula.FieldByName('SnDiaUtil').AsInteger = 1 then
    begin
      ChkSnDiaUtil.Checked    := True;
    end
    else
    begin
      ChkSnDiaUtil.Checked    := False;
    end;
    if CdsCopula.FieldByName('SnDiaNaoUtil').AsInteger = 1 then
    begin
      ChkSnDiaNaoUtil.Checked := True;
    end
    else
    begin
      ChkSnDiaNaoUtil.Checked := False;
    end;
    if CdsCopula.FieldByName('SnFinalSemana').AsInteger = 1 then
    begin
      ChkSnFinalSemana.Checked:= True;
    end
    else
    begin
      ChkSnFinalSemana.Checked:= False;
    end;
    if CdsCopula.FieldByName('SnFeriado').AsInteger = 1 then
    begin
      ChkSnFeriado.Checked    := True;
    end
    else
    begin
      ChkSnFeriado.Checked    := False;
    end;
    if CdsCopula.FieldByName('SnDiaSemana').AsInteger = 1 then
    begin
      ChkSnDiaSemana.Checked  := True;
    end
    else
    begin
      ChkSnDiaSemana.Checked  := False;
    end;
    EdtNmDescricaoFeriado.Text:= CdsCopula.FieldByName('NmDescricaoFeriado').AsString;
    DtpDtCadastro.Date        := CdsCopula.FieldByName('DtCadastro').AsDateTime;
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmCalendario.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmCalendario.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCalendario := TCalendario.Create(DtmPrincipal.Conexao);
end;

procedure TFrmCalendario.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  DtpDtCalendario.SetFocus;
end;

procedure TFrmCalendario.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCalendario';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Calendario';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  DtpDtCalendario.Date      := Now;
  EdtNmUsuario.Clear;
  EdtNmDiaSemana.Clear;
  EdtNmMes.Clear;
  EdtNrDia.Clear;
  EdtNrMes.Clear;
  EdtNrAno.Clear;
  if ChkSnDiaSemana.Checked then
  begin
    ChkSnDiaSemana.Checked  := False;
  end;
  if ChkSnFinalSemana.Checked then
  begin
    ChkSnDiaUtil.Checked    := False;
  end;
  if ChkSnDiaNaoUtil.Checked then
  begin
    ChkSnFeriado.Checked    := False;
  end;
  EdtNmDescricaoFeriado.Clear;
  DtpDtInicioSemana.Date    := Now;
  DtpDtFinalSemana.Date     := Now;
  DtpDtInicioMes.Date       := Now;
  DtpDtFinalMes.Date        := Now;
  DtpDtInicioAno.Date       := Now;
  DtpDtFinalAno.Date        := Now;
  DtpDtInicioTrimestre.Date := Now;
  DtpDtFinalTrimestre.Date  := Now;
  DtpDtCalendario.SetFocus;
end;

end.
