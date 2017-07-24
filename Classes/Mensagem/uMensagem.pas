unit uMensagem;

interface

function AcessoNegado                                                     : String;
function AcessoPermitido                                                  : String;
function AgendaGeradaComSucesso                                           : String;
function AnuladaAgenda                                                    : String;

function ArquivoDeConexaoNaoEncontrado                                    : String;
function ArquivoGeradoComSucesso                                          : String;
function ASenhaNaoConfere                                                 : String;

function BemVindoAdministrador                                            : String;

function CampoChaveDaTabelaNaoSeraModificado                              : String;

function CopiaSegurancaRealizadaComSucesso                                : String;
function DesejaRealizarCopiaSeguranca                                     : String;

function DesejaFinalizarOSistema                                          : String;
function DesejaRodarProcedureDeInicializacao                              : String;
function DesejaExcluirORegistro                                           : String;
function DesejaCancelarOLancamento                                        : String;
function DesejaSairDaTelaSemSalvarOsDados                                 : String;

function DispositivoNaoDetectado                                          : String;

function ErroAoAtualizarAImagemDaPessoa                                   : String;
function ErroAoCarregarDLL                                                : String;
function ErroAoTentarSalvarORegisto                                       : String;
function ErroAoTentarExecutarProcedure                                    : String;
function ErroAoExcluirORegistro                                           : String;
function ErroAoExecutarConsulta                                           : String;
function ErroAoAbrirWebCam                                                : String;
function ErroAoGravarAVenda                                               : String;
function ErroNaInicializacaoDoDispositivo                                 : String;
function ErroNaLeituraDoArquivo                                           : String;
function ExclusaoPrivilegios                                              : String;
function ErroAoEnviarEmail                                                : String;
function ESoPermitidoNumeros                                              : String;
function EntrarEmContatoComOSuporte                                       : String;

function FalhaAoAbrirODispositivo                                         : String;
function FalhaNaCapturaDaBiometria                                        : String;
function FalhaNaExtracaoDaBiometria                                       : String;

function ImportacaoDoDadosRealizadaComSucesso                             : String;
function ImagemAdicionadaComSucesso                                       : String;
function InformarOTipoCadastro                                            : String;

function JaEstamosNoPrimeiroRegistro                                      : String;
function JaEstamosNoUltimoRegistro                                        : String;

function OValorDeveCompletarTodaAMascaraDoCampo                           : String;

function NaoExistemDadosParaSeremAlterados                                : String;
function NaoExisteCadastroDeEmpresa                                       : String;

function ORegistroFoiSalvoComSucesso                                      : String;
function ORegistroFoiExcluidoComSucesso                                   : String;
function ORegistroNaoPodeSerAlteradoPoisEChava                            : String;
function OSistemaSeraFinalizado                                           : String;
function OcorreuUmProblemaNoConectarAoBancoDeDados                        : String;
function OCepNaoFoiEntrado                                                : String;
function OCPFJaExiste                                                     : String;
function OCPFInformadoEInvalido                                           : String;
function OCNPJInformadoEInvalido                                          : String;
function OcorreuUmErroNoSistrma                                           : String;
function OArquivoNaoExisteOuNaoLocalizado                                 : String;
function OValorDoParametroNaoENumero                                      : String;
function OValorDoParametroNaoELetra                                       : String;

function ParaModificarOsLancamentosVoceDeveLimparOsLancamentosAnteriores  : String;

function ParametroNaoConfigurado                                          : String;
function ProcedureExecutadaComSucesso                                     : String;
function ProdutoInexistenteNoEstoque                                      : String;
function ProdutoNaoEncontrado                                             : String;
function PorFavorVerificarOLog                                            : String;

function RetornoDeErro                                                    : String;

function SairDaTelaMesmoAssim                                             : String;
function ServicoNaoEncontrado                                             : String;
function SuaConexaoTimeOutE                                               : String;
function SeuSistemaFoiAtivado                                             : String;
function ScriptSQLExecutadoComSucesso                                     : String;

function TelaASerImplementada                                             : String;
function TimeOutConfiguradoComSucesso                                     : String;
function TipoDeFiltroDeConsultaInvalido                                   : String;

