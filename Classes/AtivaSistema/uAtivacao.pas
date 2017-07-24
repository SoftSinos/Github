unit uAtivacao;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TAtivacao = class
  private
    FIdAtivacao: Integer;
    FIdUsuario: Integer;
    FDtCadastro: TDateTime;
    FSnSituacao: Integer;
    FNmComputador: String;
    FNrMac: String;
    FNrIp: String;
    FNrHd: String;
    FNrChaveAtivacao: String;
    FNmLicenca: String;
    FNmUsuarioCadastro: String;
    procedure Inicializar;
  public
    property IdAtivacao: Integer read FIdAtivacao write FIdAtivacao;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property NmComputador: String read FNmComputador write FNmComputador;
    property NrMac: String read FNrMac write FNrMac;
    property NrIp: String read FNrIp write FNrIp;
    property NrHd: String read FNrHd write FNrHd;
    property NrChaveAtivacao: String read FNrChaveAtivacao write FNrChaveAtivacao;
    property NmLicenca: String read FNmLicenca write FNmLicenca;
    property NmUsuarioCadastro: String read FNmUsuarioCadastro write FNmUsuarioCadastro;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdAtivacao: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdAtivacao: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdAtivacao: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TAtivacao.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdAtivacao: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryAtivacao : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryAtivacao := TFDQuery.Create(nil);
  try
    qryAtivacao.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdAtivacao', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 9, False);
      Data.FieldDefs.Add('NmComputador', ftString, 255, False);
      Data.FieldDefs.Add('NrMac', ftString, 255, False);
      Data.FieldDefs.Add('NrIp', ftString, 255, False);
      Data.FieldDefs.Add('NrHd', ftString, 255, False);
      Data.FieldDefs.Add('NrChaveAtivacao', ftString, 255, False);
      Data.FieldDefs.Add('NmLicenca', ftString, 255, False);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 255, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryAtivacao.Params.Clear;
      qryAtivacao.SQL.Clear;
      qryAtivacao.SQL.Add('Select');
      qryAtivacao.SQL.Add('  *');
      qryAtivacao.SQL.Add('From VW_GridAtivacao');
      qryAtivacao.SQL.Add('Where 1 = 1');

      if ISnSituacao = 1 then
      begin
         qryAtivacao.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryAtivacao.SQL.Add('  And SnSituacao = 0');
      end;

      if AIdAtivacao > 0 then
      begin
         qryAtivacao.SQL.Add('  And IdAtivacao = :IdAtivacao');

         qryAtivacao.ParamByName('IdAtivacao').AsInteger := AIdAtivacao;
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
          qryAtivacao.SQL.Add (lCondicao);
          qryAtivacao.SQL.Add ('Order By');
          qryAtivacao.SQL.Add (' IdAtivacao');

          qryAtivacao.Open;
          qryAtivacao.First;
        end;
      end else begin
        qryAtivacao.SQL.Add (lCondicao);
        qryAtivacao.SQL.Add ('Order By');
        qryAtivacao.SQL.Add (' IdAtivacao');

        lFinalizaLoop := 1;
        qryAtivacao.Open;
        qryAtivacao.First;
      end;

      while not qryAtivacao.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdAtivacao').AsInteger = qryAtivacao.FieldByName('IdAtivacao').AsInteger then
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
          Data.FieldByName('IdAtivacao').AsInteger := qryAtivacao.FieldByName('IdAtivacao').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryAtivacao.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryAtivacao.FieldByName('DtCadastro').AsDateTime;
          if qryAtivacao.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'ATIVO';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'INATIVO';
          end;
          Data.FieldByName('NmComputador').AsString := qryAtivacao.FieldByName('NmComputador').AsString;
          Data.FieldByName('NrMac').AsString := qryAtivacao.FieldByName('NrMac').AsString;
          Data.FieldByName('NrIp').AsString := qryAtivacao.FieldByName('NrIp').AsString;
          Data.FieldByName('NrHd').AsString := qryAtivacao.FieldByName('NrHd').AsString;
          Data.FieldByName('NrChaveAtivacao').AsString := qryAtivacao.FieldByName('NrChaveAtivacao').AsString;
          Data.FieldByName('NmLicenca').AsString := qryAtivacao.FieldByName('NmLicenca').AsString;
          Data.FieldByName('NmUsuarioCadastro').AsString := qryAtivacao.FieldByName('NmUsuarioCadastro').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryAtivacao.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryAtivacao.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TAtivacao.Create;
begin
  Inicializar;
end;

procedure TAtivacao.Inicializar;
begin
  IdAtivacao := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  NmComputador := '';
  NrMac := '';
  NrIp := '';
  NrHd := '';
  NrChaveAtivacao := '';
  NmLicenca := '';
  NmUsuarioCadastro := '';
end;

