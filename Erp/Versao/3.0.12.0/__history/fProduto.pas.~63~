unit fProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Imaging.jpeg,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fCadastro, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.ComCtrls, dxCore, cxDateUtils,
  dxSkinsCore, dxSkinsDefaultPainters, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxCalendar, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Menus, cxButtons,
  cxImage, cxDBEdit, cxCheckBox, cxMemo;

type
  TFrmProduto = class(TFrmCadastro)
    Label2            : TLabel;
    Label3            : TLabel;
    Label7            : TLabel;
    Label5            : TLabel;
    Label22           : TLabel;
    MkeVlCusto        : TcxMaskEdit;
    Label6            : TLabel;
    MkeVlVenda        : TcxMaskEdit;
    GroupBox2         : TGroupBox;
    OpdImProduto      : TOpenDialog;
    EdtNrEan          : TcxTextEdit;
    EdtNmProduto      : TcxTextEdit;
    CbbIdGrupoProduto : TcxComboBox;
    CbbIdMarca        : TcxComboBox;
    BtnGrupoPesquisa  : TcxButton;
    BtnMarcaPesquisa  : TcxButton;
    Label4            : TLabel;
    ImgImProduto      : TcxDBImage;
    BtnWebCam         : TcxButton;
    BtnLocal          : TcxButton;
    BtnSalvarImProduto: TcxButton;
    Label8            : TLabel;
    EdtImProduto      : TcxTextEdit;
    DtsRetorno        : TDataSource;
    MemObservacao     : TcxMemo;
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
    procedure BtnLocalClick(Sender: TObject);
    procedure BtnMarcaPesquisaClick(Sender: TObject);
    procedure BtnGrupoPesquisaClick(Sender: TObject);
    procedure BtnWebCamClick(Sender: TObject);
    procedure EdtNrEanKeyPress(Sender: TObject; var Key: Char);
    procedure CbbIdMarcaChange(Sender: TObject);
    procedure BtnSalvarImProdutoClick(Sender: TObject);
    procedure CamposEdicao(Sender: TObject; var CanEdit: Boolean);
  private
    { Private declarations }
    procedure InicializarTela;
  public
    { Public declarations }
    procedure CarregarTela(ATpChamadaClasse:String);
    procedure CopulaTela;
    procedure Edicao;
  end;

var
  FrmProduto: TFrmProduto;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, uMensagem, uProcedure, uCarregaDados, fProcessando, uProduto, fAjuda, fMarcaPesquisa, fGrupoProdutoPesquisa, fWebCam;

var
  unProduto        : TProduto;
  unCarregaDados   : TCarregaDados;
  LimpaArquivo     : String;
  lTpChamadaClasse : Boolean;

procedure TFrmProduto.Edicao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'Edicao';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
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


procedure TFrmProduto.CamposEdicao(Sender: TObject; var CanEdit: Boolean);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'CamposEdicao';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  Edicao;
end;

procedure TFrmProduto.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
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

procedure TFrmProduto.BtnAnteriorClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAnteriorClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Produto', 'Anterior', CdsRetorno);

  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoPrimeiroRegistro);
  end;
end;

procedure TFrmProduto.BtnCancelarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnCancelarClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmProduto.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unProduto.Free;
end;

procedure TFrmProduto.BtnGrupoPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnGrupoPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmGrupoProdutoPesquisa := TFrmGrupoProdutoPesquisa.Create(Application);
    FrmGrupoProdutoPesquisa.ShowModal;
  finally
    FrmGrupoProdutoPesquisa.Free;
    CbbIdGrupoProduto.Properties.Items.Clear;
    CarregarTela('GrupoProduto');
  end;
end;

procedure TFrmProduto.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLocalClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  InicializarTela;
end;

procedure TFrmProduto.BtnLocalClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLocalClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    OpdImProduto.Title            := 'Selecione Imagem Produto';
    OpdImProduto.InitialDir       := '';
    OpdImProduto.FileName         := '*.jpg';
    OpdImProduto.DefaultExt       := '*.jpg';
    OpdImProduto.Filter           := 'Arquivos JPG (*.jpg)|Todos os Arquivos (*.*)|*.*';
    if OpdImProduto.Execute then
    begin
      ImgImProduto.Visible        := True;
      ImgImProduto.Picture.LoadFromFile(OpdImProduto.FileName);
      EdtImProduto.Text           := OpdImProduto.FileName;
      BtnSalvarImProduto.Enabled  := True;
    end;
  finally

  end;