function UmaEmpresaDeveSerSelecionada                                     : String;
function UmFiltroDeveSerSelecionado                                       : String;
function UmDosCamposDeveSerPreenchido                                     : String;
function UsuarioNaoCadastrado                                             : String;

function VendaRealizadaComSucesso                                         : String;
function VerificarOsCamposQueContemOSinalDeAsterisco                      : String;

implementation

function DesejaCancelarOLancamento: String;
begin
  Result := 'DESEJA CANCELAR O LAN�AMENTO?';
end;

function ServicoNaoEncontrado: String;
begin
  Result := 'SERVI�O N�O ENCONTRADO!';
end;

function ProdutoNaoEncontrado: String;
begin
  Result := 'PRODUTO N�O ENCONTRADO!';
end;

function InformarOTipoCadastro: String;
begin
  Result := 'INFORMAR O TIPO CADASTRO ANTES DE SEGUIR!';
end;

function AnuladaAgenda: String;
begin
  Result := 'ANULADA AGENDA!';
end;

function AgendaGeradaComSucesso: String;
begin
  Result := 'AGENDA GERADA COM SUCESSO!';
end;

function ScriptSQLExecutadoComSucesso: String;
begin
  Result := 'SCRIPT SQL EXECUTADO COM SUCESSO!';
end;

function OValorDeveCompletarTodaAMascaraDoCampo: String;
begin
  Result := 'O VALOR DEVE COMPLETAR TODA A MASCARA DO CAMPO!';
end;

function DesejaSairDaTelaSemSalvarOsDados: String;
begin
  Result := 'AO FECHAR SAIR DA TELA VOC� PERDER� OS DADOS!!!';
end;

function DesejaExcluirORegistro: String;
begin
  Result := 'DESEJA EXCLUIR O REGISTRO?';
end;

function EntrarEmContatoComOSuporte: String;
begin
  Result := 'ENTRAR EM CONTATO COM A EQUIPE DE SUPORTE' + #13 + #13 + 'SoftSinos Inform�tica' + #13 +'Telefone: (51)-98501-1901' + #13 + 'e-mail: suporte@softsinos.com.br';
end;

function PorFavorVerificarOLog: String;
begin
  Result := 'POR FAVOR VERIFICAR O LOG DO SISTEMA!';
end;

function ESoPermitidoNumeros: String;
begin
  Result := '� S� PERMITIDO N�MEROS!';
end;

function SeuSistemaFoiAtivado: String;
begin
  Result := 'SEU SISTEMA FOI ATIVADO COM SUCESSO!';
end;

function CampoChaveDaTabelaNaoSeraModificado: String;
begin
  Result := 'CAMPO CHAVE DA TABELA. O MESMO N�O SER� MODIFICADO!';
end;

function DesejaRealizarCopiaSeguranca: String;
begin
  Result := 'DESEJA REALIZAR UMA C�PIA DE SEGURAN�A?';
end;

function ErroAoEnviarEmail: String;
begin
  Result := 'ERRO AO ENVIAR EMAIL!';
end;

function ProdutoInexistenteNoEstoque: String;
begin
  Result := 'PRODUTO INEXIST�NTE NO ESTOQUE!';
end;

function ErroAoGravarAVenda: String;
begin
  Result := 'ERRO AO GRAVAR A VENDA!';
end;

function VendaRealizadaComSucesso: String;
begin
  Result := 'VENDA REALIZADA COM SUCESSO!';
end;

function ParaModificarOsLancamentosVoceDeveLimparOsLancamentosAnteriores: String;
begin
  Result := 'PARA MODIFICAR OS LAN�AMENTOS, VOC� DEVE LIMPAR OS LAN�AMENTOS ANTERIORES!';
end;

function ExclusaoPrivilegios: String;
begin
  Result := 'EXCLUS�O DE PRIVIL�GIOS!';
end;

function ErroAoAbrirWebCam: String;
begin
  Result := 'ERRO AO ABRIR WEBCAM!';
end;

function JaEstamosNoPrimeiroRegistro: String;
begin
  Result := 'J� ESTAMOS NO PRIMEIRO REGISTRO!';
end;

function JaEstamosNoUltimoRegistro: String;
begin
  Result := 'J� ESTAMOS NO �LTIMO REGISTRO!';
