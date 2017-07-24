unit uUf;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TUf = class
  private
    SQLConnection      		   : TFDConnection;
    FIdUf: Integer;
    FIdUsuario: Integer;
    FDtCadastro: TDateTime;
    FSnSituacao: Integer;
    FNmUf: String;
    FNmSigla: String;
    FPcIcms: Extended;
    FNrIbge: String;
    FIdRegiao: Integer;
    procedure Inicializar;
  public
    property IdUf: Integer read FIdUf write FIdUf;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property NmUf: String read FNmUf write FNmUf;
    property NmSigla: String read FNmSigla write FNmSigla;
    property PcIcms: Extended read FPcIcms write FPcIcms;
    property NrIbge: String read FNrIbge write FNrIbge;
    property IdRegiao: Integer read FIdRegiao write FIdRegiao;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdUf: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdUf: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdUf: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdUf: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TUf.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdUf: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryUf : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryUf := TFDQuery.Create(nil);
  try
    qryUf.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdUf', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 7, False);
      Data.FieldDefs.Add('NmUf', ftString, 10, False);
      Data.FieldDefs.Add('NmSigla', ftString, 10, False);
      Data.FieldDefs.Add('PcIcms', ftCurrency);
      Data.FieldDefs.Add('NrIbge', ftString, 10, False);
      Data.FieldDefs.Add('IdRegiao', ftInteger);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryUf.Params.Clear;
      qryUf.SQL.Clear;
      qryUf.SQL.Add('Select');
      qryUf.SQL.Add('  IdUf,');
      qryUf.SQL.Add('  IdUsuario,');
      qryUf.SQL.Add('  DtCadastro,');
      qryUf.SQL.Add('  SnSituacao,');
      qryUf.SQL.Add('  NmUf,');
      qryUf.SQL.Add('  NmSigla,');
      qryUf.SQL.Add('  PcIcms,');
      qryUf.SQL.Add('  NrIbge,');
      qryUf.SQL.Add('  IdRegiao');
      qryUf.SQL.Add('From Uf');
      qryUf.SQL.Add('Where 1 = 1');
      if ISnSituacao = 1 then
      begin
         qryUf.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryUf.SQL.Add('  And SnSituacao = 0');
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
          qryUf.SQL.Add (lCondicao);
          qryUf.SQL.Add ('Order By');
          qryUf.SQL.Add ('  IdUf');

          qryUf.Open;
          qryUf.First;
        end;
      end else begin
        qryUf.SQL.Add (lCondicao);
        qryUf.SQL.Add ('Order By');
        qryUf.SQL.Add ('  IdUf');

        lFinalizaLoop := 1;
        qryUf.Open;
        qryUf.First;
      end;

      while not qryUf.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdUf').AsInteger = qryUf.FieldByName('IdUf').AsInteger then
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
          Data.FieldByName('IdUf').AsInteger := qryUf.FieldByName('IdUf').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryUf.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryUf.FieldByName('DtCadastro').AsDateTime;
          if qryUf.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString  := 'Ativo';
          end else begin
            Data.FieldByName('SnSituacao').AsString  := 'Desativado';
          end;
          Data.FieldByName('NmUf').AsString := qryUf.FieldByName('NmUf').AsString;
          Data.FieldByName('NmSigla').AsString := qryUf.FieldByName('NmSigla').AsString;
          Data.FieldByName('PcIcms').AsFloat := qryUf.FieldByName('PcIcms').AsFloat;
          Data.FieldByName('NrIbge').AsString := qryUf.FieldByName('NrIbge').AsString;
          Data.FieldByName('IdRegiao').AsInteger := qryUf.FieldByName('IdRegiao').AsInteger;
          Data.Post;
        end;

        lVerificacao := 0;
        qryUf.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryUf.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TUf.Create;
begin
  Inicializar;
end;

procedure TUf.Inicializar;
begin
  IdUf := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  NmUf := '';
  NmSigla := '';
  PcIcms := 0;
  NrIbge := '';
  IdRegiao := 0;
end;

