unit fAtivacaoSistema;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Mask, Vcl.Menus,
  cxButtons, cxCheckBox;

type
  TFrmAtivacaoSistema = class(TFrmCadastro)
    RdgNmLicenca              : TRadioGroup;
    Label2                    : TLabel;
    Label3                    : TLabel;
    LblNmCpfCnpj              : TLabel;
    Label4                    : TLabel;
    Label5                    : TLabel;
    BtnAlterarNmComputador    : TBitBtn;
    BtnAlterarNrHd            : TBitBtn;
    BtnAlterarNrIp            : TBitBtn;
    BtnAlterarNrMac           : TBitBtn;
    BtnAlterarNrChaveAtivacao : TBitBtn;
    EdtNmComputador           : TcxTextEdit;
    EdtNrHd                   : TcxTextEdit;
    MkeNrChaveAtivacao        : TcxTextEdit;
    EdtNrMac                  : TcxTextEdit;
    MkeNrIp                   : TcxTextEdit;
    procedure BtnAlterarNmComputadorClick(Sender: TObject);
    procedure BtnAlterarNrHdClick(Sender: TObject);
    procedure BtnAlterarNrMacClick(Sender: TObject);
    procedure BtnAlterarNrIpClick(Sender: TObject);
    procedure BtnAlterarNrChaveAtivacaoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarTela;
  public
    { Public declarations }
  end;

var
  FrmAtivacaoSistema: TFrmAtivacaoSistema;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uAtivacao;

var
  unAtivacao : TAtivacao;

{ TFrmAtivacaoSistema }

procedure TFrmAtivacaoSistema.BtnAlterarNmComputadorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAtivacaoSistema';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarNmComputadorClick';
  DtmPrincipal.unLog.NmTabela   := 'Ativacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtNmComputador.Text := uFuncao.NomeComputador
  finally

  end;
end;

procedure TFrmAtivacaoSistema.BtnAlterarNrChaveAtivacaoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAtivacaoSistema';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarNrChaveAtivacaoClick';
  DtmPrincipal.unLog.NmTabela   := 'Ativacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    uProcedure.RandomAtivacao('Ativacao');
    MkeNrChaveAtivacao.Text := uProcedure.gRetornarProcedure;
  finally

  end;
end;

procedure TFrmAtivacaoSistema.BtnAlterarNrHdClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAtivacaoSistema';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarNrHdClick';
  DtmPrincipal.unLog.NmTabela   := 'Ativacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtNrHd.Text := uFuncao.SerialHD;
  finally

  end;
end;

procedure TFrmAtivacaoSistema.BtnAlterarNrIpClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAtivacaoSistema';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarNrIpClick';
  DtmPrincipal.unLog.NmTabela   := 'Ativacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    MkeNrIp.Text := uFuncao.EncontraIP;
  finally

  end;
end;

procedure TFrmAtivacaoSistema.BtnAlterarNrMacClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAtivacaoSistema';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarNrMacClick';
  DtmPrincipal.unLog.NmTabela   := 'Ativacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    EdtNrMac.Text := uFuncao.MacAdd
  finally

  end;
end;