end;

function BemVindoAdministrador: String;
begin
  Result := '### B E M   V I N D O   A D M I N I S T R A D O R ###';
end;

function CopiaSegurancaRealizadaComSucesso: String;
begin
  Result := 'C�PIA DE SEGURAN�A REALIZADA COM SUCESSO!';
end;

function RetornoDeErro: String;
begin
  Result := 'RETORNO DE ERRO: ';
end;

function SairDaTelaMesmoAssim: String;
begin
  Result := 'SAIR DA TELA MESMO ASSIM?';
end;

function ArquivoGeradoComSucesso: String;
begin
  Result := 'ARQUIVO GERADO COM SUCESSO!';
end;

function AcessoNegado: String;
begin
  Result := 'ACESSO NEGADO!';
end;

function AcessoPermitido: String;
begin
  Result := 'ACESSO PERMITIDO!';
end;

function ArquivoDeConexaoNaoEncontrado: String;
begin
  Result := 'ARQUIVO DE CONEX�O N�O ENCONTRADO!';
end;

function ASenhaNaoConfere: String;
begin
  Result := 'A SENHA INFORMADA N�O CONFERE!';
end;

function DataEHoraConfiguradasComSucesso: String;
begin
  Result := 'DATA E HORA CONFIGURADOS COM SUCESSO!';
end;

function DispositivoNaoDetectado: String;
begin
  Result := 'DISPOSITIVO N�O CONECTADO AO SEU COMPUTADOR!';
end;

function DesejaFinalizarOSistema: String;
begin
  Result := 'DESEJA FINALIZAR O SISTEMA?';
end;

function DesejaRodarProcedureDeInicializacao: String;
begin
  Result := 'DESEJA RODAR A PROCEDURE DE INICIALIZA��O DE DADOS?';
end;

function ErroNaInicializacaoDoDispositivo: String;
begin
  Result := 'ERRO NA INICIALIZA��O DO DISPOSITIVO!';
end;

function ErroAoAtualizarAImagemDaPessoa: String;
begin
  Result := 'ERRO AO ATUALIZAR A IMAGEM DA PESSOA!';
end;

function ErroAoExcluirORegistro: String;
begin
  Result := 'ERRO AO EXCLUIR O REGISTRO!';
end;

function ErroAoTentarSalvarORegisto: String;
begin
  Result := 'ERRO AO TENTAR SALVAR O REGISTRO!' + #13 + 'REALIZE UMA PESQUISA, O CADASTRO JA DEVE EXISTIR!' + #13 + 'CONSULTE TAMB�M O LOG DO SISTEMA.';
end;

function ErroNaLeituraDoArquivo: String;
begin
  Result := 'ERRO NA LEITURA DO ARQUIVO!';
end;

function ErroAoCarregarDLL: String;
begin
  Result := 'ERRO AO CARREGAR A BIBLIOTECA DLL!';
end;

function ErroAoTentarExecutarProcedure: String;
begin
  Result := 'ERRO AO TENTAR EXECUTAR PROCEDIMENTO!';
end;

function ErroAoExecutarConsulta: String;
begin
  Result := 'ERRO AO TENTAR EXECUTAR CONSULTA!';
end;

function FalhaAoAbrirODispositivo: String;
begin
  Result := 'FALHA AO ABRIR O DISPOSITIVO!';
end;

function FalhaNaExtracaoDaBiometria: String;
begin
  Result := 'FALHA NA EXTRA��O DA BIOM�TRIA!';
end;

function FalhaNaCapturaDaBiometria: String;
begin
  Result := 'FALHA NA CAPTURA DA BIOM�TRIA!';
end;

function ImportacaoDoDadosRealizadaComSucesso: String;
begin
  Result := 'IMPORTA��O DOS DADOS REALIZADA COM SUCESSO!';
end;

function ImagemAdicionadaComSucesso: String;
begin
  Result := 'IMAGEM ADICIONADA COM SUCESSO!';
end;

function NaoExistemDadosParaSeremAlterados: String;
begin
  Result := 'N�O EXISTEM DADOS PARA SEREM ALTERADOS!';
end;

