unit uAgenda;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TAgenda = class
  private
    FIdAgenda: Integer;
    FIdEmpresa: Integer;
    FIdUsuario: Integer;
    FDtCadastro: TDateTime;
    FSnSituacao: Integer;
    FIdProfissional: Integer;
    FIdServico: Integer;
    FIdCliente: Integer;
    FDtAgenda: TDateTime;
    procedure Inicializar;
  public
    property IdAgenda: Integer read FIdAgenda write FIdAgenda;
    property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property IdProfissional: Integer read FIdProfissional write FIdProfissional;
    property IdServico: Integer read FIdServico write FIdServico;
    property IdCliente: Integer read FIdCliente write FIdCliente;
    property DtAgenda: TDateTime read FDtAgenda write FDtAgenda;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdAgenda: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdAgenda: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdAgenda: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdAgenda: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TAgenda.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdAgenda: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryAgenda    : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryAgenda := TFDQuery.Create(nil);
  try
    qryAgenda.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdAgenda', ftInteger);
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 7, False);
      Data.FieldDefs.Add('IdProfissional', ftInteger);
      Data.FieldDefs.Add('IdServico', ftInteger);
      Data.FieldDefs.Add('IdCliente', ftInteger);
      Data.FieldDefs.Add('DtAgenda', ftDateTime);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryAgenda.Params.Clear;
      qryAgenda.SQL.Clear;
      qryAgenda.SQL.Add('Select');
      qryAgenda.SQL.Add('  IdAgenda,');
      qryAgenda.SQL.Add('  IdEmpresa,');
      qryAgenda.SQL.Add('  IdUsuario,');
      qryAgenda.SQL.Add('  DtCadastro,');
      qryAgenda.SQL.Add('  SnSituacao,');
      qryAgenda.SQL.Add('  IdProfissional,');
      qryAgenda.SQL.Add('  IdServico,');
      qryAgenda.SQL.Add('  IdCliente,');
      qryAgenda.SQL.Add('  DtAgenda');
      qryAgenda.SQL.Add('From Agenda');
      qryAgenda.SQL.Add('Where 1 = 1');
      if ISnSituacao = 1 then
      begin
         qryAgenda.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryAgenda.SQL.Add('  And SnSituacao = 0');
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
          qryAgenda.SQL.Add (lCondicao);
          qryAgenda.SQL.Add ('Order By');
          qryAgenda.SQL.Add ('  IdAgenda');

          qryAgenda.Open;
          qryAgenda.First;
        end;
      end else begin
        qryAgenda.SQL.Add (lCondicao);
        qryAgenda.SQL.Add ('Order By');
        qryAgenda.SQL.Add ('  IdAgenda');

        lFinalizaLoop := 1;
        qryAgenda.Open;
        qryAgenda.First;
      end;

      while not qryAgenda.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdAgenda').AsInteger = qryAgenda.FieldByName('IdAgenda').AsInteger then
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
          Data.FieldByName('IdAgenda').AsInteger := qryAgenda.FieldByName('IdAgenda').AsInteger;
          Data.FieldByName('IdEmpresa').AsInteger := qryAgenda.FieldByName('IdEmpresa').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryAgenda.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryAgenda.FieldByName('DtCadastro').AsDateTime;
          if qryAgenda.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString  := 'Ativo';
          end else begin
            Data.FieldByName('SnSituacao').AsString  := 'Desativado';
          end;
          Data.FieldByName('IdProfissional').AsInteger := qryAgenda.FieldByName('IdProfissional').AsInteger;
          Data.FieldByName('IdServico').AsInteger := qryAgenda.FieldByName('IdServico').AsInteger;
          Data.FieldByName('IdCliente').AsInteger := qryAgenda.FieldByName('IdCliente').AsInteger;
          Data.FieldByName('DtAgenda').AsDateTime := qryAgenda.FieldByName('DtAgenda').AsDateTime;
          Data.Post;
        end;

        lVerificacao := 0;
        qryAgenda.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryAgenda.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TAgenda.Create;
begin
  Inicializar;
end;

procedure TAgenda.Inicializar;
begin
  IdAgenda := 0;
  IdEmpresa := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  IdProfissional := 0;
  IdServico := 0;
  IdCliente := 0;
  DtAgenda := 0;
end;

