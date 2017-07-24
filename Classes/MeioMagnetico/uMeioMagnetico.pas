unit uMeioMagnetico;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TMeioMagnetico = class
  private
    FIdMeioMagnetico: Integer;
    FDtCadastro: TDateTime;
    FPK1: String;
    FNrMeioMagnetico: Integer;
    FNmMeioMagnetico: WideString;
    procedure Inicializar;
  public
    property IdMeioMagnetico: Integer read FIdMeioMagnetico write FIdMeioMagnetico;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property PK1: String read FPK1 write FPK1;
    property NrMeioMagnetico: Integer read FNrMeioMagnetico write FNrMeioMagnetico;
    property NmMeioMagnetico: WideString read FNmMeioMagnetico write FNmMeioMagnetico;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdMeioMagnetico: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdMeioMagnetico: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdMeioMagnetico: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdMeioMagnetico: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TMeioMagnetico.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdMeioMagnetico: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryMeioMagnetico : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryMeioMagnetico := TFDQuery.Create(nil);
  try
    qryMeioMagnetico.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdMeioMagnetico', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('PK1', ftString, 10, False);
      Data.FieldDefs.Add('NrMeioMagnetico', ftInteger);
      Data.FieldDefs.Add('NmMeioMagnetico', ftWideString, 10, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryMeioMagnetico.Params.Clear;
      qryMeioMagnetico.SQL.Clear;
      qryMeioMagnetico.SQL.Add('Select');
      qryMeioMagnetico.SQL.Add('  IdMeioMagnetico,');
      qryMeioMagnetico.SQL.Add('  DtCadastro,');
      qryMeioMagnetico.SQL.Add('  PK1,');
      qryMeioMagnetico.SQL.Add('  NrMeioMagnetico,');
      qryMeioMagnetico.SQL.Add('  NmMeioMagnetico');
      qryMeioMagnetico.SQL.Add('From MeioMagnetico');
      qryMeioMagnetico.SQL.Add('Where 1 = 1');

      if ISnSituacao = 1 then
      begin
         qryMeioMagnetico.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryMeioMagnetico.SQL.Add('  And SnSituacao = 0');
      end;

      if AIdMeioMagnetico > 0 then
      begin
         qryMeioMagnetico.SQL.Add('  And IdMeioMagnetico = :IdMeioMagnetico');

         qryMeioMagnetico.ParamByName('IdMeioMagnetico').AsInteger := AIdMeioMagnetico;
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
          qryMeioMagnetico.SQL.Add (lCondicao);
          qryMeioMagnetico.SQL.Add ('Order By');
          qryMeioMagnetico.SQL.Add (' IdMeioMagnetico');

          qryMeioMagnetico.Open;
          qryMeioMagnetico.First;
        end;
      end else begin
        qryMeioMagnetico.SQL.Add (lCondicao);
        qryMeioMagnetico.SQL.Add ('Order By');
        qryMeioMagnetico.SQL.Add (' IdMeioMagnetico');

        lFinalizaLoop := 1;
        qryMeioMagnetico.Open;
        qryMeioMagnetico.First;
      end;

      while not qryMeioMagnetico.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdMeioMagnetico').AsInteger = qryMeioMagnetico.FieldByName('IdMeioMagnetico').AsInteger then
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
          Data.FieldByName('IdMeioMagnetico').AsInteger := qryMeioMagnetico.FieldByName('IdMeioMagnetico').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryMeioMagnetico.FieldByName('DtCadastro').AsDateTime;
          Data.FieldByName('PK1').AsString := qryMeioMagnetico.FieldByName('PK1').AsString;
          Data.FieldByName('NrMeioMagnetico').AsInteger := qryMeioMagnetico.FieldByName('NrMeioMagnetico').AsInteger;
          Data.FieldByName('NmMeioMagnetico').AsWideString := qryMeioMagnetico.FieldByName('NmMeioMagnetico').AsWideString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryMeioMagnetico.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryMeioMagnetico.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TMeioMagnetico.Create;
begin
  Inicializar;
end;

procedure TMeioMagnetico.Inicializar;
begin
  IdMeioMagnetico := 0;
  DtCadastro := 0;
  PK1 := '';
  NrMeioMagnetico := 0;
  NmMeioMagnetico := '';
end;

function TMeioMagnetico.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryMeioMagnetico: TFDQuery;
begin
  qryMeioMagnetico:= TFDQuery.Create(Nil);
  try
    qryMeioMagnetico.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdMeioMagnetico) then
    begin
      qryMeioMagnetico.SQL.Add('Insert Into MeioMagnetico(');
      qryMeioMagnetico.SQL.Add('  DtCadastro,');
      qryMeioMagnetico.SQL.Add('  PK1,');
      qryMeioMagnetico.SQL.Add('  NrMeioMagnetico,');
      qryMeioMagnetico.SQL.Add('  NmMeioMagnetico)');
      qryMeioMagnetico.SQL.Add('Values (');
      qryMeioMagnetico.SQL.Add('  :DtCadastro,');
      qryMeioMagnetico.SQL.Add('  :PK1,');
      qryMeioMagnetico.SQL.Add('  :NrMeioMagnetico,');
      qryMeioMagnetico.SQL.Add('  :NmMeioMagnetico)');

      qryMeioMagnetico.ParamByName('DtCadastro').AsDateTime := DtCadastro;

    end else begin
      qryMeioMagnetico.SQL.Add('Update MeioMagnetico Set ');
      qryMeioMagnetico.SQL.Add('  PK1 = :PK1,');
      qryMeioMagnetico.SQL.Add('  NrMeioMagnetico = :NrMeioMagnetico,');
      qryMeioMagnetico.SQL.Add('  NmMeioMagnetico = :NmMeioMagnetico ');
    end;
    qryMeioMagnetico.ParamByName('PK1').AsString := PK1;
    qryMeioMagnetico.ParamByName('NrMeioMagnetico').AsInteger := NrMeioMagnetico;
    qryMeioMagnetico.ParamByName('NmMeioMagnetico').AsWideString := NmMeioMagnetico;
   try
      qryMeioMagnetico.ExecSQL;
      qryMeioMagnetico.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryMeioMagnetico)
  end;
