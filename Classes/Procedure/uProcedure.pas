unit uProcedure;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
     FireDAC.Comp.Client, Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

var
  gNaoMostraMensagemDeConfimacao: Boolean;
  gRetornarProcedure            : String;

procedure TruncaMeioMagnetico;
procedure CopiaSeguranca;
procedure Agendar(AIdEmpresaEntrada: Integer; AIdEmpresaProfissionalEntrada: Integer; AIdProfissionalEntrada: Integer; ANrAnoEntrada: String; AIdAgendaEntrada: Integer; ATpChamadaClasse: String);
procedure Inicializacao(AIdEmpresaEntrada: Integer);
procedure RandomAtivacao(ATpChamadaClasse: String);
procedure Registro(AIdEmpresaEntrada: Integer; AIdTabelaEntrada: Integer; ANmTabelaEntrada: String; ATpChamadaClasse: String; Data: TClientDataSet);
procedure MoverArquivo(AOrigem: String; ADestino: String; AArquivo: String);
procedure DeletarArquivo(AParta: String; AArquivo: String);
procedure FastCurvaABCCliente(AIdEmpresaEntrada: Integer; ADtInicialEntrada: TDate; ADtFinalEntrada: TDate; ATpChamadaClasse: String; Data: TClientDataSet);
procedure FastCurvaABCProfissional(AIdEmpresaEntrada: Integer; ADtInicialEntrada: TDate; ADtFinalEntrada: TDate; ATpProcedute: String; ATpChamadaClasse: String; Data: TClientDataSet);
procedure FastCurvaABCTipoPagamento(AIdEmpresaEntrada: Integer; ADtInicialEntrada: TDate; ADtFinalEntrada: TDate; ATpChamadaClasse: String; Data: TClientDataSet);
procedure FastComissaoProfissional(AIdEmpresaEntrada: Integer; ADtInicialEntrada: TDate; ADtFinalEntrada: TDate; ATpProcedute: String; ATpChamadaClasse: String; Data: TClientDataSet);

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, fProcessando;

procedure FastComissaoProfissional(AIdEmpresaEntrada: Integer; ADtInicialEntrada: TDate; ADtFinalEntrada: TDate; ATpProcedute: String; ATpChamadaClasse: String; Data: TClientDataSet);
var
  QryProc: TFDQuery;
