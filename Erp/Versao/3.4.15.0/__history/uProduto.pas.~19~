unit uProduto;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TProduto = class
  private
    FIdProduto          : Integer;
    FIdUsuario          : Integer;
    FDtCadastro         : TDateTime;
    FSnSituacao         : Integer;
    FNmProduto          : String;
    FIdMarca            : Integer;
    FIdGrupoProduto     : Integer;
    FNrEan              : String;
    FVlCusto            : Extended;
    FVlVenda            : Extended;
    FNmMarca            : String;
    FNmGrupoProduto     : String;
    FNmObs              : WideString;
    FNmUsuarioCadastro  : String;
  public
    property IdProduto          : Integer read    FIdProduto          write FIdProduto;
    property IdUsuario          : Integer read    FIdUsuario          write FIdUsuario;
    property DtCadastro         : TDateTime read  FDtCadastro         write FDtCadastro;
    property SnSituacao         : Integer read    FSnSituacao         write FSnSituacao;
    property NmProduto          : String read     FNmProduto          write FNmProduto;
    property IdMarca            : Integer read    FIdMarca            write FIdMarca;
    property IdGrupoProduto     : Integer read    FIdGrupoProduto     write FIdGrupoProduto;
    property NrEan              : String read     FNrEan              write FNrEan;
    property VlCusto            : Extended read   FVlCusto            write FVlCusto;
    property VlVenda            : Extended read   FVlVenda            write FVlVenda;
    property NmMarca            : String read     FNmMarca            write FNmMarca;
    property NmGrupoProduto     : String read     FNmGrupoProduto     write FNmGrupoProduto;
    property NmObs              : WideString read FNmObs              write FNmObs;
    property NmUsuarioCadastro  : String read     FNmUsuarioCadastro  write FNmUsuarioCadastro;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdProduto: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdProduto: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdProduto: Integer): Boolean;
    function BuscarNrEan(ASQLConnection: TFDConnection; ANrEan: String): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdProduto: Integer; AConsulta: String; Data: TClientDataSet);
    function BuscarImagem(ASQLConnection: TFDConnection; AIdProduto: Integer; Data: TClientDataSet): Boolean;
    procedure Inicializar;
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TProduto.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdProduto: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryProduto : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryProduto := TFDQuery.Create(nil);
  try
    qryProduto.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdProduto',         ftInteger);
      Data.FieldDefs.Add('IdUsuario',         ftInteger);
      Data.FieldDefs.Add('DtCadastro',        ftDateTime);
      Data.FieldDefs.Add('SnSituacao',        ftString, 9, False);
      Data.FieldDefs.Add('NmProduto',         ftString, 255, False);
      Data.FieldDefs.Add('IdMarca',           ftInteger);
      Data.FieldDefs.Add('IdGrupoProduto',    ftInteger);
      Data.FieldDefs.Add('NrEan',             ftString, 20, False);
      Data.FieldDefs.Add('VlCusto',           ftCurrency);
      Data.FieldDefs.Add('VlVenda',           ftCurrency);
      Data.FieldDefs.Add('NmMarca',           ftString, 255, False);
      Data.FieldDefs.Add('NmGrupoProduto',    ftString, 255, False);
      Data.FieldDefs.Add('NmObs',             ftWideString, 4000, False);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 255, False);
      Data.FieldDefs.Add('ImProduto',         ftBlob);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryProduto.Params.Clear;
      qryProduto.SQL.Clear;
      qryProduto.SQL.Add('Select');
      qryProduto.SQL.Add('  *');
      qryProduto.SQL.Add('From VW_GridProduto');
      qryProduto.SQL.Add('Where 1 = 1');

      if ISnSituacao = 1 then
      begin
         qryProduto.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryProduto.SQL.Add('  And SnSituacao = 0');
      end;

      if AIdProduto > 0 then
      begin
        qryProduto.SQL.Add('  And IdProduto = :IdProduto');

        qryProduto.ParamByName('IdProduto').AsInteger := AIdProduto
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
          qryProduto.SQL.Add (lCondicao);
          qryProduto.SQL.Add ('Order By');
          qryProduto.SQL.Add ('  IdProduto');

          qryProduto.Open;
          qryProduto.First;
        end;
      end else begin
        qryProduto.SQL.Add (lCondicao);
        qryProduto.SQL.Add ('Order By');
        qryProduto.SQL.Add ('  IdProduto');

        lFinalizaLoop := 1;
        qryProduto.Open;
        qryProduto.First;
      end;

      while not qryProduto.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdProduto').AsInteger = qryProduto.FieldByName('IdProduto').AsInteger then
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
          Data.FieldByName('IdProduto').AsInteger         := qryProduto.FieldByName('IdProduto').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger         := qryProduto.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime       := qryProduto.FieldByName('DtCadastro').AsDateTime;
          if qryProduto.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'ATIVO';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'INATIVO';
          end;
          Data.FieldByName('NmProduto').AsString          := qryProduto.FieldByName('NmProduto').AsString;
          Data.FieldByName('IdMarca').AsInteger           := qryProduto.FieldByName('IdMarca').AsInteger;
          Data.FieldByName('IdGrupoProduto').AsInteger    := qryProduto.FieldByName('IdGrupoProduto').AsInteger;
          Data.FieldByName('NrEan').AsString              := qryProduto.FieldByName('NrEan').AsString;
          Data.FieldByName('VlCusto').AsFloat             := qryProduto.FieldByName('VlCusto').AsFloat;
          Data.FieldByName('VlVenda').AsFloat             := qryProduto.FieldByName('VlVenda').AsFloat;
          Data.FieldByName('NmMarca').AsString            := qryProduto.FieldByName('NmMarca').AsString;
          Data.FieldByName('NmGrupoProduto').AsString     := qryProduto.FieldByName('NmGrupoProduto').AsString;
          Data.FieldByName('NmObs').AsWideString          := qryProduto.FieldByName('NmObs').AsWideString;
          Data.FieldByName('NmUsuarioCadastro').AsString  := qryProduto.FieldByName('NmUsuarioCadastro').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryProduto.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryProduto.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TProduto.Create;
