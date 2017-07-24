unit fCepPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient, Vcl.ComCtrls, Vcl.Buttons, Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxMaskEdit, cxDropDownEdit, cxTextEdit, Vcl.Menus, cxButtons;

type
  TFrmCepPesquisa = class(TFrmPesquisa)
    Label6      : TLabel;
    Label5      : TLabel;
    CbbIdCidade : TcxComboBox;
    CbbIdUf     : TcxComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
    procedure DbgPesquisaDblClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure CbbIdUfKeyPress(Sender: TObject; var Key: Char);
    procedure CbbIdUfEditing(Sender: TObject; var CanEdit: Boolean);
    procedure CbbIdUfExit(Sender: TObject);
    procedure CbbIdCidadeKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure Pesquisar(AConsulta: String);
    procedure ControleBotao;
  public
    TpAcao   : String;
    { Public declarations }
    procedure CarregarTela;

  end;

var
  FrmCepPesquisa: TFrmCepPesquisa;

implementation

{$R *.dfm}

{ TFrmCepPesquisa }

uses dPrincipal, uFuncao, fProcessando, uMensagem, uCep, fCep, dRelatorios, uEmpresa, uCarregaDados, fAjuda;

var
  unCep         : TCep;
  unEmpresa     : TEmpresa;
  dnRelatorios  : TDtmRelatorios;
  unCarregaDados: TCarregaDados;

procedure TFrmCepPesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
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

procedure TFrmCepPesquisa.BtnAlterarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  if (CdsPesquisa.FieldCount > 0) then
  begin
    if CdsPesquisa.RecordCount > 0 then
    begin
      try
        FrmCep := TFrmCep.Create(Application);

        FrmCep.PnlCampos.Enabled          := True;
        FrmCep.EdtIdRegistro.Text         := CdsPesquisa.FieldByName('IdCep'              ).AsString;
        FrmCep.EdtNmUsuario.Text          := CdsPesquisa.FieldByName('NmUsuarioCadastro'  ).AsString;
        FrmCep.DtpDtCadastro.Date         := CdsPesquisa.FieldByName('DtCadastro'         ).AsDateTime;
        if CdsPesquisa.FieldByName('SnSituacao').AsString = 'ATIVO' then
        begin
          FrmCep.ChkSnSituacao.Checked    := True;
          FrmCep.ChkSnSituacao.Caption    := 'Cadastro Ativo';
        end
        else
        begin
          FrmCep.ChkSnSituacao.Checked    := False;
          FrmCep.ChkSnSituacao.Caption    := 'Cadastro Inativo';
        end;
        FrmCep.MkeNrCep.Text              := CdsPesquisa.FieldByName('NrCep'              ).AsString;
        FrmCep.EdtNmTpLogradouro.Text     := CdsPesquisa.FieldByName('NmTpLogradouro'     ).AsString;
        FrmCep.EdtNmLogradouro.Text       := CdsPesquisa.FieldByName('NmLogradouro'       ).AsString;
        FrmCep.EdtNmBairro.Text           := CdsPesquisa.FieldByName('NmBairro'           ).AsString;

        FrmCep.CarregarTela(Integer(CbbIdUf.Properties.Items.Objects[CbbIdUf.ItemIndex]), Integer(CbbIdCidade.Properties.Items.Objects[CbbIdCidade.ItemIndex]));

        FrmCep.CbbIdUf.ItemIndex          := RetornaZeroI(Integer(CbbIdUf.Properties.Items.IndexOf(CdsPesquisa.FieldByName('NmSiglaUf').AsString)));
        FrmCep.CbbIdCidade.ItemIndex      := RetornaZeroI(Integer(CbbIdCidade.Properties.Items.IndexOf(CdsPesquisa.FieldByName('NmCidade').AsString)));

        ControleBotao;
        FrmCep.ShowModal;
      finally
        FrmCep.Free;
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

procedure TFrmCepPesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

end;

procedure TFrmCepPesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  try
    Application.CreateForm(TFrmProcessando, FrmProcessando);
    FrmProcessando.Show;
    Application.ProcessMessages;

    dnRelatorios := TDtmRelatorios.Create(Self);
    unEmpresa    := TEmpresa.Create;
    unEmpresa.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, '', dnRelatorios.CDSRelEmpresa);

    unCep.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, Integer(CbbIdUf.Properties.Items.Objects[CbbIdUf.ItemIndex]), Integer(CbbIdCidade.Properties.Items.Objects[CbbIdCidade.ItemIndex]), dnRelatorios.CDSRelPesquisa);

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\RelPesqImpCep.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmCepPesquisa.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  try
    FrmCep := TFrmCep.Create(Application);
    ControleBotao;
    FrmCep.ShowModal;
  finally
    FrmCep.Free;
  end;
