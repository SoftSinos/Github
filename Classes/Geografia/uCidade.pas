unit uCidade;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TCidade = class
  private
    FIdCidade: Integer;
    FIdUsuario: Integer;
    FDtCadastro: TDateTime;
    FSnSituacao: Integer;
    FNmCidade: String;
    FNrIbge: String;
    FIdUf: Integer;
    FNmUf: String;
    FNmSiglaUf: String;
    FNrIbgeUf: String;
    FIdRegiao: Integer;
    FNmRegiao: String;
    FIdPais: Integer;
    FNmPais: String;
    FNmSiglaPais: String;
    FNrIbgePais: String;
    FNmUsuarioCadastro: String;
    procedure Inicializar;
  public
    property IdCidade: Integer read FIdCidade write FIdCidade;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property NmCidade: String read FNmCidade write FNmCidade;
    property NrIbge: String read FNrIbge write FNrIbge;
    property IdUf: Integer read FIdUf write FIdUf;
    property NmUf: String read FNmUf write FNmUf;
    property NmSiglaUf: String read FNmSiglaUf write FNmSiglaUf;
    property NrIbgeUf: String read FNrIbgeUf write FNrIbgeUf;
    property IdRegiao: Integer read FIdRegiao write FIdRegiao;
    property NmRegiao: String read FNmRegiao write FNmRegiao;
    property IdPais: Integer read FIdPais write FIdPais;
    property NmPais: String read FNmPais write FNmPais;
    property NmSiglaPais: String read FNmSiglaPais write FNmSiglaPais;
    property NrIbgePais: String read FNrIbgePais write FNrIbgePais;
    property NmUsuarioCadastro: String read FNmUsuarioCadastro write FNmUsuarioCadastro;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdCidade: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdCidade: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdCidade: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdCidade: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TCidade.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdCidade: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryCidade    : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryCidade := TFDQuery.Create(nil);
  try
    qryCidade.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdCidade', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 9, False);
      Data.FieldDefs.Add('NmCidade', ftString, 100, False);
      Data.FieldDefs.Add('NrIbge', ftString, 10, False);
      Data.FieldDefs.Add('IdUf', ftInteger);
      Data.FieldDefs.Add('NmUf', ftString, 50, False);
      Data.FieldDefs.Add('NmSiglaUf', ftString, 10, False);
      Data.FieldDefs.Add('NrIbgeUf', ftString, 10, False);
      Data.FieldDefs.Add('IdRegiao', ftInteger);
      Data.FieldDefs.Add('NmRegiao', ftString, 50, False);
      Data.FieldDefs.Add('IdPais', ftInteger);
      Data.FieldDefs.Add('NmPais', ftString, 50, False);
      Data.FieldDefs.Add('NmSiglaPais', ftString, 10, False);
      Data.FieldDefs.Add('NrIbgePais', ftString, 10, False);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 50, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryCidade.Params.Clear;
      qryCidade.SQL.Clear;
      qryCidade.SQL.Add('Select                 ');
      qryCidade.SQL.Add('  *                    ');
      qryCidade.SQL.Add('From VW_GridCidade     ');
      qryCidade.SQL.Add('Where 1 = 1            ');

      if ISnSituacao = 1 then
      begin
         qryCidade.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryCidade.SQL.Add('  And SnSituacao = 0');
      end;

      if AIdCidade > 0 then
      begin
         qryCidade.SQL.Add('  And IdCidade = :IdCidade');

         qryCidade.ParamByName('IdCidade').AsInteger := AIdCidade;
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
          qryCidade.SQL.Add (lCondicao);
          qryCidade.SQL.Add ('Order By');
          qryCidade.SQL.Add (' IdCidade');

          qryCidade.Open;
          qryCidade.First;
        end;
      end else begin
        qryCidade.SQL.Add (lCondicao);
        qryCidade.SQL.Add ('Order By');
        qryCidade.SQL.Add (' IdCidade');

        lFinalizaLoop := 1;
        qryCidade.Open;
        qryCidade.First;
      end;

      while not qryCidade.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdCidade').AsInteger = qryCidade.FieldByName('IddCidade').AsInteger then
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
          Data.FieldByName('IdCidade').AsInteger := qryCidade.FieldByName('IdCidade').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryCidade.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryCidade.FieldByName('DtCadastro').AsDateTime;
          if qryCidade.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'ATIVO';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'INATIVO';
          end;
          Data.FieldByName('NmCidade').AsString := qryCidade.FieldByName('NmCidade').AsString;
          Data.FieldByName('NrIbge').AsString := qryCidade.FieldByName('NrIbge').AsString;
          Data.FieldByName('IdUf').AsInteger := qryCidade.FieldByName('IdUf').AsInteger;
          Data.FieldByName('NmUf').AsString := qryCidade.FieldByName('NmUf').AsString;
          Data.FieldByName('NmSiglaUf').AsString := qryCidade.FieldByName('NmSiglaUf').AsString;
          Data.FieldByName('NrIbgeUf').AsString := qryCidade.FieldByName('NrIbgeUf').AsString;
          Data.FieldByName('IdRegiao').AsInteger := qryCidade.FieldByName('IdRegiao').AsInteger;
          Data.FieldByName('NmRegiao').AsString := qryCidade.FieldByName('NmRegiao').AsString;
          Data.FieldByName('IdPais').AsInteger := qryCidade.FieldByName('IdPais').AsInteger;
          Data.FieldByName('NmPais').AsString := qryCidade.FieldByName('NmPais').AsString;
          Data.FieldByName('NmSiglaPais').AsString := qryCidade.FieldByName('NmSiglaPais').AsString;
          Data.FieldByName('NrIbgePais').AsString := qryCidade.FieldByName('NrIbgePais').AsString;
          Data.FieldByName('NmUsuarioCadastro').AsString := qryCidade.FieldByName('NmUsuarioCadastro').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryCidade.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryCidade.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TCidade.Create;
