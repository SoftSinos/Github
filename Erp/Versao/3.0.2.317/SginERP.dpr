﻿program SginERP;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  MidasLib,
  Windows,
  Dialogs,
  fPrincipal in 'fPrincipal.pas' {FrmPrincipal},
  uAjuda in '..\Classes\Ajuda\uAjuda.pas',
  NBioAPI_Type in '..\Classes\Biometria\HamsterDX\NBioAPI_Type.pas',
  uCarregaDados in '..\Classes\CarregaDados\uCarregaDados.pas',
  fConfiguracao in '..\Classes\Configuracao\fConfiguracao.pas' {FrmConfiguracao},
  uConfiguracao in '..\Classes\Configuracao\uConfiguracao.pas',
  fCriacaoRelatorios in '..\Classes\CriacaoRelatorios\fCriacaoRelatorios.pas' {FrmCriacaoRelatorios},
  uCriaPastas in '..\Classes\CriaPastas\uCriaPastas.pas',
  dArquivos in '..\Classes\DataModule\dArquivos.pas' {DtmArquivos: TDataModule},
  dMail in '..\Classes\DataModule\dMail.pas' {DtmEmail: TDataModule},
  dPrincipal in '..\Classes\DataModule\dPrincipal.pas' {DtmPrincipal: TDataModule},
  dRelatorios in '..\Classes\DataModule\dRelatorios.pas' {DtmRelatorios: TDataModule},
  uFuncao in '..\Classes\Funcao\uFuncao.pas',
  GIFImage in '..\Classes\Imagem\GIFImage.pas',
  fLogPesquisa in '..\Classes\Log\fLogPesquisa.pas',
  uLog in '..\Classes\Log\uLog.pas',
  fLogin in '..\Classes\Login\fLogin.pas' {FrmLogin},
  uMensagem in '..\Classes\Mensagem\uMensagem.pas',
  uProcedure in '..\Classes\Procedure\uProcedure.pas',
  fProcessando in '..\Classes\Processamento\fProcessando.pas' {FrmProcessando},
  fSplash in '..\Classes\Splash\fSplash.pas' {FrmSplash},
  uUsuario in '..\Classes\Usuario\uUsuario.pas',
  fUsuario in '..\Classes\Usuario\fUsuario.pas' {FrmUsuario},
  fUsuarioPesquisa in '..\Classes\Usuario\fUsuarioPesquisa.pas' {FrmUsuarioPesquisa},
  fWebCam in '..\Classes\WebCam\fWebCam.pas' {FrmWebCam},
  fEmpresa in 'fEmpresa.pas' {FrmEmpresa},
  fEmpresaPesquisa in 'fEmpresaPesquisa.pas' {FrmEmpresaPesquisa},
  fCalendario in '..\Classes\Calendario\fCalendario.pas' {FrmCalendario},
  fCalendarioPesquisa in '..\Classes\Calendario\fCalendarioPesquisa.pas' {FrmCalendarioPesquisa},
  uCalendario in '..\Classes\Calendario\uCalendario.pas',
  fConfiguracaoPesquisa in '..\Classes\Configuracao\fConfiguracaoPesquisa.pas' {FrmConfiguracaoPesquisa},
  uVersao in '..\Classes\Versao\uVersao.pas',
  uSoftHouse in '..\Classes\SoftHouse\uSoftHouse.pas',
  uMeioMagnetico in '..\Classes\MeioMagnetico\uMeioMagnetico.pas',
  uCep in '..\Classes\Geografia\uCep.pas',
  uCidade in '..\Classes\Geografia\uCidade.pas',
  uPais in '..\Classes\Geografia\uPais.pas',
  uRegiao in '..\Classes\Geografia\uRegiao.pas',
  uAtivacao in '..\Classes\AtivaSistema\uAtivacao.pas',
  fTipoPessoaPesquisa in 'fTipoPessoaPesquisa.pas' {FrmTipoPessoaPesquisa},
  fTipoPessoa in 'fTipoPessoa.pas' {FrmTipoPessoa},
  fCep in '..\Classes\Geografia\fCep.pas' {FrmCep},
  fCepPesquisa in '..\Classes\Geografia\fCepPesquisa.pas' {FrmCepPesquisa},
  fCidade in '..\Classes\Geografia\fCidade.pas' {FrmCidade},
  fCidadePesquisa in '..\Classes\Geografia\fCidadePesquisa.pas' {FrmCidadePesquisa},
  fCadastro in '..\Classes\Base\fCadastro.pas' {FrmCadastro},
  fPesquisa in '..\Classes\Base\fPesquisa.pas' {FrmPesquisa},
  fPessoaPesquisa in 'fPessoaPesquisa.pas' {FrmPessoaPesquisa},
  fPessoa in 'fPessoa.pas' {FrmPessoa},
  uEmpresa in 'uEmpresa.pas',
  uPessoa in 'uPessoa.pas',
  uTipoPessoa in 'uTipoPessoa.pas',
  uTipoServico in 'uTipoServico.pas',
  fTipoServico in 'fTipoServico.pas' {FrmTipoServico},
  fTipoServicoPesquisa in 'fTipoServicoPesquisa.pas' {FrmTipoServicoPesquisa},
  fServico in 'fServico.pas' {FrmServico},
  fServicoPesquisa in 'fServicoPesquisa.pas' {FrmServicoPesquisa},
  uServico in 'uServico.pas',
  uGrupoProduto in 'uGrupoProduto.pas',
  uMarca in 'uMarca.pas',
  fMarca in 'fMarca.pas' {FrmMarca},
  fMarcaPesquisa in 'fMarcaPesquisa.pas' {FrmMarcaPesquisa},
  fProduto in 'fProduto.pas' {FrmProduto},
  fProdutoPesquisa in 'fProdutoPesquisa.pas' {FrmProdutoPesquisa},
  uProduto in 'uProduto.pas',
  uTipoPagamento in 'uTipoPagamento.pas',
  fTipoPagamento in 'fTipoPagamento.pas' {FrmTipoPagamento},
  fTipoPagamentoPesquisa in 'fTipoPagamentoPesquisa.pas' {FrmTipoPagamentoPesquisa},
  fNotaStarter in 'fNotaStarter.pas' {FrmNotaStarter},
  fNotaPesquisa in 'fNotaPesquisa.pas' {FrmNotaPesquisa},
  uNota in 'uNota.pas',
  uNotaItem in 'uNotaItem.pas',
  uNotaPagamento in 'uNotaPagamento.pas',
  fAgendaStarter in 'fAgendaStarter.pas' {FrmAgendaStarter},
  uAgenda in 'uAgenda.pas',
  fAtivacaoSistema in '..\Classes\AtivaSistema\fAtivacaoSistema.pas' {FrmAtivacaoSistema},
  uLicenca in '..\Classes\AtivaSistema\uLicenca.pas',
  fGrupoServico in 'fGrupoServico.pas' {FrmGrupoServico},
  fGrupoServicoPesquisa in 'fGrupoServicoPesquisa.pas' {FrmGrupoServicoPesquisa},
  uGrupoServico in 'uGrupoServico.pas',
  fSobre in '..\Classes\Sobre\fSobre.pas' {FrmSobre},
  fAjuda in '..\Classes\Ajuda\fAjuda.pas' {FrmAjuda},
  fGrupoProduto in 'fGrupoProduto.pas' {FrmGrupoProduto},
  fGrupoProdutoPesquisa in 'fGrupoProdutoPesquisa.pas' {FrmGrupoProdutoPesquisa},
  fOperacao in '..\Classes\Base\fOperacao.pas' {FrmOperacao},
  fContraSenha in '..\Classes\AtivaSistema\fContraSenha.pas' {FrmContraSenha},
  fCopiaSeguranca in '..\Classes\CopiaSeguranca\fCopiaSeguranca.pas' {FrmCopiaSeguranca},
  fInformacoes in '..\Classes\Informacao\fInformacoes.pas' {FrmInformacoes},
  fRelatorio in '..\Classes\Relatorio\fRelatorio.pas' {FrmRelatorio};

{$R *.res}

var
  HprevHist: HWND;

begin
  Application.Initialize;
  HprevHist := FindWindow(Nil, PChar('⁞ ⁞ ⁞ SginERP - Software de Gestão Integrada ⁞ ⁞ ⁞'));

 if HprevHist = 0 then
 begin
  Application.Title := '⁞ ⁞ ⁞ SginERP - Software de Gestão Integrada ⁞ ⁞ ⁞';
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDtmPrincipal, DtmPrincipal);
  Application.CreateForm(TDtmEmail, DtmEmail);
  Application.CreateForm(TDtmRelatorios, DtmRelatorios);
  Application.CreateForm(TDtmArquivos, DtmArquivos);
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
 end
 else
 begin
  Application.MessageBox(PChar('O PROGRAMA NÃO PODE SER ABERTO MAIS DE UMA VEZ!'), 'ATENÇÃO', MB_OK + MB_ICONEXCLAMATION);
 end;

end.
