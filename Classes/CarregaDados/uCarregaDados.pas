unit uCarregaDados;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, uMensagem, cxDropDownEdit;

type
  TCarregaDados = class
  private
    FId           : Integer;
    FNome         : String;
  public
    gCarregarSelecionar: Integer;
    property Id   : Integer read FId    write FId;
    property Nome : String  read FNome  write FNome;
    procedure CarregaDados(ASQLConnection: TFDConnection; ANmTabela: String; ANmIdTabela: Integer; ATpConsulta: String; ACondicaoConsulta: String; ComboBox: TcxComboBox);
  end;

implementation

{ TCarregaDados }

uses dPrincipal, uFuncao;

{Exemplo do CarregarDadso            Conex�o SQL                    Pessoa             IdPessoa/NmPessoa     Funcionario          <> < > =                   Name Combobox}
procedure TCarregaDados.CarregaDados(ASQLConnection: TFDConnection; ANmTabela: String; ANmIdTabela: Integer; ATpConsulta: String; ACondicaoConsulta: String; ComboBox: TcxComboBox);
var
  QryCarregaDados: TFDQuery;
  lAbreQuery     : Boolean;
begin
  lAbreQuery := True;

  try
    QryCarregaDados := TFDQuery.Create(nil);

    QryCarregaDados.Connection := ASQLConnection;

    if ANmTabela = 'Relatorio' then
    begin
      QryCarregaDados.SQL.Add('Select IdRelatorio Id, Upper(NmRelatorio) Nome From Relatorio                ');
      QryCarregaDados.SQL.Add('Where 1 = 1                                                                  ');

      if ATpConsulta = 'Cliente' then
      begin
        QryCarregaDados.SQL.Add('  And NmTpRelatorio = :NmTpRelatorio                                       ');
        QryCarregaDados.ParamByName('NmTpRelatorio').AsString := ATpConsulta
      end
      else
      if ATpConsulta = 'Servico' then
      begin
        QryCarregaDados.SQL.Add('  And NmTpRelatorio = :NmTpRelatorio                                       ');
        QryCarregaDados.ParamByName('NmTpRelatorio').AsString := ATpConsulta
      end
      else
      if ATpConsulta = 'Produto' then
      begin
        QryCarregaDados.SQL.Add('  And NmTpRelatorio = :NmTpRelatorio                                       ');
        QryCarregaDados.ParamByName('NmTpRelatorio').AsString := ATpConsulta
      end
      else
      if ATpConsulta = 'Financeiro' then
      begin
        QryCarregaDados.SQL.Add('  And NmTpRelatorio = :NmTpRelatorio                                       ');
        QryCarregaDados.ParamByName('NmTpRelatorio').AsString := ATpConsulta
      end;

      QryCarregaDados.SQL.Add(' Order By NmRelatorio                                                        ');
    end;

    if ANmTabela = 'RelatorioOrdem' then
    begin
      QryCarregaDados.SQL.Add('Select IdRelatorioOrdem Id, Upper(NmRelatorioOrdem) Nome From RelatorioOrdem ');
      QryCarregaDados.SQL.Add('Where 1 = 1                                                                  ');
      QryCarregaDados.SQL.Add('  And IdRelatorio = :IdRelatorio                                             ');
      QryCarregaDados.ParamByName('IdRelatorio').AsInteger := ANmIdTabela;
      QryCarregaDados.SQL.Add(' Order By NmRelatorioOrdem                                                   ');
    end;

    if ANmTabela = 'Empresa' then
    begin
      QryCarregaDados.SQL.Add('Select IdEmpresa Id, NmFantasia + '' - '' + NmRazaoSocial Nome  From Empresa ');
      QryCarregaDados.SQL.Add('Where 1 = 1 Order By IdEmpresa                                               ');
    end;

    if ANmTabela = 'GrupoProduto' then
    begin
      QryCarregaDados.SQL.Add('Select IdGrupoProduto Id, NmGrupoProduto Nome From GrupoProduto              ');
      QryCarregaDados.SQL.Add('Where 1 = 1 Order By IdGrupoProduto                                          ');
    end;

    if ANmTabela = 'GrupoServico' then
    begin
      QryCarregaDados.SQL.Add('Select IdGrupoServico Id, NmGrupoServico Nome From GrupoServico              ');
      QryCarregaDados.SQL.Add('Where 1 = 1 Order By IdGrupoServico                                          ');
    end;

    if ANmTabela = 'Marca' then
    begin
      QryCarregaDados.SQL.Add('Select IdMarca Id, NmMarca Nome From Marca                                   ');
      QryCarregaDados.SQL.Add('Where 1 = 1 Order By IdMarca                                                 ');
    end;

    if ANmTabela = 'Pais' then
    begin
      QryCarregaDados.SQL.Add('Select IdPais Id, NmSigla + '' - '' + NmPais Nome From Pais                  ');
      QryCarregaDados.SQL.Add('Where 1 = 1 Order By NmPais                                                  ');
    end;

    if ANmTabela = 'Regiao' then
    begin
      QryCarregaDados.SQL.Add('Select IdRegiao Id, NmRegiao Nome From Regiao                                ');
      QryCarregaDados.SQL.Add('Where 1 = 1 Order By NmRegiao                                                ');
    end;

    if ANmTabela = 'Uf' then
    begin
      QryCarregaDados.SQL.Add('Select IdUf Id, NmSigla Nome From Uf                                         ');
      QryCarregaDados.SQL.Add('Where 1 = 1 Order By NmUf                                                    ');
    end;

    if ANmTabela = 'Cidade' then
    begin
      QryCarregaDados.SQL.Add('Select Cidade.IdCidade Id, Cidade.NmCidade Nome From Cidade                  ');
      QryCarregaDados.SQL.Add('  Inner Join Uf On Uf.IdUf = Cidade.IdUf                                     ');
      QryCarregaDados.SQL.Add('Where 1 = 1                                                                  ');

      if ATpConsulta = 'Uf' then
      begin
        QryCarregaDados.SQL.Add('And Cidade.IdUf = :IdUf                                                    ');
        QryCarregaDados.ParamByName('IdUf').AsInteger := ANmIdTabela;
      end;

      if ATpConsulta <> 'Cidade' then
      begin
        QryCarregaDados.SQL.Add('And Cidade.IdCidade = :IdCidade                                            ');
        QryCarregaDados.ParamByName('IdCidade').AsInteger := ANmIdTabela;
      end;
      QryCarregaDados.SQL.Add('Order By Cidade.NmCidade                                                     ');
    end;

    if ANmTabela = 'TipoPessoa' then
    begin
      QryCarregaDados.SQL.Add('Select IdTpPessoa Id, NmTpPessoa Nome From TipoPessoa                        ');
      QryCarregaDados.SQL.Add('Where 1 = 1 Order By IdTpPessoa                                              ');
    end;

    if ANmTabela = 'Servico' then
    begin
      QryCarregaDados.SQL.Add('Select IdServico Id, NmTpServico Nome From VW_GridServico                    ');
      QryCarregaDados.SQL.Add('Where 1 = 1                                                                  ');

      if ATpConsulta = 'Profissional' then
      begin
        QryCarregaDados.SQL.Add('  And NmProfissional = :NmProfissional                                     ');
        QryCarregaDados.ParamByName('NmProfissional').AsString := IntToStr(ANmIdTabela)
      end;
      QryCarregaDados.SQL.Add(' Order By IdServico                                                          ');
    end;

    if ANmTabela = 'TipoServico' then
    begin
      QryCarregaDados.SQL.Add('Select IdTpServico Id, NmTpServico Nome From TipoServico                     ');
      QryCarregaDados.SQL.Add('Where 1 = 1                                                                  ');

      if ATpConsulta = 'GrupoServico' then
      begin
        QryCarregaDados.SQL.Add('  And IdGrupoServico = :IdGrupoServico                                     ');
        QryCarregaDados.ParamByName('IdGrupoServico').AsInteger := ANmIdTabela
      end;
      QryCarregaDados.SQL.Add(' Order By IdTpServico                                                        ');
    end;

    if ANmTabela = 'PessoaTipoPessoa' then
    begin
      if ACondicaoConsulta = '' then
      begin
        QryCarregaDados.SQL.Add('Select                                                                     ');
        QryCarregaDados.SQL.Add('  IdPessoa Id, Cast(IdEmpresa As Varchar(255)) + '' - '' +                 ');
        QryCarregaDados.SQL.Add('  Cast(IdPessoa As Varchar(255)) + '' - '' + NmPessoa Nome From Pessoa     ');
        QryCarregaDados.SQL.Add('  Inner Join TipoPessoa On TipoPessoa.IdTpPessoa = Pessoa.IdTpPessoa       ');
        QryCarregaDados.SQL.Add('Where 1 = 1                                                                ');
      end
      else
      if ACondicaoConsulta = 'SemIds' then
      begin
        QryCarregaDados.SQL.Add('Select                                                                     ');
        QryCarregaDados.SQL.Add('  IdPessoa Id, NmPessoa Nome From Pessoa                                   ');
        QryCarregaDados.SQL.Add('  Inner Join TipoPessoa On TipoPessoa.IdTpPessoa = Pessoa.IdTpPessoa       ');
        QryCarregaDados.SQL.Add('Where 1 = 1                                                                ');
      end;

      if ATpConsulta = 'Profissional' then
      begin
        QryCarregaDados.SQL.Add('  And TipoPessoa.SnFuncionario = 1                                         ');
      end
      else
      if ATpConsulta = 'Fornecedor' then
      begin
        QryCarregaDados.SQL.Add('  And TipoPessoa.SnFornecedor = 1                                          ');
      end
      else
      if ATpConsulta = 'Cliente' then
      begin
        QryCarregaDados.SQL.Add('  And TipoPessoa.SnCliente = 1                                             ');
      end;
      QryCarregaDados.SQL.Add('Order By Pessoa.NmPessoa                                                     ');
    end;

    if ANmTabela = 'Pessoa' then
    begin
      QryCarregaDados.SQL.Add('Select IdPessoa Id, NmPessoa Nome From Pessoa                                ');
      QryCarregaDados.SQL.Add('Where 1 = 1                                                                  ');
      QryCarregaDados.SQL.Add('Order By NmPessoa                                                            ');
    end;

    if ANmTabela = 'TipoPagamento' then
    begin
      QryCarregaDados.SQL.Add('Select IdTpPagamento Id, NmTpPagamento Nome From TipoPagamento               ');
      QryCarregaDados.SQL.Add('Where 1 = 1                                                                  ');
      QryCarregaDados.SQL.Add('Order By NmTpPagamento                                                       ');
    end;

    if ANmTabela = 'Produto' then
    begin
      QryCarregaDados.SQL.Add('Select IdProduto Id, NmProduto + '' '' + NmMarca Nome From VW_GridProduto    ');
      QryCarregaDados.SQL.Add('Where 1 = 1                                                                  ');
      QryCarregaDados.SQL.Add('Order By NmProduto                                                       ');
    end;

    if ANmTabela = 'Calendario' then
    begin
      if ATpConsulta = 'Mes' then
      begin
        QryCarregaDados.SQL.Add('Select Distinct NrMes  Id, Upper(NmMes) Nome From Calendario               ');
        QryCarregaDados.SQL.Add('Order By NrMes                                                             ');
      end;
    end;

    if ANmTabela = 'Calendario' then
    begin
      if ATpConsulta = 'Ano' then
      begin
        if ACondicaoConsulta = '' then
        begin
          QryCarregaDados.SQL.Add('Select Distinct NrAno Id, NrAno Nome From Calendario                     ');
          QryCarregaDados.SQL.Add('Order By  NrAno                                                          ');
        end
        else
        if ACondicaoConsulta = 'MaiorIgual' then
        begin
          QryCarregaDados.SQL.Add('Select Distinct NrAno Id, NrAno Nome From Calendario                     ');
          QryCarregaDados.SQL.Add('Where NrAno >= :NrAno                                                    ');
          QryCarregaDados.SQL.Add('Order By  NrAno                                                          ');

          QryCarregaDados.ParamByName('NrAno').AsString := IntToStr(ANmIdTabela)
        end;
      end;
    end;

    if lAbreQuery then
    begin
      QryCarregaDados.Open;
      QryCarregaDados.First;
    end;

    if ComboBox <> Nil then
    begin
      if gCarregarSelecionar = 1 then
      begin
        ComboBox.Properties.Items.AddObject('[SELECIONE]', TObject(0));
      end
      else if gCarregarSelecionar = 2 then
      begin
        ComboBox.Properties.Items.AddObject('[VAZIO]', TObject(0));
      end
      else if gCarregarSelecionar = 3 then
      begin
        ComboBox.Properties.Items.AddObject('[TODOS]', TObject(0));
      end;

      while not QryCarregaDados.eof do
      begin
        ComboBox.Properties.Items.AddObject(QryCarregaDados.FieldByName('Nome').AsString, TObject(QryCarregaDados.FieldByName('Id').AsInteger));
        QryCarregaDados.Next;
      end;

      ComboBox.ItemIndex := 0;
    end;
  except
    MsgErro(uMensagem.ErroAoExecutarConsulta);
  end;
end;

end.
