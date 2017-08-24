unit uTipoPessoa;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TTipoPessoa = class
  private
    FIdTpPessoa       : Integer;
    FIdUsuario        : Integer;
    FDtCadastro       : TDateTime;
    FSnSituacao       : Integer;
    FNmTpPessoa       : String;
    FSnCliente        : Integer;
    FSnFornecedor     : Integer;
    FSnFuncionario    : Integer;
    FNmUsuarioCadastro: String;
    procedure Inicializar;
  public
    property IdTpPessoa         : Integer   read FIdTpPessoa        write FIdTpPessoa;
    property IdUsuario          : Integer   read FIdUsuario         write FIdUsuario;
    property DtCadastro         : TDateTime read FDtCadastro        write FDtCadastro;
    property SnSituacao         : Integer   read FSnSituacao        write FSnSituacao;
    property NmTpPessoa         : String    read FNmTpPessoa        write FNmTpPessoa;
    property SnCliente          : Integer   read FSnCliente         write FSnCliente;
    property SnFornecedor       : Integer   read FSnFornecedor      write FSnFornecedor;
    property SnFuncionario      : Integer   read FSnFuncionario     write FSnFuncionario;
    property NmUsuarioCadastro  : String    read FNmUsuarioCadastro write FNmUsuarioCadastro;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection)                              : Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdTpPessoa: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdTpPessoa: Integer)  : Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdTpPessoa: Integer)        : Boolean;
    function BuscarNmTpPessoa(ASQLConnection: TFDConnection; ANmTpPessoa: String)     : Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection)                    : Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdTpPessoa: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TTipoPessoa.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdTpPessoa: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryTipoPessoa : TFDQuery;
  I             : Integer;
  lCampo        : TField;
  lCondicao     : String;
  lVerificacao  : Integer;
  lFinalizaLoop : Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryTipoPessoa := TFDQuery.Create(nil);
  try
    qryTipoPessoa.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdTpPessoa',        ftInteger);
      Data.FieldDefs.Add('IdUsuario',         ftInteger);
      Data.FieldDefs.Add('DtCadastro',        ftDateTime);
      Data.FieldDefs.Add('SnSituacao',        ftString, 7,    False);
      Data.FieldDefs.Add('NmTpPessoa',        ftString, 255,  False);
      Data.FieldDefs.Add('SnCliente',         ftString, 7,    False);
      Data.FieldDefs.Add('SnFornecedor',      ftString, 7,    False);
      Data.FieldDefs.Add('SnFuncionario',     ftString, 7,    False);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 255,  False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryTipoPessoa.Params.Clear;
      qryTipoPessoa.SQL.Clear;
      qryTipoPessoa.SQL.Add('Select                ');
      qryTipoPessoa.SQL.Add('  *                   ');
      qryTipoPessoa.SQL.Add('From VW_GridTipoPessoa');
      qryTipoPessoa.SQL.Add('Where 1 = 1           ');

      if ISnSituacao = 1 then
      begin
         qryTipoPessoa.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryTipoPessoa.SQL.Add('  And SnSituacao = 0');
      end;

      if AIdTpPessoa > 0 then
      begin
         qryTipoPessoa.SQL.Add('  And IdTpPessoa = :IdTpPessoa');

         qryTipoPessoa.ParamByName('IdTpPessoa').AsInteger := AIdTpPessoa;
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
          qryTipoPessoa.SQL.Add (lCondicao);
          qryTipoPessoa.SQL.Add ('Order By    ');
          qryTipoPessoa.SQL.Add (' IdTpPessoa');

          qryTipoPessoa.Open;
          qryTipoPessoa.First;
        end;
      end else begin
        qryTipoPessoa.SQL.Add (lCondicao);
        qryTipoPessoa.SQL.Add ('Order By    ');
        qryTipoPessoa.SQL.Add (' IdTpPessoa');

        lFinalizaLoop := 1;
        qryTipoPessoa.Open;
        qryTipoPessoa.First;
      end;

      while not qryTipoPessoa.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdTpPessoa').AsInteger = qryTipoPessoa.FieldByName('IdTpPessoa').AsInteger then
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
          Data.FieldByName('IdTpPessoa').AsInteger       := qryTipoPessoa.FieldByName('IdTpPessoa').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger        := qryTipoPessoa.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime      := qryTipoPessoa.FieldByName('DtCadastro').AsDateTime;
          if qryTipoPessoa.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString      := 'Ativo';
          end else begin
            Data.FieldByName('SnSituacao').AsString      := 'Inativo';
          end;
          Data.FieldByName('NmTpPessoa').AsString        := qryTipoPessoa.FieldByName('NmTpPessoa').AsString;
          if qryTipoPessoa.FieldByName('SnCliente').AsBoolean then
          begin
            Data.FieldByName('SnCliente').AsString       := 'Ativo';
          end else begin
            Data.FieldByName('SnCliente').AsString       := 'Inativo';
          end;
          if qryTipoPessoa.FieldByName('SnFornecedor').AsBoolean then
          begin
            Data.FieldByName('SnFornecedor').AsString    := 'Ativo';
          end else begin
            Data.FieldByName('SnFornecedor').AsString    := 'Inativo';
          end;
          if qryTipoPessoa.FieldByName('SnFuncionario').AsBoolean then
          begin
            Data.FieldByName('SnFuncionario').AsString   := 'Ativo';
          end else begin
            Data.FieldByName('SnFuncionario').AsString   := 'Inativo';
          end;
          Data.FieldByName('NmUsuarioCadastro').AsString := qryTipoPessoa.FieldByName('NmUsuarioCadastro').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryTipoPessoa.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryTipoPessoa.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TTipoPessoa.Create;
