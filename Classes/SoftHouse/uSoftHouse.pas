unit uSoftHouse;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TSoftHouse = class
  private
    FNmLogoTipo: WideString;
    procedure Inicializar;
  public
    property NmLogoTipo: WideString read FNmLogoTipo write FNmLogoTipo;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection): Boolean;
    class function Existe(ASQLConnection: TFDConnection; ANmLogoTipo: String): Boolean;
    function Buscar(ASQLConnection: TFDConnection; ANmLogoTipo: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdSoftHouse: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TSoftHouse.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdSoftHouse: Integer; AConsulta: String; Data: TClientDataSet);
var
  qrySoftHouse : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qrySoftHouse := TFDQuery.Create(nil);
  try
    qrySoftHouse.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('NmLogoTipo', ftWideString, 10, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qrySoftHouse.Params.Clear;
      qrySoftHouse.SQL.Clear;
      qrySoftHouse.SQL.Add('Select');
      qrySoftHouse.SQL.Add('  NmLogoTipo');
      qrySoftHouse.SQL.Add('From SoftHouse');
      qrySoftHouse.SQL.Add('Where 1 = 1');
      if ISnSituacao = 1 then
      begin
         qrySoftHouse.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qrySoftHouse.SQL.Add('  And SnSituacao = 0');
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
          qrySoftHouse.SQL.Add (lCondicao);
          qrySoftHouse.SQL.Add ('Order By');
          qrySoftHouse.SQL.Add (' IdSoftHouse');

          qrySoftHouse.Open;
          qrySoftHouse.First;
        end;
      end else begin
        qrySoftHouse.SQL.Add (lCondicao);
        qrySoftHouse.SQL.Add ('Order By');
        qrySoftHouse.SQL.Add (' IdSoftHouse');

        lFinalizaLoop := 1;
        qrySoftHouse.Open;
        qrySoftHouse.First;
      end;

      while not qrySoftHouse.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdSoftHouse').AsInteger = qrySoftHouse.FieldByName('IdSoftHouse').AsInteger then
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
          Data.FieldByName('NmLogoTipo').AsWideString := qrySoftHouse.FieldByName('NmLogoTipo').AsWideString;
          Data.Post;
        end;

        lVerificacao := 0;
        qrySoftHouse.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qrySoftHouse.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TSoftHouse.Create;
begin
  Inicializar;
end;

procedure TSoftHouse.Inicializar;
begin
  NmLogoTipo := '';
end;

function TSoftHouse.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qrySoftHouse: TFDQuery;
begin
  qrySoftHouse:= TFDQuery.Create(Nil);
  try
    qrySoftHouse.Connection := ASQLConnection;
    if not Existe(ASQLConnection, NmLogoTipo) then
    begin
      qrySoftHouse.SQL.Add('Insert Into SoftHouse(');
      qrySoftHouse.SQL.Add('  NmLogoTipo)');
      qrySoftHouse.SQL.Add('Values (');
      qrySoftHouse.SQL.Add('  :NmLogoTipo)');
    end else begin
      qrySoftHouse.SQL.Add('Update SoftHouse Set ');
      qrySoftHouse.SQL.Add('  NmLogoTipo = :NmLogoTipo ');
    end;
    qrySoftHouse.ParamByName('NmLogoTipo').AsWideString := NmLogoTipo;
   try
      qrySoftHouse.ExecSQL;
      qrySoftHouse.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qrySoftHouse)
  end;
end;

class function TSoftHouse.Inativar(ASQLConnection: TFDConnection): Boolean;
var
  qrySoftHouse: TFDQuery;
begin
  qrySoftHouse:= TFDQuery.Create(Nil);
  try
    qrySoftHouse.Connection := ASQLConnection;
    qrySoftHouse.SQL.Add('Update SoftHouse Set ');
    qrySoftHouse.SQL.Add('Where 1 = 1');
   try
      qrySoftHouse.ExecSQL;
      qrySoftHouse.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qrySoftHouse)
  end;
end;

class function TSoftHouse.Existe(ASQLConnection: TFDConnection; ANmLogoTipo: String): Boolean;
var
  qrySoftHouse: TFDQuery;
begin
  Result := False;
  qrySoftHouse:= TFDQuery.Create(Nil);
  try
    qrySoftHouse.Connection := ASQLConnection;
    qrySoftHouse.SQL.Add('Select NmLogoTipo From SoftHouse');
    qrySoftHouse.SQL.Add('Where 1 = 1');
    qrySoftHouse.Open;
    if qrySoftHouse.Fields[0].Value > 0 then
      Result := True;
    qrySoftHouse.Close;
  finally
    FreeAndNil(qrySoftHouse)
  end;
end;

class function TSoftHouse.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qrySoftHouse: TFDQuery;
begin
  Result := 0;
  qrySoftHouse:= TFDQuery.Create(Nil);
  try
    qrySoftHouse.Connection := ASQLConnection;
    qrySoftHouse.SQL.Add('Select Max(IdSoftHouse) As IdSoftHouse From SoftHouse');
    qrySoftHouse.Open;

    if qrySoftHouse.FieldByName('IdSoftHouse').AsInteger > 0 then
      Result := qrySoftHouse.FieldByName('IdSoftHouse').AsInteger;
    qrySoftHouse.Close;
  finally
    FreeAndNil(qrySoftHouse)
  end;
end;

function TSoftHouse.Buscar(ASQLConnection: TFDConnection; ANmLogoTipo: Integer): Boolean;
var
  qrySoftHouse: TFDQuery;
begin
  Result := False;
  qrySoftHouse:= TFDQuery.Create(Nil);
  try
    qrySoftHouse.Connection := ASQLConnection;
    qrySoftHouse.SQL.Add('Select * From VW_GridSoftHouse');
    qrySoftHouse.SQL.Add('Where NmLogoTipo = :NmLogoTipo');

    qrySoftHouse.ParamByName('NmLogoTipo').AsString := IntToStr(ANmLogoTipo);

    qrySoftHouse.Open;
    if not qrySoftHouse.IsEmpty then
    begin
      Result := True;
      NmLogoTipo := qrySoftHouse.FieldByName('NmLogoTipo').AsWideString;
    end;
    qrySoftHouse.Close;
  finally
    FreeAndNil(qrySoftHouse)
  end;
end;

end.