end;


procedure TFrmProduto.BtnMarcaPesquisaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnMarcaPesquisaClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    FrmMarcaPesquisa := TFrmMarcaPesquisa.Create(Application);
    FrmMarcaPesquisa.ShowModal;
  finally
    FrmMarcaPesquisa.Free;
    CbbIdMarca.Properties.Items.Clear;;
    CarregarTela('Marca');
  end;
end;

procedure TFrmProduto.BtnProximoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnProximoClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  if Trim(EdtIdRegistro.Text) = '' then
  begin
    EdtIdRegistro.Text := '0';
  end;

  uProcedure.Registro(DtmPrincipal.IdEmpresaLogada, StrToInt(EdtIdRegistro.Text), 'Produto', 'Proximo', CdsRetorno);

  if CdsRetorno.RecordCount > 0 then
  begin
    CopulaTela;
  end
  else
  begin
    MsgAtencao(uMensagem.JaEstamosNoUltimoRegistro);
  end;
end;


procedure TFrmProduto.BtnSalvarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    if ((Integer(CbbIdMarca.Properties.Items.Objects[CbbIdMarca.ItemIndex]) > 0) and (Integer(CbbIdGrupoProduto.Properties.Items.Objects[CbbIdGrupoProduto.ItemIndex]) > 0)
         and (Trim(EdtNmProduto.Text) <> '') and (Trim(MkeVlCusto.Text) <> '') and (Trim(MkeVlVenda.Text) <> '')) then
    begin
      if Trim(EdtIdRegistro.Text) <> '' then
      begin
        unProduto.IdProduto     := StrToInt(EdtIdRegistro.Text);
      end
      else
      begin
        unProduto.IdProduto     := 0;
      end;
      unProduto.IdUsuario       := DtmPrincipal.IdUsuarioLogado;
      unProduto.DtCadastro      := Now;
      if ChkSnSituacao.Checked then
      begin
        unProduto.SnSituacao    := 1;
      end
      else
      begin
        unProduto.SnSituacao    := 0;
      end;
      unProduto.IdMarca         := Integer(CbbIdMarca.Properties.Items.Objects[CbbIdMarca.ItemIndex]);
      unProduto.IdGrupoProduto  := Integer(CbbIdGrupoProduto.Properties.Items.Objects[CbbIdGrupoProduto.ItemIndex]);
      unProduto.NmProduto       := EdtNmProduto.Text;
      unProduto.VlCusto         := StrToFloat(MkeVlCusto.Text);
      unProduto.VlVenda         := StrToFloat(MkeVlVenda.Text);
      unProduto.NrEan           := EdtNrEan.Text;
      unProduto.NmObs           := MemObservacao.Text;

      if unProduto.Salvar(DtmPrincipal.Conexao) then
      begin
        if Trim(EdtIdRegistro.Text) <> '' then
        begin
          unProduto.Buscar(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text));
        end
        else
        begin
          unProduto.Buscar(DtmPrincipal.Conexao, unProduto.BuscaMaxId(DtmPrincipal.Conexao));
        end;
        EdtIdRegistro.Text      := IntToStr(unProduto.IdProduto);
        DtpDtCadastro.Date      := unProduto.DtCadastro;
        EdtNmUsuario.Text       := unProduto.NmUsuarioCadastro;

        if unProduto.SnSituacao = 1 then
        begin
          ChkSnSituacao.Checked := True;
        end
        else
        begin
          ChkSnSituacao.Checked := False;
        end;
        MsgInformacao(uMensagem.ORegistroFoiSalvoComSucesso);

        BtnWebCam.Enabled           := True;
        BtnLocal.Enabled            := True;
        EdtNrEan.Enabled            := False;
        inherited;

        CbbIdMarca.Style.Color        := clWindow;
        CbbIdGrupoProduto.Style.Color := clWindow;
        EdtNmProduto.Style.Color      := clWindow;
        MkeVlCusto.Style.Color  := clWindow;
        MkeVlVenda.Style.Color  := clWindow;
        EdtNrEan.Style.Color          := clWindow;
      end
      else
      begin
        MsgErro(uMensagem.ErroAoTentarSalvarORegisto);
      end;
    end
    else
    begin
      CbbIdMarca.Style.Color          := clHighlight;
      CbbIdGrupoProduto.Style.Color   := clHighlight;
      EdtNmProduto.Style.Color        := clHighlight;
      MkeVlCusto.Style.Color    := clHighlight;
      MkeVlVenda.Style.Color    := clHighlight;
      EdtNrEan.Style.Color            := clHighlight;

      BtnIncluir.Enabled        := False;
      BtnSalvar.Enabled         := True;
      BtnCancelar.Enabled       := True;
      BtnFechar.Enabled         := True;

      MsgAtencao(uMensagem.VerificarOsCamposQueContemOSinalDeAsterisco);
      Abort;
    end;
  finally

  end;
