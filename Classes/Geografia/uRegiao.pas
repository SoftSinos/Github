unit uRegiao;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TRegiao = class
  private
    FIdRegiao: Integer;
    FIdUsuario: Integer;
    FDtCadastro: TDateTime;
    FSnSituacao: Integer;
    FNmRegiao: String;
    FIdPais: Integer;
    procedure Inicializar;
  public
    property IdRegiao: Integer read FIdRegiao write FIdRegiao;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property NmRegiao: String read FNmRegiao write FNmRegiao;
    property IdPais: Integer read FIdPais write FIdPais;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdRegiao: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdRegiao: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdRegiao: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdRegiao: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TRegiao.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdRegiao: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryRegiao : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryRegiao := TFDQuery.Create(nil);
  try
    qryRegiao.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdRegiao', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 9, False);
      Data.FieldDefs.Add('NmRegiao', ftString, 255, False);
      Data.FieldDefs.Add('IdPais', ftInteger);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryRegiao.Params.Clear;
      qryRegiao.SQL.Clear;
      qryRegiao.SQL.Add('Select');
      qryRegiao.SQL.Add('  *');
      qryRegiao.SQL.Add('From VW_GridRegiao');
      qryRegiao.SQL.Add('Where 1 = 1');

      if ISnSituacao = 1 then
      begin
         qryRegiao.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryRegiao.SQL.Add('  And SnSituacao = 0');
      end;

      if AIdRegiao > 0 then
      begin
         qryRegiao.SQL.Add('  And IdRegiao = :IdRegiao');

         qryRegiao.ParamByName('IdRegiao').AsInteger := AIdRegiao;
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
          qryRegiao.SQL.Add (lCondicao);
          qryRegiao.SQL.Add ('Order By');
          qryRegiao.SQL.Add (' IdRegiao');

          qryRegiao.Open;
          qryRegiao.First;
        end;
      end else begin
        qryRegiao.SQL.Add (lCondicao);
        qryRegiao.SQL.Add ('Order By');
        qryRegiao.SQL.Add (' IdRegiao');

        lFinalizaLoop := 1;
        qryRegiao.Open;
        qryRegiao.First;
      end;

      while not qryRegiao.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdRegiao').AsInteger = qryRegiao.FieldByName('IdRegiao').AsInteger then
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
          Data.FieldByName('IdRegiao').AsInteger := qryRegiao.FieldByName('IdRegiao').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryRegiao.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryRegiao.FieldByName('DtCadastro').AsDateTime;
          if qryRegiao.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'ATIVO';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'INATIVO';
          end;
          Data.FieldByName('NmRegiao').AsString := qryRegiao.FieldByName('NmRegiao').AsString;
          Data.FieldByName('IdPais').AsInteger := qryRegiao.FieldByName('IdPais').AsInteger;
          Data.Post;
        end;

        lVerificacao := 0;
        qryRegiao.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryRegiao.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TRegiao.Create;
begin
  Inicializar;
end;

procedure TRegiao.Inicializar;
begin
  IdRegiao := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  NmRegiao := '';
  IdPais := 0;
end;

function TRegiao.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryRegiao: TFDQuery;
begin
  qryRegiao:= TFDQuery.Create(Nil);
  try
    qryRegiao.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdRegiao) then
    begin
      qryRegiao.SQL.Add('Insert Into Regiao(');
      qryRegiao.SQL.Add('  IdUsuario,');
      qryRegiao.SQL.Add('  DtCadastro,');
      qryRegiao.SQL.Add('  SnSituacao,');
      qryRegiao.SQL.Add('  NmRegiao,');
      qryRegiao.SQL.Add('  IdPais)');
      qryRegiao.SQL.Add('Values (');
      qryRegiao.SQL.Add('  :IdUsuario,');
      qryRegiao.SQL.Add('  :DtCadastro,');
      qryRegiao.SQL.Add('  :SnSituacao,');
      qryRegiao.SQL.Add('  :NmRegiao,');
      qryRegiao.SQL.Add('  :IdPais)');

      qryRegiao.ParamByName('IdUsuario').AsInteger := IdUsuario;
      qryRegiao.ParamByName('DtCadastro').AsDateTime := DtCadastro;

    end else begin
      qryRegiao.SQL.Add('Update Regiao Set ');
      qryRegiao.SQL.Add('  SnSituacao = :SnSituacao,');
      qryRegiao.SQL.Add('  NmRegiao = :NmRegiao,');
      qryRegiao.SQL.Add('  IdPais = :IdPais ');
      qryRegiao.SQL.Add('Where IdRegiao = :IdRegiao');

      qryRegiao.ParamByName('IdRegiao').AsInteger := IdRegiao;

    end;
    qryRegiao.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryRegiao.ParamByName('NmRegiao').AsString := NmRegiao;
    qryRegiao.ParamByName('IdPais').AsInteger := IdPais;
   try
      qryRegiao.ExecSQL;
      qryRegiao.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryRegiao)
  end;