begin
  Inicializar;
end;

procedure TTipoPessoa.Inicializar;
begin
  IdTpPessoa        := 0;
  IdUsuario         := 0;
  DtCadastro        := 0;
  SnSituacao        := 0;
  NmTpPessoa        := '';
  SnCliente         := 0;
  SnFornecedor      := 0;
  SnFuncionario     := 0;
  NmUsuarioCadastro := '';
end;

function TTipoPessoa.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryTipoPessoa: TFDQuery;
begin
  qryTipoPessoa:= TFDQuery.Create(Nil);
  try
    qryTipoPessoa.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdTpPessoa) then
    begin
      qryTipoPessoa.SQL.Add('Insert Into TipoPessoa(          ');
      qryTipoPessoa.SQL.Add('  IdUsuario,                     ');
      qryTipoPessoa.SQL.Add('  DtCadastro,                    ');
      qryTipoPessoa.SQL.Add('  SnSituacao,                    ');
      qryTipoPessoa.SQL.Add('  NmTpPessoa,                    ');
      qryTipoPessoa.SQL.Add('  SnCliente,                     ');
      qryTipoPessoa.SQL.Add('  SnFornecedor,                  ');
      qryTipoPessoa.SQL.Add('  SnFuncionario)                 ');
      qryTipoPessoa.SQL.Add('Values (                         ');
      qryTipoPessoa.SQL.Add('  :IdUsuario,                    ');
      qryTipoPessoa.SQL.Add('  :DtCadastro,                   ');
      qryTipoPessoa.SQL.Add('  :SnSituacao,                   ');
      qryTipoPessoa.SQL.Add('  :NmTpPessoa,                   ');
      qryTipoPessoa.SQL.Add('  :SnCliente,                    ');
      qryTipoPessoa.SQL.Add('  :SnFornecedor,                 ');
      qryTipoPessoa.SQL.Add('  :SnFuncionario)                ');

      qryTipoPessoa.ParamByName('IdUsuario').AsInteger     := IdUsuario;
      qryTipoPessoa.ParamByName('DtCadastro').AsDateTime   := DtCadastro;

    end else begin
      qryTipoPessoa.SQL.Add('Update TipoPessoa Set            ');
      qryTipoPessoa.SQL.Add('  SnSituacao = :SnSituacao,      ');
      qryTipoPessoa.SQL.Add('  NmTpPessoa = :NmTpPessoa,      ');
      qryTipoPessoa.SQL.Add('  SnCliente = :SnCliente,        ');
      qryTipoPessoa.SQL.Add('  SnFornecedor = :SnFornecedor,  ');
      qryTipoPessoa.SQL.Add('  SnFuncionario = :SnFuncionario ');
      qryTipoPessoa.SQL.Add('Where IdTpPessoa = :IdTpPessoa   ');

      qryTipoPessoa.ParamByName('IdTpPessoa').AsInteger := IdTpPessoa;

    end;
    qryTipoPessoa.ParamByName('SnSituacao').AsInteger    := SnSituacao;
    qryTipoPessoa.ParamByName('NmTpPessoa').AsString     := NmTpPessoa;
    qryTipoPessoa.ParamByName('SnCliente').AsInteger     := SnCliente;
    qryTipoPessoa.ParamByName('SnFornecedor').AsInteger  := SnFornecedor;
    qryTipoPessoa.ParamByName('SnFuncionario').AsInteger := SnFuncionario;
   try
      qryTipoPessoa.ExecSQL;
      qryTipoPessoa.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryTipoPessoa)
  end;
