unit uCaixaFechamento;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TCaixaFechamento = class
  private
    FIdCaixaFechamento: Integer;
    FIdEmpresa: Integer;
    FIdUsuario: Integer;
    FDtCadastro: TDateTime;
    FSnSituacao: Integer;
    FIdCaixa: Integer;
    FIdTpPagamento: Integer;
    FVlDia: Extended;
    FVlGaveta: Extended;
    FVlResultado: Extended;
    procedure Inicializar;
  public
    property IdCaixaFechamento: Integer read FIdCaixaFechamento write FIdCaixaFechamento;
    property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property IdCaixa: Integer read FIdCaixa write FIdCaixa;
    property IdTpPagamento: Integer read FIdTpPagamento write FIdTpPagamento;
    property VlDia: Extended read FVlDia write FVlDia;
    property VlGaveta: Extended read FVlGaveta write FVlGaveta;
    property VlResultado: Extended read FVlResultado write FVlResultado;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdCaixaFechamento: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdCaixaFechamento: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdCaixaFechamento: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdCaixaFechamento: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TCaixaFechamento.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdCaixaFechamento: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryCaixaFechamento : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryCaixaFechamento := TFDQuery.Create(nil);
  try
    qryCaixaFechamento.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdCaixaFechamento', ftInteger);
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 7, False);
      Data.FieldDefs.Add('IdCaixa', ftInteger);
      Data.FieldDefs.Add('IdTpPagamento', ftInteger);
      Data.FieldDefs.Add('VlDia', ftCurrency);
      Data.FieldDefs.Add('VlGaveta', ftCurrency);
      Data.FieldDefs.Add('VlResultado', ftCurrency);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryCaixaFechamento.Params.Clear;
      qryCaixaFechamento.SQL.Clear;
      qryCaixaFechamento.SQL.Add('Select');
      qryCaixaFechamento.SQL.Add('  IdCaixaFechamento,');
      qryCaixaFechamento.SQL.Add('  IdEmpresa,');
      qryCaixaFechamento.SQL.Add('  IdUsuario,');
      qryCaixaFechamento.SQL.Add('  DtCadastro,');
      qryCaixaFechamento.SQL.Add('  SnSituacao,');
      qryCaixaFechamento.SQL.Add('  IdCaixa,');
      qryCaixaFechamento.SQL.Add('  IdTpPagamento,');
      qryCaixaFechamento.SQL.Add('  VlDia,');
      qryCaixaFechamento.SQL.Add('  VlGaveta,');
      qryCaixaFechamento.SQL.Add('  VlResultado');
      qryCaixaFechamento.SQL.Add('From CaixaFechamento');
      qryCaixaFechamento.SQL.Add('Where 1 = 1');
      if ISnSituacao = 1 then
      begin
         qryCaixaFechamento.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryCaixaFechamento.SQL.Add('  And SnSituacao = 0');
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
          qryCaixaFechamento.SQL.Add (lCondicao);
          qryCaixaFechamento.SQL.Add ('Order By');
          qryCaixaFechamento.SQL.Add ('  IdCaixaFechamento');

          qryCaixaFechamento.Open;
          qryCaixaFechamento.First;
        end;
      end else begin
        qryCaixaFechamento.SQL.Add (lCondicao);
        qryCaixaFechamento.SQL.Add ('Order By');
        qryCaixaFechamento.SQL.Add ('  IdCaixaFechamento');

        lFinalizaLoop := 1;
        qryCaixaFechamento.Open;
        qryCaixaFechamento.First;
      end;

      while not qryCaixaFechamento.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdCaixaFechamento').AsInteger = qryCaixaFechamento.FieldByName('IdCaixaFechamento').AsInteger then
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
          Data.FieldByName('IdCaixaFechamento').AsInteger := qryCaixaFechamento.FieldByName('IdCaixaFechamento').AsInteger;
          Data.FieldByName('IdEmpresa').AsInteger := qryCaixaFechamento.FieldByName('IdEmpresa').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryCaixaFechamento.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryCaixaFechamento.FieldByName('DtCadastro').AsDateTime;
          if qryCaixaFechamento.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString  := 'Ativo';
          end else begin
            Data.FieldByName('SnSituacao').AsString  := 'Desativado';
          end;
          Data.FieldByName('IdCaixa').AsInteger := qryCaixaFechamento.FieldByName('IdCaixa').AsInteger;
          Data.FieldByName('IdTpPagamento').AsInteger := qryCaixaFechamento.FieldByName('IdTpPagamento').AsInteger;
          Data.FieldByName('VlDia').AsFloat := qryCaixaFechamento.FieldByName('VlDia').AsFloat;
          Data.FieldByName('VlGaveta').AsFloat := qryCaixaFechamento.FieldByName('VlGaveta').AsFloat;
          Data.FieldByName('VlResultado').AsFloat := qryCaixaFechamento.FieldByName('VlResultado').AsFloat;
          Data.Post;
        end;

        lVerificacao := 0;
        qryCaixaFechamento.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryCaixaFechamento.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TCaixaFechamento.Create;
