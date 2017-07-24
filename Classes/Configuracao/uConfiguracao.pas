unit uConfiguracao;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TConfiguracao = class
  private
    FIdEmpresa                : Integer;
    FIdUsuario                : Integer;
    FIdConfiguracao           : Integer;
    FDtCadastro               : TDateTime;
    FSnSituacao               : Integer;
    FNmSigla                  : String;
    FNmConfiguracao           : String;
    FNmValor                  : String;
    FNmRazaoSocialNmFantasia  : String;
    FNmUsuarioCadastro        : String;
  public
    property IdEmpresa      : Integer   read FIdEmpresa       write FIdEmpresa;
    property IdUsuario      : Integer   read FIdUsuario       write FIdUsuario;
    property IdConfiguracao : Integer   read FIdConfiguracao  write FIdConfiguracao;
    property DtCadastro     : TDateTime read FDtCadastro      write FDtCadastro;
    property SnSituacao     : Integer   read FSnSituacao      write FSnSituacao;
    property NmSigla        : String    read FNmSigla         write FNmSigla;
    property NmConfiguracao : String    read FNmConfiguracao  write FNmConfiguracao;
    property NmValor        : String    read FNmValor         write FNmValor;
    property NmRazaoSocialNmFantasia     : String    read FNmRazaoSocialNmFantasia      write FNmRazaoSocialNmFantasia;
    property NmUsuarioCadastro     : String    read FNmUsuarioCadastro      write FNmUsuarioCadastro;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdEmpresa: Integer; ANmSigla: String): Boolean;
    class function AtualizaValor(ASQLConnection: TFDConnection; AIdEmpresa: Integer; ANmSigla: String; INmValor: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdConfiguracao: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdEmpresa: Integer; ANmSigla: String): Boolean;
    function BuscarConfiguracao(ASQLConnection: TFDConnection; AIdConfiguracao: Integer): Boolean;
    function BuscarSigla(ASQLConnection: TFDConnection; ANmSigla: String): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdEmpresa: Integer; AIdConfiguracao: Integer; AConsulta: String; Data: TClientDataSet);
    procedure Inicializar;
  end;

implementation

uses uFuncao, dPrincipal;

procedure TConfiguracao.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdEmpresa: Integer; AIdConfiguracao: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryConfiguracao : TFDQuery;
  I               : Integer;
  lCampo          : TField;
  lCondicao       : String;
  lVerificacao    : Integer;
  lFinalizaLoop   : Integer;
begin
  lVerificacao    := 0;
  lFinalizaLoop   := 0;

  qryConfiguracao := TFDQuery.Create(nil);
  try
    qryConfiguracao.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('IdConfiguracao', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 9, False);
      Data.FieldDefs.Add('NmSigla', ftString, 10, False);
      Data.FieldDefs.Add('NmConfiguracao', ftString, 255, False);
      Data.FieldDefs.Add('NmValor', ftString, 50, False);
      Data.FieldDefs.Add('NmRazaoSocialNmFantasia', ftString, 255, False);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 255, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount - 1 do
    begin
      lCampo := Data.Fields[I];

      qryConfiguracao.Params.Clear;
      qryConfiguracao.SQL.Clear;
      qryConfiguracao.SQL.Add('Select');
      qryConfiguracao.SQL.Add('  *   ');
      qryConfiguracao.SQL.Add('From VW_GridConfiguracao');
      qryConfiguracao.SQL.Add('Where 1 = 1');

      if AIdEmpresa > 0 then
      begin
        qryConfiguracao.SQL.Add(' And IdEmpresa = :IdEmpresa');

        qryConfiguracao.ParamByName('IdEmpresa').AsInteger := AIdEmpresa;
      end;

       if AIdConfiguracao > 0 then
      begin
         qryConfiguracao.SQL.Add('  And IdConfiguracao = :IdConfiguracao');

         qryConfiguracao.ParamByName('IdConfiguracao').AsInteger := AIdConfiguracao;
      end;

      if not DtmPrincipal.UsuarioSuporte then
      begin
         qryConfiguracao.SQL.Add('  And SnSuporte = :SnSuporte');

         qryConfiguracao.ParamByName('SnSuporte').AsBoolean := False;
      end;

      if Trim(AConsulta) <> '' then
      begin
        if PermitePesquisa(lCampo, AConsulta) then
        begin
          if lCampo.DataType in [ftString] then
          begin
            lCondicao := ' And ' + lCampo.FieldName + ' Like ' + QuotedStr('%' + AConsulta + '%');
          end
          else if lCampo.DataType in [ftInteger] then
          begin
            lCondicao := ' And ' + lCampo.FieldName + ' = ' + AConsulta;
          end;
          qryConfiguracao.SQL.Add(lCondicao);
          qryConfiguracao.SQL.Add('Order By');
          qryConfiguracao.SQL.Add('  NmSigla');

          qryConfiguracao.Open;
          qryConfiguracao.First;
        end;
      end
      else
      begin
        qryConfiguracao.SQL.Add(lCondicao);
        qryConfiguracao.SQL.Add('Order By');
        qryConfiguracao.SQL.Add('  NmSigla');

        lFinalizaLoop := 1;
        qryConfiguracao.Open;
        qryConfiguracao.First;
      end;

      while not qryConfiguracao.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdConfiguracao').AsInteger = qryConfiguracao.FieldByName('IdConfiguracao').AsInteger
              then
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
          Data.FieldByName('IdEmpresa').AsInteger       := qryConfiguracao.FieldByName('IdEmpresa').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger       := qryConfiguracao.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('IdConfiguracao').AsInteger  := qryConfiguracao.FieldByName('IdConfiguracao').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime     := qryConfiguracao.FieldByName('DtCadastro').AsDateTime;
          if qryConfiguracao.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'ATIVO';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'INATIVO';
          end;
          Data.FieldByName('NmSigla').AsString          := qryConfiguracao.FieldByName('NmSigla').AsString;
          Data.FieldByName('NmConfiguracao').AsString   := qryConfiguracao.FieldByName('NmConfiguracao').AsString;
          Data.FieldByName('NmValor').AsString          := qryConfiguracao.FieldByName('NmValor').AsString;
          Data.FieldByName('NmRazaoSocialNmFantasia').AsString       := qryConfiguracao.FieldByName('NmRazaoSocialNmFantasia').AsString;
          Data.FieldByName('NmUsuarioCadastro').AsString       := qryConfiguracao.FieldByName('NmUsuarioCadastro').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryConfiguracao.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryConfiguracao.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TConfiguracao.Create;