end;

class function TTipoPessoa.Inativar(ASQLConnection: TFDConnection; AIdTpPessoa: Integer): Boolean;
var
  qryTipoPessoa: TFDQuery;
begin
  qryTipoPessoa:= TFDQuery.Create(Nil);
  try
    qryTipoPessoa.Connection := ASQLConnection;
    qryTipoPessoa.SQL.Add('Update TipoPessoa Set  ');
    qryTipoPessoa.SQL.Add('  SnSituacao = 0       ');
    qryTipoPessoa.SQL.Add('Where 1 = 1            ');
    qryTipoPessoa.SQL.Add('  And IdTpPessoa = ' + IntToStr(AIdTpPessoa));
   try
      qryTipoPessoa.ExecSQL;
      qryTipoPessoa.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryTipoPessoa)
  end;
end;

class function TTipoPessoa.Existe(ASQLConnection: TFDConnection; AIdTpPessoa: Integer): Boolean;
var
  qryTipoPessoa: TFDQuery;
begin
  Result := False;
  qryTipoPessoa:= TFDQuery.Create(Nil);
  try
    qryTipoPessoa.Connection := ASQLConnection;
    qryTipoPessoa.SQL.Add('Select IdTpPessoa From TipoPessoa');
    qryTipoPessoa.SQL.Add('Where 1 = 1                      ');
    qryTipoPessoa.SQL.Add('  And IdTpPessoa = ' + IntToStr(AIdTpPessoa));
    qryTipoPessoa.Open;
    if qryTipoPessoa.Fields[0].Value > 0 then
      Result := True;
    qryTipoPessoa.Close;
  finally
    FreeAndNil(qryTipoPessoa)
  end;
end;

class function TTipoPessoa.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryTipoPessoa: TFDQuery;
begin
  Result := 0;
  qryTipoPessoa:= TFDQuery.Create(Nil);
  try
    qryTipoPessoa.Connection := ASQLConnection;
    qryTipoPessoa.SQL.Add('Select Max(IdTpPessoa) As IdTpPessoa From TipoPessoa');
    qryTipoPessoa.Open;

    if qryTipoPessoa.FieldByName('IdTpPessoa').AsInteger > 0 then
      Result := qryTipoPessoa.FieldByName('IdTpPessoa').AsInteger;
    qryTipoPessoa.Close;
  finally
    FreeAndNil(qryTipoPessoa)
  end;
end;