begin
  Inicializar;
end;

procedure TProduto.Inicializar;
begin
  IdProduto         := 0;
  IdUsuario         := 0;
  DtCadastro        := 0;
  SnSituacao        := 0;
  NmProduto         := '';
  IdMarca           := 0;
  IdGrupoProduto    := 0;
  NrEan             := '';
  VlCusto           := 0;
  VlVenda           := 0;
  NmMarca           := '';
  NmGrupoProduto    := '';
  NmObs             := '';
  NmUsuarioCadastro := '';
end;

function TProduto.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryProduto: TFDQuery;
begin
  qryProduto:= TFDQuery.Create(Nil);
  try
    qryProduto.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdProduto) then
    begin
      qryProduto.SQL.Add('Insert Into Produto(');
      qryProduto.SQL.Add('  IdUsuario,        ');
      qryProduto.SQL.Add('  DtCadastro,       ');
      qryProduto.SQL.Add('  SnSituacao,       ');
      qryProduto.SQL.Add('  NmProduto,        ');
      qryProduto.SQL.Add('  IdMarca,          ');
      qryProduto.SQL.Add('  IdGrupoProduto,   ');
      qryProduto.SQL.Add('  NrEan,            ');
      qryProduto.SQL.Add('  VlCusto,          ');
      qryProduto.SQL.Add('  NmObs,            ');
      qryProduto.SQL.Add('  VlVenda)          ');
      qryProduto.SQL.Add('Values (            ');
      qryProduto.SQL.Add('  :IdUsuario,       ');
      qryProduto.SQL.Add('  :DtCadastro,      ');
      qryProduto.SQL.Add('  :SnSituacao,      ');
      qryProduto.SQL.Add('  :NmProduto,       ');
      qryProduto.SQL.Add('  :IdMarca,         ');
      qryProduto.SQL.Add('  :IdGrupoProduto,  ');
      qryProduto.SQL.Add('  :NrEan,           ');
      qryProduto.SQL.Add('  :VlCusto,         ');
      qryProduto.SQL.Add('  :NmObs,           ');
      qryProduto.SQL.Add('  :VlVenda)         ');

      qryProduto.ParamByName('IdUsuario').AsInteger       := IdUsuario;
      qryProduto.ParamByName('DtCadastro').AsDateTime     := DtCadastro;

    end else begin
      qryProduto.SQL.Add('Update Produto Set                  ');
      qryProduto.SQL.Add('  SnSituacao = :SnSituacao,         ');
      qryProduto.SQL.Add('  NmProduto = :NmProduto,           ');
      qryProduto.SQL.Add('  IdMarca = :IdMarca,               ');
      qryProduto.SQL.Add('  IdGrupoProduto = :IdGrupoProduto, ');
      qryProduto.SQL.Add('  NrEan = :NrEan,                   ');
      qryProduto.SQL.Add('  VlCusto = :VlCusto,               ');
      qryProduto.SQL.Add('  NmObs = :NmObs,                   ');
      qryProduto.SQL.Add('  VlVenda = :VlVenda                ');
      qryProduto.SQL.Add('Where IdProduto = :IdProduto        ');

      qryProduto.ParamByName('IdProduto').AsInteger     := IdProduto;

    end;
    qryProduto.ParamByName('SnSituacao').AsInteger      := SnSituacao;
    qryProduto.ParamByName('NmProduto').AsString        := NmProduto;
    qryProduto.ParamByName('IdMarca').AsInteger         := IdMarca;
    qryProduto.ParamByName('IdGrupoProduto').AsInteger  := IdGrupoProduto;
    qryProduto.ParamByName('NrEan').AsString            := NrEan;
    qryProduto.ParamByName('VlCusto').AsFloat           := VlCusto;
    qryProduto.ParamByName('NmObs').AsWideString        := NmObs;
    qryProduto.ParamByName('VlVenda').AsFloat           := VlVenda;
   try
      qryProduto.ExecSQL;
      qryProduto.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryProduto)
  end;
