unit uCep;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TCep = class
  private
    FIdCep: Integer;
    FIdUsuario: Integer;
    FDtCadastro: TDateTime;
    FSnSituacao: Integer;
    FNrCep: String;
    FNmTpLogradouro: String;
    FNmLogradouro: String;
    FNmEndereco: String;
    FNmBairro: String;
    FIdCidade: Integer;
    FNmCidade: String;
    FNrIbgeCidade: String;
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
    property IdCep: Integer read FIdCep write FIdCep;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property NrCep: String read FNrCep write FNrCep;
    property NmTpLogradouro: String read FNmTpLogradouro write FNmTpLogradouro;
    property NmLogradouro: String read FNmLogradouro write FNmLogradouro;
    property NmEndereco: String read FNmEndereco write FNmEndereco;
    property NmBairro: String read FNmBairro write FNmBairro;
    property IdCidade: Integer read FIdCidade write FIdCidade;
    property NmCidade: String read FNmCidade write FNmCidade;
    property NrIbgeCidade: String read FNrIbgeCidade write FNrIbgeCidade;
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
    class function Inativar(ASQLConnection: TFDConnection; AIdCep: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdCep: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdCep: Integer): Boolean;
    function BuscarNrCep(ASQLConnection: TFDConnection; ANrCep: String): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdCep: Integer; AConsulta: String; AIdUf: Integer; AIdCidade: Integer; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TCep.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdCep: Integer; AConsulta: String; AIdUf: Integer; AIdCidade: Integer; Data: TClientDataSet);
var
  qryCep : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryCep := TFDQuery.Create(nil);
  try
    qryCep.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdCep', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 9, False);
      Data.FieldDefs.Add('NrCep', ftString, 20, False);
      Data.FieldDefs.Add('NmEndereco', ftString, 255, False);
      Data.FieldDefs.Add('NmTpLogradouro', ftString, 100, False);
      Data.FieldDefs.Add('NmLogradouro', ftString, 255, False);
      Data.FieldDefs.Add('NmBairro', ftString, 100, False);
      Data.FieldDefs.Add('IdCidade', ftInteger);
      Data.FieldDefs.Add('NmCidade', ftString, 100, False);
      Data.FieldDefs.Add('NrIbgeCidade', ftString, 10, False);
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
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 255, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryCep.Params.Clear;
      qryCep.SQL.Clear;
      qryCep.SQL.Add('Select');
      qryCep.SQL.Add('  *');
      qryCep.SQL.Add('From VW_GridCep');
      qryCep.SQL.Add('Where 1 = 1');

      if ISnSituacao = 1 then
      begin
         qryCep.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryCep.SQL.Add('  And SnSituacao = 0');
      end;

      if (AIdUf > 0) and (AIdCidade > 0) then
      begin
         qryCep.SQL.Add('  And IdUf = :IdUf');
         qryCep.SQL.Add('  And IdCidade = :IdCidade');

         qryCep.ParamByName('IdUf').AsInteger := AIdUf;
         qryCep.ParamByName('IdCidade').AsInteger := AIdCidade;
      end;

      if AIdCep > 0 then
      begin
         qryCep.SQL.Add('  And IdCep = :IdCep');

         qryCep.ParamByName('IdCep').AsInteger := AIdCep;
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
          qryCep.SQL.Add (lCondicao);
          qryCep.SQL.Add ('Order By');
          qryCep.SQL.Add (' IdCep');

          qryCep.Open;
          qryCep.First;
        end;
      end else begin
        qryCep.SQL.Add (lCondicao);
        qryCep.SQL.Add ('Order By');
        qryCep.SQL.Add (' IdCep');

        lFinalizaLoop := 1;
        qryCep.Open;
        qryCep.First;
      end;

      while not qryCep.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdCep').AsInteger = qryCep.FieldByName('IdCep').AsInteger then
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
          Data.FieldByName('IdCep').AsInteger := qryCep.FieldByName('IdCep').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryCep.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryCep.FieldByName('DtCadastro').AsDateTime;
          if qryCep.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'ATIVO';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'INATIVO';
          end;
          Data.FieldByName('NrCep').AsString := qryCep.FieldByName('NrCep').AsString;
          Data.FieldByName('NmTpLogradouro').AsString := qryCep.FieldByName('NmTpLogradouro').AsString;
          Data.FieldByName('NmLogradouro').AsString := qryCep.FieldByName('NmLogradouro').AsString;
          Data.FieldByName('NmEndereco').AsString := qryCep.FieldByName('NmEndereco').AsString;
          Data.FieldByName('NmBairro').AsString := qryCep.FieldByName('NmBairro').AsString;
          Data.FieldByName('IdCidade').AsInteger := qryCep.FieldByName('IdCidade').AsInteger;
          Data.FieldByName('NmCidade').AsString := qryCep.FieldByName('NmCidade').AsString;
          Data.FieldByName('NrIbgeCidade').AsString := qryCep.FieldByName('NrIbgeCidade').AsString;
          Data.FieldByName('IdUf').AsInteger := qryCep.FieldByName('IdUf').AsInteger;
          Data.FieldByName('NmUf').AsString := qryCep.FieldByName('NmUf').AsString;
          Data.FieldByName('NmSiglaUf').AsString := qryCep.FieldByName('NmSiglaUf').AsString;
          Data.FieldByName('NrIbgeUf').AsString := qryCep.FieldByName('NrIbgeUf').AsString;
          Data.FieldByName('IdRegiao').AsInteger := qryCep.FieldByName('IdRegiao').AsInteger;
          Data.FieldByName('NmRegiao').AsString := qryCep.FieldByName('NmRegiao').AsString;
          Data.FieldByName('IdPais').AsInteger := qryCep.FieldByName('IdPais').AsInteger;
          Data.FieldByName('NmPais').AsString := qryCep.FieldByName('NmPais').AsString;
          Data.FieldByName('NmSiglaPais').AsString := qryCep.FieldByName('NmSiglaPais').AsString;
          Data.FieldByName('NrIbgePais').AsString := qryCep.FieldByName('NrIbgePais').AsString;
          Data.FieldByName('NmUsuarioCadastro').AsString := qryCep.FieldByName('NmUsuarioCadastro').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryCep.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryCep.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TCep.Create;