function TTipoPessoa.Buscar(ASQLConnection: TFDConnection; AIdTpPessoa: Integer): Boolean;
var
  qryTipoPessoa: TFDQuery;
begin
  Result := False;
  qryTipoPessoa:= TFDQuery.Create(Nil);
  try
    qryTipoPessoa.Connection := ASQLConnection;
    qryTipoPessoa.SQL.Add('Select * From VW_GridTipoPessoa');
    qryTipoPessoa.SQL.Add('Where IdTpPessoa = :IdTpPessoa                    ');

    qryTipoPessoa.ParamByName('IdTpPessoa').AsString := IntToStr(AIdTpPessoa);

    qryTipoPessoa.Open;
    if not qryTipoPessoa.IsEmpty then
    begin
      Result          := True;
      IdTpPessoa      := qryTipoPessoa.FieldByName('IdTpPessoa').AsInteger;
      IdUsuario       := qryTipoPessoa.FieldByName('IdUsuario').AsInteger;
      DtCadastro      := qryTipoPessoa.FieldByName('DtCadastro').AsDateTime;
      if qryTipoPessoa.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao    := 1
      end else begin
        SnSituacao    := 0
      end;
      NmTpPessoa      := qryTipoPessoa.FieldByName('NmTpPessoa').AsString;
      if qryTipoPessoa.FieldByName('SnCliente').AsBoolean then
      begin
        SnCliente     := 1
      end else begin
        SnCliente     := 0
      end;
      if qryTipoPessoa.FieldByName('SnFornecedor').AsBoolean then
      begin
        SnFornecedor  := 1
      end else begin
        SnFornecedor  := 0
      end;
      if qryTipoPessoa.FieldByName('SnFuncionario').AsBoolean then
      begin
        SnFuncionario := 1
      end else begin
        SnFuncionario := 0
      end;
    end;
    qryTipoPessoa.Close;
  finally
    FreeAndNil(qryTipoPessoa)
  end;
end;

function TTipoPessoa.BuscarNmTpPessoa(ASQLConnection: TFDConnection; ANmTpPessoa: String): Boolean;
var
  qryTipoPessoa: TFDQuery;
begin
  Result := False;
  qryTipoPessoa:= TFDQuery.Create(Nil);
  try
    qryTipoPessoa.Connection := ASQLConnection;
    qryTipoPessoa.SQL.Add('Select * From VW_GridTipoPessoa'     );
    qryTipoPessoa.SQL.Add('Where NmTpPessoa = :NmTpPessoa'      );

    qryTipoPessoa.ParamByName('NmTpPessoa').AsString := ANmTpPessoa;

    qryTipoPessoa.Open;
    if not qryTipoPessoa.IsEmpty then
    begin
      Result          := True;
      IdTpPessoa      := qryTipoPessoa.FieldByName('IdTpPessoa' ).AsInteger;
      IdUsuario       := qryTipoPessoa.FieldByName('IdUsuario'  ).AsInteger;
      DtCadastro      := qryTipoPessoa.FieldByName('DtCadastro' ).AsDateTime;
      if qryTipoPessoa.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao    := 1
      end else begin
        SnSituacao    := 0
      end;
      NmTpPessoa      := qryTipoPessoa.FieldByName('NmTpPessoa' ).AsString;
      if qryTipoPessoa.FieldByName('SnCliente').AsBoolean then
      begin
        SnCliente     := 1
      end else begin
        SnCliente     := 0
      end;
      if qryTipoPessoa.FieldByName('SnFornecedor').AsBoolean then
      begin
        SnFornecedor  := 1
      end else begin
        SnFornecedor  := 0
      end;
      if qryTipoPessoa.FieldByName('SnFuncionario').AsBoolean then
      begin
        SnFuncionario := 1
      end else begin
        SnFuncionario := 0
      end;
    end;
    qryTipoPessoa.Close;
  finally
    FreeAndNil(qryTipoPessoa)
  end;
end;
end.

