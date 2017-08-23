unit uProdutoValor;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TProdutoValor = class
  private
    FIdProdutoValor: Integer;
    FIdEmpresa: Integer;
    FIdUsuario: Integer;
    FDtCadastro: TDateTime;
    FSnSituacao: Integer;
    FIdProduto: Integer;
    FVlCusto: Extended;
    FVlVenda: Extended;
    procedure Inicializar;
  public
    property IdProdutoValor: Integer read FIdProdutoValor write FIdProdutoValor;
    property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property IdProduto: Integer read FIdProduto write FIdProduto;
    property VlCusto: Extended read FVlCusto write FVlCusto;
    property VlVenda: Extended read FVlVenda write FVlVenda;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdProdutoValor: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdProdutoValor: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdProdutoValor: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdProdutoValor: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TProdutoValor.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdProdutoValor: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryProdutoValor : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryProdutoValor := TFDQuery.Create(nil);
  try
    qryProdutoValor.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdProdutoValor', ftInteger);
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 7, False);
      Data.FieldDefs.Add('IdProduto', ftInteger);
      Data.FieldDefs.Add('VlCusto', ftCurrency);
      Data.FieldDefs.Add('VlVenda', ftCurrency);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryProdutoValor.Params.Clear;
      qryProdutoValor.SQL.Clear;
      qryProdutoValor.SQL.Add('Select');
      qryProdutoValor.SQL.Add('  IdProdutoValor,');
      qryProdutoValor.SQL.Add('  IdEmpresa,');
      qryProdutoValor.SQL.Add('  IdUsuario,');
      qryProdutoValor.SQL.Add('  DtCadastro,');
      qryProdutoValor.SQL.Add('  SnSituacao,');
      qryProdutoValor.SQL.Add('  IdProduto,');
      qryProdutoValor.SQL.Add('  VlCusto,');
      qryProdutoValor.SQL.Add('  VlVenda');
      qryProdutoValor.SQL.Add('From ProdutoValor');
      qryProdutoValor.SQL.Add('Where 1 = 1');
      if ISnSituacao = 1 then
      begin
         qryProdutoValor.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryProdutoValor.SQL.Add('  And SnSituacao = 0');
      end;

      if Trim(AConsulta) <> '' then
      begin
        if PermitePesquisa(lCampo, AConsulta) then
        begin
          if lCampo.DataType in [ftString] then
          begin
            lCondicao := ' And ' + lCampo.FieldName + ' Like ' + QuotedStr('%' + AConsulta + '%');
          end else if lCampo.DataType in [ftInteger] then
          begin
            lCondicao := ' And ' + lCampo.FieldName + ' = ' + AConsulta;
          end;
          qryProdutoValor.SQL.Add (lCondicao);
          qryProdutoValor.SQL.Add ('Order By');
          qryProdutoValor.SQL.Add ('  IdProdutoValor');

          qryProdutoValor.Open;
          qryProdutoValor.First;
        end;
      end else begin
        qryProdutoValor.SQL.Add (lCondicao);
        qryProdutoValor.SQL.Add ('Order By');
        qryProdutoValor.SQL.Add ('  IdProdutoValor');

        lFinalizaLoop := 1;
        qryProdutoValor.Open;
        qryProdutoValor.First;
      end;

      while not qryProdutoValor.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdProdutoValor').AsInteger = qryProdutoValor.FieldByName('IdProdutoValor').AsInteger then
              begin
                lVerificacao := 1;
              end;
              Data.Next
            end;
          end;
        end;
        if lVerificacao = 0 then
        begin
          Data.Append;
          Data.FieldByName('IdProdutoValor').AsInteger := qryProdutoValor.FieldByName('IdProdutoValor').AsInteger;
          Data.FieldByName('IdEmpresa').AsInteger := qryProdutoValor.FieldByName('IdEmpresa').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryProdutoValor.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryProdutoValor.FieldByName('DtCadastro').AsDateTime;
          if qryProdutoValor.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString  := 'Ativo';
          end else begin
            Data.FieldByName('SnSituacao').AsString  := 'Desativado';
          end;
          Data.FieldByName('IdProduto').AsInteger := qryProdutoValor.FieldByName('IdProduto').AsInteger;
          Data.FieldByName('VlCusto').AsFloat := qryProdutoValor.FieldByName('VlCusto').AsFloat;
          Data.FieldByName('VlVenda').AsFloat := qryProdutoValor.FieldByName('VlVenda').AsFloat;
          Data.Post;
        end;

        lVerificacao := 0;
        qryProdutoValor.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryProdutoValor.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TProdutoValor.Create;
begin
  Inicializar;
end;

procedure TProdutoValor.Inicializar;
begin
  IdProdutoValor := 0;
  IdEmpresa := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  IdProduto := 0;
  VlCusto := 0;
  VlVenda := 0;
end;