begin
  Inicializar;
end;

procedure TCep.Inicializar;
begin
  IdCep := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  NrCep := '';
  NmTpLogradouro := '';
  NmLogradouro := '';
  NmEndereco := '';
  NmBairro := '';
  IdCidade := 0;
  NmCidade := '';
  NrIbgeCidade := '';
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
  NmTpLogradouro := '';
  NmLogradouro := '';

end;

function TCep.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryCep: TFDQuery;
begin
  qryCep:= TFDQuery.Create(Nil);
  try
    qryCep.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdCep) then
    begin
      qryCep.SQL.Add('Insert Into Cep(');
      qryCep.SQL.Add('  IdUsuario,');
      qryCep.SQL.Add('  DtCadastro,');
      qryCep.SQL.Add('  SnSituacao,');
      qryCep.SQL.Add('  NrCep,');
      qryCep.SQL.Add('  NmTpLogradouro,');
      qryCep.SQL.Add('  NmLogradouro,');
      qryCep.SQL.Add('  NmBairro,');
      qryCep.SQL.Add('  IdCidade)');
      qryCep.SQL.Add('Values (');
      qryCep.SQL.Add('  :IdUsuario,');
      qryCep.SQL.Add('  :DtCadastro,');
      qryCep.SQL.Add('  :SnSituacao,');
      qryCep.SQL.Add('  :NrCep,');
      qryCep.SQL.Add('  :NmTpLogradouro,');
      qryCep.SQL.Add('  :NmLogradouro,');
      qryCep.SQL.Add('  :NmBairro,');
      qryCep.SQL.Add('  :IdCidade)');

      qryCep.ParamByName('IdUsuario').AsInteger := IdUsuario;
      qryCep.ParamByName('DtCadastro').AsDateTime := DtCadastro;

    end else begin
      qryCep.SQL.Add('Update Cep Set ');
      qryCep.SQL.Add('  SnSituacao = :SnSituacao,');
      qryCep.SQL.Add('  NrCep = :NrCep,');
      qryCep.SQL.Add('  NmTpLogradouro = :NmTpLogradouro,');
      qryCep.SQL.Add('  NmLogradouro = :NmLogradouro,');
      qryCep.SQL.Add('  NmBairro = :NmBairro,');
      qryCep.SQL.Add('  IdCidade = :IdCidade ');
      qryCep.SQL.Add('Where IdCep = :IdCep');

      qryCep.ParamByName('IdCep').AsInteger := IdCep;

    end;
    qryCep.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryCep.ParamByName('NrCep').AsString := NrCep;
    qryCep.ParamByName('NmTpLogradouro').AsString := NmTpLogradouro;
    qryCep.ParamByName('NmLogradouro').AsString := NmLogradouro;
    qryCep.ParamByName('NmBairro').AsString := NmBairro;
    qryCep.ParamByName('IdCidade').AsInteger := IdCidade;
   try
      qryCep.ExecSQL;
      qryCep.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryCep)
  end;
