unit fProdutoPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient, Vcl.ComCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, Vcl.Menus, cxButtons;

type
  TFrmProdutoPesquisa = class(TFrmPesquisa)
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnIncluirClick(Sender: TObject);
    procedure BtnAlterarClick(Sender: TObject);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure BtnLimparClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnAjudaClick(Sender: TObject);
    procedure DbgPesquisaDblClick(Sender: TObject);
  private
    { Private declarations }
    procedure Pesquisar(AConsulta: String);
    procedure ControleBotao;
  public
    TpAcao : String;
    { Public declarations }
  end;

var
  FrmProdutoPesquisa: TFrmProdutoPesquisa;

implementation

{$R *.dfm}

uses dPrincipal, uFuncao, fProcessando, uMensagem, uProduto, fProduto, dRelatorios, uEmpresa, fAjuda;

var
  unProduto    : TProduto;
  unEmpresa    : TEmpresa;
  dnRelatorios : TDtmRelatorios;

procedure TFrmProdutoPesquisa.BtnAjudaClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAjudaClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
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

procedure TFrmProdutoPesquisa.BtnAlterarClick(Sender: TObject);
var
   ProdutoImagem: file of Byte;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnAlterarClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  if (CdsPesquisa.FieldCount > 0) then
  begin
    if CdsPesquisa.RecordCount > 0 then
    begin
      try
        FrmProduto := TFrmProduto.Create(Application);
        FrmProduto.CarregarTela('Geral');

        FrmProduto.PnlCampos.Enabled           := True;
        FrmProduto.EdtIdRegistro.Text          := CdsPesquisa.FieldByName('IdProduto'         ).AsString;
        FrmProduto.EdtNmUsuario.Text           := CdsPesquisa.FieldByName('NmUsuarioCadastro' ).AsString;
        FrmProduto.DtpDtCadastro.Date          := CdsPesquisa.FieldByName('DtCadastro'        ).AsDateTime;
        if CdsPesquisa.FieldByName('SnSituacao').AsString = 'Ativo' then
        begin
          FrmProduto.ChkSnSituacao.Checked     := True;
          FrmProduto.ChkSnSituacao.Caption     := 'Cadastro Ativo';
        end
        else
        begin
          FrmProduto.ChkSnSituacao.Checked     := False;
          FrmProduto.ChkSnSituacao.Caption     := 'Cadastro Inativo';
        end;
        FrmProduto.CbbIdMarca.ItemIndex        := RetornaZeroI(Integer(FrmProduto.CbbIdMarca.Properties.Items.IndexOf(CdsPesquisa.FieldByName('NmMarca').AsString)));
        FrmProduto.CbbIdGrupoProduto.ItemIndex := RetornaZeroI(Integer(FrmProduto.CbbIdGrupoProduto.Properties.Items.IndexOf(CdsPesquisa.FieldByName('NmGrupoProduto').AsString)));
        FrmProduto.EdtNmProduto.Text           := CdsPesquisa.FieldByName('NmProduto'         ).AsString;
        FrmProduto.MkeVlCusto.Text             := FormatFloat('0.00' , CdsPesquisa.FieldByName('VlCusto').AsCurrency);
        FrmProduto.MkeVlVenda.Text             := FormatFloat('0.00' , CdsPesquisa.FieldByName('VlVenda').AsCurrency);
        FrmProduto.EdtNrEan.Text               := CdsPesquisa.FieldByName('NrEan'             ).AsString;
        FrmProduto.MemObservacao.Text          := CdsPesquisa.FieldByName('NmObs'         ).AsString;

        if FileExists(DtmPrincipal.NmCaminhoImgProduto + RemoveCaracteres(CdsPesquisa.FieldByName('IdProduto').AsString) + '.jpg') then
        begin
          AssignFile(ProdutoImagem, (DtmPrincipal.NmCaminhoImgProduto + RemoveCaracteres(CdsPesquisa.FieldByName('IdProduto').AsString) + '.jpg'));
          Reset(ProdutoImagem);
          if FileSize(ProdutoImagem) > 0 then
          begin
            CloseFile(ProdutoImagem);
            FrmProduto.ImgImProduto.Picture.LoadFromFile(DtmPrincipal.NmCaminhoImgProduto + RemoveCaracteres(CdsPesquisa.FieldByName('IdProduto').AsString) + '.jpg');
          end;
        end;

        ControleBotao;
        FrmProduto.ShowModal;
      finally
        FrmProduto.Free;
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