function TProdutoValor.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryProdutoValor: TFDQuery;
begin
  qryProdutoValor:= TFDQuery.Create(Nil);
  try
    qryProdutoValor.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdProdutoValor) then
    begin
      qryProdutoValor.SQL.Add('Insert Into ProdutoValor(');
      qryProdutoValor.SQL.Add('  IdEmpresa,');
      qryProdutoValor.SQL.Add('  IdUsuario,');
      qryProdutoValor.SQL.Add('  DtCadastro,');
      qryProdutoValor.SQL.Add('  SnSituacao,');
      qryProdutoValor.SQL.Add('  IdProduto,');
      qryProdutoValor.SQL.Add('  VlCusto,');
      qryProdutoValor.SQL.Add('  VlVenda)');
      qryProdutoValor.SQL.Add('Values (');
      qryProdutoValor.SQL.Add('  :IdEmpresa,');
      qryProdutoValor.SQL.Add('  :IdUsuario,');
      qryProdutoValor.SQL.Add('  :DtCadastro,');
      qryProdutoValor.SQL.Add('  :SnSituacao,');
      qryProdutoValor.SQL.Add('  :IdProduto,');
      qryProdutoValor.SQL.Add('  :VlCusto,');
      qryProdutoValor.SQL.Add('  :VlVenda)');

      qryProdutoValor.ParamByName('IdEmpresa').AsInteger := IdEmpresa;
      qryProdutoValor.ParamByName('SnSituacao').AsInteger := SnSituacao;
      qryProdutoValor.ParamByName('IdProduto').AsInteger := IdProduto;
    end else begin
      qryProdutoValor.SQL.Add('Update ProdutoValor Set ');
      qryProdutoValor.SQL.Add('  IdUsuario = :IdUsuario,');
      qryProdutoValor.SQL.Add('  DtCadastro = :DtCadastro,');
      qryProdutoValor.SQL.Add('  VlCusto = :VlCusto,');
      qryProdutoValor.SQL.Add('  VlVenda = :VlVenda ');
      qryProdutoValor.SQL.Add('Where IdProdutoValor = :IdProdutoValor');

      qryProdutoValor.ParamByName('IdProdutoValor').AsInteger := IdProdutoValor;

    end;
    qryProdutoValor.ParamByName('IdUsuario').AsInteger := IdUsuario;
    qryProdutoValor.ParamByName('DtCadastro').AsDateTime := DtCadastro;
    qryProdutoValor.ParamByName('VlCusto').AsFloat := VlCusto;
    qryProdutoValor.ParamByName('VlVenda').AsFloat := VlVenda;
   try
      qryProdutoValor.ExecSQL;
      qryProdutoValor.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryProdutoValor)
  end;
end;

class function TProdutoValor.Inativar(ASQLConnection: TFDConnection; AIdProdutoValor: Integer): Boolean;
var
  qryProdutoValor: TFDQuery;
begin
  qryProdutoValor:= TFDQuery.Create(Nil);
  try
    qryProdutoValor.Connection := ASQLConnection;
    qryProdutoValor.SQL.Add('Update ProdutoValor Set ');
    qryProdutoValor.SQL.Add('  SnSituacao = 0 ');
    qryProdutoValor.SQL.Add('Where 1 = 1');
    qryProdutoValor.SQL.Add('  And IdProdutoValor = ' + IntToStr(AIdProdutoValor));
   try
      qryProdutoValor.ExecSQL;
      qryProdutoValor.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryProdutoValor)
  end;
end;

class function TProdutoValor.Existe(ASQLConnection: TFDConnection; AIdProdutoValor: Integer): Boolean;
var
  qryProdutoValor: TFDQuery;
begin
  Result := False;
  qryProdutoValor:= TFDQuery.Create(Nil);
  try
    qryProdutoValor.Connection := ASQLConnection;
    qryProdutoValor.SQL.Add('Select IdProdutoValor From ProdutoValor');
    qryProdutoValor.SQL.Add('Where 1 = 1');
    qryProdutoValor.SQL.Add('  And IdProdutoValor = ' + IntToStr(AIdProdutoValor));
    qryProdutoValor.Open;
    if qryProdutoValor.Fields[0].Value > 0 then
      Result := True;
    qryProdutoValor.Close;
  finally
    FreeAndNil(qryProdutoValor)
  end;
end;

class function TProdutoValor.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryProdutoValor: TFDQuery;
begin
  Result := 0;
  qryProdutoValor:= TFDQuery.Create(Nil);
  try
    qryProdutoValor.Connection := ASQLConnection;
    qryProdutoValor.SQL.Add('Select Max(IdProdutoValor) As IdProdutoValor From ProdutoValor');
    qryProdutoValor.Open;

    if qryProdutoValor.FieldByName('IdProdutoValor').AsInteger > 0 then
      Result := qryProdutoValor.FieldByName('IdProdutoValor').AsInteger;
    qryProdutoValor.Close;
  finally
    FreeAndNil(qryProdutoValor)
  end;
end;

function TProdutoValor.Buscar(ASQLConnection: TFDConnection; AIdProdutoValor: Integer): Boolean;
var
  qryProdutoValor: TFDQuery;
begin
  Result := False;
  qryProdutoValor:= TFDQuery.Create(Nil);
  try
    qryProdutoValor.Connection := ASQLConnection;
    qryProdutoValor.SQL.Add('Select * From ProdutoValor');
    qryProdutoValor.SQL.Add('Where 1 = 1');
    if AIdProdutoValor > 0 then
    begin
      qryProdutoValor.SQL.Add('  And IdProdutoValor = ' + IntToStr(AIdProdutoValor));
    end;

    qryProdutoValor.Open;
    if not qryProdutoValor.IsEmpty then
    begin
      Result := True;
      IdProdutoValor := qryProdutoValor.FieldByName('IdProdutoValor').AsInteger;
      IdEmpresa := qryProdutoValor.FieldByName('IdEmpresa').AsInteger;
      IdUsuario := qryProdutoValor.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryProdutoValor.FieldByName('DtCadastro').AsDateTime;
      if qryProdutoValor.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      IdProduto := qryProdutoValor.FieldByName('IdProduto').AsInteger;
      VlCusto := qryProdutoValor.FieldByName('VlCusto').AsFloat;
      VlVenda := qryProdutoValor.FieldByName('VlVenda').AsFloat;
    end;
    qryProdutoValor.Close;
  finally
    FreeAndNil(qryProdutoValor)
  end;
end;

end.

