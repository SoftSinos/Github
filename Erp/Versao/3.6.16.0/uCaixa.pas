unit uCaixa;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TCaixa = class
  private
    FIdCaixa: Integer;
    FIdEmpresa: Integer;
    FIdUsuario: Integer;
    FDtCadastro: TDateTime;
    FSnSituacao: Integer;
    FDtAbertura: TDateTime;
    FDtFechamento: TDateTime;
    procedure Inicializar;
  public
    property IdCaixa: Integer read FIdCaixa write FIdCaixa;
    property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property DtAbertura: TDateTime read FDtAbertura write FDtAbertura;
    property DtFechamento: TDateTime read FDtFechamento write FDtFechamento;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdCaixa: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdCaixa: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdCaixa: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdCaixa: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TCaixa.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdCaixa: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryCaixa : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryCaixa := TFDQuery.Create(nil);
  try
    qryCaixa.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdCaixa', ftInteger);
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 7, False);
      Data.FieldDefs.Add('DtAbertura', ftDateTime);
      Data.FieldDefs.Add('DtFechamento', ftDateTime);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryCaixa.Params.Clear;
      qryCaixa.SQL.Clear;
      qryCaixa.SQL.Add('Select');
      qryCaixa.SQL.Add('  IdCaixa,');
      qryCaixa.SQL.Add('  IdEmpresa,');
      qryCaixa.SQL.Add('  IdUsuario,');
      qryCaixa.SQL.Add('  DtCadastro,');
      qryCaixa.SQL.Add('  SnSituacao,');
      qryCaixa.SQL.Add('  DtAbertura,');
      qryCaixa.SQL.Add('  DtFechamento');
      qryCaixa.SQL.Add('From Caixa');
      qryCaixa.SQL.Add('Where 1 = 1');
      if ISnSituacao = 1 then
      begin
         qryCaixa.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryCaixa.SQL.Add('  And SnSituacao = 0');
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
          qryCaixa.SQL.Add (lCondicao);
          qryCaixa.SQL.Add ('Order By');
          qryCaixa.SQL.Add ('  IdCaixa');

          qryCaixa.Open;
          qryCaixa.First;
        end;
      end else begin
        qryCaixa.SQL.Add (lCondicao);
        qryCaixa.SQL.Add ('Order By');
        qryCaixa.SQL.Add ('  IdCaixa');

        lFinalizaLoop := 1;
        qryCaixa.Open;
        qryCaixa.First;
      end;

      while not qryCaixa.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdCaixa').AsInteger = qryCaixa.FieldByName('IdCaixa').AsInteger then
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
          Data.FieldByName('IdCaixa').AsInteger := qryCaixa.FieldByName('IdCaixa').AsInteger;
          Data.FieldByName('IdEmpresa').AsInteger := qryCaixa.FieldByName('IdEmpresa').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryCaixa.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryCaixa.FieldByName('DtCadastro').AsDateTime;
          if qryCaixa.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString  := 'Ativo';
          end else begin
            Data.FieldByName('SnSituacao').AsString  := 'Desativado';
          end;
          Data.FieldByName('DtAbertura').AsDateTime := qryCaixa.FieldByName('DtAbertura').AsDateTime;
          Data.FieldByName('DtFechamento').AsDateTime := qryCaixa.FieldByName('DtFechamento').AsDateTime;
          Data.Post;
        end;

        lVerificacao := 0;
        qryCaixa.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryCaixa.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TCaixa.Create;
begin
  Inicializar;
end;

procedure TCaixa.Inicializar;
begin
  IdCaixa := 0;
  IdEmpresa := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  DtAbertura := 0;
  DtFechamento := 0;
end;