function TUf.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryUf: TFDQuery;
begin
  qryUf:= TFDQuery.Create(Nil);
  try
    qryUf.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdUf) then
    begin
      qryUf.SQL.Add('Insert Into Uf(');
      qryUf.SQL.Add('  IdUsuario,');
      qryUf.SQL.Add('  DtCadastro,');
      qryUf.SQL.Add('  SnSituacao,');
      qryUf.SQL.Add('  NmUf,');
      qryUf.SQL.Add('  NmSigla,');
      qryUf.SQL.Add('  PcIcms,');
      qryUf.SQL.Add('  NrIbge,');
      qryUf.SQL.Add('  IdRegiao)');
      qryUf.SQL.Add('Values (');
      qryUf.SQL.Add('  :IdUsuario,');
      qryUf.SQL.Add('  :DtCadastro,');
      qryUf.SQL.Add('  :SnSituacao,');
      qryUf.SQL.Add('  :NmUf,');
      qryUf.SQL.Add('  :NmSigla,');
      qryUf.SQL.Add('  :PcIcms,');
      qryUf.SQL.Add('  :NrIbge,');
      qryUf.SQL.Add('  :IdRegiao)');
    end else begin
      qryUf.SQL.Add('Update Uf Set ');
      qryUf.SQL.Add('  IdUsuario = :IdUsuario,');
      qryUf.SQL.Add('  DtCadastro = :DtCadastro,');
      qryUf.SQL.Add('  SnSituacao = :SnSituacao,');
      qryUf.SQL.Add('  NmUf = :NmUf,');
      qryUf.SQL.Add('  NmSigla = :NmSigla,');
      qryUf.SQL.Add('  PcIcms = :PcIcms,');
      qryUf.SQL.Add('  NrIbge = :NrIbge,');
      qryUf.SQL.Add('  IdRegiao = :IdRegiao ');
      qryUf.SQL.Add('Where IdUf = :IdUf');

      qryUf.ParamByName('IdUf').AsInteger := IdUf;

    end;
    qryUf.ParamByName('IdUsuario').AsInteger := IdUsuario;
    qryUf.ParamByName('DtCadastro').AsDateTime := DtCadastro;
    qryUf.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryUf.ParamByName('NmUf').AsString := NmUf;
    qryUf.ParamByName('NmSigla').AsString := NmSigla;
    qryUf.ParamByName('PcIcms').AsFloat := PcIcms;
    qryUf.ParamByName('NrIbge').AsString := NrIbge;
    qryUf.ParamByName('IdRegiao').AsInteger := IdRegiao;
   try
      qryUf.ExecSQL;
      qryUf.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryUf)
  end;
end;

class function TUf.Inativar(ASQLConnection: TFDConnection; AIdUf: Integer): Boolean;
var
  qryUf: TFDQuery;
begin
  qryUf:= TFDQuery.Create(Nil);
  try
    qryUf.Connection := ASQLConnection;
    qryUf.SQL.Add('Update Uf Set ');
    qryUf.SQL.Add('  SnSituacao = 0 ');
    qryUf.SQL.Add('Where 1 = 1');
    qryUf.SQL.Add('  And IdUf = ' + IntToStr(AIdUf));
   try
      qryUf.ExecSQL;
      qryUf.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryUf)
  end;
end;

class function TUf.Existe(ASQLConnection: TFDConnection; AIdUf: Integer): Boolean;
var
  qryUf: TFDQuery;
begin
  Result := False;
  qryUf:= TFDQuery.Create(Nil);
  try
    qryUf.Connection := ASQLConnection;
    qryUf.SQL.Add('Select IdUf From Uf');
    qryUf.SQL.Add('Where 1 = 1');
    qryUf.SQL.Add('  And IdUf = ' + IntToStr(AIdUf));
    qryUf.Open;
    if qryUf.Fields[0].Value > 0 then
      Result := True;
    qryUf.Close;
  finally
    FreeAndNil(qryUf)
  end;
end;

class function TUf.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryUf: TFDQuery;
begin
  Result := 0;
  qryUf:= TFDQuery.Create(Nil);
  try
    qryUf.Connection := ASQLConnection;
    qryUf.SQL.Add('Select Max(IdUf) As IdUf From Uf');
    qryUf.Open;

    if qryUf.FieldByName('IdUf').AsInteger > 0 then
      Result := qryUf.FieldByName('IdUf').AsInteger;
    qryUf.Close;
  finally
    FreeAndNil(qryUf)
  end;
end;

function TUf.Buscar(ASQLConnection: TFDConnection; AIdUf: Integer): Boolean;
var
  qryUf: TFDQuery;
begin
  Result := False;
  qryUf:= TFDQuery.Create(Nil);
  try
    qryUf.Connection := ASQLConnection;
    qryUf.SQL.Add('Select * From Uf');
    qryUf.SQL.Add('Where 1 = 1');
    if AIdEmpresa > 0 then
    begin
      qryUf.SQL.Add('  And IdUf = ' + IntToStr(AIdUf));
    end;

    qryUf.Open;
    if not qryUf.IsEmpty then
    begin
      Result := True;
      IdUf := qryUf.FieldByName('IdUf').AsInteger;
      IdUsuario := qryUf.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryUf.FieldByName('DtCadastro').AsDateTime;
      if qryUf.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      NmUf := qryUf.FieldByName('NmUf').AsString;
      NmSigla := qryUf.FieldByName('NmSigla').AsString;
      PcIcms := qryUf.FieldByName('PcIcms').AsFloat;
      NrIbge := qryUf.FieldByName('NrIbge').AsString;
      IdRegiao := qryUf.FieldByName('IdRegiao').AsInteger;
    end;
    qryUf.Close;
  finally
    FreeAndNil(qryUf)
  end;
end;

end.