end;

class function TCep.Inativar(ASQLConnection: TFDConnection; AIdCep: Integer): Boolean;
var
  qryCep: TFDQuery;
begin
  qryCep:= TFDQuery.Create(Nil);
  try
    qryCep.Connection := ASQLConnection;
    qryCep.SQL.Add('Update Cep Set ');
    qryCep.SQL.Add('  SnSituacao = 0 ');
    qryCep.SQL.Add('Where 1 = 1');
    qryCep.SQL.Add('  And IdCep = ' + IntToStr(AIdCep));
   try
      qryCep.ExecSQL;
      qryCep.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryCep)
  end;
end;

class function TCep.Existe(ASQLConnection: TFDConnection; AIdCep: Integer): Boolean;
var
  qryCep: TFDQuery;
begin
  Result := False;
  qryCep:= TFDQuery.Create(Nil);
  try
    qryCep.Connection := ASQLConnection;
    qryCep.SQL.Add('Select IdCep From Cep');
    qryCep.SQL.Add('Where 1 = 1');
    qryCep.SQL.Add('  And IdCep = ' + IntToStr(AIdCep));
    qryCep.Open;
    if qryCep.Fields[0].Value > 0 then
      Result := True;
    qryCep.Close;
  finally
    FreeAndNil(qryCep)
  end;
end;

class function TCep.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryCep: TFDQuery;
begin
  Result := 0;
  qryCep:= TFDQuery.Create(Nil);
  try
    qryCep.Connection := ASQLConnection;
    qryCep.SQL.Add('Select Max(IdCep) As IdCep From Cep');
    qryCep.Open;

    if qryCep.FieldByName('IdCep').AsInteger > 0 then
      Result := qryCep.FieldByName('IdCep').AsInteger;
    qryCep.Close;
  finally
    FreeAndNil(qryCep)
  end;
end;

function TCep.Buscar(ASQLConnection: TFDConnection; AIdCep: Integer): Boolean;
var
  qryCep: TFDQuery;
