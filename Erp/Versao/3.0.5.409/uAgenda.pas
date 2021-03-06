unit uAgenda;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TAgenda = class
  private
    FIdAgenda           : Integer;
    FIdEmpresa          : Integer;
    FIdUsuario          : Integer;
    FDtCadastro         : TDateTime;
    FSnSituacao         : Integer;
    FDtAgenda           : TDateTime;
    FHrAgenda           : String;
    FSnRealizada        : Integer;
    FIdEmpProfissional  : Integer;
    FIdProfissional     : Integer;
    FIdTpServico        : Integer;
    FIdEmpCliente       : Integer;
    FIdCliente          : Integer;
    FNmProfissional     : String;
    FNmCliente          : String;
    FNmTpServico        : String;
    FNmUsuarioCadastro  : String;
    procedure Inicializar;
  public
    property IdAgenda           : Integer   read FIdAgenda          write FIdAgenda;
    property IdEmpresa          : Integer   read FIdEmpresa         write FIdEmpresa;
    property IdUsuario          : Integer   read FIdUsuario         write FIdUsuario;
    property DtCadastro         : TDateTime read FDtCadastro        write FDtCadastro;
    property SnSituacao         : Integer   read FSnSituacao        write FSnSituacao;
    property DtAgenda           : TDateTime read FDtAgenda          write FDtAgenda;
    property HrAgenda           : String    read FHrAgenda          write FHrAgenda;
    property SnRealizada        : Integer   read FSnRealizada       write FSnRealizada;
    property IdEmpProfissional  : Integer   read FIdEmpProfissional write FIdEmpProfissional;
    property IdProfissional     : Integer   read FIdProfissional    write FIdProfissional;
    property IdTpServico        : Integer   read FIdTpServico       write FIdTpServico;
    property IdEmpCliente       : Integer   read FIdEmpCliente      write FIdEmpCliente;
    property IdCliente          : Integer   read FIdCliente         write FIdCliente;
    property NmProfissional     : String    read FNmProfissional    write FNmProfissional;
    property NmCliente          : String    read FNmCliente         write FNmCliente;
    property NmTpServico        : String    read FNmTpServico       write FNmTpServico;
    property NmUsuarioCadastro  : String    read FNmUsuarioCadastro write FNmUsuarioCadastro;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdAgenda: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdAgenda: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdAgenda: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdAgenda: Integer; AIdEmpProfissional: Integer; AIdProfissional: Integer; ADtAgenda: TDate; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TAgenda.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdAgenda: Integer; AIdEmpProfissional: Integer; AIdProfissional: Integer; ADtAgenda: TDate; AConsulta: String; Data: TClientDataSet);
