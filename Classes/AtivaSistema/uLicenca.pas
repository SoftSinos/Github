unit uLicenca;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TLicenca = class
  private
    FIdLicenca          : Integer;
    FIdUsuario          : Integer;
    FDtCadastro         : TDateTime;
    FSnSituacao         : Integer;
    FNmMenu             : String;
    FNmLicenca          : String;
    FNmUsuarioCadastro  : String;
    procedure Inicializar;
  public
    property IdLicenca          : Integer   read  FIdLicenca        write FIdLicenca;
    property IdUsuario          : Integer   read  FIdUsuario        write FIdUsuario;
    property DtCadastro         : TDateTime read  FDtCadastro       write FDtCadastro;
    property SnSituacao         : Integer   read  FSnSituacao       write FSnSituacao;
    property NmMenu             : String    read  FNmMenu           write FNmMenu;
    property NmLicenca          : String    read  FNmLicenca        write FNmLicenca;
    property NmUsuarioCadastro  : String    read FNmUsuarioCadastro write FNmUsuarioCadastro;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdLicenca: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdLicenca: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdLicenca: Integer): Boolean;
    function BuscarMenu(ASQLConnection: TFDConnection; ANmMenu: String; ANmLicenca: String): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdLicenca: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TLicenca.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdLicenca: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryLicenca : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryLicenca := TFDQuery.Create(nil);
  try
    qryLicenca.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdLicenca',         ftInteger);
      Data.FieldDefs.Add('IdUsuario',         ftInteger);
      Data.FieldDefs.Add('DtCadastro',        ftDateTime);
      Data.FieldDefs.Add('SnSituacao',        ftString, 7,    False);
      Data.FieldDefs.Add('NmMenu',            ftString, 10,   False);
      Data.FieldDefs.Add('NmLicenca',         ftString, 10,   False);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 255,  False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryLicenca.Params.Clear;
      qryLicenca.SQL.Clear;
      qryLicenca.SQL.Add('Select                        ');
      qryLicenca.SQL.Add('  *                           ');
      qryLicenca.SQL.Add('From VW_GridLicenca           ');
      qryLicenca.SQL.Add('Where 1 = 1                   ');

      if ISnSituacao = 1 then
      begin
         qryLicenca.SQL.Add('  And SnSituacao = 1       ');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryLicenca.SQL.Add('  And SnSituacao = 0       ');
      end;

      if AIdLicenca > 0 then
      begin
        qryLicenca.SQL.Add('  And IdLicenca = :IdLicenca');

        qryLicenca.ParamByName('IdLicenca').AsInteger := AIdLicenca
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
          qryLicenca.SQL.Add (lCondicao);
          qryLicenca.SQL.Add ('Order By   ');
          qryLicenca.SQL.Add ('  IdLicenca');

          qryLicenca.Open;
          qryLicenca.First;
        end;
      end else begin
        qryLicenca.SQL.Add (lCondicao);
        qryLicenca.SQL.Add ('Order By   ');
        qryLicenca.SQL.Add ('  IdLicenca');

        lFinalizaLoop := 1;
        qryLicenca.Open;
        qryLicenca.First;
      end;

      while not qryLicenca.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdLicenca').AsInteger = qryLicenca.FieldByName('IdLicenca').AsInteger then
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
          Data.FieldByName('IdLicenca').AsInteger         := qryLicenca.FieldByName('IdLicenca').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger         := qryLicenca.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime       := qryLicenca.FieldByName('DtCadastro').AsDateTime;
          if qryLicenca.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'ATIVO';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'INATIVO';
          end;
          Data.FieldByName('NmMenu').AsString             := qryLicenca.FieldByName('NmMenu').AsString;
          Data.FieldByName('NmLicenca').AsString          := qryLicenca.FieldByName('NmLicenca').AsString;
          Data.FieldByName('NmUsuarioCadastro').AsString  := qryLicenca.FieldByName('NmUsuarioCadastro').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryLicenca.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryLicenca.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TLicenca.Create;
begin
  Inicializar;
end;

procedure TLicenca.Inicializar;
begin
  IdLicenca         := 0;
  IdUsuario         := 0;
  DtCadastro        := 0;
  SnSituacao        := 0;
  NmMenu            := '';
  NmLicenca         := '';
  NmUsuarioCadastro := '';
end;

function TLicenca.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryLicenca: TFDQuery;
begin
  qryLicenca:= TFDQuery.Create(Nil);
  try
    qryLicenca.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdLicenca) then
    begin
      qryLicenca.SQL.Add('Insert Into Licenca(');
      qryLicenca.SQL.Add('  IdUsuario,');
      qryLicenca.SQL.Add('  DtCadastro,');
      qryLicenca.SQL.Add('  SnSituacao,');
      qryLicenca.SQL.Add('  NmMenu,');
      qryLicenca.SQL.Add('  NmLicenca)');
      qryLicenca.SQL.Add('Values (');
      qryLicenca.SQL.Add('  :IdUsuario,');
      qryLicenca.SQL.Add('  :DtCadastro,');
      qryLicenca.SQL.Add('  :SnSituacao,');
      qryLicenca.SQL.Add('  :NmMenu,');
      qryLicenca.SQL.Add('  :NmLicenca)');

      qryLicenca.ParamByName('IdUsuario').AsInteger := IdUsuario;
      qryLicenca.ParamByName('DtCadastro').AsDateTime := DtCadastro;

    end else begin
      qryLicenca.SQL.Add('Update Licenca Set ');
      qryLicenca.SQL.Add('  SnSituacao = :SnSituacao,');
      qryLicenca.SQL.Add('  NmMenu = :NmMenu,');
      qryLicenca.SQL.Add('  NmLicenca = :NmLicenca ');
      qryLicenca.SQL.Add('Where IdLicenca = :IdLicenca');

      qryLicenca.ParamByName('IdLicenca').AsInteger := IdLicenca;

    end;
    qryLicenca.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryLicenca.ParamByName('NmMenu').AsString := NmMenu;
    qryLicenca.ParamByName('NmLicenca').AsString := NmLicenca;
   try
      qryLicenca.ExecSQL;
      qryLicenca.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryLicenca)
  end;