procedure TFrmAtivacaoSistema.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAtivacaoSistema';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Ativacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if true then
    begin
      if ((Trim(EdtNmComputador.Text) <> '') and (Trim(EdtNrHd.Text) <> '') and (Trim(MkeNrChaveAtivacao.Text) <> '') and (Trim(EdtNrMac.Text) <> '') and (Trim(MkeNrIp.Text) <> '') and (RdgNmLicenca.ItemIndex > -1)) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unAtivacao.IdAtivacao    := StrToInt(EdtIdRegistro.Text);
        end
        else
        begin
          unAtivacao.IdAtivacao    := 0;
        end;
        unAtivacao.IdUsuario       := DtmPrincipal.IdUsuarioLogado;
        unAtivacao.DtCadastro      := Now;
        if ChkSnSituacao.Checked then
        begin
          unAtivacao.SnSituacao    := 1;
        end
        else
        begin
          unAtivacao.SnSituacao    := 0;
        end;
        unAtivacao.NmComputador    := EdtNmComputador.Text;
        unAtivacao.NrHd            := EdtNrHd.Text;
        unAtivacao.NrChaveAtivacao := MkeNrChaveAtivacao.Text;
        unAtivacao.NrMac           := EdtNrMac.Text;
        unAtivacao.NrIp            := MkeNrIp.Text;
        if RdgNmLicenca.ItemIndex = 0 then
        begin
          unAtivacao.NmLicenca     := 'Starter';
        end
        else if RdgNmLicenca.ItemIndex = 1 then
        begin
          unAtivacao.NmLicenca     := 'Ultimate';
        end
        else if RdgNmLicenca.ItemIndex = 2 then
        begin
          unAtivacao.NmLicenca     := 'Business';
        end;

        if unAtivacao.Salvar(DtmPrincipal.Conexao) then
        begin
          if Trim(EdtIdRegistro.Text) <> '' then
          begin
            unAtivacao.Buscar(DtmPrincipal.Conexao);
          end
          else
          begin
            unAtivacao.Buscar(DtmPrincipal.Conexao);
          end;
          EdtIdRegistro.Text       := IntToStr(unAtivacao.IdAtivacao);
          DtpDtCadastro.Date       := unAtivacao.DtCadastro;
          EdtNmUsuario.Text        := unAtivacao.NmUsuarioCadastro;

          if unAtivacao.SnSituacao = 1 then
          begin
            ChkSnSituacao.Checked  := True;
          end
          else
          begin
            ChkSnSituacao.Checked  := False;
          end;
          MsgInformacao(uMensagem.SeuSistemaFoiAtivado);
          BtnSalvar.Enabled        := False;
          BtnCancelar.Enabled      := False;

          EdtNmComputador.Style.Color    := clWindow;
          EdtNrHd.Style.Color            := clWindow;
          MkeNrChaveAtivacao.Style.Color := clWindow;
          EdtNrMac.Style.Color           := clWindow;
          MkeNrIp.Style.Color            := clWindow;
        end
        else
        begin
          MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
        end;
      end
      else
      begin
        EdtNmComputador.Style.Color    := clHighlight;
        EdtNrHd.Style.Color            := clHighlight;
        MkeNrChaveAtivacao.Style.Color := clHighlight;
        EdtNrMac.Style.Color           := clHighlight;
        MkeNrIp.Style.Color            := clHighlight;

        BtnIncluir.Enabled   := False;
        BtnSalvar.Enabled    := True;
        BtnCancelar.Enabled  := False;
        BtnFechar.Enabled    := True;

        MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
        Abort;
      end;
    end;
  finally

  end;
end;

procedure TFrmAtivacaoSistema.CarregarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAtivacaoSistema';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Ativacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unAtivacao.Buscar(DtmPrincipal.Conexao);

  if unAtivacao.IdAtivacao > 0  then
  begin
    EdtIdRegistro.Text      := IntToStr(unAtivacao.IdAtivacao);
    DtpDtCadastro.Date      := unAtivacao.DtCadastro;
    EdtNmUsuario.Text       := unAtivacao.NmUsuarioCadastro;

    if unAtivacao.SnSituacao = 1 then
    begin
      ChkSnSituacao.Checked := True;
    end
    else
    begin
      ChkSnSituacao.Checked := False;
    end;

    EdtNmComputador.Text    := unAtivacao.NmComputador;
    EdtNrMac.Text           := unAtivacao.NrMac;
    EdtNrHd.Text            := unAtivacao.NrHd;
    MkeNrChaveAtivacao.Text := unAtivacao.NrChaveAtivacao;
    MkeNrIp.Text            := unAtivacao.NrIp;

    if unAtivacao.NmLicenca = 'Starter' then
    begin
      RdgNmLicenca.ItemIndex := 0
    end
    else if unAtivacao.NmLicenca = 'Ultimate' then
    begin
      RdgNmLicenca.ItemIndex := 1
    end
    else if unAtivacao.NmLicenca = 'Business' then
    begin
      RdgNmLicenca.ItemIndex := 2
    end;
    PnlCampos.Enabled   := False;
    BtnIncluir.Enabled  := False;
    BtnSalvar.Enabled   := False;
    BtnCancelar.Enabled := False;
  end;
end;

procedure TFrmAtivacaoSistema.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAtivacaoSistema';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Ativacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmAtivacaoSistema.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAtivacaoSistema';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Ativacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unAtivacao       := TAtivacao.Create;
end;

procedure TFrmAtivacaoSistema.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmAtivacaoSistema';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Ativacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  RdgNmLicenca.SetFocus;

  CarregarTela;
end;

end.