var
  qryAgenda : TFDQuery;
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
      Data.FieldDefs.Add('SnSelecao', ftBoolean);
      Data.FieldDefs.Add('IdAgenda', ftInteger);
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 9, False);
      Data.FieldDefs.Add('DtAgenda', ftDateTime);
      Data.FieldDefs.Add('HrAgenda', ftTime);
      Data.FieldDefs.Add('SnRealizada', ftString, 10, False);
      Data.FieldDefs.Add('IdEmpProfissional', ftInteger);
      Data.FieldDefs.Add('IdProfissional', ftInteger);
      Data.FieldDefs.Add('IdTpServico', ftInteger);
      Data.FieldDefs.Add('IdEmpCliente', ftInteger);
      Data.FieldDefs.Add('IdCliente', ftInteger);
      Data.FieldDefs.Add('NmProfissional', ftString, 255, False);
      Data.FieldDefs.Add('NmCliente', ftString, 255, False);
      Data.FieldDefs.Add('NmTpServico', ftString, 255, False);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 255, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryAgenda.Params.Clear;
      qryAgenda.SQL.Clear;
      qryAgenda.SQL.Add('Select            ');
      qryAgenda.SQL.Add('  *               ');
      qryAgenda.SQL.Add('From VW_GridAgenda');
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

      if AIdAgenda > 0 then
      begin
        qryAgenda.SQL.Add('  And IdAgenda = :IdAgenda');

        qryAgenda.ParamByName('IdAgenda').AsInteger := AIdAgenda;
      end;

      if AIdProfissional > 0 then
      begin
        qryAgenda.SQL.Add('  And IdEmpProfissional = :IdEmpProfissional');
        qryAgenda.SQL.Add('  And IdProfissional = :IdProfissional');

        qryAgenda.ParamByName('IdEmpProfissional').AsInteger := AIdEmpProfissional;
        qryAgenda.ParamByName('IdProfissional').AsInteger    := AIdProfissional;
      end;

      if ADtAgenda > 0 then
      begin
        qryAgenda.SQL.Add('  And DtAgenda = :DtAgenda');

        qryAgenda.ParamByName('DtAgenda').AsDate := ADtAgenda;
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
          Data.FieldByName('IdAgenda').AsInteger          := qryAgenda.FieldByName('IdAgenda').AsInteger;
          Data.FieldByName('IdEmpresa').AsInteger         := qryAgenda.FieldByName('IdEmpresa').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger         := qryAgenda.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime       := qryAgenda.FieldByName('DtCadastro').AsDateTime;
          if qryAgenda.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'Ativo';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'Desativado';
          end;
          Data.FieldByName('DtAgenda').AsDateTime         := qryAgenda.FieldByName('DtAgenda').AsDateTime;
          Data.FieldByName('HrAgenda').AsDateTime         := qryAgenda.FieldByName('HrAgenda').AsDateTime;
          if qryAgenda.FieldByName('SnRealizada').AsBoolean then
          begin
            Data.FieldByName('SnRealizada').AsString      := 'AGENDADA';
          end else begin
            Data.FieldByName('SnRealizada').AsString      := 'DISPONÍVEL';
          end;
          Data.FieldByName('IdEmpProfissional').AsInteger := qryAgenda.FieldByName('IdEmpProfissional').AsInteger;
          Data.FieldByName('IdProfissional').AsInteger    := qryAgenda.FieldByName('IdProfissional').AsInteger;
          Data.FieldByName('IdTpServico').AsInteger       := qryAgenda.FieldByName('IdTpServico').AsInteger;
          Data.FieldByName('IdEmpCliente').AsInteger      := qryAgenda.FieldByName('IdEmpCliente').AsInteger;
          Data.FieldByName('IdCliente').AsInteger         := qryAgenda.FieldByName('IdCliente').AsInteger;
          Data.FieldByName('NmProfissional').AsString     := qryAgenda.FieldByName('NmProfissional').AsString;
          Data.FieldByName('NmCliente').AsString          := qryAgenda.FieldByName('NmCliente').AsString;
          Data.FieldByName('NmTpServico').AsString        := qryAgenda.FieldByName('NmTpServico').AsString;
          Data.FieldByName('NmUsuarioCadastro').AsString  := qryAgenda.FieldByName('NmUsuarioCadastro').AsString;
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
  DtAgenda := 0;
  HrAgenda  := '';
  SnRealizada := 0;
  IdEmpProfissional := 0;
  IdProfissional := 0;
  IdTpServico := 0;
  IdEmpCliente := 0;
  IdCliente := 0;
  NmProfissional := '';
  NmCliente := '';
  NmTpServico := '';
  NmUsuarioCadastro := '';
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
      qryAgenda.SQL.Add('  DtAgenda,');
      qryAgenda.SQL.Add('  HrAgenda,');
      qryAgenda.SQL.Add('  SnRealizada,');
      qryAgenda.SQL.Add('  IdEmpProfissional,');
      qryAgenda.SQL.Add('  IdProfissional,');
      qryAgenda.SQL.Add('  IdTpServico,');
      qryAgenda.SQL.Add('  IdEmpCliente,');
      qryAgenda.SQL.Add('  IdCliente)');
      qryAgenda.SQL.Add('Values (');
      qryAgenda.SQL.Add('  :IdEmpresa,');
      qryAgenda.SQL.Add('  :IdUsuario,');
      qryAgenda.SQL.Add('  :DtCadastro,');
      qryAgenda.SQL.Add('  :SnSituacao,');
      qryAgenda.SQL.Add('  :DtAgenda,');
      qryAgenda.SQL.Add('  :HrAgenda,');
      qryAgenda.SQL.Add('  :SnRealizada,');
      qryAgenda.SQL.Add('  :IdEmpProfissional,');
      qryAgenda.SQL.Add('  :IdProfissional,');
      qryAgenda.SQL.Add('  :IdTpServico,');
      qryAgenda.SQL.Add('  :IdEmpCliente,');
      qryAgenda.SQL.Add('  :IdCliente)');
    end else begin
      qryAgenda.SQL.Add('Update Agenda Set ');
      qryAgenda.SQL.Add('  IdEmpresa = :IdEmpresa,');
      qryAgenda.SQL.Add('  IdUsuario = :IdUsuario,');
      qryAgenda.SQL.Add('  DtCadastro = :DtCadastro,');
      qryAgenda.SQL.Add('  SnSituacao = :SnSituacao,');
      qryAgenda.SQL.Add('  DtAgenda = :DtAgenda,');
      qryAgenda.SQL.Add('  HrAgenda = :HrAgenda,');
      qryAgenda.SQL.Add('  SnRealizada = :SnRealizada,');
      qryAgenda.SQL.Add('  IdEmpProfissional = :IdEmpProfissional,');
      qryAgenda.SQL.Add('  IdProfissional = :IdProfissional,');
      qryAgenda.SQL.Add('  IdTpServico = :IdTpServico,');
      qryAgenda.SQL.Add('  IdEmpCliente = :IdEmpCliente,');
      qryAgenda.SQL.Add('  IdCliente = :IdCliente ');
      qryAgenda.SQL.Add('Where IdAgenda = :IdAgenda');

      qryAgenda.ParamByName('IdAgenda').AsInteger := IdAgenda;

    end;
    qryAgenda.ParamByName('IdEmpresa').AsInteger := IdEmpresa;
    qryAgenda.ParamByName('IdUsuario').AsInteger := IdUsuario;
    qryAgenda.ParamByName('DtCadastro').AsDateTime := DtCadastro;
    qryAgenda.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryAgenda.ParamByName('DtAgenda').AsDateTime := DtAgenda;
    qryAgenda.ParamByName('HrAgenda').AsString := HrAgenda;
    qryAgenda.ParamByName('SnRealizada').AsInteger := SnRealizada;
    qryAgenda.ParamByName('IdEmpProfissional').AsInteger := IdEmpProfissional;
    qryAgenda.ParamByName('IdProfissional').AsInteger := IdProfissional;
    qryAgenda.ParamByName('IdTpServico').AsInteger := IdTpServico;
    qryAgenda.ParamByName('IdEmpCliente').AsInteger := IdEmpCliente;
    qryAgenda.ParamByName('IdCliente').AsInteger := IdCliente;
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
      DtAgenda := qryAgenda.FieldByName('DtAgenda').AsDateTime;
      HrAgenda := qryAgenda.FieldByName('HrAgenda').AsString;
      if qryAgenda.FieldByName('SnRealizada').AsBoolean then
      begin
        SnRealizada := 1
      end else begin
        SnRealizada := 0
      end;
      IdEmpProfissional := qryAgenda.FieldByName('IdEmpProfissional').AsInteger;
      IdProfissional := qryAgenda.FieldByName('IdProfissional').AsInteger;
      IdTpServico := qryAgenda.FieldByName('IdTpServico').AsInteger;
      IdEmpCliente := qryAgenda.FieldByName('IdEmpCliente').AsInteger;
      IdCliente := qryAgenda.FieldByName('IdCliente').AsInteger;
      NmProfissional := qryAgenda.FieldByName('NmProfissional').AsString;
      NmCliente := qryAgenda.FieldByName('NmCliente').AsString;
      NmTpServico := qryAgenda.FieldByName('NmTpServico').AsString;
      NmUsuarioCadastro := qryAgenda.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryAgenda.Close;
  finally
    FreeAndNil(qryAgenda)
  end;
end;

end.