function TAtivacao.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryAtivacao: TFDQuery;
begin
  qryAtivacao:= TFDQuery.Create(Nil);
  try
    qryAtivacao.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdAtivacao) then
    begin
      qryAtivacao.SQL.Add('Insert Into Ativacao(');
      qryAtivacao.SQL.Add('  IdUsuario,');
      qryAtivacao.SQL.Add('  DtCadastro,');
      qryAtivacao.SQL.Add('  SnSituacao,');
      qryAtivacao.SQL.Add('  NmComputador,');
      qryAtivacao.SQL.Add('  NrMac,');
      qryAtivacao.SQL.Add('  NrIp,');
      qryAtivacao.SQL.Add('  NrHd,');
      qryAtivacao.SQL.Add('  NrChaveAtivacao,');
      qryAtivacao.SQL.Add('  NmLicenca)');
      qryAtivacao.SQL.Add('Values (');
      qryAtivacao.SQL.Add('  :IdUsuario,');
      qryAtivacao.SQL.Add('  :DtCadastro,');
      qryAtivacao.SQL.Add('  :SnSituacao,');
      qryAtivacao.SQL.Add('  :NmComputador,');
      qryAtivacao.SQL.Add('  :NrMac,');
      qryAtivacao.SQL.Add('  :NrIp,');
      qryAtivacao.SQL.Add('  :NrHd,');
      qryAtivacao.SQL.Add('  :NrChaveAtivacao,');
      qryAtivacao.SQL.Add('  :NmLicenca)');

      qryAtivacao.ParamByName('IdUsuario').AsInteger := IdUsuario;
      qryAtivacao.ParamByName('DtCadastro').AsDateTime := DtCadastro;

    end else begin
      qryAtivacao.SQL.Add('Update Ativacao Set ');
      qryAtivacao.SQL.Add('  SnSituacao = :SnSituacao,');
      qryAtivacao.SQL.Add('  NmComputador = :NmComputador,');
      qryAtivacao.SQL.Add('  NrMac = :NrMac,');
      qryAtivacao.SQL.Add('  NrIp = :NrIp,');
      qryAtivacao.SQL.Add('  NrHd = :NrHd,');
      qryAtivacao.SQL.Add('  NrChaveAtivacao = :NrChaveAtivacao,');
      qryAtivacao.SQL.Add('  NmLicenca = :NmLicenca ');
      qryAtivacao.SQL.Add('Where IdAtivacao = :IdAtivacao');

      qryAtivacao.ParamByName('IdAtivacao').AsInteger := IdAtivacao;

    end;
      qryAtivacao.ParamByName('SnSituacao').AsInteger := SnSituacao;
      qryAtivacao.ParamByName('NmComputador').AsString := NmComputador;
      qryAtivacao.ParamByName('NrMac').AsString := NrMac;
      qryAtivacao.ParamByName('NrIp').AsString := NrIp;
      qryAtivacao.ParamByName('NrHd').AsString := NrHd;
      qryAtivacao.ParamByName('NrChaveAtivacao').AsString := NrChaveAtivacao;
      qryAtivacao.ParamByName('NmLicenca').AsString := NmLicenca;
   try
      qryAtivacao.ExecSQL;
      qryAtivacao.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryAtivacao)
  end;
end;

class function TAtivacao.Inativar(ASQLConnection: TFDConnection; AIdAtivacao: Integer): Boolean;
var
  qryAtivacao: TFDQuery;
begin
  qryAtivacao:= TFDQuery.Create(Nil);
  try
    qryAtivacao.Connection := ASQLConnection;
    qryAtivacao.SQL.Add('Update Ativacao Set ');
    qryAtivacao.SQL.Add('  SnSituacao = 0 ');
    qryAtivacao.SQL.Add('Where 1 = 1');
    qryAtivacao.SQL.Add('  And IdAtivacao = ' + IntToStr(AIdAtivacao));
   try
      qryAtivacao.ExecSQL;
      qryAtivacao.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryAtivacao)
  end;
end;

class function TAtivacao.Existe(ASQLConnection: TFDConnection; AIdAtivacao: Integer): Boolean;
var
  qryAtivacao: TFDQuery;
begin
  Result := False;
  qryAtivacao:= TFDQuery.Create(Nil);
  try
    qryAtivacao.Connection := ASQLConnection;
    qryAtivacao.SQL.Add('Select IdAtivacao From Ativacao');
    qryAtivacao.SQL.Add('Where 1 = 1');
    qryAtivacao.SQL.Add('  And IdAtivacao = ' + IntToStr(AIdAtivacao));
    qryAtivacao.Open;
    if qryAtivacao.Fields[0].Value > 0 then
      Result := True;
    qryAtivacao.Close;
  finally
    FreeAndNil(qryAtivacao)
  end;
end;

class function TAtivacao.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryAtivacao: TFDQuery;
begin
  Result := 0;
  qryAtivacao:= TFDQuery.Create(Nil);
  try
    qryAtivacao.Connection := ASQLConnection;
    qryAtivacao.SQL.Add('Select Max(IdAtivacao) As IdAtivacao From Ativacao');
    qryAtivacao.Open;

    if qryAtivacao.FieldByName('IdAtivacao').AsInteger > 0 then
      Result := qryAtivacao.FieldByName('IdAtivacao').AsInteger;
    qryAtivacao.Close;
  finally
    FreeAndNil(qryAtivacao)
  end;
end;

function TAtivacao.Buscar(ASQLConnection: TFDConnection): Boolean;
var
  qryAtivacao: TFDQuery;
begin
  Result := False;
  qryAtivacao:= TFDQuery.Create(Nil);
  try
    qryAtivacao.Connection := ASQLConnection;
    qryAtivacao.SQL.Add('Select * From VW_GridAtivacao');

    qryAtivacao.Open;
    if not qryAtivacao.IsEmpty then
    begin
      Result := True;
      IdAtivacao := qryAtivacao.FieldByName('IdAtivacao').AsInteger;
      IdUsuario := qryAtivacao.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryAtivacao.FieldByName('DtCadastro').AsDateTime;
      if qryAtivacao.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      NmComputador := qryAtivacao.FieldByName('NmComputador').AsString;
      NrMac := qryAtivacao.FieldByName('NrMac').AsString;
      NrIp := qryAtivacao.FieldByName('NrIp').AsString;
      NrHd := qryAtivacao.FieldByName('NrHd').AsString;
      NrChaveAtivacao := qryAtivacao.FieldByName('NrChaveAtivacao').AsString;
      NmLicenca := qryAtivacao.FieldByName('NmLicenca').AsString;
      NmUsuarioCadastro := qryAtivacao.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryAtivacao.Close;
  finally
    FreeAndNil(qryAtivacao)
  end;
end;

end.