begin
  Inicializar();
end;

procedure TConfiguracao.Inicializar();
begin
  IdEmpresa       := 0;
  IdUsuario       := 0;
  IdConfiguracao  := 0;
  DtCadastro      := 0;
  SnSituacao      := 0;
  NmSigla         := '';
  NmConfiguracao  := '';
  NmValor         := '';
  NmRazaoSocialNmFantasia      := '';
  NmUsuarioCadastro := '';
end;

function TConfiguracao.Salvar(ASQLConnection: TFDConnection): Boolean;
var
  qryConfiguracao: TFDQuery;
begin
  qryConfiguracao := TFDQuery.Create(Nil);
  try

    qryConfiguracao.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdConfiguracao) then
    begin
      qryConfiguracao.SQL.Add('Insert Into Configuracao(');
      qryConfiguracao.SQL.Add('  IdEmpresa,');
      qryConfiguracao.SQL.Add('  IdUsuario,');
      qryConfiguracao.SQL.Add('  DtCadastro,');
      qryConfiguracao.SQL.Add('  SnSituacao,');
      qryConfiguracao.SQL.Add('  NmSigla,');
      qryConfiguracao.SQL.Add('  NmConfiguracao,');
      qryConfiguracao.SQL.Add('  NmValor)');
      qryConfiguracao.SQL.Add('Values (');
      qryConfiguracao.SQL.Add('  :IdEmpresa,');
      qryConfiguracao.SQL.Add('  :IdUsuario,');
      qryConfiguracao.SQL.Add('  :DtCadastro,');
      qryConfiguracao.SQL.Add('  :SnSituacao,');
      qryConfiguracao.SQL.Add('  :NmSigla,');
      qryConfiguracao.SQL.Add('  :NmConfiguracao,');
      qryConfiguracao.SQL.Add('  :NmValor)');

      qryConfiguracao.ParamByName('IdEmpresa').AsInteger    := IdEmpresa;
      qryConfiguracao.ParamByName('IdUsuario').AsInteger    := IdUsuario;
      qryConfiguracao.ParamByName('DtCadastro').AsDateTime  := DtCadastro;

    end
    else
    begin
      qryConfiguracao.SQL.Add('Update Configuracao Set ');
      qryConfiguracao.SQL.Add('  SnSituacao = :SnSituacao,');
      qryConfiguracao.SQL.Add('  NmConfiguracao = :NmConfiguracao,');
      qryConfiguracao.SQL.Add('  NmValor = :NmValor ');
      qryConfiguracao.SQL.Add('Where IdConfiguracao = :IdConfiguracao');
      qryConfiguracao.SQL.Add('  And NmSigla = :NmSigla');

      qryConfiguracao.ParamByName('IdConfiguracao').AsInteger := IdConfiguracao;

    end;
    qryConfiguracao.ParamByName('SnSituacao').AsInteger       := SnSituacao;
    qryConfiguracao.ParamByName('NmSigla').AsString           := NmSigla;
    qryConfiguracao.ParamByName('NmConfiguracao').AsString    := NmConfiguracao;
    qryConfiguracao.ParamByName('NmValor').AsString           := NmValor;
    try
      qryConfiguracao.ExecSQL;
      qryConfiguracao.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryConfiguracao)
  end;
