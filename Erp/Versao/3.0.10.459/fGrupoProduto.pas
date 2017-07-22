unit fGrupoProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, cxButtons,
  cxCheckBox;

type
  TFrmGrupoProduto = class(TFrmCadastro)
    Label7            : TLabel;
    EdtNmGrupoProduto : TcxTextEdit;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnAnteriorClick(Sender: TObject);
    procedure BtnProximoClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
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
  FrmGrupoProduto: TFrmGrupoProduto;

implementation

{$R *.dfm}
uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uGrupoProduto, fAjuda;

var
  unGrupoProduto   : TGrupoProduto;
  lTpChamadaClasse : Boolean;

procedure TFrmGrupoProduto.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'GrupoProduto';
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


procedure TFrmGrupoProduto.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'GrupoProduto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmGrupoProduto.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoProduto';
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

procedure TFrmGrupoProduto.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoProduto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'GrupoProduto', 'Anterior', CdsRetorno);

  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmGrupoProduto.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoProduto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmGrupoProduto.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoProduto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unGrupoProduto.Free;
end;

procedure TFrmGrupoProduto.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLocalClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoProduto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmGrupoProduto.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoProduto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'GrupoProduto', 'Proximo', CdsRetorno);
  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;

procedure TFrmGrupoProduto.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'GrupoProduto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((Trim(EdtNmGrupoProduto.Text) <> '')) then
    begin
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unGrupoProduto.IdGrupoProduto    := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unGrupoProduto.IdGrupoProduto    := 0;
      end;
      unGrupoProduto.IdUsuario     := DtmPrincipal.IdUsuarioLogado;
      unGrupoProduto.DtCadastro    := Now;
      if ChkSnSituacao.Checked then
      begin
        unGrupoProduto.SnSituacao  := 1;
      end
      else
      begin
        unGrupoProduto.SnSituacao  := 0;
      end;
      unGrupoProduto.NmGrupoProduto       := EdtNmGrupoProduto.Text;

      if unGrupoProduto.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unGrupoProduto.Buscar(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text));
        end
        else
        begin
          unGrupoProduto.Buscar(DtmPrincipal.Conexao, unGrupoProduto.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text      := IntToStr(unGrupoProduto.IdGrupoProduto);
        DtpDtCadastro.Date      := unGrupoProduto.DtCadastro;
        EdtNmUsuario.Text       := unGrupoProduto.NmUsuarioCadastro;

        if unGrupoProduto.SnSituacao = 1 then
        begin
          ChkSnSituacao.Checked := True;
        end
        else
        begin
          ChkSnSituacao.Checked := False;
        end;
        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        inherited;

        EdtNmGrupoProduto.Style.Color    := clWindow;
      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      EdtNmGrupoProduto.Style.Color    := clHighlight;

      BtnIncluir.Enabled   := False;
      BtnSalvar.Enabled    := True;
      BtnCancelar.Enabled  := True;
      BtnFechar.Enabled    := True;

      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
      Abort;
    end;
  finally

  end;
end;

procedure TFrmGrupoProduto.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'GrupoProduto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unGrupoProduto.CarregaDbGrid(DtmPrincipal.Conexao, 2, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', CdsCopula);

    lTpChamadaClasse := True;

    EdtIdRegistro.Text        := CdsCopula.FieldByName('IdGrupoProduto').AsString;
    DtpDtCadastro.Date        := CdsCopula.FieldByName('DtCadastro').AsDateTime;
    EdtNmUsuario.Text         := CdsCopula.FieldByName('NmUsuarioCadastro').AsString;
    if CdsCopula.FieldByName('SnSituacao').AsString = 'ATIVO' then
    begin
      ChkSnSituacao.Checked   := True;
      ChkSnSituacao.Caption   := 'Cadastro Ativo';
    end
    else
    begin
      ChkSnSituacao.Checked   := False;
      ChkSnSituacao.Caption   := 'Cadastro Inativo';
    end;
    EdtNmGrupoProduto.Text    := CdsCopula.FieldByName('NmGrupoProduto').AsString;
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmGrupoProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'GrupoProduto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmGrupoProduto.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unGrupoProduto       := TGrupoProduto.Create;
end;

procedure TFrmGrupoProduto.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  EdtNmGrupoProduto.SetFocus
end;

procedure TFrmGrupoProduto.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmGrupoProduto';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'GrupoProduto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unGrupoProduto.IdGrupoProduto := 0;
  EdtNmUsuario.Clear;
  EdtNmGrupoProduto.Clear;
  EdtNmGrupoProduto.SetFocus
end;

end.
