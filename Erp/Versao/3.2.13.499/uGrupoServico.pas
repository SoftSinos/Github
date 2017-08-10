unit uGrupoServico;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TGrupoServico = class
  private
    FIdGrupoServico     : Integer;
    FIdUsuario          : Integer;
    FDtCadastro         : TDateTime;
    FSnSituacao         : Integer;
    FNmGrupoServico     : String;
    FNmUsuarioCadastro  : String;
    procedure Inicializar;
  public
    property IdGrupoServico     : Integer read    FIdGrupoServico     write FIdGrupoServico;
    property IdUsuario          : Integer read    FIdUsuario          write FIdUsuario;
    property DtCadastro         : TDateTime read  FDtCadastro         write FDtCadastro;
    property SnSituacao         : Integer read    FSnSituacao         write FSnSituacao;
    property NmGrupoServico     : String read     FNmGrupoServico     write FNmGrupoServico;
    property NmUsuarioCadastro  : String read     FNmUsuarioCadastro  write FNmUsuarioCadastro;
   constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdGrupoServico: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdGrupoServico: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdGrupoServico: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdGrupoServico: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TGrupoServico.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdGrupoServico: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryGrupoServico : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryGrupoServico := TFDQuery.Create(nil);
  try
    qryGrupoServico.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdGrupoServico',    ftInteger);
      Data.FieldDefs.Add('IdUsuario',         ftInteger);
      Data.FieldDefs.Add('DtCadastro',        ftDateTime);
      Data.FieldDefs.Add('SnSituacao',        ftString, 7, False);
      Data.FieldDefs.Add('NmGrupoServico',    ftString, 255, False);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 255, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryGrupoServico.Params.Clear;
      qryGrupoServico.SQL.Clear;
      qryGrupoServico.SQL.Add('Select                   ');
      qryGrupoServico.SQL.Add('  *                      ');
      qryGrupoServico.SQL.Add('From VW_GridGrupoServico ');
      qryGrupoServico.SQL.Add('Where 1 = 1              ');

      if ISnSituacao = 1 then
      begin
         qryGrupoServico.SQL.Add('  And SnSituacao = 1  ');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryGrupoServico.SQL.Add('  And SnSituacao = 0  ');
      end;

      if AIdGrupoServico > 0 then
      begin
        qryGrupoServico.SQL.Add('  And IdGrupoServico = :IdGrupoServico');

        qryGrupoServico.ParamByName('IdGrupoServico').AsInteger := AIdGrupoServico
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
          qryGrupoServico.SQL.Add (lCondicao);
          qryGrupoServico.SQL.Add ('Order By');
          qryGrupoServico.SQL.Add ('  IdGrupoServico');

          qryGrupoServico.Open;
          qryGrupoServico.First;
        end;
      end else begin
        qryGrupoServico.SQL.Add (lCondicao);
        qryGrupoServico.SQL.Add ('Order By');
        qryGrupoServico.SQL.Add ('  IdGrupoServico');

        lFinalizaLoop := 1;
        qryGrupoServico.Open;
        qryGrupoServico.First;
      end;

      while not qryGrupoServico.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdGrupoServico').AsInteger = qryGrupoServico.FieldByName('IdGrupoServico').AsInteger then
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
          Data.FieldByName('IdGrupoServico').AsInteger    := qryGrupoServico.FieldByName('IdGrupoServico').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger         := qryGrupoServico.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime       := qryGrupoServico.FieldByName('DtCadastro').AsDateTime;
          if qryGrupoServico.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'ATIVO';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'INATIVO';
          end;
          Data.FieldByName('NmGrupoServico').AsString     := qryGrupoServico.FieldByName('NmGrupoServico').AsString;
          Data.FieldByName('NmUsuarioCadastro').AsString  := qryGrupoServico.FieldByName('NmUsuarioCadastro').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryGrupoServico.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryGrupoServico.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TGrupoServico.Create;
begin
  Inicializar;
end;

procedure TGrupoServico.Inicializar;
begin
  IdGrupoServico    := 0;
  IdUsuario         := 0;
  DtCadastro        := 0;
  SnSituacao        := 0;
  NmGrupoServico    := '';
  NmUsuarioCadastro := '';
end;