function TAgenda.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryAgenda: TFDQuery;
begin
  qryAgenda:= TFDQuery.Create(Nil);
  try
    qryAgenda.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdAgenda) then
    begin
      qryAgenda.SQL.Add('Insert Into Agenda(');
      qryAgenda.SQL.Add('  IdEmpresa,');
      qryAgenda.SQL.Add('  IdUsuario,');
      qryAgenda.SQL.Add('  DtCadastro,');
      qryAgenda.SQL.Add('  SnSituacao,');
      qryAgenda.SQL.Add('  IdProfissional,');
      qryAgenda.SQL.Add('  IdServico,');
      qryAgenda.SQL.Add('  IdCliente,');
      qryAgenda.SQL.Add('  DtAgenda)');
      qryAgenda.SQL.Add('Values (');
      qryAgenda.SQL.Add('  :IdEmpresa,');
      qryAgenda.SQL.Add('  :IdUsuario,');
      qryAgenda.SQL.Add('  :DtCadastro,');
      qryAgenda.SQL.Add('  :SnSituacao,');
      qryAgenda.SQL.Add('  :IdProfissional,');
      qryAgenda.SQL.Add('  :IdServico,');
      qryAgenda.SQL.Add('  :IdCliente,');
      qryAgenda.SQL.Add('  :DtAgenda)');
    end else begin
      qryAgenda.SQL.Add('Update Agenda Set ');
      qryAgenda.SQL.Add('  IdEmpresa = :IdEmpresa,');
      qryAgenda.SQL.Add('  IdUsuario = :IdUsuario,');
      qryAgenda.SQL.Add('  DtCadastro = :DtCadastro,');
      qryAgenda.SQL.Add('  SnSituacao = :SnSituacao,');
      qryAgenda.SQL.Add('  IdProfissional = :IdProfissional,');
      qryAgenda.SQL.Add('  IdServico = :IdServico,');
      qryAgenda.SQL.Add('  IdCliente = :IdCliente,');
      qryAgenda.SQL.Add('  DtAgenda = :DtAgenda ');
      qryAgenda.SQL.Add('Where IdAgenda = :IdAgenda');

      qryAgenda.ParamByName('IdAgenda').AsInteger := IdAgenda;

    end;
    qryAgenda.ParamByName('IdEmpresa').AsInteger := IdEmpresa;
    qryAgenda.ParamByName('IdUsuario').AsInteger := IdUsuario;
    qryAgenda.ParamByName('DtCadastro').AsDateTime := DtCadastro;
    qryAgenda.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryAgenda.ParamByName('IdProfissional').AsInteger := IdProfissional;
    qryAgenda.ParamByName('IdServico').AsInteger := IdServico;
    qryAgenda.ParamByName('IdCliente').AsInteger := IdCliente;
    qryAgenda.ParamByName('DtAgenda').AsDateTime := DtAgenda;
   try
      qryAgenda.ExecSQL;
      qryAgenda.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryAgenda)
  end;
end;

class function TAgenda.Inativar(ASQLConnection: TFDConnection; AIdAgenda: Integer): Boolean;
var
  qryAgenda: TFDQuery;
begin
  qryAgenda:= TFDQuery.Create(Nil);
  try
    qryAgenda.Connection := ASQLConnection;
    qryAgenda.SQL.Add('Update Agenda Set ');
    qryAgenda.SQL.Add('  SnSituacao = 0 ');
    qryAgenda.SQL.Add('Where 1 = 1');
    qryAgenda.SQL.Add('  And IdAgenda = ' + IntToStr(AIdAgenda));
   try
      qryAgenda.ExecSQL;
      qryAgenda.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryAgenda)
  end;
end;

class function TAgenda.Existe(ASQLConnection: TFDConnection; AIdAgenda: Integer): Boolean;
var
  qryAgenda: TFDQuery;
begin
  Result := False;
  qryAgenda:= TFDQuery.Create(Nil);
  try
    qryAgenda.Connection := ASQLConnection;
    qryAgenda.SQL.Add('Select IdAgenda From Agenda');
    qryAgenda.SQL.Add('Where 1 = 1');
    qryAgenda.SQL.Add('  And IdAgenda = ' + IntToStr(AIdAgenda));
    qryAgenda.Open;
    if qryAgenda.Fields[0].Value > 0 then
      Result := True;
    qryAgenda.Close;
  finally
    FreeAndNil(qryAgenda)
  end;
end;

class function TAgenda.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryAgenda: TFDQuery;
begin
  Result := 0;
  qryAgenda:= TFDQuery.Create(Nil);
  try
    qryAgenda.Connection := ASQLConnection;
    qryAgenda.SQL.Add('Select Max(IdAgenda) As IdAgenda From Agenda');
    qryAgenda.Open;

    if qryAgenda.FieldByName('IdAgenda').AsInteger > 0 then
      Result := qryAgenda.FieldByName('IdAgenda').AsInteger;
    qryAgenda.Close;
  finally
    FreeAndNil(qryAgenda)
  end;
end;

function TAgenda.Buscar(ASQLConnection: TFDConnection; AIdAgenda: Integer): Boolean;
var
  qryAgenda: TFDQuery;
begin
  Result := False;
  qryAgenda:= TFDQuery.Create(Nil);
  try
    qryAgenda.Connection := ASQLConnection;
    qryAgenda.SQL.Add('Select * From Agenda');
    qryAgenda.SQL.Add('Where 1 = 1');

    if AIdAgenda > 0 then
    begin
      qryAgenda.SQL.Add('  And IdAgenda = ' + IntToStr(AIdAgenda));
    end;

    qryAgenda.Open;
    if not qryAgenda.IsEmpty then
    begin
      Result := True;
      IdAgenda := qryAgenda.FieldByName('IdAgenda').AsInteger;
      IdEmpresa := qryAgenda.FieldByName('IdEmpresa').AsInteger;
      IdUsuario := qryAgenda.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryAgenda.FieldByName('DtCadastro').AsDateTime;
      if qryAgenda.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      IdProfissional := qryAgenda.FieldByName('IdProfissional').AsInteger;
      IdServico := qryAgenda.FieldByName('IdServico').AsInteger;
      IdCliente := qryAgenda.FieldByName('IdCliente').AsInteger;
      DtAgenda := qryAgenda.FieldByName('DtAgenda').AsDateTime;
    end;
    qryAgenda.Close;
  finally
    FreeAndNil(qryAgenda)
  end;
end;

end.