begin
  Inicializar;
end;

procedure TCaixaFechamento.Inicializar;
begin
  IdCaixaFechamento := 0;
  IdEmpresa := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  IdCaixa := 0;
  IdTpPagamento := 0;
  VlDia := 0;
  VlGaveta := 0;
  VlResultado := 0;
end;

function TCaixaFechamento.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryCaixaFechamento: TFDQuery;
begin
  qryCaixaFechamento:= TFDQuery.Create(Nil);
  try
    qryCaixaFechamento.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdCaixaFechamento) then
    begin
      qryCaixaFechamento.SQL.Add('Insert Into CaixaFechamento(');
      qryCaixaFechamento.SQL.Add('  IdEmpresa,');
      qryCaixaFechamento.SQL.Add('  IdUsuario,');
      qryCaixaFechamento.SQL.Add('  DtCadastro,');
      qryCaixaFechamento.SQL.Add('  SnSituacao,');
      qryCaixaFechamento.SQL.Add('  IdCaixa,');
      qryCaixaFechamento.SQL.Add('  IdTpPagamento,');
      qryCaixaFechamento.SQL.Add('  VlDia,');
      qryCaixaFechamento.SQL.Add('  VlGaveta,');
      qryCaixaFechamento.SQL.Add('  VlResultado)');
      qryCaixaFechamento.SQL.Add('Values (');
      qryCaixaFechamento.SQL.Add('  :IdEmpresa,');
      qryCaixaFechamento.SQL.Add('  :IdUsuario,');
      qryCaixaFechamento.SQL.Add('  :DtCadastro,');
      qryCaixaFechamento.SQL.Add('  :SnSituacao,');
      qryCaixaFechamento.SQL.Add('  :IdCaixa,');
      qryCaixaFechamento.SQL.Add('  :IdTpPagamento,');
      qryCaixaFechamento.SQL.Add('  :VlDia,');
      qryCaixaFechamento.SQL.Add('  :VlGaveta,');
      qryCaixaFechamento.SQL.Add('  :VlResultado)');
    end else begin
      qryCaixaFechamento.SQL.Add('Update CaixaFechamento Set ');
      qryCaixaFechamento.SQL.Add('  IdEmpresa = :IdEmpresa,');
      qryCaixaFechamento.SQL.Add('  IdUsuario = :IdUsuario,');
      qryCaixaFechamento.SQL.Add('  DtCadastro = :DtCadastro,');
      qryCaixaFechamento.SQL.Add('  SnSituacao = :SnSituacao,');
      qryCaixaFechamento.SQL.Add('  IdTpPagamento = :IdTpPagamento,');
      qryCaixaFechamento.SQL.Add('  VlDia = :VlDia,');
      qryCaixaFechamento.SQL.Add('  VlGaveta = :VlGaveta,');
      qryCaixaFechamento.SQL.Add('  VlResultado = :VlResultado ');
      qryCaixaFechamento.SQL.Add('Where IdCaixaFechamento = :IdCaixaFechamento');

      qryCaixaFechamento.ParamByName('IdCaixaFechamento').AsInteger := IdCaixaFechamento;

    end;
    qryCaixaFechamento.ParamByName('IdEmpresa').AsInteger := IdEmpresa;
    qryCaixaFechamento.ParamByName('IdUsuario').AsInteger := IdUsuario;
    qryCaixaFechamento.ParamByName('DtCadastro').AsDateTime := DtCadastro;
    qryCaixaFechamento.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryCaixaFechamento.ParamByName('IdCaixa').AsInteger := IdCaixa;
    qryCaixaFechamento.ParamByName('IdTpPagamento').AsInteger := IdTpPagamento;
    qryCaixaFechamento.ParamByName('VlDia').AsFloat := VlDia;
    qryCaixaFechamento.ParamByName('VlGaveta').AsFloat := VlGaveta;
    qryCaixaFechamento.ParamByName('VlResultado').AsFloat := VlResultado;
   try
      qryCaixaFechamento.ExecSQL;
      qryCaixaFechamento.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryCaixaFechamento)
  end;