end;

procedure TFrmCepPesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  EdtPesquisa.Enabled := False;
end;

procedure TFrmCepPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if (Integer(CbbIdUf.Properties.Items.Objects[CbbIdUf.ItemIndex]) > 0) and (Integer(CbbIdCidade.Properties.Items.Objects[CbbIdCidade.ItemIndex]) > 0) then
  begin
    Pesquisar(EdtPesquisa.Text);
  end
  else begin
    MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
    Abort;
  end;

  inherited;
end;

procedure TFrmCepPesquisa.CarregarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Uf', 0, '', '', CbbIdUf);
end;

procedure TFrmCepPesquisa.CbbIdCidadeKeyPress(Sender: TObject; var Key: Char);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdCidadeKeyPress';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if Key = #13 then
  begin
    EdtPesquisa.Enabled := True;
    EdtPesquisa.SetFocus;
  end;
end;

procedure TFrmCepPesquisa.CbbIdUfEditing(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdUfEditing';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  CbbIdCidade.Properties.Items.Clear;
end;

procedure TFrmCepPesquisa.CbbIdUfExit(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdUfKeyPress';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;


end;

procedure TFrmCepPesquisa.CbbIdUfKeyPress(Sender: TObject; var Key: Char);
var
  iTemp : Integer;
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
    DtmPrincipal.unLog.NmMetodo   := 'CbbIdUfKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Cep';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    if CbbIdUf.Text <> '[SELECIONE]' then
    begin
      iTemp := Integer(CbbIdUf.Properties.Items.Objects[CbbIdUf.ItemIndex]);

      unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Cidade', iTemp, 'Uf', '', CbbIdCidade);

      if CbbIdCidade.Text = '[SELECIONE]' then
      begin
         CbbIdCidade.SetFocus;
      end;
    end;
  end;
end;

procedure TFrmCepPesquisa.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmCep.BtnIncluir.Enabled   := False;
  FrmCep.BtnSalvar.Enabled    := False;
  FrmCep.BtnCancelar.Enabled  := False;
  FrmCep.BtnFechar.Enabled    := True;

  if Trim(FrmCep.EdtIdRegistro.Text) <> '' then
  begin
    FrmCep.BtnIncluir.Enabled := True;
    FrmCep.BtnAnterior.Enabled:= True;
    FrmCep.BtnProximo.Enabled := True;
  end
  else
  begin
    FrmCep.BtnSalvar.Enabled  := True;
    FrmCep.BtnCancelar.Enabled:= True;
  end;
end;

procedure TFrmCepPesquisa.DbgPesquisaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmTipoPessoaPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if TpAcao <> 'CarregaDados' then
  begin
    BtnAlterarClick(Sender);
  end
  else
  begin
    BtnFecharClick(Sender);
  end;

  inherited;
end;

procedure TFrmCepPesquisa.EdtPesquisaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
    DtmPrincipal.unLog.NmMetodo   := 'EdtPesquisaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Cep';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    if (Integer(CbbIdUf.Properties.Items.Objects[CbbIdUf.ItemIndex]) > 0) and (Integer(CbbIdCidade.Properties.Items.Objects[CbbIdCidade.ItemIndex]) > 0) then
    begin
      BtnPesquisarClick(Sender);
    end
    else begin
      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
      Abort;
    end;
  end;
  inherited;
end;

procedure TFrmCepPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmCepPesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;
end;

procedure TFrmCepPesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  CarregarTela;
  CbbIdUf.SetFocus;
end;

procedure TFrmCepPesquisa.Pesquisar(AConsulta: String);
var
  I: Integer;
  lConsulta: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmCepPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Cep';
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
        unCep  := TCep.Create;

        unCep.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, Integer(CbbIdUf.Properties.Items.Objects[CbbIdUf.ItemIndex]), Integer(CbbIdCidade.Properties.Items.Objects[CbbIdCidade.ItemIndex]), CdsPesquisa);
      end;
    end;
  finally
    unCep.Free;
    FrmProcessando.Destroy;
  end;
  inherited;
end;


end.