function TCaixa.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryCaixa: TFDQuery;
begin
  qryCaixa:= TFDQuery.Create(Nil);
  try
    qryCaixa.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdCaixa) then
    begin
      qryCaixa.SQL.Add('Insert Into Caixa(');
      qryCaixa.SQL.Add('  IdEmpresa,');
      qryCaixa.SQL.Add('  IdUsuario,');
      qryCaixa.SQL.Add('  DtCadastro,');
      qryCaixa.SQL.Add('  SnSituacao,');
      qryCaixa.SQL.Add('  DtAbertura,');
      qryCaixa.SQL.Add('  DtFechamento)');
      qryCaixa.SQL.Add('Values (');
      qryCaixa.SQL.Add('  :IdEmpresa,');
      qryCaixa.SQL.Add('  :IdUsuario,');
      qryCaixa.SQL.Add('  :DtCadastro,');
      qryCaixa.SQL.Add('  :SnSituacao,');
      qryCaixa.SQL.Add('  :DtAbertura,');
      qryCaixa.SQL.Add('  :DtFechamento)');
    end else begin
      qryCaixa.SQL.Add('Update Caixa Set ');
      qryCaixa.SQL.Add('  IdEmpresa = :IdEmpresa,');
      qryCaixa.SQL.Add('  IdUsuario = :IdUsuario,');
      qryCaixa.SQL.Add('  DtCadastro = :DtCadastro,');
      qryCaixa.SQL.Add('  SnSituacao = :SnSituacao,');
      qryCaixa.SQL.Add('  DtAbertura = :DtAbertura,');
      qryCaixa.SQL.Add('  DtFechamento = :DtFechamento ');
      qryCaixa.SQL.Add('Where IdCaixa = :IdCaixa');

      qryCaixa.ParamByName('IdCaixa').AsInteger := IdCaixa;

    end;
    qryCaixa.ParamByName('IdEmpresa').AsInteger := IdEmpresa;
    qryCaixa.ParamByName('IdUsuario').AsInteger := IdUsuario;
    qryCaixa.ParamByName('DtCadastro').AsDateTime := DtCadastro;
    qryCaixa.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryCaixa.ParamByName('DtAbertura').AsDateTime := DtAbertura;
    qryCaixa.ParamByName('DtFechamento').AsDateTime := DtFechamento;
   try
      qryCaixa.ExecSQL;
      qryCaixa.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryCaixa)
  end;
end;

class function TCaixa.Inativar(ASQLConnection: TFDConnection; AIdCaixa: Integer): Boolean;
var
  qryCaixa: TFDQuery;
begin
  qryCaixa:= TFDQuery.Create(Nil);
  try
    qryCaixa.Connection := ASQLConnection;
    qryCaixa.SQL.Add('Update Caixa Set ');
    qryCaixa.SQL.Add('  SnSituacao = 0 ');
    qryCaixa.SQL.Add('Where 1 = 1');
    qryCaixa.SQL.Add('  And IdCaixa = ' + IntToStr(AIdCaixa));
   try
      qryCaixa.ExecSQL;
      qryCaixa.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryCaixa)
  end;
end;

class function TCaixa.Existe(ASQLConnection: TFDConnection; AIdCaixa: Integer): Boolean;
var
  qryCaixa: TFDQuery;
begin
  Result := False;
  qryCaixa:= TFDQuery.Create(Nil);
  try
    qryCaixa.Connection := ASQLConnection;
    qryCaixa.SQL.Add('Select IdCaixa From Caixa');
    qryCaixa.SQL.Add('Where 1 = 1');
    qryCaixa.SQL.Add('  And IdCaixa = ' + IntToStr(AIdCaixa));
    qryCaixa.Open;
    if qryCaixa.Fields[0].Value > 0 then
      Result := True;
    qryCaixa.Close;
  finally
    FreeAndNil(qryCaixa)
  end;
end;

class function TCaixa.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryCaixa: TFDQuery;
begin
  Result := 0;
  qryCaixa:= TFDQuery.Create(Nil);
  try
    qryCaixa.Connection := ASQLConnection;
    qryCaixa.SQL.Add('Select Max(IdCaixa) As IdCaixa From Caixa');
    qryCaixa.Open;

    if qryCaixa.FieldByName('IdCaixa').AsInteger > 0 then
      Result := qryCaixa.FieldByName('IdCaixa').AsInteger;
    qryCaixa.Close;
  finally
    FreeAndNil(qryCaixa)
  end;
end;

function TCaixa.Buscar(ASQLConnection: TFDConnection; AIdCaixa: Integer): Boolean;
var
  qryCaixa: TFDQuery;
begin
  Result := False;
  qryCaixa:= TFDQuery.Create(Nil);
  try
    qryCaixa.Connection := ASQLConnection;
    qryCaixa.SQL.Add('Select * From Caixa');
    qryCaixa.SQL.Add('Where 1 = 1');
    if AIdCaixa > 0 then
    begin
      qryCaixa.SQL.Add('  And IdCaixa = ' + IntToStr(AIdCaixa));
    end;

    qryCaixa.Open;
    if not qryCaixa.IsEmpty then
    begin
      Result := True;
      IdCaixa := qryCaixa.FieldByName('IdCaixa').AsInteger;
      IdEmpresa := qryCaixa.FieldByName('IdEmpresa').AsInteger;
      IdUsuario := qryCaixa.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryCaixa.FieldByName('DtCadastro').AsDateTime;
      if qryCaixa.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      DtAbertura := qryCaixa.FieldByName('DtAbertura').AsDateTime;
      DtFechamento := qryCaixa.FieldByName('DtFechamento').AsDateTime;
    end;
    qryCaixa.Close;
  finally
    FreeAndNil(qryCaixa)
  end;
end;

end.