function NaoExisteCadastroDeEmpresa: String;
begin
  Result := 'N�O EXISTE NENHUM CADASTRO DE EMPRESA!' + #13 + 'DESEJA REALIZAR O CADASTRO AGORA?';
end;

function OcorreuUmProblemaNoConectarAoBancoDeDados: String;
begin
  Result := 'OCORREU UM PROBLEMA NO CONECTAR AO BANCO DE DADOS!';
end;

function ORegistroNaoPodeSerAlteradoPoisEChava: String;
begin
  Result := 'O REGISTRO N�O PODE SER ALTERADO POIS � CHAVE DE OUTROS PROCESSOS!';
end;

function ORegistroFoiSalvoComSucesso: String;
begin
  Result := 'O REGISTRO FOI SALVO COM SUCESSO!';
end;

function OCepNaoFoiEntrado: String;
begin
  Result := 'O CEP N�O FOI ENCONTRADO!';
end;

function OCPFJaExiste: String;
begin
  Result := 'O CPF J� EXISTE!';
end;

function OCPFInformadoEInvalido: String;
begin
  Result := 'O CPF INFORMADO � INVALIDO!';
end;

function OCNPJInformadoEInvalido: String;
begin
  Result := 'O CNPJ INFORMADO � INVALIDO!';
end;

function OSistemaSeraFinalizado: String;
begin
  Result := 'O SISTEMA SER� FINALIZADO.' + #13 + 'VOC� DEVER� ABRIR O SISTEMA NOVAMENTE!';
end;

function OArquivoNaoExisteOuNaoLocalizado: String;
begin
  Result := 'O ARQUIVO N�O EXISTE OU N�O PODE SER LOCALIZADO!';
end;

function OcorreuUmErroNoSistrma: String;
begin
  Result := 'OCORREU UM ERRO DESCONHECIDO NO SISTEMA!';
end;

function ORegistroFoiExcluidoComSucesso: String;
begin
  Result := 'O REGISTRO FOI EXCLUIDO COM SUCESSO!';
end;

function OValorDoParametroNaoENumero: String;
begin
  Result := 'O VALOR DO PARAMETRO N�O � N�MERICO!';
end;

function OValorDoParametroNaoELetra: String;
begin
  Result := 'O VALOR DO PARAMETRO N�O � LETRA!';
end;

function ParaAlterarUmaMarcacaoASituacaoDaMesmaDeveSerAtiva: String;
begin
  Result := 'PARA ALTERAR UMA MARCA��O A SITUA��O DA MESMA DEVE SER ATIVA!';
end;

function ParametroNaoConfigurado: String;
begin
  Result := 'PARAMETRO N�O CONFIGURADO!';
end;

function ProcedureExecutadaComSucesso: String;
begin
  Result := 'PROCEDIMENTO EXECUTADO COM SUCESSO!';
end;

function SuaConexaoTimeOutE: String;
begin
  Result := 'SUA CONEX�O TIME OUT � DE ';
end;

function TimeOutConfiguradoComSucesso: String;
begin
  Result := 'TIME OUT CONFIGURADO COM SUCESSO!';
end;

function TipoDeFiltroDeConsultaInvalido: String;
begin
  Result := 'TIPO DO FILTRO DA CONSULTA � INVALIDO!';
end;

function TelaASerImplementada: String;
begin
  Result := 'TELA A SER IMPLEMENTADA!';
end;

function UsuarioNaoCadastrado: String;
begin
  Result := 'USU�RIO N�O CADASTRO OU N�O ENCONTRADO!';
end;

function UmaEmpresaDeveSerSelecionada: String;
begin
  Result := 'UMA EMPRESA DEVE SER SELECIONADA!';
end;

function UmDosCamposDeveSerPreenchido: String;
begin
  Result := 'UM DOS CAMPOS DEVE SER PREENCHIDOS!';
end;

function UmFiltroDeveSerSelecionado: String;
begin
  Result := 'UM FILTRO DEVE SER SELECIONADO!';
end;

function VerificarOsCamposQueContemOSinalDeAsterisco: String;
begin
  Result := 'VERIFICAR OS CAMPO QUE CONT�M O SINAL DE (*) ASTERISCO!';
end;

end.