begin
  Inicializar;
end;

procedure TCidade.Inicializar;
begin
  IdCidade := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  NmCidade := '';
  NrIbge := '';
  IdUf := 0;
  NmUf := '';
  NmSiglaUf := '';
  NrIbgeUf := '';
  IdRegiao := 0;
  NmRegiao := '';
  IdPais := 0;
  NmPais := '';
  NmSiglaPais := '';
  NrIbgePais := '';
  NmUsuarioCadastro := '';
end;

function TCidade.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryCidade: TFDQuery;
begin
  qryCidade:= TFDQuery.Create(Nil);
  try
    qryCidade.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdCidade) then
    begin
      qryCidade.SQL.Add('Insert Into Cidade(');
      qryCidade.SQL.Add('  IdUsuario,');
      qryCidade.SQL.Add('  DtCadastro,');
      qryCidade.SQL.Add('  SnSituacao,');
      qryCidade.SQL.Add('  NmCidade,');
      qryCidade.SQL.Add('  NrIbge,');
      qryCidade.SQL.Add('  IdUf)');
      qryCidade.SQL.Add('Values (');
      qryCidade.SQL.Add('  :IdUsuario,');
      qryCidade.SQL.Add('  :DtCadastro,');
      qryCidade.SQL.Add('  :SnSituacao,');
      qryCidade.SQL.Add('  :NmCidade,');
      qryCidade.SQL.Add('  :NrIbge,');
      qryCidade.SQL.Add('  :IdUf)');

      qryCidade.ParamByName('IdUsuario').AsInteger := IdUsuario;
      qryCidade.ParamByName('DtCadastro').AsDateTime := DtCadastro;

    end else begin
      qryCidade.SQL.Add('Update Cidade Set ');
      qryCidade.SQL.Add('  SnSituacao = :SnSituacao,');
      qryCidade.SQL.Add('  NmCidade = :NmCidade,');
      qryCidade.SQL.Add('  NrIbge = :NrIbge,');
      qryCidade.SQL.Add('  IdUf = :IdUf ');
      qryCidade.SQL.Add('Where IdCidade = :IdCidade');

      qryCidade.ParamByName('IdCidade').AsInteger := IdCidade;

    end;
    qryCidade.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryCidade.ParamByName('NmCidade').AsString := NmCidade;
    qryCidade.ParamByName('NrIbge').AsString := NrIbge;
    qryCidade.ParamByName('IdUf').AsInteger := IdUf;
   try
      qryCidade.ExecSQL;
      qryCidade.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryCidade)
  end;
