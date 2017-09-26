unit uTipoMovimento;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TTipoMovimento = class
  private
    FIdTpMovimento: Integer;
    FIdUsuario: Integer;
    FDtCadastro: TDateTime;
    FSnSituacao: Integer;
    FNmTpMovimento: String;
    FNmSigla: String;
    procedure Inicializar;
  public
    property IdTpMovimento: Integer read FIdTpMovimento write FIdTpMovimento;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property NmTpMovimento: String read FNmTpMovimento write FNmTpMovimento;
    property NmSigla: String read FNmSigla write FNmSigla;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdTpMovimento: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdTpMovimento: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdTpMovimento: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdTpMovimento: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TTipoMovimento.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdTpMovimento: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryTipoMovimento : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryTipoMovimento := TFDQuery.Create(nil);
  try
    qryTipoMovimento.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdTpMovimento', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 7, False);
      Data.FieldDefs.Add('NmTpMovimento', ftString, 10, False);
      Data.FieldDefs.Add('NmSigla', ftString, 10, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryTipoMovimento.Params.Clear;
      qryTipoMovimento.SQL.Clear;
      qryTipoMovimento.SQL.Add('Select');
      qryTipoMovimento.SQL.Add('  IdTpMovimento,');
      qryTipoMovimento.SQL.Add('  IdUsuario,');
      qryTipoMovimento.SQL.Add('  DtCadastro,');
      qryTipoMovimento.SQL.Add('  SnSituacao,');
      qryTipoMovimento.SQL.Add('  NmTpMovimento,');
      qryTipoMovimento.SQL.Add('  NmSigla');
      qryTipoMovimento.SQL.Add('From TipoMovimento');
      qryTipoMovimento.SQL.Add('Where 1 = 1');
      if ISnSituacao = 1 then
      begin
         qryTipoMovimento.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryTipoMovimento.SQL.Add('  And SnSituacao = 0');
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
          qryTipoMovimento.SQL.Add (lCondicao);
          qryTipoMovimento.SQL.Add ('Order By');
          qryTipoMovimento.SQL.Add ('  IdTipoMovimento');

          qryTipoMovimento.Open;
          qryTipoMovimento.First;
        end;
      end else begin
        qryTipoMovimento.SQL.Add (lCondicao);
        qryTipoMovimento.SQL.Add ('Order By');
        qryTipoMovimento.SQL.Add ('  IdTipoMovimento');

        lFinalizaLoop := 1;
        qryTipoMovimento.Open;
        qryTipoMovimento.First;
      end;

      while not qryTipoMovimento.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdTipoMovimento').AsInteger = qryTipoMovimento.FieldByName('IdTipoMovimento').AsInteger then
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
          Data.FieldByName('IdTpMovimento').AsInteger := qryTipoMovimento.FieldByName('IdTpMovimento').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryTipoMovimento.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryTipoMovimento.FieldByName('DtCadastro').AsDateTime;
          if qryTipoMovimento.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString  := 'Ativo';
          end else begin
            Data.FieldByName('SnSituacao').AsString  := 'Desativado';
          end;
          Data.FieldByName('NmTpMovimento').AsString := qryTipoMovimento.FieldByName('NmTpMovimento').AsString;
          Data.FieldByName('NmSigla').AsString := qryTipoMovimento.FieldByName('NmSigla').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryTipoMovimento.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryTipoMovimento.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TTipoMovimento.Create;
begin
  Inicializar;
end;

procedure TTipoMovimento.Inicializar;
begin
  IdTpMovimento := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  NmTpMovimento := '';
  NmSigla := '';
end;

function TTipoMovimento.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryTipoMovimento: TFDQuery;
begin
  qryTipoMovimento:= TFDQuery.Create(Nil);
  try
    qryTipoMovimento.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdTpMovimento) then
    begin
      qryTipoMovimento.SQL.Add('Insert Into TipoMovimento(');
      qryTipoMovimento.SQL.Add('  IdTpMovimento,');
      qryTipoMovimento.SQL.Add('  IdUsuario,');
      qryTipoMovimento.SQL.Add('  DtCadastro,');
      qryTipoMovimento.SQL.Add('  SnSituacao,');
      qryTipoMovimento.SQL.Add('  NmTpMovimento,');
      qryTipoMovimento.SQL.Add('  NmSigla)');
      qryTipoMovimento.SQL.Add('Values (');
      qryTipoMovimento.SQL.Add('  :IdTpMovimento,');
      qryTipoMovimento.SQL.Add('  :IdUsuario,');
      qryTipoMovimento.SQL.Add('  :DtCadastro,');
      qryTipoMovimento.SQL.Add('  :SnSituacao,');
      qryTipoMovimento.SQL.Add('  :NmTpMovimento,');
      qryTipoMovimento.SQL.Add('  :NmSigla)');
    end else begin
      qryTipoMovimento.SQL.Add('Update TipoMovimento Set ');
      qryTipoMovimento.SQL.Add('  IdUsuario = :IdUsuario,');
      qryTipoMovimento.SQL.Add('  DtCadastro = :DtCadastro,');
      qryTipoMovimento.SQL.Add('  SnSituacao = :SnSituacao,');
      qryTipoMovimento.SQL.Add('  NmTpMovimento = :NmTpMovimento,');
      qryTipoMovimento.SQL.Add('  NmSigla = :NmSigla ');
      qryTipoMovimento.SQL.Add('Where IdTpMovimento = :IdTpMovimento');

      qryTipoMovimento.ParamByName('IdTpMovimento').AsInteger := IdTpMovimento;

    end;
    qryTipoMovimento.ParamByName('IdTpMovimento').AsInteger := IdTpMovimento;
    qryTipoMovimento.ParamByName('IdUsuario').AsInteger := IdUsuario;
    qryTipoMovimento.ParamByName('DtCadastro').AsDateTime := DtCadastro;
    qryTipoMovimento.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryTipoMovimento.ParamByName('NmTpMovimento').AsString := NmTpMovimento;
    qryTipoMovimento.ParamByName('NmSigla').AsString := NmSigla;
   try
      qryTipoMovimento.ExecSQL;
      qryTipoMovimento.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryTipoMovimento)
  end;