end;

class function TConfiguracao.Inativar(ASQLConnection: TFDConnection; AIdEmpresa: Integer; ANmSigla: String): Boolean;
var
  qryConfiguracao: TFDQuery;
begin
  qryConfiguracao := TFDQuery.Create(Nil);
  try
    qryConfiguracao.Connection := ASQLConnection;
    qryConfiguracao.SQL.Add('Update Configuracao Set ');
    qryConfiguracao.SQL.Add('  SnSituacao = 0 ');
    qryConfiguracao.SQL.Add('Where IdEmpresa = ' + IntToStr(AIdEmpresa));
    qryConfiguracao.SQL.Add('  And NmSigla = ' + QuotedStr(ANmSigla));
    try
      qryConfiguracao.ExecSQL;
      qryConfiguracao.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryConfiguracao)
  end;
end;

class function TConfiguracao.Existe(ASQLConnection: TFDConnection; AIdConfiguracao: Integer): Boolean;
var
  qryConfiguracao: TFDQuery;
begin
  Result := False;
  qryConfiguracao := TFDQuery.Create(Nil);
  try
    qryConfiguracao.Connection := ASQLConnection;
    qryConfiguracao.SQL.Add('Select IdEmpresa From Configuracao');
    qryConfiguracao.SQL.Add('Where IdConfiguracao = ' + IntToStr(AIdConfiguracao));
    qryConfiguracao.Open;
    if qryConfiguracao.Fields[0].Value > 0 then
      Result := True;
    qryConfiguracao.Close;
  finally
    FreeAndNil(qryConfiguracao)
  end;
end;

class function TConfiguracao.AtualizaValor(ASQLConnection: TFDConnection; AIdEmpresa: Integer; ANmSigla: String; INmValor: Integer): Boolean;
var
  qryConfiguracao: TFDQuery;
begin
  qryConfiguracao := TFDQuery.Create(Nil);
  try
    qryConfiguracao.Connection := ASQLConnection;
    qryConfiguracao.SQL.Add('Update Configuracao Set ');
    qryConfiguracao.SQL.Add('  NmValor = :NmValor ');
    qryConfiguracao.SQL.Add('Where IdEmpresa = ' + IntToStr(AIdEmpresa));
    qryConfiguracao.SQL.Add('  And NmSigla = ' + QuotedStr(ANmSigla));

    qryConfiguracao.ParamByName('NmValor').AsString := IntToStr(INmValor);

    try
      qryConfiguracao.ExecSQL;
      qryConfiguracao.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryConfiguracao)
  end;
end;

class function TConfiguracao.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryConfiguracao: TFDQuery;
begin
  Result := 0;
  qryConfiguracao := TFDQuery.Create(Nil);
  try
    qryConfiguracao.Connection := ASQLConnection;
    qryConfiguracao.SQL.Add('Select Max(IdConfiguracao) As IdConfiguracao From Configuracao');
    qryConfiguracao.Open;

    if qryConfiguracao.FieldByName('IdConfiguracao').AsInteger > 0 then
      Result := qryConfiguracao.FieldByName('IdConfiguracao').AsInteger;
    qryConfiguracao.Close;
  finally
    FreeAndNil(qryConfiguracao)
  end;
end;

function TConfiguracao.Buscar(ASQLConnection: TFDConnection; AIdEmpresa: Integer; ANmSigla: String): Boolean;
var
  qryConfiguracao: TFDQuery;