end;

class function TCaixaFechamento.Inativar(ASQLConnection: TFDConnection; AIdCaixaFechamento: Integer): Boolean;
var
  qryCaixaFechamento: TFDQuery;
begin
  qryCaixaFechamento:= TFDQuery.Create(Nil);
  try
    qryCaixaFechamento.Connection := ASQLConnection;
    qryCaixaFechamento.SQL.Add('Update CaixaFechamento Set ');
    qryCaixaFechamento.SQL.Add('  SnSituacao = 0 ');
    qryCaixaFechamento.SQL.Add('Where 1 = 1');
    qryCaixaFechamento.SQL.Add('  And IdCaixaFechamento = ' + IntToStr(AIdCaixaFechamento));
   try
      qryCaixaFechamento.ExecSQL;
      qryCaixaFechamento.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryCaixaFechamento)
  end;
end;

class function TCaixaFechamento.Existe(ASQLConnection: TFDConnection; AIdCaixaFechamento: Integer): Boolean;
var
  qryCaixaFechamento: TFDQuery;
begin
  Result := False;
  qryCaixaFechamento:= TFDQuery.Create(Nil);
  try
    qryCaixaFechamento.Connection := ASQLConnection;
    qryCaixaFechamento.SQL.Add('Select IdCaixaFechamento From CaixaFechamento');
    qryCaixaFechamento.SQL.Add('Where 1 = 1');
    qryCaixaFechamento.SQL.Add('  And IdCaixaFechamento = ' + IntToStr(AIdCaixaFechamento));
    qryCaixaFechamento.Open;
    if qryCaixaFechamento.Fields[0].Value > 0 then
      Result := True;
    qryCaixaFechamento.Close;
  finally
    FreeAndNil(qryCaixaFechamento)
  end;
end;

class function TCaixaFechamento.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryCaixaFechamento: TFDQuery;
begin
  Result := 0;
  qryCaixaFechamento:= TFDQuery.Create(Nil);
  try
    qryCaixaFechamento.Connection := ASQLConnection;
    qryCaixaFechamento.SQL.Add('Select Max(IdCaixaFechamento) As IdCaixaFechamento From CaixaFechamento');
    qryCaixaFechamento.Open;

    if qryCaixaFechamento.FieldByName('IdCaixaFechamento').AsInteger > 0 then
      Result := qryCaixaFechamento.FieldByName('IdCaixaFechamento').AsInteger;
    qryCaixaFechamento.Close;
  finally
    FreeAndNil(qryCaixaFechamento)
  end;
end;

function TCaixaFechamento.Buscar(ASQLConnection: TFDConnection; AIdCaixaFechamento: Integer): Boolean;
var
  qryCaixaFechamento: TFDQuery;
begin
  Result := False;
  qryCaixaFechamento:= TFDQuery.Create(Nil);
  try
    qryCaixaFechamento.Connection := ASQLConnection;
    qryCaixaFechamento.SQL.Add('Select * From CaixaFechamento');
    qryCaixaFechamento.SQL.Add('Where 1 = 1');
    if AIdCaixaFechamento > 0 then
    begin
      qryCaixaFechamento.SQL.Add('  And IdCaixaFechamento = ' + IntToStr(AIdCaixaFechamento));
    end;

    qryCaixaFechamento.Open;
    if not qryCaixaFechamento.IsEmpty then
    begin
      Result := True;
      IdCaixaFechamento := qryCaixaFechamento.FieldByName('IdCaixaFechamento').AsInteger;
      IdEmpresa := qryCaixaFechamento.FieldByName('IdEmpresa').AsInteger;
      IdUsuario := qryCaixaFechamento.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryCaixaFechamento.FieldByName('DtCadastro').AsDateTime;
      if qryCaixaFechamento.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      IdCaixa := qryCaixaFechamento.FieldByName('IdCaixa').AsInteger;
      IdTpPagamento := qryCaixaFechamento.FieldByName('IdTpPagamento').AsInteger;
      VlDia := qryCaixaFechamento.FieldByName('VlDia').AsFloat;
      VlGaveta := qryCaixaFechamento.FieldByName('VlGaveta').AsFloat;
      VlResultado := qryCaixaFechamento.FieldByName('VlResultado').AsFloat;
    end;
    qryCaixaFechamento.Close;
  finally
    FreeAndNil(qryCaixaFechamento)
  end;
end;

end.