end;

class function TTipoMovimento.Inativar(ASQLConnection: TFDConnection; AIdTpMovimento: Integer): Boolean;
var
  qryTipoMovimento: TFDQuery;
begin
  qryTipoMovimento:= TFDQuery.Create(Nil);
  try
    qryTipoMovimento.Connection := ASQLConnection;
    qryTipoMovimento.SQL.Add('Update TipoMovimento Set ');
    qryTipoMovimento.SQL.Add('  SnSituacao = 0 ');
    qryTipoMovimento.SQL.Add('Where 1 = 1');
    qryTipoMovimento.SQL.Add('  And IdTpMovimento = ' + IntToStr(AIdTpMovimento));
   try
      qryTipoMovimento.ExecSQL;
      qryTipoMovimento.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryTipoMovimento)
  end;
end;

class function TTipoMovimento.Existe(ASQLConnection: TFDConnection; AIdTpMovimento: Integer): Boolean;
var
  qryTipoMovimento: TFDQuery;
begin
  Result := False;
  qryTipoMovimento:= TFDQuery.Create(Nil);
  try
    qryTipoMovimento.Connection := ASQLConnection;
    qryTipoMovimento.SQL.Add('Select IdTpMovimento From TipoMovimento');
    qryTipoMovimento.SQL.Add('Where 1 = 1');
    qryTipoMovimento.SQL.Add('  And IdTpMovimento = ' + IntToStr(AIdTpMovimento));
    qryTipoMovimento.Open;
    if qryTipoMovimento.Fields[0].Value > 0 then
      Result := True;
    qryTipoMovimento.Close;
  finally
    FreeAndNil(qryTipoMovimento)
  end;
end;

class function TTipoMovimento.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryTipoMovimento: TFDQuery;
begin
  Result := 0;
  qryTipoMovimento:= TFDQuery.Create(Nil);
  try
    qryTipoMovimento.Connection := ASQLConnection;
    qryTipoMovimento.SQL.Add('Select Max(IdTipoMovimento) As IdTipoMovimento From TipoMovimento');
    qryTipoMovimento.Open;

    if qryTipoMovimento.FieldByName('IdTipoMovimento').AsInteger > 0 then
      Result := qryTipoMovimento.FieldByName('IdTipoMovimento').AsInteger;
    qryTipoMovimento.Close;
  finally
    FreeAndNil(qryTipoMovimento)
  end;
end;

function TTipoMovimento.Buscar(ASQLConnection: TFDConnection; AIdTpMovimento: Integer): Boolean;
var
  qryTipoMovimento: TFDQuery;
begin
  Result := False;
  qryTipoMovimento:= TFDQuery.Create(Nil);
  try
    qryTipoMovimento.Connection := ASQLConnection;
    qryTipoMovimento.SQL.Add('Select * From TipoMovimento');
    qryTipoMovimento.SQL.Add('Where 1 = 1');
    if AIdTpMovimento > 0 then
    begin
      qryTipoMovimento.SQL.Add('  And IdTpMovimento = ' + IntToStr(AIdTpMovimento));
    end;

    qryTipoMovimento.Open;
    if not qryTipoMovimento.IsEmpty then
    begin
      Result := True;
      IdTpMovimento := qryTipoMovimento.FieldByName('IdTpMovimento').AsInteger;
      IdUsuario := qryTipoMovimento.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryTipoMovimento.FieldByName('DtCadastro').AsDateTime;
      if qryTipoMovimento.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      NmTpMovimento := qryTipoMovimento.FieldByName('NmTpMovimento').AsString;
      NmSigla := qryTipoMovimento.FieldByName('NmSigla').AsString;
    end;
    qryTipoMovimento.Close;
  finally
    FreeAndNil(qryTipoMovimento)
  end;
end;

end.