begin
  Result := False;
  qryConfiguracao := TFDQuery.Create(Nil);
  try
    qryConfiguracao.Connection := ASQLConnection;
    qryConfiguracao.SQL.Add('Select * From VW_GridConfiguracao');
    qryConfiguracao.SQL.Add('Where IdEmpresa = :IdEmpresa');
    qryConfiguracao.SQL.Add('  And NmSigla = :NmSigla');

    qryConfiguracao.ParamByName('IdEmpresa').AsInteger  := AIdEmpresa;
    qryConfiguracao.ParamByName('NmSigla').AsString     := ANmSigla;

    qryConfiguracao.Open;
    if not qryConfiguracao.IsEmpty then
    begin
      Result          := True;
      IdEmpresa       := qryConfiguracao.FieldByName('IdEmpresa').AsInteger;
      IdUsuario       := qryConfiguracao.FieldByName('IdUsuario').AsInteger;
      IdConfiguracao  := qryConfiguracao.FieldByName('IdConfiguracao').AsInteger;
      DtCadastro      := qryConfiguracao.FieldByName('DtCadastro').AsDateTime;
      if qryConfiguracao.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao    := 1
      end
      else
      begin
        SnSituacao    := 0
      end;
      NmSigla         := qryConfiguracao.FieldByName('NmSigla').AsString;
      NmConfiguracao  := qryConfiguracao.FieldByName('NmConfiguracao').AsString;
      NmValor         := qryConfiguracao.FieldByName('NmValor').AsString;
      NmRazaoSocialNmFantasia      := qryConfiguracao.FieldByName('NmRazaoSocialNmFantasia').AsString;
      NmUsuarioCadastro      := qryConfiguracao.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryConfiguracao.Close;
  finally
    FreeAndNil(qryConfiguracao)
  end;
end;

function TConfiguracao.BuscarConfiguracao(ASQLConnection: TFDConnection; AIdConfiguracao: Integer): Boolean;
var
  qryConfiguracao: TFDQuery;
begin
  Result          := False;
  qryConfiguracao := TFDQuery.Create(Nil);
  try
    qryConfiguracao.Connection := ASQLConnection;
    qryConfiguracao.SQL.Add('Select * From VW_GridConfiguracao');
    qryConfiguracao.SQL.Add('Where IdConfiguracao = :IdConfiguracao');

    qryConfiguracao.ParamByName('IdConfiguracao').AsInteger := AIdConfiguracao;

    qryConfiguracao.Open;
    if not qryConfiguracao.IsEmpty then
    begin
      Result          := True;
      IdEmpresa       := qryConfiguracao.FieldByName('IdEmpresa').AsInteger;
      IdUsuario       := qryConfiguracao.FieldByName('IdUsuario').AsInteger;
      IdConfiguracao  := qryConfiguracao.FieldByName('IdConfiguracao').AsInteger;
      DtCadastro      := qryConfiguracao.FieldByName('DtCadastro').AsDateTime;
      if qryConfiguracao.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao    := 1
      end
      else
      begin
        SnSituacao    := 0
      end;
      NmSigla         := qryConfiguracao.FieldByName('NmSigla').AsString;
      NmConfiguracao  := qryConfiguracao.FieldByName('NmConfiguracao').AsString;
      NmValor         := qryConfiguracao.FieldByName('NmValor').AsString;
      NmRazaoSocialNmFantasia      := qryConfiguracao.FieldByName('NmRazaoSocialNmFantasia').AsString;
      NmUsuarioCadastro      := qryConfiguracao.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryConfiguracao.Close;
  finally
    FreeAndNil(qryConfiguracao)
  end;
end;

function TConfiguracao.BuscarSigla(ASQLConnection: TFDConnection; ANmSigla: String): Boolean;
var
  qryConfiguracao: TFDQuery;
begin
  Result          := False;
  qryConfiguracao := TFDQuery.Create(Nil);
  try
    qryConfiguracao.Connection := ASQLConnection;
    qryConfiguracao.SQL.Add('Select * From VW_GridConfiguracao ');
    qryConfiguracao.SQL.Add('Where NmSigla = :NmSigla          ');

    qryConfiguracao.ParamByName('NmSigla').AsString := ANmSigla;

    qryConfiguracao.Open;
    if not qryConfiguracao.IsEmpty then
    begin
      Result          := True;
      IdEmpresa       := qryConfiguracao.FieldByName('IdEmpresa').AsInteger;
      IdUsuario       := qryConfiguracao.FieldByName('IdUsuario').AsInteger;
      IdConfiguracao  := qryConfiguracao.FieldByName('IdConfiguracao').AsInteger;
      DtCadastro      := qryConfiguracao.FieldByName('DtCadastro').AsDateTime;
      if qryConfiguracao.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao    := 1
      end
      else
      begin
        SnSituacao    := 0
      end;
      NmSigla         := qryConfiguracao.FieldByName('NmSigla').AsString;
      NmConfiguracao  := qryConfiguracao.FieldByName('NmConfiguracao').AsString;
      NmValor         := qryConfiguracao.FieldByName('NmValor').AsString;
      NmRazaoSocialNmFantasia      := qryConfiguracao.FieldByName('NmRazaoSocialNmFantasia').AsString;
      NmUsuarioCadastro      := qryConfiguracao.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryConfiguracao.Close;
  finally
    FreeAndNil(qryConfiguracao)
  end;
end;

end.
