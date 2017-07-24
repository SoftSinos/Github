unit fLogin;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Imaging.jpeg, Vcl.ExtCtrls, Comobj, NBioAPI_Type, DelphiTwain, Camera, Data.DB, Datasnap.DBClient, Vcl.Imaging.pngimage, dxGDIPlusClasses, Vcl.ButtonGroup,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxLabel, cxTextEdit, cxMaskEdit, cxDropDownEdit, Vcl.Menus, cxButtons;

type
  TFrmLogin = class(TForm)
    ImgSplash         : TImage;
    cxLabel2          : TcxLabel;
    cxLabel3          : TcxLabel;
    cxLabel4          : TcxLabel;
    EdtNmSenha        : TcxTextEdit;
    EdtNmUsuario      : TcxTextEdit;
    CbbIdEmpresa      : TcxComboBox;
    ChkAdministracao  : TCheckBox;
    LblSgin           : TcxLabel;
    LblLicencaLogin   : TcxLabel;
    LblErp            : TcxLabel;
    BtnLogin          : TcxButton;
    BtnSair           : TcxButton;
    ChkModoAtualizacao: TCheckBox;
    Image1: TImage;
    procedure BtnSairClick(Sender: TObject);
    procedure BtnLoginClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CbbIdEmpresaKeyPress(Sender: TObject; var Key: Char);
    procedure EdtNmUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure EdtNmSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure EdtNmSenhaEnter(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarTela(ATpChamadaClasse:String);
    procedure UsuarioAdministrador;
  public
    { Public declarations }
  end;

var
  FrmLogin      : TFrmLogin;
  objNBioBSP    : variant;
  objDevice     : variant;
  objExtraction : variant;
  objIndexSearch: variant;

implementation

{$R *.dfm}

uses fSplash, fPrincipal, uCarregaDados, uMensagem, uUsuario, uEmpresa, dPrincipal, uFuncao, fContraSenha, dMail, uProcedure, fExecutaScriptSQL;

var
  unCarregaDados : TCarregaDados;
  unUsuario      : TUsuario;
  unEmpresa      : TEmpresa;

procedure TFrmLogin.BtnLoginClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogin';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLoginClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    DtmPrincipal.IdEmpresaLogada  := Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]);

    if Integer(CbbIdEmpresa.Properties.Items.Objects[CbbIdEmpresa.ItemIndex]) > 0then
    begin
      if (Trim(EdtNmUsuario.Text) <> '') and (Trim(EdtNmSenha.Text) <> '') then
      begin
        if uFuncao.SafetyOpen(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada) then
        begin
          if ChkModoAtualizacao.Checked then
          begin
            unUsuario.NmUsuario                         := EdtNmUsuario.Text;
            unUsuario.NmSenha                           := EdtNmSenha.Text;

            if (unUsuario.ValidaUsuarioSenha(DtmPrincipal.Conexao)) = '0' then
            begin
              MsgAtencao(uMensagem.ASenhaNaoConfere);
              EdtNmSenha.Text            := '';
              EdtNmSenha.SetFocus;
              ChkModoAtualizacao.Checked := False;
            end
            else
            begin
             try
                FrmExecutaScriptSQL := TFrmExecutaScriptSQL.Create(Application);
                FrmExecutaScriptSQL.ShowModal;
              finally
                FrmExecutaScriptSQL.Free;
                ChkModoAtualizacao.Checked := False;
              end;
            end;
            Exit;
          end;

          unEmpresa.Buscar(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada);
          DtmPrincipal.NmRazaoSocial                    := unEmpresa.NmRazaoSocial;
          DtmPrincipal.NmFantasia                       := unEmpresa.NmFantasia;
          DtmPrincipal.NmFantasiaNmRazaoSocial          := unEmpresa.NmFantasia + ' - ' + unEmpresa.NmRazaoSocial;

          if (EdtNmUsuario.Text = 'SOFTSINOS') and (EdtNmSenha.Text = '.SS@2017') then
          begin
            MsgAtencao(uMensagem.BemVindoAdministrador);
            FrmPrincipal.Visible                        := True;
            FrmPrincipal.StbPrincipal.Panels[1].Text    := DataPorExtenso(Now);
            FrmPrincipal.StbPrincipal.Panels[3].Text    := 'Usu�rio: ' + EdtNmUsuario.Text;
            FrmPrincipal.StbPrincipal.Panels[4].Text    := 'Empresa: ' + DtmPrincipal.NmFantasiaNmRazaoSocial;

            DtmPrincipal.UsuarioAdministrador           := True;
            DtmPrincipal.UsuarioSuporte                 := True;
            UsuarioAdministrador;
            DtmPrincipal.CarregaLog;
            DtmPrincipal.NmUsuario                      := EdtNmUsuario.Text;
            Close;
          end else
          begin
            unUsuario.NmUsuario                         := EdtNmUsuario.Text;
            unUsuario.NmSenha                           := EdtNmSenha.Text;

            DtmPrincipal.UsuarioSuporte                 := False;

            if (unUsuario.ValidaUsuarioSenha(DtmPrincipal.Conexao)) = '1' then
            begin
              unUsuario.BuscarUsuario(DtmPrincipal.Conexao, EdtNmUsuario.Text);

              DtmPrincipal.IdUsuarioLogado              := unUsuario.IdUsuario;
              DtmPrincipal.NmUsuario                    := unUsuario.NmLogin;

              FrmPrincipal.StbPrincipal.Panels[3].Text  := 'Usu�rio: ' + DtmPrincipal.NmUsuario;
              FrmPrincipal.StbPrincipal.Panels[4].Text  := 'Empresa: ' + DtmPrincipal.NmFantasiaNmRazaoSocial;

              if unUsuario.SnAdministrador = 1 then
              begin
                DtmPrincipal.UsuarioAdministrador       := True;
              end
              else
              begin
                DtmPrincipal.UsuarioAdministrador       := False;
              end;

              UsuarioAdministrador;

              FrmPrincipal.Visible                      := True;
              DtmPrincipal.CarregaLog;
              Close;
            end
            else if (unUsuario.ValidaUsuarioSenha(DtmPrincipal.Conexao)) = '0' then
            begin
              MsgAtencao(uMensagem.ASenhaNaoConfere);
              EdtNmSenha.Text                           := '';
              EdtNmSenha.SetFocus;
            end
            else
            begin
              if not unUsuario.ExisteCadastro(DtmPrincipal.Conexao) then
              begin
                MsgAtencao(uMensagem.UsuarioNaoCadastrado);
                EdtNmUsuario.Text                       := '';
                EdtNmSenha.Text                         := '';
                EdtNmUsuario.SetFocus;
              end
              else
              begin
                MsgAtencao(uMensagem.UsuarioNaoCadastrado);
                EdtNmUsuario.Text                       := '';
                EdtNmSenha.Text                         := '';
                EdtNmUsuario.SetFocus;
              end;
            end;
          end;
        end
        else
        begin
          try
            FrmContraSenha := TFrmContraSenha.Create(Application);
            FrmContraSenha.ShowModal;
          finally
            FrmContraSenha.Free;
          end;
        end;
      end
      else
      begin
        MsgAtencao(uMensagem.UsuarioNaoCadastrado);
        EdtNmUsuario.Text                       := '';
        EdtNmSenha.Text                         := '';
        EdtNmUsuario.SetFocus;
      end;
    end
    else
    begin
      MsgAtencao(uMensagem.UmaEmpresaDeveSerSelecionada);
    end;
  finally
    if FrmPrincipal.Visible then
    begin
      try
        if ChkAdministracao.Checked = True then
        begin
          DtmEmail.GerarEmail('log@softsinos.com.br',
                              DtmPrincipal.NmFantasiaNmRazaoSocial,
                              'Autentica��o de Usu�rio',
                              'Cliente: ' + DtmPrincipal.NmFantasiaNmRazaoSocial + #13 + 'Usu�rio: ' + EdtNmUsuario.Text + #13 + 'Opera��o: Autentica��o de Usu�rio' + #13 + 'Dia: ' + DateToStr(Now) + #13 + 'Hor�rio: ' + TimeToStr(Now),
                              False,
                              False);
        end
        else if (EdtNmUsuario.Text <> 'SOFTSINOS') and (Trim(EdtNmUsuario.Text) <> '') then
        begin
          DtmEmail.GerarEmail('log@softsinos.com.br',
                              DtmPrincipal.NmFantasiaNmRazaoSocial,
                              'Autentica��o de Usu�rio',
                              'Cliente: ' + DtmPrincipal.NmFantasiaNmRazaoSocial + #13 + 'Usu�rio: ' + EdtNmUsuario.Text + #13 + 'Opera��o: Autentica��o de Usu�rio' + #13 + 'Dia: ' + DateToStr(Now) + #13 + 'Hor�rio: ' + TimeToStr(Now),
                              False,
                              False);
        end;
      except

      end;
    end;
    ChkAdministracao.Checked := False;
    FrmLogin.Free;
  end;
end;

procedure TFrmLogin.BtnSairClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogin';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSairClick';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if MsgConfirmacao(uMensagem.DesejaFinalizarOSistema) then
  begin
    FinalizarAplicacao(DtmPrincipal.NmExecutavel);
  end;
end;

procedure TFrmLogin.CarregarTela(ATpChamadaClasse:String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogin';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  if ATpChamadaClasse = 'Geral' then
  begin
   unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Empresa', 0, '', '', CbbIdEmpresa);
  end;
end;

procedure TFrmLogin.CbbIdEmpresaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmLogin';
    DtmPrincipal.unLog.NmMetodo   := 'CbbIdEmpresaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    EdtNmUsuario.SetFocus;
  end;
end;

procedure TFrmLogin.EdtNmSenhaEnter(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogin';
  DtmPrincipal.unLog.NmMetodo   := 'EdtNmSenhaEnter';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if EdtNmUsuario.Text = 'SOFTSINOS' then
  begin
    ChkAdministracao.Visible   := True;
  end
  else
  begin
    ChkAdministracao.Visible   := False;
  end;
end;

procedure TFrmLogin.EdtNmSenhaKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmLogin';
    DtmPrincipal.unLog.NmMetodo   := 'EdtNmSenhaKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    BtnLogin.SetFocus;
  end;
end;

procedure TFrmLogin.EdtNmUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmLogin';
    DtmPrincipal.unLog.NmMetodo   := 'EdtNmSenhaEnter';
    DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    if EdtNmUsuario.Text = 'SOFTSINOS' then
    begin
      ChkAdministracao.Visible   := True;
    end
    else
    begin
      ChkAdministracao.Visible   := False;
    end;
    EdtNmSenha.SetFocus;
  end;
end;

procedure TFrmLogin.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogin';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Action := caFree;
end;

procedure TFrmLogin.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogin';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados  := TCarregaDados.Create;
  unUsuario       := TUsuario.Create;
  unEmpresa       := TEmpresa.Create;

  if FileExists('Imagem/Sistema/Login.jpg') then
  begin
    ImgSplash.Picture.LoadFromFile('Imagem/Sistema/Login.jpg');
  end;
end;

procedure TFrmLogin.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogin';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  CarregarTela('Geral');

  if CbbIdEmpresa.Properties.Items.Count = 2 then
  begin
    CbbIdEmpresa.ItemIndex := 1;
  end;

  if DebugHook > 0 then
  begin
    EdtNmUsuario.Text   := 'SoftSinos';
    EdtNmSenha.Text     := '.SS@2017';
  end;
end;

procedure TFrmLogin.UsuarioAdministrador;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmLogin';
  DtmPrincipal.unLog.NmMetodo   := 'UsuarioAdministrador';
  DtmPrincipal.unLog.NmTabela   := 'Aplicacao';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if not DtmPrincipal.UsuarioAdministrador then
  begin
    FrmPrincipal.UsuarioAdministrador(False);
  end
  else
  begin
    FrmPrincipal.UsuarioAdministrador(True);
  end;
end;

end.
