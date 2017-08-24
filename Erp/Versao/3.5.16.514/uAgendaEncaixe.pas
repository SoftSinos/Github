unit uAgendaEncaixe;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TAgendaEncaixe = class
  private
    FIdAgendaEncaixe  : Integer;
    FIdEmpresa      : Integer;
    FIdUsuario        : Integer;
    FDtCadastro       : TDateTime;
    FSnSituacao       : Integer;
    FIdAgenda         : Integer;
    FIdTpServico      : Integer;
    FIdEmpCliente     : Integer;
    FIdCliente        : Integer;
  public
    procedure Inicializar;
    property IdAgendaEncaixe: Integer read FIdAgendaEncaixe write FIdAgendaEncaixe;
    property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property IdAgenda: Integer read FIdAgenda write FIdAgenda;
    property IdTpServico: Integer read FIdTpServico write FIdTpServico;
    property IdEmpCliente: Integer read FIdEmpCliente write FIdEmpCliente;
    property IdCliente: Integer read FIdCliente write FIdCliente;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdAgendaEncaixe: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdAgendaEncaixe: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdAgendaEncaixe: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdAgendaEncaixe: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TAgendaEncaixe.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdAgendaEncaixe: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryAgendaEncaixe : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryAgendaEncaixe := TFDQuery.Create(nil);
  try
    qryAgendaEncaixe.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdAgendaEncaixe', ftInteger);
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 7, False);
      Data.FieldDefs.Add('IdAgenda', ftInteger);
      Data.FieldDefs.Add('IdTpServico', ftInteger);
      Data.FieldDefs.Add('IdEmpCliente', ftInteger);
      Data.FieldDefs.Add('IdCliente', ftInteger);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryAgendaEncaixe.Params.Clear;
      qryAgendaEncaixe.SQL.Clear;
      qryAgendaEncaixe.SQL.Add('Select');
      qryAgendaEncaixe.SQL.Add('  IdAgendaEncaixe,');
      qryAgendaEncaixe.SQL.Add('  IdEmpresa,');
      qryAgendaEncaixe.SQL.Add('  IdUsuario,');
      qryAgendaEncaixe.SQL.Add('  DtCadastro,');
      qryAgendaEncaixe.SQL.Add('  SnSituacao,');
      qryAgendaEncaixe.SQL.Add('  IdAgenda,');
      qryAgendaEncaixe.SQL.Add('  IdTpServico,');
      qryAgendaEncaixe.SQL.Add('  IdEmpCliente,');
      qryAgendaEncaixe.SQL.Add('  IdCliente');
      qryAgendaEncaixe.SQL.Add('From AgendaEncaixe');
      qryAgendaEncaixe.SQL.Add('Where 1 = 1');
      if ISnSituacao = 1 then
      begin
         qryAgendaEncaixe.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryAgendaEncaixe.SQL.Add('  And SnSituacao = 0');
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
          qryAgendaEncaixe.SQL.Add (lCondicao);
          qryAgendaEncaixe.SQL.Add ('Order By');
          qryAgendaEncaixe.SQL.Add ('  IdAgendaEncaixe');

          qryAgendaEncaixe.Open;
          qryAgendaEncaixe.First;
        end;
      end else begin
        qryAgendaEncaixe.SQL.Add (lCondicao);
        qryAgendaEncaixe.SQL.Add ('Order By');
        qryAgendaEncaixe.SQL.Add ('  IdAgendaEncaixe');

        lFinalizaLoop := 1;
        qryAgendaEncaixe.Open;
        qryAgendaEncaixe.First;
      end;

      while not qryAgendaEncaixe.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdAgendaEncaixe').AsInteger = qryAgendaEncaixe.FieldByName('IdAgendaEncaixe').AsInteger then
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
          Data.FieldByName('IdAgendaEncaixe').AsInteger := qryAgendaEncaixe.FieldByName('IdAgendaEncaixe').AsInteger;
          Data.FieldByName('IdEmpresa').AsInteger := qryAgendaEncaixe.FieldByName('IdEmpresa').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryAgendaEncaixe.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryAgendaEncaixe.FieldByName('DtCadastro').AsDateTime;
          if qryAgendaEncaixe.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString  := 'Ativo';
          end else begin
            Data.FieldByName('SnSituacao').AsString  := 'Desativado';
          end;
          Data.FieldByName('IdAgenda').AsInteger := qryAgendaEncaixe.FieldByName('IdAgenda').AsInteger;
          Data.FieldByName('IdTpServico').AsInteger := qryAgendaEncaixe.FieldByName('IdTpServico').AsInteger;
          Data.FieldByName('IdEmpCliente').AsInteger := qryAgendaEncaixe.FieldByName('IdEmpCliente').AsInteger;
          Data.FieldByName('IdCliente').AsInteger := qryAgendaEncaixe.FieldByName('IdCliente').AsInteger;
          Data.Post;
        end;

        lVerificacao := 0;
        qryAgendaEncaixe.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryAgendaEncaixe.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TAgendaEncaixe.Create;
