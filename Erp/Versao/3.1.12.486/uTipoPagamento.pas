unit uTipoPagamento;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TTipoPagamento = class
  private
    FIdTpPagamento: Integer;
    FIdUsuario: Integer;
    FDtCadastro: TDateTime;
    FSnSituacao: Integer;
    FNmTpPagamento: String;
    FNmUsuarioCadastro: String;
  public
    property IdTpPagamento: Integer read FIdTpPagamento write FIdTpPagamento;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property NmTpPagamento: String read FNmTpPagamento write FNmTpPagamento;
    property NmUsuarioCadastro: String read FNmUsuarioCadastro write FNmUsuarioCadastro;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdTpPagamento: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdTpPagamento: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdTpPagamento: Integer): Boolean;
    function BuscarNmTpPagamento(ASQLConnection: TFDConnection; ANmTpPagamento: String): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdTpPagamento: Integer; AConsulta: String; Data: TClientDataSet);
    procedure Inicializar;
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TTipoPagamento.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdTpPagamento: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryTipoPagamento : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryTipoPagamento := TFDQuery.Create(nil);
  try
    qryTipoPagamento.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdTpPagamento', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 9, False);
      Data.FieldDefs.Add('NmTpPagamento', ftString, 255, False);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 255, False);
     Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryTipoPagamento.Params.Clear;
      qryTipoPagamento.SQL.Clear;
      qryTipoPagamento.SQL.Add('Select');
      qryTipoPagamento.SQL.Add('  *');
      qryTipoPagamento.SQL.Add('From VW_GridTipoPagamento');
      qryTipoPagamento.SQL.Add('Where 1 = 1');

      if ISnSituacao = 1 then
      begin
         qryTipoPagamento.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryTipoPagamento.SQL.Add('  And SnSituacao = 0');
      end;

      if AIdTpPagamento > 0 then
      begin
        qryTipoPagamento.SQL.Add('  And IdTpPagamento = :IdTpPagamento');

        qryTipoPagamento.ParamByName('IdTpPagamento').AsInteger := AIdTpPagamento
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
          qryTipoPagamento.SQL.Add (lCondicao);
          qryTipoPagamento.SQL.Add ('Order By');
          qryTipoPagamento.SQL.Add (' IdTpPagamento');

          qryTipoPagamento.Open;
          qryTipoPagamento.First;
        end;
      end else begin
        qryTipoPagamento.SQL.Add (lCondicao);
        qryTipoPagamento.SQL.Add ('Order By');
        qryTipoPagamento.SQL.Add (' IdTpPagamento');

        lFinalizaLoop := 1;
        qryTipoPagamento.Open;
        qryTipoPagamento.First;
      end;

      while not qryTipoPagamento.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdTpPagamento').AsInteger = qryTipoPagamento.FieldByName('IdTpPagamento').AsInteger then
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
          Data.FieldByName('IdTpPagamento').AsInteger := qryTipoPagamento.FieldByName('IdTpPagamento').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryTipoPagamento.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryTipoPagamento.FieldByName('DtCadastro').AsDateTime;
          if qryTipoPagamento.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString  := 'Ativo';
          end else begin
            Data.FieldByName('SnSituacao').AsString  := 'Inativo';
          end;
          Data.FieldByName('NmTpPagamento').AsString := qryTipoPagamento.FieldByName('NmTpPagamento').AsString;
          Data.FieldByName('NmUsuarioCadastro').AsString := qryTipoPagamento.FieldByName('NmUsuarioCadastro').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryTipoPagamento.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryTipoPagamento.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TTipoPagamento.Create;
begin
  Inicializar;
end;

procedure TTipoPagamento.Inicializar;
begin
  IdTpPagamento := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  NmTpPagamento := '';
  NmUsuarioCadastro := '';
end;

function TTipoPagamento.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryTipoPagamento: TFDQuery;
begin
  qryTipoPagamento:= TFDQuery.Create(Nil);
  try
    qryTipoPagamento.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdTpPagamento) then
    begin
      qryTipoPagamento.SQL.Add('Insert Into TipoPagamento(  ');
      qryTipoPagamento.SQL.Add('  IdUsuario,                ');
      qryTipoPagamento.SQL.Add('  DtCadastro,               ');
      qryTipoPagamento.SQL.Add('  SnSituacao,               ');
      qryTipoPagamento.SQL.Add('  NmTpPagamento)            ');
      qryTipoPagamento.SQL.Add('Values (                    ');
      qryTipoPagamento.SQL.Add('  :IdUsuario,               ');
      qryTipoPagamento.SQL.Add('  :DtCadastro,              ');
      qryTipoPagamento.SQL.Add('  :SnSituacao,              ');
      qryTipoPagamento.SQL.Add('  :NmTpPagamento)           ');

      qryTipoPagamento.ParamByName('IdUsuario')     .AsInteger  := IdUsuario;
      qryTipoPagamento.ParamByName('DtCadastro')    .AsDateTime := DtCadastro;
      qryTipoPagamento.ParamByName('NmTpPagamento') .AsString   := NmTpPagamento;

    end else begin
      qryTipoPagamento.SQL.Add('Update TipoPagamento Set            ');
      qryTipoPagamento.SQL.Add('  SnSituacao = :SnSituacao          ');
      qryTipoPagamento.SQL.Add('Where IdTpPagamento = :IdTpPagamento');

      qryTipoPagamento.ParamByName('IdTpPagamento') .AsInteger  := IdTpPagamento;

    end;
    qryTipoPagamento.ParamByName('SnSituacao')      .AsInteger  := SnSituacao;
   try
      qryTipoPagamento.ExecSQL;
      qryTipoPagamento.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryTipoPagamento)
  end;