end;

class function TProduto.Inativar(ASQLConnection: TFDConnection; AIdProduto: Integer): Boolean;
var
  qryProduto: TFDQuery;
begin
  qryProduto:= TFDQuery.Create(Nil);
  try
    qryProduto.Connection := ASQLConnection;
    qryProduto.SQL.Add('Update Produto Set ');
    qryProduto.SQL.Add('  SnSituacao = 0 ');
    qryProduto.SQL.Add('Where 1 = 1');
    qryProduto.SQL.Add('  And IdProduto = ' + IntToStr(AIdProduto));
   try
      qryProduto.ExecSQL;
      qryProduto.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryProduto)
  end;
end;

class function TProduto.Existe(ASQLConnection: TFDConnection; AIdProduto: Integer): Boolean;
var
  qryProduto: TFDQuery;
begin
  Result := False;
  qryProduto:= TFDQuery.Create(Nil);
  try
    qryProduto.Connection := ASQLConnection;
    qryProduto.SQL.Add('Select IdProduto From Produto');
    qryProduto.SQL.Add('Where 1 = 1');
    qryProduto.SQL.Add('  And IdProduto = ' + IntToStr(AIdProduto));
    qryProduto.Open;
    if qryProduto.Fields[0].Value > 0 then
      Result := True;
    qryProduto.Close;
  finally
    FreeAndNil(qryProduto)
  end;
end;

class function TProduto.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryProduto: TFDQuery;
begin
  Result := 0;
  qryProduto:= TFDQuery.Create(Nil);
  try
    qryProduto.Connection := ASQLConnection;
    qryProduto.SQL.Add('Select Max(IdProduto) As IdProduto From Produto');
    qryProduto.Open;

    if qryProduto.FieldByName('IdProduto').AsInteger > 0 then
      Result := qryProduto.FieldByName('IdProduto').AsInteger;
    qryProduto.Close;
  finally
    FreeAndNil(qryProduto)
  end;
end;

function TProduto.Buscar(ASQLConnection: TFDConnection; AIdProduto: Integer): Boolean;
var
  qryProduto: TFDQuery;