end;

class function TCidade.Inativar(ASQLConnection: TFDConnection; AIdCidade: Integer): Boolean;
var
  qryCidade: TFDQuery;
begin
  qryCidade:= TFDQuery.Create(Nil);
  try
    qryCidade.Connection := ASQLConnection;
    qryCidade.SQL.Add('Update Cidade Set ');
    qryCidade.SQL.Add('  SnSituacao = 0 ');
    qryCidade.SQL.Add('Where 1 = 1');
    qryCidade.SQL.Add('  And IdCidade = ' + IntToStr(AIdCidade));
   try
      qryCidade.ExecSQL;
      qryCidade.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryCidade)
  end;
end;

class function TCidade.Existe(ASQLConnection: TFDConnection; AIdCidade: Integer): Boolean;
var
  qryCidade: TFDQuery;
begin
  Result := False;
  qryCidade:= TFDQuery.Create(Nil);
  try
    qryCidade.Connection := ASQLConnection;
    qryCidade.SQL.Add('Select IdCidade From Cidade');
    qryCidade.SQL.Add('Where 1 = 1');
    qryCidade.SQL.Add('  And IdCidade = ' + IntToStr(AIdCidade));
    qryCidade.Open;
    if qryCidade.Fields[0].Value > 0 then
      Result := True;
    qryCidade.Close;
  finally
    FreeAndNil(qryCidade)
  end;
end;

class function TCidade.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryCidade: TFDQuery;
begin
  Result := 0;
  qryCidade:= TFDQuery.Create(Nil);
  try
    qryCidade.Connection := ASQLConnection;
    qryCidade.SQL.Add('Select Max(IdCidade) As IdCidade From Cidade');
    qryCidade.Open;

    if qryCidade.FieldByName('IdCidade').AsInteger > 0 then
      Result := qryCidade.FieldByName('IdCidade').AsInteger;
    qryCidade.Close;
  finally
    FreeAndNil(qryCidade)
  end;
end;

function TCidade.Buscar(ASQLConnection: TFDConnection; AIdCidade: Integer): Boolean;
var
  qryCidade: TFDQuery;
begin
  Result := False;
  qryCidade:= TFDQuery.Create(Nil);
  try
    qryCidade.Connection := ASQLConnection;
    qryCidade.SQL.Add('Select * From VW_GridCidade');
    qryCidade.SQL.Add('Where IdCidade = :IdCidade');

    qryCidade.ParamByName('IdCidade').AsString := IntToStr(AIdCidade);

    qryCidade.Open;
    if not qryCidade.IsEmpty then
    begin
      Result := True;
      IdCidade := qryCidade.FieldByName('IdCidade').AsInteger;
      IdUsuario := qryCidade.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryCidade.FieldByName('DtCadastro').AsDateTime;
      if qryCidade.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      NmCidade := qryCidade.FieldByName('NmCidade').AsString;
      NrIbge := qryCidade.FieldByName('NrIbge').AsString;
      IdUf := qryCidade.FieldByName('IdUf').AsInteger;
      NmUf := qryCidade.FieldByName('NmUf').AsString;
      NmSiglaUf := qryCidade.FieldByName('NmSiglaUf').AsString;
      NrIbgeUf := qryCidade.FieldByName('NrIbgeUf').AsString;
      IdRegiao := qryCidade.FieldByName('IdRegiao').AsInteger;
      NmRegiao := qryCidade.FieldByName('NmRegiao').AsString;
      IdPais := qryCidade.FieldByName('IdPais').AsInteger;
      NmPais := qryCidade.FieldByName('NmPais').AsString;
      NmSiglaPais := qryCidade.FieldByName('NmSiglaPais').AsString;
      NrIbgePais := qryCidade.FieldByName('NrIbgePais').AsString;
      NmUsuarioCadastro := qryCidade.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryCidade.Close;
  finally
    FreeAndNil(qryCidade)
  end;
end;

end.