end;

class function TTipoPagamento.Inativar(ASQLConnection: TFDConnection; AIdTpPagamento: Integer): Boolean;
var
  qryTipoPagamento: TFDQuery;
begin
  qryTipoPagamento:= TFDQuery.Create(Nil);
  try
    qryTipoPagamento.Connection := ASQLConnection;
    qryTipoPagamento.SQL.Add('Update TipoPagamento Set                          ');
    qryTipoPagamento.SQL.Add('  SnSituacao = 0                                  ');
    qryTipoPagamento.SQL.Add('Where 1 = 1                                       ');
    qryTipoPagamento.SQL.Add('  And IdTpPagamento = ' + IntToStr(AIdTpPagamento) );
   try
      qryTipoPagamento.ExecSQL;
      qryTipoPagamento.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryTipoPagamento)
  end;
end;

class function TTipoPagamento.Existe(ASQLConnection: TFDConnection; AIdTpPagamento: Integer): Boolean;
var
  qryTipoPagamento: TFDQuery;
begin
  Result := False;
  qryTipoPagamento:= TFDQuery.Create(Nil);
  try
    qryTipoPagamento.Connection := ASQLConnection;
    qryTipoPagamento.SQL.Add('Select IdTpPagamento From TipoPagamento');
    qryTipoPagamento.SQL.Add('Where 1 = 1');
    qryTipoPagamento.SQL.Add('  And IdTpPagamento = ' + IntToStr(AIdTpPagamento));
    qryTipoPagamento.Open;
    if qryTipoPagamento.Fields[0].Value > 0 then
      Result := True;
    qryTipoPagamento.Close;
  finally
    FreeAndNil(qryTipoPagamento)
  end;
end;

class function TTipoPagamento.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryTipoPagamento: TFDQuery;
begin
  Result := 0;
  qryTipoPagamento:= TFDQuery.Create(Nil);
  try
    qryTipoPagamento.Connection := ASQLConnection;
    qryTipoPagamento.SQL.Add('Select Max(IdTpPagamento) As IdTpPagamento From TipoPagamento');
    qryTipoPagamento.Open;

    if qryTipoPagamento.FieldByName('IdTpPagamento').AsInteger > 0 then
      Result := qryTipoPagamento.FieldByName('IdTpPagamento').AsInteger;
    qryTipoPagamento.Close;
  finally
    FreeAndNil(qryTipoPagamento)
  end;
end;

function TTipoPagamento.Buscar(ASQLConnection: TFDConnection; AIdTpPagamento: Integer): Boolean;
var
  qryTipoPagamento: TFDQuery;
begin
  Result := False;
  qryTipoPagamento:= TFDQuery.Create(Nil);
  try
    qryTipoPagamento.Connection := ASQLConnection;
    qryTipoPagamento.SQL.Add('Select * From VW_GridTipoPagamento');
    qryTipoPagamento.SQL.Add('Where IdTpPagamento = :IdTpPagamento');

    qryTipoPagamento.ParamByName('IdTpPagamento').AsString := IntToStr(AIdTpPagamento);

    qryTipoPagamento.Open;
    if not qryTipoPagamento.IsEmpty then
    begin
      Result := True;
      IdTpPagamento := qryTipoPagamento.FieldByName('IdTpPagamento').AsInteger;
      IdUsuario := qryTipoPagamento.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryTipoPagamento.FieldByName('DtCadastro').AsDateTime;
      if qryTipoPagamento.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      NmTpPagamento := qryTipoPagamento.FieldByName('NmTpPagamento').AsString;
      NmUsuarioCadastro := qryTipoPagamento.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryTipoPagamento.Close;
  finally
    FreeAndNil(qryTipoPagamento)
  end;
end;

function TTipoPagamento.BuscarNmTpPagamento(ASQLConnection: TFDConnection; ANmTpPagamento: String): Boolean;
var
  qryTipoPagamento: TFDQuery;
begin
  Result := False;
  qryTipoPagamento:= TFDQuery.Create(Nil);
  try
    qryTipoPagamento.Connection := ASQLConnection;
    qryTipoPagamento.SQL.Add('Select * From VW_GridTipoPagamento');
    qryTipoPagamento.SQL.Add('Where NmTpPagamento = :NmTpPagamento');

    qryTipoPagamento.ParamByName('NmTpPagamento').AsString := ANmTpPagamento;

    qryTipoPagamento.Open;
    if not qryTipoPagamento.IsEmpty then
    begin
      Result := True;
      IdTpPagamento := qryTipoPagamento.FieldByName('IdTpPagamento').AsInteger;
      IdUsuario := qryTipoPagamento.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryTipoPagamento.FieldByName('DtCadastro').AsDateTime;
      if qryTipoPagamento.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      NmTpPagamento := qryTipoPagamento.FieldByName('NmTpPagamento').AsString;
      NmUsuarioCadastro := qryTipoPagamento.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryTipoPagamento.Close;
  finally
    FreeAndNil(qryTipoPagamento)
  end;
end;

end.