end;

procedure TFrmProduto.BtnSalvarImProdutoClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnSalvarImProdutoClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if Trim(EdtIdRegistro.Text) <> '' then
  begin
    if SalvaImagem(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada, 'Produto', EdtImProduto.Text) then
    begin
      MsgInformacao(uMensagem.ImagemAdicionadaComSucesso);
      BtnSalvarImProduto.Enabled := False;
      //DeleteFile(DtmPrincipal.NmCaminhoImgProduto + RemoveCaracteres(EdtNrEan.Text) + '.jpg');
    end;
  end
  else
  begin
    MsgAtencao(uMensagem.UmaEmpresaDeveSerSelecionada);
  end;
end;

procedure TFrmProduto.BtnWebCamClick(Sender: TObject);
var
  DirNomeFoto: string;
  NomeFoto: string;
  procedure ConverteParaJpeg(ANomeFoto: string);
  var
    cjBmp: TBitmap;
    cjJpg: TJpegImage;
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
    DtmPrincipal.unLog.NmMetodo   := 'ConverteParaJpeg';
    DtmPrincipal.unLog.NmTabela   := 'Produto';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    ImgImProduto.Visible := False;
    ImgImProduto.Picture.Bitmap.LoadFromFile(DtmPrincipal.NmCaminhoImgProduto + ANomeFoto + '.bmp');

    cjJpg := TJpegImage.Create;
    cjBmp := TBitmap.Create;

    cjBmp.Assign(ImgImProduto.Picture.Bitmap);
    cjJpg.Assign(cjBmp);

    cjJpg.SaveToFile(DtmPrincipal.NmCaminhoImgProduto + ANomeFoto + '.jpg');
    ImgImProduto.Visible := True;
    ImgImProduto.Picture.LoadFromFile(DtmPrincipal.NmCaminhoImgProduto + ANomeFoto + '.jpg');

    if FileExists(DtmPrincipal.NmCaminhoImgProduto + RemoveCaracteres(EdtNrEan.Text) + '.bmp') then
    begin
      DeleteFile(DtmPrincipal.NmCaminhoImgProduto + RemoveCaracteres(EdtNrEan.Text) + '.bmp');
      EdtImProduto.Text           := DtmPrincipal.NmCaminhoImgProduto + ANomeFoto + '.jpg';
      BtnSalvarImProduto.Enabled  := True;
    end;

    cjJpg.Free;
    cjBmp.Free;
  end;

begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'BtnWebCamClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmWebCam        := TFrmWebCam.Create(Self);
  try
    with FrmWebCam, CamCamera do
    begin
      NomeFoto     := RemoveCaracteres(EdtNrEan.Text);
      LimpaArquivo := NomeFoto;

      DirNomeFoto  := DtmPrincipal.NmCaminhoImgProduto + NomeFoto + '.bmp';

      FichierImage := DirNomeFoto;
      if FrmWebCam.ShowModal = mrOk then
      begin
        CaptureImageDisque(FichierImage);
        ConverteParaJpeg(NomeFoto);
      end;
    end;
  finally
    FreeAndNil(FrmWebCam);
  end;
end;

procedure TFrmProduto.CarregarTela(ATpChamadaClasse:String);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'CarregarTela';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unCarregaDados.gCarregarSelecionar := 1;
  if ATpChamadaClasse = 'Geral' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Marca', 0, '', '', '', CbbIdMarca);
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'GrupoProduto', 0, '', '', '',  CbbIdGrupoProduto);
  end
  else
  if ATpChamadaClasse = 'Marca' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'Marca', 0, '', '', '', CbbIdMarca);
  end
  else
  if ATpChamadaClasse = 'GrupoProduto' then
  begin
    unCarregaDados.CarregaDados(DtmPrincipal.Conexao, 'GrupoProduto', 0, '', '', '',  CbbIdGrupoProduto);
  end;