end;

class function TMeioMagnetico.Inativar(ASQLConnection: TFDConnection; AIdMeioMagnetico: Integer): Boolean;
var
  qryMeioMagnetico: TFDQuery;
begin
  qryMeioMagnetico:= TFDQuery.Create(Nil);
  try
    qryMeioMagnetico.Connection := ASQLConnection;
    qryMeioMagnetico.SQL.Add('Update MeioMagnetico Set ');
    qryMeioMagnetico.SQL.Add('Where 1 = 1');
   try
      qryMeioMagnetico.ExecSQL;
      qryMeioMagnetico.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryMeioMagnetico)
  end;
end;

class function TMeioMagnetico.Existe(ASQLConnection: TFDConnection; AIdMeioMagnetico: Integer): Boolean;
var
  qryMeioMagnetico: TFDQuery;
begin
  Result := False;
  qryMeioMagnetico:= TFDQuery.Create(Nil);
  try
    qryMeioMagnetico.Connection := ASQLConnection;
    qryMeioMagnetico.SQL.Add('Select IdMeioMagnetico From MeioMagnetico');
    qryMeioMagnetico.SQL.Add('Where 1 = 1');
    qryMeioMagnetico.Open;
    if qryMeioMagnetico.Fields[0].Value > 0 then
      Result := True;
    qryMeioMagnetico.Close;
  finally
    FreeAndNil(qryMeioMagnetico)
  end;
end;

class function TMeioMagnetico.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryMeioMagnetico: TFDQuery;
begin
  Result := 0;
  qryMeioMagnetico:= TFDQuery.Create(Nil);
  try
    qryMeioMagnetico.Connection := ASQLConnection;
    qryMeioMagnetico.SQL.Add('Select Max(IdMeioMagnetico) As IdMeioMagnetico From MeioMagnetico');
    qryMeioMagnetico.Open;

    if qryMeioMagnetico.FieldByName('IdMeioMagnetico').AsInteger > 0 then
      Result := qryMeioMagnetico.FieldByName('IdMeioMagnetico').AsInteger;
    qryMeioMagnetico.Close;
  finally
    FreeAndNil(qryMeioMagnetico)
  end;
end;

function TMeioMagnetico.Buscar(ASQLConnection: TFDConnection; AIdMeioMagnetico: Integer): Boolean;
var
  qryMeioMagnetico: TFDQuery;
begin
  Result := False;
  qryMeioMagnetico:= TFDQuery.Create(Nil);
  try
    qryMeioMagnetico.Connection := ASQLConnection;
    qryMeioMagnetico.SQL.Add('Select * From VW_GridMeioMagnetico');
    qryMeioMagnetico.SQL.Add('Where IdMeioMagnetico = :IdMeioMagnetico');

    qryMeioMagnetico.ParamByName('IdMeioMagnetico').AsString := IntToStr(AIdMeioMagnetico);

    qryMeioMagnetico.Open;
    if not qryMeioMagnetico.IsEmpty then
    begin
      Result := True;
      IdMeioMagnetico := qryMeioMagnetico.FieldByName('IdMeioMagnetico').AsInteger;
      DtCadastro := qryMeioMagnetico.FieldByName('DtCadastro').AsDateTime;
      PK1 := qryMeioMagnetico.FieldByName('PK1').AsString;
      NrMeioMagnetico := qryMeioMagnetico.FieldByName('NrMeioMagnetico').AsInteger;
      NmMeioMagnetico := qryMeioMagnetico.FieldByName('NmMeioMagnetico').AsWideString;
    end;
    qryMeioMagnetico.Close;
  finally
    FreeAndNil(qryMeioMagnetico)
  end;
end;

end.