begin
  Result := False;
  qryCep:= TFDQuery.Create(Nil);
  try
    qryCep.Connection := ASQLConnection;
    qryCep.SQL.Add('Select * From VW_GridCep');
    qryCep.SQL.Add('Where 1 = 1');
    if AIdCep > 0 then
    begin
      qryCep.SQL.Add('  And IdCep = ' + IntToStr(AIdCep));
    end;

    qryCep.Open;
    if not qryCep.IsEmpty then
    begin
      Result := True;
      IdCep := qryCep.FieldByName('IdCep').AsInteger;
      IdUsuario := qryCep.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryCep.FieldByName('DtCadastro').AsDateTime;
      if qryCep.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      NrCep := qryCep.FieldByName('NrCep').AsString;
      NmTpLogradouro := qryCep.FieldByName('NmTpLogradouro').AsString;
      NmLogradouro := qryCep.FieldByName('NmLogradouro').AsString;
      NmEndereco := qryCep.FieldByName('NmEndereco').AsString;
      NmBairro := qryCep.FieldByName('NmBairro').AsString;
      IdCidade := qryCep.FieldByName('IdCidade').AsInteger;
      NmCidade := qryCep.FieldByName('NmCidade').AsString;
      NrIbgeCidade := qryCep.FieldByName('NrIbgeCidade').AsString;
      IdUf := qryCep.FieldByName('IdUf').AsInteger;
      NmUf := qryCep.FieldByName('NmUf').AsString;
      NmSiglaUf := qryCep.FieldByName('NmSiglaUf').AsString;
      NrIbgeUf := qryCep.FieldByName('NrIbgeUf').AsString;
      IdRegiao := qryCep.FieldByName('IdRegiao').AsInteger;
      NmRegiao := qryCep.FieldByName('NmRegiao').AsString;
      IdPais := qryCep.FieldByName('IdPais').AsInteger;
      NmPais := qryCep.FieldByName('NmPais').AsString;
      NmSiglaPais := qryCep.FieldByName('NmSiglaPais').AsString;
      NrIbgePais := qryCep.FieldByName('NrIbgePais').AsString;
      NmUsuarioCadastro := qryCep.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryCep.Close;
  finally
    FreeAndNil(qryCep)
  end;
end;

function TCep.BuscarNrCep(ASQLConnection: TFDConnection; ANrCep: String): Boolean;
var
  qryCep: TFDQuery;
begin
  Result := False;
  qryCep:= TFDQuery.Create(Nil);
  try
    qryCep.Connection := ASQLConnection;
    qryCep.SQL.Add('Select * From VW_GridCep');
    qryCep.SQL.Add('Where NrCep = :NrCep');

    qryCep.ParamByName('NrCep').AsString := ANrCep;

    qryCep.Open;
    if not qryCep.IsEmpty then
    begin
      Result := True;
      IdCep := qryCep.FieldByName('IdCep').AsInteger;
      IdUsuario := qryCep.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryCep.FieldByName('DtCadastro').AsDateTime;
      if qryCep.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      NrCep := qryCep.FieldByName('NrCep').AsString;
      NmTpLogradouro := qryCep.FieldByName('NmTpLogradouro').AsString;
      NmLogradouro := qryCep.FieldByName('NmLogradouro').AsString;
      NmEndereco := qryCep.FieldByName('NmEndereco').AsString;
      NmBairro := qryCep.FieldByName('NmBairro').AsString;
      IdCidade := qryCep.FieldByName('IdCidade').AsInteger;
      NmCidade := qryCep.FieldByName('NmCidade').AsString;
      NrIbgeCidade := qryCep.FieldByName('NrIbgeCidade').AsString;
      IdUf := qryCep.FieldByName('IdUf').AsInteger;
      NmUf := qryCep.FieldByName('NmUf').AsString;
      NmSiglaUf := qryCep.FieldByName('NmSiglaUf').AsString;
      NrIbgeUf := qryCep.FieldByName('NrIbgeUf').AsString;
      IdRegiao := qryCep.FieldByName('IdRegiao').AsInteger;
      NmRegiao := qryCep.FieldByName('NmRegiao').AsString;
      IdPais := qryCep.FieldByName('IdPais').AsInteger;
      NmPais := qryCep.FieldByName('NmPais').AsString;
      NmSiglaPais := qryCep.FieldByName('NmSiglaPais').AsString;
      NrIbgePais := qryCep.FieldByName('NrIbgePais').AsString;
      NmUsuarioCadastro := qryCep.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryCep.Close;
  finally
    FreeAndNil(qryCep)
  end;
end;

end.