procedure TFrmProdutoPesquisa.BtnFecharClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnFecharClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmProdutoPesquisa.BtnImprimirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnImprimirClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
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
      unProduto.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, dnRelatorios.CDSRelPesquisa);
    end
    else
    begin
      unProduto.CarregaDbGrid(DtmPrincipal.Conexao, 2, DtmPrincipal.IdEmpresaLogada, EdtPesquisa.Text, dnRelatorios.CDSRelPesquisa);
    end;

    FrmProcessando.Destroy;

    dnRelatorios.frxPDFExport.ShowDialog := True;
    dnRelatorios.frxReport.LoadFromFile(DtmPrincipal.NmCaminhoExecutavel +  'Relatorio\RelPesqImpProduto.fr3');
    dnRelatorios.frxReport.ShowReport();
  finally
    dnRelatorios.Destroy;
  end;
end;

procedure TFrmProdutoPesquisa.BtnIncluirClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnIncluirClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;

  try
    FrmProduto := TFrmProduto.Create(Application);
    ControleBotao;
    FrmProduto.CarregarTela('Geral');
    FrmProduto.ShowModal;
  finally
    FrmProduto.Free;
  end;
end;

procedure TFrmProdutoPesquisa.BtnLimparClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnLimparClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmProdutoPesquisa.BtnPesquisarClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'BtnPesquisarClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  Pesquisar(EdtPesquisa.Text);

  inherited;
end;

procedure TFrmProdutoPesquisa.ControleBotao;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'ControleBotao';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  FrmProduto.BtnIncluir.Enabled   := False;
  FrmProduto.BtnSalvar.Enabled    := False;
  FrmProduto.BtnCancelar.Enabled  := False;
  FrmProduto.BtnFechar.Enabled    := True;

  if Trim(FrmProduto.EdtIdRegistro.Text) <> '' then
  begin
    FrmProduto.BtnIncluir.Enabled  := True;
    FrmProduto.BtnAnterior.Enabled := True;
    FrmProduto.BtnProximo.Enabled  := True;
    FrmProduto.BtnWebCam.Enabled   := True;
    FrmProduto.BtnLocal.Enabled    := True;
    FrmProduto.EdtNrEan.Enabled    := False;
  end
  else
  begin
    FrmProduto.BtnSalvar.Enabled   := True;
    FrmProduto.BtnCancelar.Enabled := True;
    FrmProduto.EdtNrEan.Enabled    := True;
  end;
end;

procedure TFrmProdutoPesquisa.DbgPesquisaDblClick(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'DbgPesquisaDblClick';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
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

procedure TFrmProdutoPesquisa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormClose';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmProdutoPesquisa.FormCreate(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormCreate';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmProdutoPesquisa.FormShow(Sender: TObject);
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'FormShow';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
  DtmPrincipal.unLog.GerarLog(DtmPrincipal.Conexao);

  inherited;
end;

procedure TFrmProdutoPesquisa.Pesquisar(AConsulta: String);
var
  I: Integer;
  lConsulta: Integer;
begin
  DtmPrincipal.unLog.NmOperacao := 'Entrou';
  DtmPrincipal.unLog.NmClasse   := 'TFrmProdutoPesquisa';
  DtmPrincipal.unLog.NmMetodo   := 'Pesquisar';
  DtmPrincipal.unLog.NmTabela   := 'Produto';
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
        unProduto  := TProduto.Create;

        unProduto.CarregaDbGrid(DtmPrincipal.Conexao, 2, 0, EdtPesquisa.Text, CdsPesquisa);
      end;
    end;
  finally
    unProduto.Free;
    FrmProcessando.Destroy;
  end;

  inherited;
end;

end.