end;

procedure TFrmProduto.CbbIdMarcaChange(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'CbbIdMarcaChange';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  BtnSalvar.Enabled := True;
  BtnWebCam.Enabled := True;
  BtnLocal.Enabled  := True;
end;

procedure TFrmProduto.CopulaTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'CopulaTela';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  try
    unProduto.CarregaDbGrid(DtmPrincipal.Conexao, 2, CdsRetorno.FieldByName('IdRetorno').AsInteger, '', CdsCopula);

    lTpChamadaClasse := True;

    EdtIdRegistro.Text          := CdsCopula.FieldByName('IdProduto').AsString;
    DtpDtCadastro.Date          := CdsCopula.FieldByName('DtCadastro').AsDateTime;
    EdtNmUsuario.Text           := CdsCopula.FieldByName('NmUsuarioCadastro').AsString;
    if CdsCopula.FieldByName('SnSituacao').AsString = 'ATIVO' then
    begin
      ChkSnSituacao.Checked     := True;
      ChkSnSituacao.Caption     := 'Cadastro Ativo';
    end
    else
    begin
      ChkSnSituacao.Checked     := False;
      ChkSnSituacao.Caption     := 'Cadastro Inativo';
    end;
    CbbIdMarca.ItemIndex        := Integer(CbbIdMarca.Properties.Items.IndexOf(CdsCopula.FieldByName('NmMarca').AsString));
    CbbIdGrupoProduto.ItemIndex := Integer(CbbIdGrupoProduto.Properties.Items.IndexOf(CdsCopula.FieldByName('NmGrupoProduto').AsString));
    EdtNmProduto.Text           := CdsCopula.FieldByName('NmProduto').AsString;
    MkeVlCusto.Text             := CdsCopula.FieldByName('VlCusto').AsString;
    MkeVlVenda.Text             := CdsCopula.FieldByName('VlVenda').AsString;
    EdtNrEan.Text               := CdsCopula.FieldByName('NrEan').AsString;
    MemObservacao.Text          := CdsCopula.FieldByName('NmObs').AsString;

    if Trim(EdtIdRegistro.Text) <> '' then
    begin
      if unProduto.BuscarImagem(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text), CdsCopula) then
      begin
        ImgImProduto.DataBinding.DataField := 'ImProduto';
      end;
    end;
  finally
    lTpChamadaClasse := False;
  end;
end;

procedure TFrmProduto.EdtNrEanKeyPress(Sender: TObject; var Key: Char);
begin
  if (not(Key in ['0'..'9', #08, #13, #46])) and (Key <> #0) then
  begin
    DtmPrincipal.unLog.NmOperacao := 'Entrou';
    DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
    DtmPrincipal.unLog.NmMetodo   := 'EdtNrEanKeyPress';
    DtmPrincipal.unLog.NmTabela   := 'Produto';
    DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

    MsgAtencao(uMensagem.ESoPermitidoNumeros);
    Key := #0;
  end;
end;

procedure TFrmProduto.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;


procedure TFrmProduto.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  unCarregaDados := TCarregaDados.Create;
  unProduto      := TProduto.Create;
end;

procedure TFrmProduto.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
  CbbIdMarca.SetFocus;

  if Trim(EdtIdRegistro.Text) <> '' then
  begin
    if unProduto.BuscarImagem(DtmPrincipal.Conexao, StrToInt(EdtIdRegistro.Text), CdsRetorno) then
    begin
      ImgImProduto.DataBinding.DataField := 'ImProduto';
    end;
  end;
end;

procedure TFrmProduto.InicializarTela;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProduto';
  DtmPrincipal.unLog.NmMetodo   := 'InicializarTela';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  unProduto.IdProduto          := 0;
  EdtNmUsuario.Clear;
  ChkSnSituacao.Caption        := 'Cadastro Ativo';
  CbbIdMarca.ItemIndex         := 0;
  CbbIdGrupoProduto.ItemIndex  := 0;
  EdtNrEan.Enabled             := True;
  BtnWebCam.Enabled            := False;
  BtnLocal.Enabled             := False;
  EdtNmProduto.Clear;
  EdtNrEan.Clear;
  MkeVlCusto.Clear;
  MkeVlVenda.Clear;
  MemObservacao.Clear;
  CbbIdMarca.SetFocus;
end;

end.