function TGrupoServico.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryGrupoServico: TFDQuery;
begin
  qryGrupoServico:= TFDQuery.Create(Nil);
  try
    qryGrupoServico.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdGrupoServico) then
    begin
      qryGrupoServico.SQL.Add('Insert Into GrupoServico(');
      qryGrupoServico.SQL.Add('  IdUsuario,');
      qryGrupoServico.SQL.Add('  DtCadastro,');
      qryGrupoServico.SQL.Add('  SnSituacao,');
      qryGrupoServico.SQL.Add('  NmGrupoServico)');
      qryGrupoServico.SQL.Add('Values (');
      qryGrupoServico.SQL.Add('  :IdUsuario,');
      qryGrupoServico.SQL.Add('  :DtCadastro,');
      qryGrupoServico.SQL.Add('  :SnSituacao,');
      qryGrupoServico.SQL.Add('  :NmGrupoServico)');
    end else begin
      qryGrupoServico.SQL.Add('Update GrupoServico Set ');
      qryGrupoServico.SQL.Add('  IdUsuario = :IdUsuario,');
      qryGrupoServico.SQL.Add('  DtCadastro = :DtCadastro,');
      qryGrupoServico.SQL.Add('  SnSituacao = :SnSituacao,');
      qryGrupoServico.SQL.Add('  NmGrupoServico = :NmGrupoServico ');
      qryGrupoServico.SQL.Add('Where IdGrupoServico = :IdGrupoServico');

      qryGrupoServico.ParamByName('IdGrupoServico').AsInteger := IdGrupoServico;

    end;
    qryGrupoServico.ParamByName('IdUsuario').AsInteger := IdUsuario;
    qryGrupoServico.ParamByName('DtCadastro').AsDateTime := DtCadastro;
    qryGrupoServico.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryGrupoServico.ParamByName('NmGrupoServico').AsString := NmGrupoServico;
   try
      qryGrupoServico.ExecSQL;
      qryGrupoServico.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryGrupoServico)
  end;
end;

class function TGrupoServico.Inativar(ASQLConnection: TFDConnection; AIdGrupoServico: Integer): Boolean;
var
  qryGrupoServico: TFDQuery;
begin
  qryGrupoServico:= TFDQuery.Create(Nil);
  try
    qryGrupoServico.Connection := ASQLConnection;
    qryGrupoServico.SQL.Add('Update GrupoServico Set ');
    qryGrupoServico.SQL.Add('  SnSituacao = 0 ');
    qryGrupoServico.SQL.Add('Where 1 = 1');
    qryGrupoServico.SQL.Add('  And IdGrupoServico = ' + IntToStr(AIdGrupoServico));
   try
      qryGrupoServico.ExecSQL;
      qryGrupoServico.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryGrupoServico)
  end;
end;

class function TGrupoServico.Existe(ASQLConnection: TFDConnection; AIdGrupoServico: Integer): Boolean;
var
  qryGrupoServico: TFDQuery;
begin
  Result := False;
  qryGrupoServico:= TFDQuery.Create(Nil);
  try
    qryGrupoServico.Connection := ASQLConnection;
    qryGrupoServico.SQL.Add('Select IdGrupoServico From GrupoServico');
    qryGrupoServico.SQL.Add('Where 1 = 1');
    qryGrupoServico.SQL.Add('  And IdGrupoServico = ' + IntToStr(AIdGrupoServico));
    qryGrupoServico.Open;
    if qryGrupoServico.Fields[0].Value > 0 then
      Result := True;
    qryGrupoServico.Close;
  finally
    FreeAndNil(qryGrupoServico)
  end;
end;

class function TGrupoServico.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryGrupoServico: TFDQuery;
begin
  Result := 0;
  qryGrupoServico:= TFDQuery.Create(Nil);
  try
    qryGrupoServico.Connection := ASQLConnection;
    qryGrupoServico.SQL.Add('Select Max(IdGrupoServico) As IdGrupoServico From GrupoServico');
    qryGrupoServico.Open;

    if qryGrupoServico.FieldByName('IdGrupoServico').AsInteger > 0 then
      Result := qryGrupoServico.FieldByName('IdGrupoServico').AsInteger;
    qryGrupoServico.Close;
  finally
    FreeAndNil(qryGrupoServico)
  end;
end;

function TGrupoServico.Buscar(ASQLConnection: TFDConnection; AIdGrupoServico: Integer): Boolean;
var
  qryGrupoServico: TFDQuery;
begin
  Result := False;
  qryGrupoServico:= TFDQuery.Create(Nil);
  try
    qryGrupoServico.Connection := ASQLConnection;
    qryGrupoServico.SQL.Add('Select * From VW_GridGrupoServico');
    qryGrupoServico.SQL.Add('Where IdGrupoServico = :IdGrupoServico');

    qryGrupoServico.ParamByName('IdGrupoServico').AsString := IntToStr(AIdGrupoServico);

    qryGrupoServico.Open;
    if not qryGrupoServico.IsEmpty then
    begin
      Result            := True;
      IdGrupoServico    := qryGrupoServico.FieldByName('IdGrupoServico').AsInteger;
      IdUsuario         := qryGrupoServico.FieldByName('IdUsuario').AsInteger;
      DtCadastro        := qryGrupoServico.FieldByName('DtCadastro').AsDateTime;
      if qryGrupoServico.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao      := 1
      end else begin
        SnSituacao      := 0
      end;
      NmGrupoServico    := qryGrupoServico.FieldByName('NmGrupoServico').AsString;
      NmUsuarioCadastro := qryGrupoServico.FieldByName('NmUsuarioCadastro').AsString;
     end;
    qryGrupoServico.Close;
  finally
    FreeAndNil(qryGrupoServico)
  end;
end;

end.