begin
  Inicializar;
end;

procedure TAgendaEncaixe.Inicializar;
begin
  IdAgendaEncaixe := 0;
  IdEmpresa := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  IdAgenda := 0;
  IdTpServico := 0;
  IdEmpCliente := 0;
  IdCliente := 0;
end;

function TAgendaEncaixe.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryAgendaEncaixe: TFDQuery;
begin
  qryAgendaEncaixe:= TFDQuery.Create(Nil);
  try
    qryAgendaEncaixe.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdAgendaEncaixe) then
    begin
      qryAgendaEncaixe.SQL.Add('Insert Into AgendaEncaixe(');
      qryAgendaEncaixe.SQL.Add('  IdEmpresa,');
      qryAgendaEncaixe.SQL.Add('  IdUsuario,');
      qryAgendaEncaixe.SQL.Add('  DtCadastro,');
      qryAgendaEncaixe.SQL.Add('  SnSituacao,');
      qryAgendaEncaixe.SQL.Add('  IdAgenda,');
      qryAgendaEncaixe.SQL.Add('  IdTpServico,');
      qryAgendaEncaixe.SQL.Add('  IdEmpCliente,');
      qryAgendaEncaixe.SQL.Add('  IdCliente)');
      qryAgendaEncaixe.SQL.Add('Values (');
      qryAgendaEncaixe.SQL.Add('  :IdEmpresa,');
      qryAgendaEncaixe.SQL.Add('  :IdUsuario,');
      qryAgendaEncaixe.SQL.Add('  :DtCadastro,');
      qryAgendaEncaixe.SQL.Add('  :SnSituacao,');
      qryAgendaEncaixe.SQL.Add('  :IdAgenda,');
      qryAgendaEncaixe.SQL.Add('  :IdTpServico,');
      qryAgendaEncaixe.SQL.Add('  :IdEmpCliente,');
      qryAgendaEncaixe.SQL.Add('  :IdCliente)');
    end else begin
      qryAgendaEncaixe.SQL.Add('Update AgendaEncaixe Set ');
      qryAgendaEncaixe.SQL.Add('  IdEmpresa = :IdEmpresa,');
      qryAgendaEncaixe.SQL.Add('  IdUsuario = :IdUsuario,');
      qryAgendaEncaixe.SQL.Add('  DtCadastro = :DtCadastro,');
      qryAgendaEncaixe.SQL.Add('  SnSituacao = :SnSituacao,');
      qryAgendaEncaixe.SQL.Add('  IdTpServico = :IdTpServico,');
      qryAgendaEncaixe.SQL.Add('  IdEmpCliente = :IdEmpCliente,');
      qryAgendaEncaixe.SQL.Add('  IdCliente = :IdCliente ');
      qryAgendaEncaixe.SQL.Add('Where IdAgendaEncaixe = :IdAgendaEncaixe');

      qryAgendaEncaixe.ParamByName('IdAgendaEncaixe').AsInteger := IdAgendaEncaixe;

    end;
    qryAgendaEncaixe.ParamByName('IdEmpresa').AsInteger := IdEmpresa;
    qryAgendaEncaixe.ParamByName('IdUsuario').AsInteger := IdUsuario;
    qryAgendaEncaixe.ParamByName('DtCadastro').AsDateTime := DtCadastro;
    qryAgendaEncaixe.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryAgendaEncaixe.ParamByName('IdAgenda').AsInteger := IdAgenda;
    qryAgendaEncaixe.ParamByName('IdTpServico').AsInteger := IdTpServico;
    qryAgendaEncaixe.ParamByName('IdEmpCliente').AsInteger := IdEmpCliente;
    qryAgendaEncaixe.ParamByName('IdCliente').AsInteger := IdCliente;
   try
      qryAgendaEncaixe.ExecSQL;
      qryAgendaEncaixe.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryAgendaEncaixe)
  end;
end;