begin
  try
    QryProc := TFDQuery.Create(Nil);

    QryProc.Connection := DtmPrincipal.Conexao;

    if ATpProcedute = 'Produto' then
    begin
      if Data.FieldCount = 0 then
      begin
        Data.FieldDefs.Add('IdEmpresa', ftInteger);
        Data.FieldDefs.Add('NmFantasiaNmRazaoSocial', ftString, 120, False);
        Data.FieldDefs.Add('IdEmpProfissional', ftInteger);
        Data.FieldDefs.Add('IdProfissional', ftInteger);
        Data.FieldDefs.Add('NmProfissional', ftString, 255, False);
        Data.FieldDefs.Add('NmProduto', ftString, 255, False);
        Data.FieldDefs.Add('PcComissao', ftFloat);
        Data.FieldDefs.Add('VlProdutos', ftCurrency);
        Data.FieldDefs.Add('VlComissao', ftFloat);
        Data.FieldDefs.Add('DtInicioEntrada', ftDate);
        Data.FieldDefs.Add('DtFinalEntrada', ftDate);
        Data.CreateDataSet;
      end;
    end
    else
    if ATpProcedute = 'Servico' then
    begin
      if Data.FieldCount = 0 then
      begin
        Data.FieldDefs.Add('IdEmpresa', ftInteger);
        Data.FieldDefs.Add('NmFantasiaNmRazaoSocial', ftString, 120, False);
        Data.FieldDefs.Add('IdEmpProfissional', ftInteger);
        Data.FieldDefs.Add('IdProfissional', ftInteger);
        Data.FieldDefs.Add('NmProfissional', ftString, 255, False);
        Data.FieldDefs.Add('NmTpServico', ftString, 255, False);
        Data.FieldDefs.Add('PcComissao', ftFloat);
        Data.FieldDefs.Add('VlServicos', ftCurrency);
        Data.FieldDefs.Add('VlComissao', ftFloat);
        Data.FieldDefs.Add('DtInicioEntrada', ftDate);
        Data.FieldDefs.Add('DtFinalEntrada', ftDate);
        Data.CreateDataSet;
      end;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    QryProc.Close;
    QryProc.Sql.Clear;

    if ATpProcedute = 'Produto' then
    begin
      QryProc.Sql.Add('Exec PC_FastComissaoProdutoProfissional ');
    end
    else
    if ATpProcedute = 'Servico' then
    begin
      QryProc.Sql.Add('Exec PC_FastComissaoServicoProfissional ');
    end;

    QryProc.Sql.Add('  :IdEmpresaEntrada,                 ');
    QryProc.Sql.Add('  :DtInicioEntrada,                  ');
    QryProc.Sql.Add('  :DtFinalEntrada,                   ');
    QryProc.Sql.Add('  :TpChamadaClasse                   ');


    QryProc.ParamByName('IdEmpresaEntrada').AsInteger := AIdEmpresaEntrada;
    QryProc.ParamByName('DtInicioEntrada').AsDateTime := ADtInicialEntrada;
    QryProc.ParamByName('DtFinalEntrada').AsDateTime  := ADtFinalEntrada;
    QryProc.ParamByName('TpChamadaClasse').AsString   := ATpChamadaClasse;

    try
      QryProc.Open;

      QryProc.First;
      while not QryProc.Eof do
      begin
        Data.Append;
        Data.FieldByName('IdEmpresa').AsInteger               := QryProc.FieldByName('IdEmpresa').AsInteger;
        Data.FieldByName('NmFantasiaNmRazaoSocial').AsString  := QryProc.FieldByName('NmFantasiaNmRazaoSocial').AsString;
        Data.FieldByName('IdEmpProfissional').AsInteger       := QryProc.FieldByName('IdEmpProfissional').AsInteger;
        Data.FieldByName('IdProfissional').AsInteger          := QryProc.FieldByName('IdProfissional').AsInteger;
        Data.FieldByName('NmProfissional').AsString           := QryProc.FieldByName('NmProfissional').AsString;
        Data.FieldByName('DtInicioEntrada').AsDateTime        := QryProc.FieldByName('DtInicioEntrada').AsDateTime;
        Data.FieldByName('DtFinalEntrada').AsDateTime         := QryProc.FieldByName('DtFinalEntrada').AsDateTime;

        if ATpProcedute = 'Produto' then
        begin
          Data.FieldByName('NmProduto').AsString              := QryProc.FieldByName('NmProduto').AsString;
          Data.FieldByName('PcComissao').AsFloat              := QryProc.FieldByName('PcComissao').AsFloat;
          Data.FieldByName('VlProdutos').AsFloat              := QryProc.FieldByName('VlProdutos').AsFloat;
          Data.FieldByName('VlComissao').AsFloat              := QryProc.FieldByName('VlComissao').AsFloat;
        end
        else
        if ATpProcedute = 'Servico' then
        begin
          Data.FieldByName('NmTpServico').AsString            := QryProc.FieldByName('NmTpServico').AsString;
          Data.FieldByName('PcComissao').AsFloat              := QryProc.FieldByName('PcComissao').AsFloat;
          Data.FieldByName('VlServicos').AsFloat              := QryProc.FieldByName('VlServicos').AsFloat;
          Data.FieldByName('VlComissao').AsFloat              := QryProc.FieldByName('VlComissao').AsFloat;
        end;

        Data.Post;

        QryProc.Next;
      end;
    except
      on e: exception do
      begin
        if ATpProcedute = 'Produto' then
        begin
          MsgErro(uMensagem.ErroAoTentarExecutarProcedure + ' ' + '"PC_FastComissaoProdutoProfissional" ' + #13 + #13 + e.Message)
        end
        else
        if ATpProcedute = 'Servico' then
        begin
          MsgErro(uMensagem.ErroAoTentarExecutarProcedure + ' ' + '"PC_FastComissaoServicoProfissional" ' + #13 + #13 + e.Message)
        end;
      end;
    end;
  finally
    QryProc.Close;
    Data.EnableControls;
    Data.First;
    FreeAndNil(QryProc)
  end;
end;

procedure FastCurvaABCTipoPagamento(AIdEmpresaEntrada: Integer; ADtInicialEntrada: TDate; ADtFinalEntrada: TDate; ATpChamadaClasse: String; Data: TClientDataSet);
var
  QryProc: TFDQuery;
begin
  try
    QryProc := TFDQuery.Create(Nil);

    QryProc.Connection := DtmPrincipal.Conexao;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('NmFantasiaNmRazaoSocial', ftString, 120, False);
      Data.FieldDefs.Add('IdTpPagamento', ftInteger);
      Data.FieldDefs.Add('NmTpPagamento', ftString, 255, False);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('VlPagamentos', ftCurrency);
      Data.FieldDefs.Add('VlNotas', ftCurrency);
      Data.FieldDefs.Add('PcParticipacao', ftCurrency);
      Data.FieldDefs.Add('DtInicioEntrada', ftDate);
      Data.FieldDefs.Add('DtFinalEntrada', ftDate);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    QryProc.Close;
    QryProc.Sql.Clear;

    QryProc.Sql.Add('Exec PC_FastCurvaTipoPagamento');
    QryProc.Sql.Add('  :IdEmpresaEntrada,          ');
    QryProc.Sql.Add('  :DtInicioEntrada,           ');
    QryProc.Sql.Add('  :DtFinalEntrada,            ');
    QryProc.Sql.Add('  :TpChamadaClasse            ');

    QryProc.ParamByName('IdEmpresaEntrada').AsInteger := AIdEmpresaEntrada;
    QryProc.ParamByName('DtInicioEntrada').AsDateTime := ADtInicialEntrada;
    QryProc.ParamByName('DtFinalEntrada').AsDateTime  := ADtFinalEntrada;
    QryProc.ParamByName('TpChamadaClasse').AsString   := ATpChamadaClasse;

    try
      QryProc.Open;

      QryProc.First;
      while not QryProc.Eof do
      begin
        Data.Append;
        Data.FieldByName('IdEmpresa').AsInteger               := QryProc.FieldByName('IdEmpresa').AsInteger;
        Data.FieldByName('NmFantasiaNmRazaoSocial').AsString  := QryProc.FieldByName('NmFantasiaNmRazaoSocial').AsString;
        Data.FieldByName('IdTpPagamento').AsInteger           := QryProc.FieldByName('IdTpPagamento').AsInteger;
        Data.FieldByName('NmTpPagamento').AsString            := QryProc.FieldByName('NmTpPagamento').AsString;
        Data.FieldByName('DtCadastro').AsDateTime             := QryProc.FieldByName('DtCadastro').AsDateTime;
        Data.FieldByName('VlNotas').AsFloat                   := QryProc.FieldByName('VlNotas').AsFloat;
        Data.FieldByName('VlPagamentos').AsFloat              := QryProc.FieldByName('VlPagamentos').AsFloat;
        Data.FieldByName('PcParticipacao').AsFloat            := QryProc.FieldByName('PcParticipacao').AsFloat;
        Data.FieldByName('DtInicioEntrada').AsDateTime        := QryProc.FieldByName('DtInicioEntrada').AsDateTime;
        Data.FieldByName('DtFinalEntrada').AsDateTime         := QryProc.FieldByName('DtFinalEntrada').AsDateTime;

        Data.Post;

        QryProc.Next;
      end;
    except
      on e: exception do
      begin
        MsgErro(uMensagem.ErroAoTentarExecutarProcedure + ' ' + '"PC_FastCurvaTipoPagamento" ' + #13 + #13 + e.Message)
      end;
    end;

  finally
    QryProc.Close;
    Data.EnableControls;
    Data.First;
    FreeAndNil(QryProc)
  end;
end;

procedure FastCurvaABCProfissional(AIdEmpresaEntrada: Integer; ADtInicialEntrada: TDate; ADtFinalEntrada: TDate; ATpProcedute: String; ATpChamadaClasse: String; Data: TClientDataSet);
var
  QryProc: TFDQuery;
begin
  try
    QryProc := TFDQuery.Create(Nil);

    QryProc.Connection := DtmPrincipal.Conexao;

    if ATpProcedute = 'Produto' then
    begin
      if Data.FieldCount = 0 then
      begin
        Data.FieldDefs.Add('IdEmpresa', ftInteger);
        Data.FieldDefs.Add('NmFantasiaNmRazaoSocial', ftString, 120, False);
        Data.FieldDefs.Add('IdEmpProfissional', ftInteger);
        Data.FieldDefs.Add('IdProfissional', ftInteger);
        Data.FieldDefs.Add('NmProfissional', ftString, 255, False);
        Data.FieldDefs.Add('QtdProdutos', ftFloat);
        Data.FieldDefs.Add('NmProduto', ftString, 255, False);
        Data.FieldDefs.Add('VlProdutos', ftCurrency);
        Data.FieldDefs.Add('TkVlProdutos', ftFloat);
        Data.FieldDefs.Add('DtInicioEntrada', ftDate);
        Data.FieldDefs.Add('DtFinalEntrada', ftDate);
        Data.CreateDataSet;
      end;
    end
    else
    if ATpProcedute = 'Servico' then
    begin
      if Data.FieldCount = 0 then
      begin
        Data.FieldDefs.Add('IdEmpresa', ftInteger);
        Data.FieldDefs.Add('NmFantasiaNmRazaoSocial', ftString, 120, False);
        Data.FieldDefs.Add('IdEmpProfissional', ftInteger);
        Data.FieldDefs.Add('IdProfissional', ftInteger);
        Data.FieldDefs.Add('NmProfissional', ftString, 255, False);
        Data.FieldDefs.Add('QtdServicos', ftFloat);
        Data.FieldDefs.Add('NmTpServico', ftString, 255, False);
        Data.FieldDefs.Add('VlServicos', ftCurrency);
        Data.FieldDefs.Add('TkVlServicos', ftFloat);
        Data.FieldDefs.Add('DtInicioEntrada', ftDate);
        Data.FieldDefs.Add('DtFinalEntrada', ftDate);
        Data.CreateDataSet;
      end;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    QryProc.Close;
    QryProc.Sql.Clear;

    if ATpProcedute = 'Produto' then
    begin
      QryProc.Sql.Add('Exec PC_FastCurvaProdutoProfissional ');
    end
    else
    if ATpProcedute = 'Servico' then
    begin
      QryProc.Sql.Add('Exec PC_FastCurvaServicoProfissional ');
    end;

    QryProc.Sql.Add('  :IdEmpresaEntrada,                 ');
    QryProc.Sql.Add('  :DtInicioEntrada,                  ');
    QryProc.Sql.Add('  :DtFinalEntrada,                   ');
    QryProc.Sql.Add('  :TpChamadaClasse                   ');


    QryProc.ParamByName('IdEmpresaEntrada').AsInteger := AIdEmpresaEntrada;
    QryProc.ParamByName('DtInicioEntrada').AsDateTime := ADtInicialEntrada;
    QryProc.ParamByName('DtFinalEntrada').AsDateTime  := ADtFinalEntrada;
    QryProc.ParamByName('TpChamadaClasse').AsString   := ATpChamadaClasse;

    try
      QryProc.Open;

      QryProc.First;
      while not QryProc.Eof do
      begin
        Data.Append;
        Data.FieldByName('IdEmpresa').AsInteger               := QryProc.FieldByName('IdEmpresa').AsInteger;
        Data.FieldByName('NmFantasiaNmRazaoSocial').AsString  := QryProc.FieldByName('NmFantasiaNmRazaoSocial').AsString;
        Data.FieldByName('IdEmpProfissional').AsInteger       := QryProc.FieldByName('IdEmpProfissional').AsInteger;
        Data.FieldByName('IdProfissional').AsInteger          := QryProc.FieldByName('IdProfissional').AsInteger;
        Data.FieldByName('NmProfissional').AsString           := QryProc.FieldByName('NmProfissional').AsString;
        Data.FieldByName('DtInicioEntrada').AsDateTime        := QryProc.FieldByName('DtInicioEntrada').AsDateTime;
        Data.FieldByName('DtFinalEntrada').AsDateTime         := QryProc.FieldByName('DtFinalEntrada').AsDateTime;

        if ATpProcedute = 'Produto' then
        begin
          Data.FieldByName('QtdProdutos').AsFloat               := QryProc.FieldByName('QtdProdutos').AsFloat;
          Data.FieldByName('NmProduto').AsString                := QryProc.FieldByName('NmProduto').AsString;
          Data.FieldByName('VlProdutos').AsFloat                := QryProc.FieldByName('VlProdutos').AsFloat;
          Data.FieldByName('TkVlProdutos').AsFloat              := QryProc.FieldByName('TkVlProdutos').AsFloat;
        end
        else
        if ATpProcedute = 'Servico' then
        begin
          Data.FieldByName('QtdServicos').AsFloat               := QryProc.FieldByName('QtdServicos').AsFloat;
          Data.FieldByName('NmTpServico').AsString              := QryProc.FieldByName('NmTpServico').AsString;
          Data.FieldByName('VlServicos').AsFloat                := QryProc.FieldByName('VlServicos').AsFloat;
          Data.FieldByName('TkVlServicos').AsFloat              := QryProc.FieldByName('TkVlServicos').AsFloat;
        end;

        Data.Post;

        QryProc.Next;
      end;
    except
      on e: exception do
      begin
        if ATpProcedute = 'Produto' then
        begin
          MsgErro(uMensagem.ErroAoTentarExecutarProcedure + ' ' + '"PC_FastCurvaProdutoProfissional" ' + #13 + #13 + e.Message)
        end
        else
        if ATpProcedute = 'Servico' then
        begin
          MsgErro(uMensagem.ErroAoTentarExecutarProcedure + ' ' + '"PC_FastCurvaServicoProfissional" ' + #13 + #13 + e.Message)
        end;
      end;
    end;
  finally
    QryProc.Close;
    Data.EnableControls;
    Data.First;
    FreeAndNil(QryProc)
  end;
end;

procedure FastCurvaABCCliente(AIdEmpresaEntrada: Integer; ADtInicialEntrada: TDate; ADtFinalEntrada: TDate; ATpChamadaClasse: String; Data: TClientDataSet);
var
  QryProc: TFDQuery;
begin
  try
    QryProc := TFDQuery.Create(Nil);

    QryProc.Connection := DtmPrincipal.Conexao;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('NmFantasiaNmRazaoSocial', ftString, 120, False);
      Data.FieldDefs.Add('IdEmpCliente', ftInteger);
      Data.FieldDefs.Add('IdCliente', ftInteger);
      Data.FieldDefs.Add('NmCliente', ftString, 255, False);
      Data.FieldDefs.Add('DtNascimento', ftDateTime);
      Data.FieldDefs.Add('NmEmail', ftString, 255, False);
      Data.FieldDefs.Add('NmFacebook', ftString, 255, False);
      Data.FieldDefs.Add('NrCelular', ftString, 20, False);
      Data.FieldDefs.Add('NrWhatsApp', ftString, 20, False);
      Data.FieldDefs.Add('QtdNotas', ftFloat);
      Data.FieldDefs.Add('VlNotas', ftCurrency);
      Data.FieldDefs.Add('VlProdutos', ftCurrency);
      Data.FieldDefs.Add('VlServicos', ftCurrency);
      Data.FieldDefs.Add('VlPagamentos', ftCurrency);
      Data.FieldDefs.Add('TkVlNotas', ftFloat);
      Data.FieldDefs.Add('TkVlProdutos', ftFloat);
      Data.FieldDefs.Add('TkVlServicos', ftFloat);
      Data.FieldDefs.Add('QtdAgdRealizadas', ftInteger);
      Data.FieldDefs.Add('TkAgdRealizadas', ftFloat);
      Data.FieldDefs.Add('QtdAgdCanceladas', ftInteger);
      Data.FieldDefs.Add('DtInicioEntrada', ftDate);
      Data.FieldDefs.Add('DtFinalEntrada', ftDate);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    QryProc.Close;
    QryProc.Sql.Clear;

    QryProc.Sql.Add('Exec PC_FastCurvaConsumoCliente');
    QryProc.Sql.Add('  :IdEmpresaEntrada,           ');
    QryProc.Sql.Add('  :DtInicioEntrada,            ');
    QryProc.Sql.Add('  :DtFinalEntrada,             ');
    QryProc.Sql.Add('  :TpChamadaClasse             ');

    QryProc.ParamByName('IdEmpresaEntrada').AsInteger := AIdEmpresaEntrada;
    QryProc.ParamByName('DtInicioEntrada').AsDateTime := ADtInicialEntrada;
    QryProc.ParamByName('DtFinalEntrada').AsDateTime  := ADtFinalEntrada;
    QryProc.ParamByName('TpChamadaClasse').AsString   := ATpChamadaClasse;

    try
      QryProc.Open;

      QryProc.First;
      while not QryProc.Eof do
      begin
        Data.Append;
        Data.FieldByName('IdEmpresa').AsInteger               := QryProc.FieldByName('IdEmpresa').AsInteger;
        Data.FieldByName('NmFantasiaNmRazaoSocial').AsString  := QryProc.FieldByName('NmFantasiaNmRazaoSocial').AsString;
        Data.FieldByName('IdEmpCliente').AsInteger            := QryProc.FieldByName('IdEmpCliente').AsInteger;
        Data.FieldByName('IdCliente').AsInteger               := QryProc.FieldByName('IdCliente').AsInteger;
        Data.FieldByName('NmCliente').AsString                := QryProc.FieldByName('NmCliente').AsString;
        Data.FieldByName('DtNascimento').AsDateTime           := QryProc.FieldByName('DtNascimento').AsDateTime;
        Data.FieldByName('NmEmail').AsString                  := QryProc.FieldByName('NmEmail').AsString;
        Data.FieldByName('NmFacebook').AsString               := QryProc.FieldByName('NmFacebook').AsString;
        Data.FieldByName('NrCelular').AsString                := FormatMaskText('\(99\)99999\-9999;0;_', QryProc.FieldByName('NrCelular').AsString);
        Data.FieldByName('NrWhatsApp').AsString               := QryProc.FieldByName('NrWhatsApp').AsString;
        Data.FieldByName('QtdNotas').AsFloat                  := QryProc.FieldByName('QtdNotas').AsFloat;
        Data.FieldByName('VlNotas').AsFloat                   := QryProc.FieldByName('VlNotas').AsFloat;
        Data.FieldByName('VlProdutos').AsFloat                := QryProc.FieldByName('VlProdutos').AsFloat;
        Data.FieldByName('VlServicos').AsFloat                := QryProc.FieldByName('VlServicos').AsFloat;
        Data.FieldByName('VlPagamentos').AsFloat              := QryProc.FieldByName('VlPagamentos').AsFloat;
        Data.FieldByName('TkVlNotas').AsFloat                 := QryProc.FieldByName('TkVlNotas').AsFloat;
        Data.FieldByName('TkVlProdutos').AsFloat              := QryProc.FieldByName('TkVlProdutos').AsFloat;
        Data.FieldByName('TkVlServicos').AsFloat              := QryProc.FieldByName('TkVlServicos').AsFloat;
        Data.FieldByName('QtdAgdRealizadas').AsInteger        := QryProc.FieldByName('QtdAgdRealizadas').AsInteger;
        Data.FieldByName('TkAgdRealizadas').AsFloat           := QryProc.FieldByName('TkAgdRealizadas').AsFloat;
        Data.FieldByName('QtdAgdCanceladas').AsInteger        := QryProc.FieldByName('QtdAgdCanceladas').AsInteger;
        Data.FieldByName('DtInicioEntrada').AsDateTime        := QryProc.FieldByName('DtInicioEntrada').AsDateTime;
        Data.FieldByName('DtFinalEntrada').AsDateTime         := QryProc.FieldByName('DtFinalEntrada').AsDateTime;

        Data.Post;

        QryProc.Next;
      end;
    except
      on e: exception do
      begin
        MsgErro(uMensagem.ErroAoTentarExecutarProcedure + ' ' + '"PC_FastCurvaConsumoCliente" ' + #13 + #13 + e.Message)
      end;
    end;

  finally
    QryProc.Close;
    Data.EnableControls;
    Data.First;
    FreeAndNil(QryProc)
  end;
end;

procedure DeletarArquivo(AParta, AArquivo: String);
var
  I: integer;
  SR: TSearchRec;
begin
  I := FindFirst(AParta + AArquivo, faAnyFile, SR);
  while I = 0 do
  begin
    DeleteFile(AParta + SR.Name);
    I := FindNext(SR);
  end;
end;

procedure MoverArquivo(AOrigem, ADestino, AArquivo: String);
var
  O: PWideChar;
  D: PWideChar;
begin
  try
    O:= PWideChar(AOrigem + AArquivo);
    D:= PWideChar(ADestino + AArquivo);

    MoveFile(O,D);
  finally

  end;
end;

procedure RandomAtivacao(ATpChamadaClasse: String);
var
  QryProc: TFDQuery;
begin
  try
    QryProc := TFDQuery.Create(Nil);

    QryProc.Connection := DtmPrincipal.Conexao;

    QryProc.Close;
    QryProc.SQL.Clear;

    QryProc.SQL.Add('Exec PC_Random    ');
    QryProc.SQL.Add(' :TpChamadaClasse ');

    QryProc.ParamByName('TpChamadaClasse').AsString := ATpChamadaClasse;

    try
      QryProc.Open;

      while not QryProc.Eof do
      begin
        gRetornarProcedure := QryProc.FieldByName('NrChaveAtivacao').AsString;

        QryProc.Next;
      end;
    except
      on e: exception do
      begin
        MsgErro(uMensagem.ErroAoTentarExecutarProcedure + ' ' + '"PC_Random" ' + #13 + #13 + e.Message)
      end;
    end;

  finally
    QryProc.Close;
    FreeAndNil(QryProc)
  end;
end;


procedure CopiaSeguranca;
var
  QryProc: TFDQuery;
begin
  Application.CreateForm(TFrmProcessando, FrmProcessando);
  FrmProcessando.Show;
  Application.ProcessMessages;

  if FileExists(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\' + uFuncao.DiaDaSemana(DayofWeek(Date), 0) + '\CopiaSeguraca.zseg') then
  begin
    DeleteFile(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\' + uFuncao.DiaDaSemana(DayofWeek(Date), 0) + '\CopiaSeguraca.zseg');
  end;

  try
    QryProc   := TFDQuery.Create(nil);
    begin
      QryProc.Sql.Clear;
      QryProc.Connection := DtmPrincipal.Conexao;
      QryProc.Sql.Add('BACKUP DATABASE :NmBanco                                                ');
      QryProc.Sql.Add( 'TO DISK = ' + quotedStr(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\' + uFuncao.DiaDaSemana(DayofWeek(Date), 0) + '\CopiaSeguraca.zseg'));

      QryProc.ParamByName('NmBanco').AsString := DtmPrincipal.NmBanco;

      QryProc.ExecSQL;
    end;
  finally
    FrmProcessando.Destroy;
  end;
end;

procedure Registro(AIdEmpresaEntrada: Integer; AIdTabelaEntrada: Integer; ANmTabelaEntrada: String; ATpChamadaClasse: String; Data: TClientDataSet);
var
  QryProc: TFDQuery;
begin
  try
    QryProc := TFDQuery.Create(Nil);

    QryProc.Connection := DtmPrincipal.Conexao;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdRetorno', ftInteger);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    QryProc.Close;
    QryProc.SQL.Clear;

    QryProc.SQL.Add('Exec PC_Registro     ');
    QryProc.SQL.Add('  :IdEmpresaEntrada, ');
    QryProc.SQL.Add('  :IdTabelaEntrada,  ');
    QryProc.SQL.Add('  :NmTabelaEntrada,  ');
    QryProc.SQL.Add('  :TpChamadaClasse   ');

    QryProc.ParamByName('IdEmpresaEntrada').AsInteger := AIdEmpresaEntrada;
    QryProc.ParamByName('IdTabelaEntrada').AsInteger  := AIdTabelaEntrada;
    QryProc.ParamByName('NmTabelaEntrada').AsString   := ANmTabelaEntrada;
    QryProc.ParamByName('TpChamadaClasse').AsString   := ATpChamadaClasse;

    try
      QryProc.Open;

      while not QryProc.Eof do
      begin
        Data.Append;
        Data.FieldByName('IdRetorno').AsInteger           := QryProc.FieldByName('IdRetorno').AsInteger;
        Data.Post;

        QryProc.Next;
      end;
    except
      on e: exception do
      begin
        MsgErro(uMensagem.ErroAoTentarExecutarProcedure + ' ' + '"PC_Registro" ' + #13 + #13 + e.Message)
      end;
    end;

  finally
    QryProc.Close;
    Data.EnableControls;
    Data.First;
    FreeAndNil(QryProc)
  end;
end;

procedure Agendar(AIdEmpresaEntrada: Integer; AIdEmpresaProfissionalEntrada: Integer; AIdProfissionalEntrada: Integer; ANrAnoEntrada: String; AIdAgendaEntrada: Integer; ATpChamadaClasse: String);
var
  QryProc: TFDQuery;
begin
  try
    QryProc := TFDQuery.Create(Nil);

    QryProc.Connection := DtmPrincipal.Conexao;

    QryProc.Close;
    QryProc.SQL.Clear;

    QryProc.SQL.Add('Exec PC_Agendar              ');
    QryProc.SQL.Add('  :IdEmpresaEntrada,         ');
    QryProc.SQL.Add('  :IdEmpProfissionalEmpresa, ');
    QryProc.SQL.Add('  :IdProfissionalEntrada,    ');
    QryProc.SQL.Add('  :NrAnoEntrada,             ');
    QryProc.SQL.Add('  :IdAgendaEntrada,          ');
    QryProc.SQL.Add('  :TpChamadaClasse           ');

    QryProc.ParamByName('IdEmpresaEntrada').AsInteger         := AIdEmpresaEntrada;
    QryProc.ParamByName('IdEmpProfissionalEmpresa').AsInteger := AIdEmpresaProfissionalEntrada;
    QryProc.ParamByName('IdProfissionalEntrada').AsInteger    := AIdProfissionalEntrada;
    QryProc.ParamByName('NrAnoEntrada').AsString              := ANrAnoEntrada;
    QryProc.ParamByName('IdAgendaEntrada').AsInteger          := AIdAgendaEntrada;
    QryProc.ParamByName('TpChamadaClasse').AsString           := ATpChamadaClasse;

    try
      QryProc.ExecSQL;
    except
      on e: exception do
      begin
        MsgErro(uMensagem.ErroAoTentarExecutarProcedure + ' ' + '"PC_Agendar" ' + #13 + #13 + e.Message)
      end;
    end;

  finally
    QryProc.Close;
    FreeAndNil(QryProc)
  end;
end;

procedure Inicializacao(AIdEmpresaEntrada: Integer);
var
  QryProc: TFDQuery;
begin
  try
    QryProc := TFDQuery.Create(Nil);

    QryProc.Connection := DtmPrincipal.Conexao;

    QryProc.Close;
    QryProc.SQL.Clear;
    QryProc.SQL.Add('Exec PC_Inicializacao');
    QryProc.SQL.Add('  :IdEmpresaEntrada ');

    QryProc.ParamByName('IdEmpresaEntrada').AsInteger := AIdEmpresaEntrada;

    try
      QryProc.ExecSQL;
    except
      on e: exception do
      begin
        MsgErro(uMensagem.ErroAoTentarExecutarProcedure + ' ' + '"PC_Inicializacao" ' + #13 + #13 + e.Message)
      end;
    end;
  finally
    QryProc.Close;
    FreeAndNil(QryProc);
    if not gNaoMostraMensagemDeConfimacao then
    begin
      MsgInformacao(uMensagem.ProcedureExecutadaComSucesso + ' ' + '"Exec PC_Inicializacao" ');
    end;
  end;
end;

procedure GeracaoMeioMagnetico(ACaminhoInventario: String);
var
  QryDados : TFDQuery;
  Arquivo  : TextFile;
begin
  try
    QryDados            := TFDQuery.Create(Nil);
    QryDados.Connection := DtmPrincipal.Conexao;

    QryDados.Close;
    QryDados.SQL.Clear;

    try
      QryDados.SQL.Add('Select NmMeioMagnetico From MeioMagnetico');
      QryDados.SQL.Add('Order By IdMeioMagnetico Asc');
      try
        QryDados.ExecSQL;
      except
        on e: exception do
        begin
          MsgErro(uMensagem.ErroAoTentarExecutarProcedure + ' ' + '"GeracaoMeioMagnetico" ' + #13 + #13 + e.Message)
        end;
      end;

      if not QryDados.IsEmpty then
      begin
        AssignFile(Arquivo, ACaminhoInventario);
        Rewrite(Arquivo);

        while not QryDados.Eof do
        begin
          Writeln(Arquivo, QryDados.FieldByName('NmMeioMagnetico').AsString);
          QryDados.Next;
        end;
        Closefile(Arquivo);
      end;

    finally
      DtmPrincipal.NrContadoRegistro := QryDados.RecordCount;
    end;
  finally
    MsgInformacao(uMensagem.ArquivoGeradoComSucesso + #13 + '" ' + ACaminhoInventario + '" ');
    QryDados.Close;
    FreeAndNil(QryDados)
  end;
end;

procedure TruncaMeioMagnetico;
var
  QryProc: TFDQuery;
begin
  try
    QryProc            := TFDQuery.Create(Nil);
    QryProc.Connection := DtmPrincipal.Conexao;

    QryProc.Close;
    try
      QryProc.SQL.Add('Truncate Table MeioMagnetico');
      try
        QryProc.ExecSQL;
      except
        on e: exception do
        begin
          MsgErro(uMensagem.ErroAoTentarExecutarProcedure + ' ' + '"TruncaMeioMagnetico" ' + #13 + #13 + e.Message)
        end;
      end;
    finally

    end;
  finally
    QryProc.Close;
    FreeAndNil(QryProc)
  end;
end;

end.