end;

class function TRegiao.Inativar(ASQLConnection: TFDConnection; AIdRegiao: Integer): Boolean;
var
  qryRegiao: TFDQuery;
begin
  qryRegiao:= TFDQuery.Create(Nil);
  try
    qryRegiao.Connection := ASQLConnection;
    qryRegiao.SQL.Add('Update Regiao Set ');
    qryRegiao.SQL.Add('  SnSituacao = 0 ');
    qryRegiao.SQL.Add('Where 1 = 1');
    qryRegiao.SQL.Add('  And IdRegiao = ' + IntToStr(AIdRegiao));
   try
      qryRegiao.ExecSQL;
      qryRegiao.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryRegiao)
  end;
end;

class function TRegiao.Existe(ASQLConnection: TFDConnection; AIdRegiao: Integer): Boolean;
var
  qryRegiao: TFDQuery;
begin
  Result := False;
  qryRegiao:= TFDQuery.Create(Nil);
  try
    qryRegiao.Connection := ASQLConnection;
    qryRegiao.SQL.Add('Select IdRegiao From Regiao');
    qryRegiao.SQL.Add('Where 1 = 1');
    qryRegiao.SQL.Add('  And IdRegiao = ' + IntToStr(AIdRegiao));
    qryRegiao.Open;
    if qryRegiao.Fields[0].Value > 0 then
      Result := True;
    qryRegiao.Close;
  finally
    FreeAndNil(qryRegiao)
  end;
end;

class function TRegiao.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryRegiao: TFDQuery;
begin
  Result := 0;
  qryRegiao:= TFDQuery.Create(Nil);
  try
    qryRegiao.Connection := ASQLConnection;
    qryRegiao.SQL.Add('Select Max(IdRegiao) As IdRegiao From Regiao');
    qryRegiao.Open;

    if qryRegiao.FieldByName('IdRegiao').AsInteger > 0 then
      Result := qryRegiao.FieldByName('IdRegiao').AsInteger;
    qryRegiao.Close;
  finally
    FreeAndNil(qryRegiao)
  end;
end;

function TRegiao.Buscar(ASQLConnection: TFDConnection; AIdRegiao: Integer): Boolean;
var
  qryRegiao: TFDQuery;
begin
  Result := False;
  qryRegiao:= TFDQuery.Create(Nil);
  try
    qryRegiao.Connection := ASQLConnection;
    qryRegiao.SQL.Add('Select * From VW_GridRegiao');
    qryRegiao.SQL.Add('Where IdRegiao = :IdRegiao');

    qryRegiao.ParamByName('IdRegiao').AsString := IntToStr(AIdRegiao);

    qryRegiao.Open;
    if not qryRegiao.IsEmpty then
    begin
      Result := True;
      IdRegiao := qryRegiao.FieldByName('IdRegiao').AsInteger;
      IdUsuario := qryRegiao.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryRegiao.FieldByName('DtCadastro').AsDateTime;
      if qryRegiao.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      NmRegiao := qryRegiao.FieldByName('NmRegiao').AsString;
      IdPais := qryRegiao.FieldByName('IdPais').AsInteger;
    end;
    qryRegiao.Close;
  finally
    FreeAndNil(qryRegiao)
  end;
end;

end.