begin
  Result := False;
  qryProduto:= TFDQuery.Create(Nil);
  try
    qryProduto.Connection := ASQLConnection;
    qryProduto.SQL.Add('Select * From VW_GridProduto');
    qryProduto.SQL.Add('Where IdProduto = :IdProduto');

    qryProduto.ParamByName('IdProduto').AsString := IntToStr(AIdProduto);

    qryProduto.Open;
    if not qryProduto.IsEmpty then
    begin
      Result            := True;
      IdProduto         := qryProduto.FieldByName('IdProduto').AsInteger;
      IdUsuario         := qryProduto.FieldByName('IdUsuario').AsInteger;
      DtCadastro        := qryProduto.FieldByName('DtCadastro').AsDateTime;
      if qryProduto.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao      := 1
      end else begin
        SnSituacao      := 0
      end;
      NmProduto         := qryProduto.FieldByName('NmProduto').AsString;
      IdMarca           := qryProduto.FieldByName('IdMarca').AsInteger;
      IdGrupoProduto    := qryProduto.FieldByName('IdGrupoProduto').AsInteger;
      NrEan             := qryProduto.FieldByName('NrEan').AsString;
      VlCusto           := qryProduto.FieldByName('VlCusto').AsFloat;
      VlVenda           := qryProduto.FieldByName('VlVenda').AsFloat;
      NmMarca           := qryProduto.FieldByName('NmMarca').AsString;
      NmGrupoProduto    := qryProduto.FieldByName('NmGrupoProduto').AsString;
      NmObs             := qryProduto.FieldByName('NmObs').AsWideString;
      NmUsuarioCadastro := qryProduto.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryProduto.Close;
  finally
    FreeAndNil(qryProduto)
  end;
end;

function TProduto.BuscarImagem(ASQLConnection: TFDConnection; AIdProduto: Integer; Data: TClientDataSet): Boolean;
var
  qryProduto : TFDQuery;
begin
  Result                  := False;

  qryProduto              := TFDQuery.Create(nil);
  try
    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('ImProduto', ftBlob);
      Data.FieldDefs.Add('IdRetorno', ftInteger);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    qryProduto.Params.Clear;
    qryProduto.SQL.Clear;

    qryProduto.Connection := ASQLConnection;

    qryProduto.SQL.Add('Select ImProduto From Produto ');
    qryProduto.SQL.Add('Where IdProduto = :IdProduto  ');

    qryProduto.ParamByName('IdProduto').AsInteger := AIdProduto;

    qryProduto.Open;

    while not qryProduto.Eof do
    begin
      Data.Append;
      Data.FieldByName('ImProduto').AsBytes        := qryProduto.FieldByName('ImProduto').AsBytes;
      Data.Post;
      qryProduto.Next;
      Result := True;
    end;
  finally
    qryProduto.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

function TProduto.BuscarNrEan(ASQLConnection: TFDConnection; ANrEan: String): Boolean;
var
  qryProduto: TFDQuery;
begin
  Result := False;
  qryProduto:= TFDQuery.Create(Nil);
  try
    qryProduto.Connection := ASQLConnection;
    qryProduto.SQL.Add('Select * From VW_GridProduto');
    qryProduto.SQL.Add('Where NrEan = :NrEan        ');

    qryProduto.ParamByName('NrEan').AsString := ANrEan;

    qryProduto.Open;
    if not qryProduto.IsEmpty then
    begin
      Result            := True;
      IdProduto         := qryProduto.FieldByName('IdProduto').AsInteger;
      IdUsuario         := qryProduto.FieldByName('IdUsuario').AsInteger;
      DtCadastro        := qryProduto.FieldByName('DtCadastro').AsDateTime;
      if qryProduto.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao      := 1
      end else begin
        SnSituacao      := 0
      end;
      NmProduto         := qryProduto.FieldByName('NmProduto').AsString;
      IdMarca           := qryProduto.FieldByName('IdMarca').AsInteger;
      IdGrupoProduto    := qryProduto.FieldByName('IdGrupoProduto').AsInteger;
      NrEan             := qryProduto.FieldByName('NrEan').AsString;
      VlCusto           := qryProduto.FieldByName('VlCusto').AsFloat;
      VlVenda           := qryProduto.FieldByName('VlVenda').AsFloat;
      NmMarca           := qryProduto.FieldByName('NmMarca').AsString;
      NmGrupoProduto    := qryProduto.FieldByName('NmGrupoProduto').AsString;
      NmObs             := qryProduto.FieldByName('NmObs').AsWideString;
      NmUsuarioCadastro := qryProduto.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryProduto.Close;
  finally
    FreeAndNil(qryProduto)
  end;
end;

end.