end;

class function TLicenca.Inativar(ASQLConnection: TFDConnection; AIdLicenca: Integer): Boolean;
var
  qryLicenca: TFDQuery;
begin
  qryLicenca:= TFDQuery.Create(Nil);
  try
    qryLicenca.Connection := ASQLConnection;
    qryLicenca.SQL.Add('Update Licenca Set ');
    qryLicenca.SQL.Add('  SnSituacao = 0 ');
    qryLicenca.SQL.Add('Where 1 = 1');
    qryLicenca.SQL.Add('  And IdLicenca = ' + IntToStr(AIdLicenca));
   try
      qryLicenca.ExecSQL;
      qryLicenca.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryLicenca)
  end;
end;

class function TLicenca.Existe(ASQLConnection: TFDConnection; AIdLicenca: Integer): Boolean;
var
  qryLicenca: TFDQuery;
begin
  Result := False;
  qryLicenca:= TFDQuery.Create(Nil);
  try
    qryLicenca.Connection := ASQLConnection;
    qryLicenca.SQL.Add('Select IdLicenca From Licenca');
    qryLicenca.SQL.Add('Where 1 = 1');
    qryLicenca.SQL.Add('  And IdLicenca = ' + IntToStr(AIdLicenca));
    qryLicenca.Open;
    if qryLicenca.Fields[0].Value > 0 then
      Result := True;
    qryLicenca.Close;
  finally
    FreeAndNil(qryLicenca)
  end;
end;

class function TLicenca.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryLicenca: TFDQuery;
begin
  Result := 0;
  qryLicenca:= TFDQuery.Create(Nil);
  try
    qryLicenca.Connection := ASQLConnection;
    qryLicenca.SQL.Add('Select Max(IdLicenca) As IdLicenca From Licenca');
    qryLicenca.Open;

    if qryLicenca.FieldByName('IdLicenca').AsInteger > 0 then
      Result := qryLicenca.FieldByName('IdLicenca').AsInteger;
    qryLicenca.Close;
  finally
    FreeAndNil(qryLicenca)
  end;
end;

function TLicenca.Buscar(ASQLConnection: TFDConnection; AIdLicenca: Integer): Boolean;
var
  qryLicenca: TFDQuery;
begin
  Result := False;
  qryLicenca:= TFDQuery.Create(Nil);
  try
    qryLicenca.Connection := ASQLConnection;
    qryLicenca.SQL.Add('Select * From Licenca ');
    qryLicenca.SQL.Add('Where 1 = 1           ');

    if AIdLicenca > 0 then
    begin
      qryLicenca.SQL.Add('  And IdLicenca = ' + IntToStr(AIdLicenca));
    end;

    qryLicenca.Open;
    if not qryLicenca.IsEmpty then
    begin
      Result            := True;
      IdLicenca         := qryLicenca.FieldByName('IdLicenca').AsInteger;
      IdUsuario         := qryLicenca.FieldByName('IdUsuario').AsInteger;
      DtCadastro        := qryLicenca.FieldByName('DtCadastro').AsDateTime;
      if qryLicenca.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao      := 1
      end else begin
        SnSituacao      := 0
      end;
      NmMenu            := qryLicenca.FieldByName('NmMenu').AsString;
      NmLicenca         := qryLicenca.FieldByName('NmLicenca').AsString;
      NmUsuarioCadastro := qryLicenca.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryLicenca.Close;
  finally
    FreeAndNil(qryLicenca)
  end;
end;

function TLicenca.BuscarMenu(ASQLConnection: TFDConnection; ANmMenu: String; ANmLicenca: String): Boolean;
var
  qryLicenca: TFDQuery;
begin
  Result := False;
  qryLicenca:= TFDQuery.Create(Nil);
  try
    qryLicenca.Connection := ASQLConnection;
    qryLicenca.SQL.Add('Select * From VW_GridLicenca  ');
    qryLicenca.SQL.Add('Where 1 = 1                   ');
    qryLicenca.SQL.Add('  And NmMenu = :NmMenu        ');
    qryLicenca.SQL.Add('  And (NmLicenca = :NmLicenca ');
    qryLicenca.SQL.Add('    Or NmLicenca = ''Full'')  ');

    qryLicenca.ParamByName('NmMenu').AsString    := ANmMenu;
    qryLicenca.ParamByName('NmLicenca').AsString := ANmLicenca;

    qryLicenca.Open;
    if not qryLicenca.IsEmpty then
    begin
      Result            := True;
      IdLicenca         := qryLicenca.FieldByName('IdLicenca').AsInteger;
      IdUsuario         := qryLicenca.FieldByName('IdUsuario').AsInteger;
      DtCadastro        := qryLicenca.FieldByName('DtCadastro').AsDateTime;
      if qryLicenca.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao      := 1
      end else begin
        SnSituacao      := 0
      end;
      NmMenu            := qryLicenca.FieldByName('NmMenu').AsString;
      NmLicenca         := qryLicenca.FieldByName('NmLicenca').AsString;
      NmUsuarioCadastro := qryLicenca.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryLicenca.Close;
  finally
    FreeAndNil(qryLicenca)
  end;
end;

end.

