unit uVersao;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TVersao = class
  private
    FIdVersao: Integer;
    FDtCadastro: TDateTime;
    FNrVersaoBd: String;
    FNrVersaoApp: String;
    procedure Inicializar;
  public
    property IdVersao: Integer read FIdVersao write FIdVersao;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property NrVersaoBd: String read FNrVersaoBd write FNrVersaoBd;
    property NrVersaoApp: String read FNrVersaoApp write FNrVersaoApp;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdVersao: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdVersao: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdVersao: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdVersao: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TVersao.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdVersao: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryVersao : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryVersao := TFDQuery.Create(nil);
  try
    qryVersao.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdVersao', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('NrVersaoBd', ftString, 10, False);
      Data.FieldDefs.Add('NrVersaoApp', ftString, 10, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryVersao.Params.Clear;
      qryVersao.SQL.Clear;
      qryVersao.SQL.Add('Select');
      qryVersao.SQL.Add('  *');
      qryVersao.SQL.Add('From VW_GridVersao');
      qryVersao.SQL.Add('Where 1 = 1');
      if ISnSituacao = 1 then
      begin
         qryVersao.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryVersao.SQL.Add('  And SnSituacao = 0');
      end;

      if AIdVersao > 0 then
      begin
         qryVersao.SQL.Add('  And IdVersao = :IdVersao');

         qryVersao.ParamByName('IdVersao').AsInteger := AIdVersao;
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
          qryVersao.SQL.Add (lCondicao);
          qryVersao.SQL.Add ('Order By');
          qryVersao.SQL.Add (' IdVersao');

          qryVersao.Open;
          qryVersao.First;
        end;
      end else begin
        qryVersao.SQL.Add (lCondicao);
        qryVersao.SQL.Add ('Order By');
        qryVersao.SQL.Add (' IdVersao');

        lFinalizaLoop := 1;
        qryVersao.Open;
        qryVersao.First;
      end;

      while not qryVersao.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdVersao').AsInteger = qryVersao.FieldByName('IdVersao').AsInteger then
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
          Data.FieldByName('IdVersao').AsInteger := qryVersao.FieldByName('IdVersao').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryVersao.FieldByName('DtCadastro').AsDateTime;
          Data.FieldByName('NrVersaoBd').AsString := qryVersao.FieldByName('NrVersaoBd').AsString;
          Data.FieldByName('NrVersaoApp').AsString := qryVersao.FieldByName('NrVersaoApp').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryVersao.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryVersao.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TVersao.Create;
begin
  Inicializar;
end;

procedure TVersao.Inicializar;
begin
  IdVersao := 0;
  DtCadastro := 0;
  NrVersaoBd := '';
  NrVersaoApp := '';
end;

function TVersao.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryVersao: TFDQuery;
begin
  qryVersao:= TFDQuery.Create(Nil);
  try
    qryVersao.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdVersao) then
    begin
      qryVersao.SQL.Add('Insert Into Versao(');
      qryVersao.SQL.Add('  DtCadastro,');
      qryVersao.SQL.Add('  NrVersaoBd,');
      qryVersao.SQL.Add('  NrVersaoApp)');
      qryVersao.SQL.Add('Values (');
      qryVersao.SQL.Add('  :DtCadastro,');
      qryVersao.SQL.Add('  :NrVersaoBd,');
      qryVersao.SQL.Add('  :NrVersaoApp)');

      qryVersao.ParamByName('DtCadastro').AsDateTime := DtCadastro;

    end else begin
      qryVersao.SQL.Add('Update Versao Set ');
      qryVersao.SQL.Add('  NrVersaoBd = :NrVersaoBd,');
      qryVersao.SQL.Add('  NrVersaoApp = :NrVersaoApp ');
      qryVersao.SQL.Add('Where IdVersao = :IdVersao');

      qryVersao.ParamByName('IdVersao').AsInteger := IdVersao;

    end;
    qryVersao.ParamByName('NrVersaoBd').AsString := NrVersaoBd;
    qryVersao.ParamByName('NrVersaoApp').AsString := NrVersaoApp;
   try
      qryVersao.ExecSQL;
      qryVersao.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryVersao)
  end;
end;

class function TVersao.Inativar(ASQLConnection: TFDConnection; AIdVersao: Integer): Boolean;
var
  qryVersao: TFDQuery;
begin
  qryVersao:= TFDQuery.Create(Nil);
  try
    qryVersao.Connection := ASQLConnection;
    qryVersao.SQL.Add('Update Versao Set ');
    qryVersao.SQL.Add('  SnSituacao = 0 ');
    qryVersao.SQL.Add('Where 1 = 1');
    qryVersao.SQL.Add('  And IdVersao = ' + IntToStr(AIdVersao));
   try
      qryVersao.ExecSQL;
      qryVersao.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryVersao)
  end;
end;

class function TVersao.Existe(ASQLConnection: TFDConnection; AIdVersao: Integer): Boolean;
var
  qryVersao: TFDQuery;
begin
  Result := False;
  qryVersao:= TFDQuery.Create(Nil);
  try
    qryVersao.Connection := ASQLConnection;
    qryVersao.SQL.Add('Select IdVersao From Versao');
    qryVersao.SQL.Add('Where 1 = 1');
    qryVersao.SQL.Add('  And IdVersao = ' + IntToStr(AIdVersao));
    qryVersao.Open;
    if qryVersao.Fields[0].Value > 0 then
      Result := True;
    qryVersao.Close;
  finally
    FreeAndNil(qryVersao)
  end;
end;

class function TVersao.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryVersao: TFDQuery;
begin
  Result := 0;
  qryVersao:= TFDQuery.Create(Nil);
  try
    qryVersao.Connection := ASQLConnection;
    qryVersao.SQL.Add('Select Max(IdVersao) As IdVersao From Versao');
    qryVersao.Open;

    if qryVersao.FieldByName('IdVersao').AsInteger > 0 then
      Result := qryVersao.FieldByName('IdVersao').AsInteger;
    qryVersao.Close;
  finally
    FreeAndNil(qryVersao)
  end;
end;

function TVersao.Buscar(ASQLConnection: TFDConnection; AIdVersao: Integer): Boolean;
var
  qryVersao: TFDQuery;
begin
  Result := False;
  qryVersao:= TFDQuery.Create(Nil);
  try
    qryVersao.Connection := ASQLConnection;
    qryVersao.SQL.Add('Select * From VW_GridVersao');
    qryVersao.SQL.Add('Where IdVersao = :IdVersao');

    qryVersao.ParamByName('IdVersao').AsString := IntToStr(AIdVersao);

    qryVersao.Open;
    if not qryVersao.IsEmpty then
    begin
      Result := True;
      IdVersao := qryVersao.FieldByName('IdVersao').AsInteger;
      DtCadastro := qryVersao.FieldByName('DtCadastro').AsDateTime;
      NrVersaoBd := qryVersao.FieldByName('NrVersaoBd').AsString;
      NrVersaoApp := qryVersao.FieldByName('NrVersaoApp').AsString;
    end;
    qryVersao.Close;
  finally
    FreeAndNil(qryVersao)
  end;
end;

end.