class function TAgendaEncaixe.Inativar(ASQLConnection: TFDConnection; AIdAgendaEncaixe: Integer): Boolean;
var
  qryAgendaEncaixe: TFDQuery;
begin
  qryAgendaEncaixe:= TFDQuery.Create(Nil);
  try
    qryAgendaEncaixe.Connection := ASQLConnection;
    qryAgendaEncaixe.SQL.Add('Update AgendaEncaixe Set ');
    qryAgendaEncaixe.SQL.Add('  SnSituacao = 0 ');
    qryAgendaEncaixe.SQL.Add('Where 1 = 1');
    qryAgendaEncaixe.SQL.Add('  And IdAgendaEncaixe = ' + IntToStr(AIdAgendaEncaixe));
   try
      qryAgendaEncaixe.ExecSQL;
      qryAgendaEncaixe.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryAgendaEncaixe)
  end;
end;

class function TAgendaEncaixe.Existe(ASQLConnection: TFDConnection; AIdAgendaEncaixe: Integer): Boolean;
var
  qryAgendaEncaixe: TFDQuery;
begin
  Result := False;
  qryAgendaEncaixe:= TFDQuery.Create(Nil);
  try
    qryAgendaEncaixe.Connection := ASQLConnection;
    qryAgendaEncaixe.SQL.Add('Select IdAgendaEncaixe From AgendaEncaixe');
    qryAgendaEncaixe.SQL.Add('Where 1 = 1');
    qryAgendaEncaixe.SQL.Add('  And IdAgendaEncaixe = ' + IntToStr(AIdAgendaEncaixe));
    qryAgendaEncaixe.Open;
    if qryAgendaEncaixe.Fields[0].Value > 0 then
      Result := True;
    qryAgendaEncaixe.Close;
  finally
    FreeAndNil(qryAgendaEncaixe)
  end;
end;

class function TAgendaEncaixe.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryAgendaEncaixe: TFDQuery;
begin
  Result := 0;
  qryAgendaEncaixe:= TFDQuery.Create(Nil);
  try
    qryAgendaEncaixe.Connection := ASQLConnection;
    qryAgendaEncaixe.SQL.Add('Select Max(IdAgendaEncaixe) As IdAgendaEncaixe From AgendaEncaixe');
    qryAgendaEncaixe.Open;

    if qryAgendaEncaixe.FieldByName('IdAgendaEncaixe').AsInteger > 0 then
      Result := qryAgendaEncaixe.FieldByName('IdAgendaEncaixe').AsInteger;
    qryAgendaEncaixe.Close;
  finally
    FreeAndNil(qryAgendaEncaixe)
  end;
end;

function TAgendaEncaixe.Buscar(ASQLConnection: TFDConnection; AIdAgendaEncaixe: Integer): Boolean;
var
  qryAgendaEncaixe: TFDQuery;
begin
  Result := False;
  qryAgendaEncaixe:= TFDQuery.Create(Nil);
  try
    qryAgendaEncaixe.Connection := ASQLConnection;
    qryAgendaEncaixe.SQL.Add('Select * From AgendaEncaixe');
    qryAgendaEncaixe.SQL.Add('Where 1 = 1');
    if AIdAgendaEncaixe > 0 then
    begin
      qryAgendaEncaixe.SQL.Add('  And IdAgendaEncaixe = ' + IntToStr(AIdAgendaEncaixe));
    end;

    qryAgendaEncaixe.Open;
    if not qryAgendaEncaixe.IsEmpty then
    begin
      Result := True;
      IdAgendaEncaixe := qryAgendaEncaixe.FieldByName('IdAgendaEncaixe').AsInteger;
      IdEmpresa := qryAgendaEncaixe.FieldByName('IdEmpresa').AsInteger;
      IdUsuario := qryAgendaEncaixe.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryAgendaEncaixe.FieldByName('DtCadastro').AsDateTime;
      if qryAgendaEncaixe.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      IdAgenda := qryAgendaEncaixe.FieldByName('IdAgenda').AsInteger;
      IdTpServico := qryAgendaEncaixe.FieldByName('IdTpServico').AsInteger;
      IdEmpCliente := qryAgendaEncaixe.FieldByName('IdEmpCliente').AsInteger;
      IdCliente := qryAgendaEncaixe.FieldByName('IdCliente').AsInteger;
    end;
    qryAgendaEncaixe.Close;
  finally
    FreeAndNil(qryAgendaEncaixe)
  end;
end;

end.

