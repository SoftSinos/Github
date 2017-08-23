unit uEmpresa;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TEmpresa = class
  private
    FIdEmpresa              : Integer;
    FIdUsuario              : Integer;
    FDtCadastro             : TDateTime;
    FSnSituacao             : Integer;
    FNmRazaoSocial          : String;
    FNmFantasia             : String;
    FNrCnpj                 : String;
    FNrIE                   : String;
    FNrNumero               : String;
    FNmComplemento          : String;
    FNrCep                  : String;
    FNrTelefone             : String;
    FImLogoTipo             : WideString;
    FNmObs                  : WideString;
    FNmEmail                : String;
    FNmSitio                : String;
    FNmFantasiaNmRazaoSocial: String;
    FNmEndereco             : String;
    FNmBairro               : String;
    FNmCidade               : String;
    FNmSiglaUf              : String;
    FNmUsuarioCadastro      : String;
    FImLogoTipoSoftHouse    : WideString;
    procedure Inicializar;
  public
    property IdEmpresa              : Integer     read FIdEmpresa write FIdEmpresa;
    property IdUsuario              : Integer     read FIdUsuario write FIdUsuario;
    property DtCadastro             : TDateTime   read FDtCadastro write FDtCadastro;
    property SnSituacao             : Integer     read FSnSituacao write FSnSituacao;
    property NmRazaoSocial          : String      read FNmRazaoSocial write FNmRazaoSocial;
    property NmFantasia             : String      read FNmFantasia write FNmFantasia;
    property NrCnpj                 : String      read FNrCnpj write FNrCnpj;
    property NrIE                   : String      read FNrIE write FNrIE;
    property NrNumero               : String      read FNrNumero write FNrNumero;
    property NmComplemento          : String      read FNmComplemento write FNmComplemento;
    property NrCep                  : String      read FNrCep write FNrCep;
    property NrTelefone             : String      read FNrTelefone write FNrTelefone;
    property ImLogoTipo             : WideString  read FImLogoTipo write FImLogoTipo;
    property NmObs                  : WideString  read FNmObs write FNmObs;
    property NmEmail                : String      read FNmEmail write FNmEmail;
    property NmSitio                : String      read FNmSitio write FNmSitio;
    property NmFantasiaNmRazaoSocial: String      read FNmFantasiaNmRazaoSocial write FNmFantasiaNmRazaoSocial;
    property NmEndereco             : String      read FNmEndereco write FNmEndereco;
    property NmBairro               : String      read FNmBairro write FNmBairro;
    property NmCidade               : String      read FNmCidade write FNmCidade;
    property NmSiglaUf              : String      read FNmSiglaUf write FNmSiglaUf;
    property NmUsuarioCadastro      : String      read FNmUsuarioCadastro write FNmUsuarioCadastro;
    property ImLogoTipoSoftHouse    : WideString  read FImLogoTipo write FImLogoTipo;

    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdEmpresa: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdEmpresa: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdEmpresa: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdEmpresa: Integer; AConsulta: String; Data: TClientDataSet);
    function BuscarImagem(ASQLConnection: TFDConnection; AIdEmpresa: Integer; Data: TClientDataSet): Boolean;
    function ExisteCadastro(ASQLConnection: TFDConnection): Boolean;
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TEmpresa.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdEmpresa: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryEmpresa : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryEmpresa := TFDQuery.Create(nil);
  try
    qryEmpresa.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 9, False);
      Data.FieldDefs.Add('NmRazaoSocial', ftString, 100, False);
      Data.FieldDefs.Add('NmFantasia', ftString, 20, False);
      Data.FieldDefs.Add('NrCnpj', ftString, 20, False);
      Data.FieldDefs.Add('NrIE', ftString, 20, False);
      Data.FieldDefs.Add('NrNumero', ftString, 10, False);
      Data.FieldDefs.Add('NmComplemento', ftString, 255, False);
      Data.FieldDefs.Add('NrCep', ftString, 15, False);
      Data.FieldDefs.Add('NrTelefone', ftString, 15, False);
      Data.FieldDefs.Add('ImLogoTipo', ftBlob, 4000, False);
      Data.FieldDefs.Add('NmObs', ftWideString, 255, False);
      Data.FieldDefs.Add('NmEmail', ftString, 100, False);
      Data.FieldDefs.Add('NmSitio', ftString, 50, False);
      Data.FieldDefs.Add('NmFantasiaNmRazaoSocial', ftString, 120, False);
      Data.FieldDefs.Add('NmEndereco', ftString, 70, False);
      Data.FieldDefs.Add('NmBairro', ftString, 25, False);
      Data.FieldDefs.Add('NmCidade', ftString, 50, False);
      Data.FieldDefs.Add('NmSiglaUf', ftString, 2, False);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 50, False);
      Data.FieldDefs.Add('ImLogoTipoSoftHouse', ftBlob, 4000, False);

      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryEmpresa.Params.Clear;
      qryEmpresa.SQL.Clear;
      qryEmpresa.SQL.Add('Select             ');
      qryEmpresa.SQL.Add('  *                ');
      qryEmpresa.SQL.Add('From VW_GridEmpresa');
      qryEmpresa.SQL.Add('Where 1 = 1        ');

      if ISnSituacao = 1 then
      begin
         qryEmpresa.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryEmpresa.SQL.Add('  And SnSituacao = 0');
      end;

       if AIdEmpresa > 0 then
      begin
         qryEmpresa.SQL.Add('  And IdEmpresa = :IdEmpresa');

         qryEmpresa.ParamByName('IdEmpresa').AsInteger := AIdEmpresa;
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
          qryEmpresa.SQL.Add (lCondicao);
          qryEmpresa.SQL.Add ('Order By');
          qryEmpresa.SQL.Add (' IdEmpresa');

          qryEmpresa.Open;
          qryEmpresa.First;
        end;
      end else begin
        qryEmpresa.SQL.Add (lCondicao);
        qryEmpresa.SQL.Add ('Order By');
        qryEmpresa.SQL.Add (' IdEmpresa');

        lFinalizaLoop := 1;
        qryEmpresa.Open;
        qryEmpresa.First;
      end;

      while not qryEmpresa.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdEmpresa').AsInteger = qryEmpresa.FieldByName('IdEmpresa').AsInteger then
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
          Data.FieldByName('IdEmpresa').AsInteger               := qryEmpresa.FieldByName('IdEmpresa').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger               := qryEmpresa.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime             := qryEmpresa.FieldByName('DtCadastro').AsDateTime;
          if qryEmpresa.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'ATIVO';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'INATIVO';
          end;
          Data.FieldByName('NmRazaoSocial').AsString            := qryEmpresa.FieldByName('NmRazaoSocial').AsString;
          Data.FieldByName('NmFantasia').AsString               := qryEmpresa.FieldByName('NmFantasia').AsString;
          Data.FieldByName('NrCnpj').AsString                   := qryEmpresa.FieldByName('NrCnpj').AsString;
          Data.FieldByName('NrIE').AsString                     := qryEmpresa.FieldByName('NrIE').AsString;
          Data.FieldByName('NrNumero').AsString                 := qryEmpresa.FieldByName('NrNumero').AsString;
          Data.FieldByName('NmComplemento').AsString            := qryEmpresa.FieldByName('NmComplemento').AsString;
          Data.FieldByName('NrCep').AsString                    := qryEmpresa.FieldByName('NrCep').AsString;
          Data.FieldByName('NrTelefone').AsString               := qryEmpresa.FieldByName('NrTelefone').AsString;
          Data.FieldByName('ImLogoTipo').AsWideString           :=  qryEmpresa.FieldByName('ImLogoTipo').AsWideString;
          Data.FieldByName('NmObs').AsWideString                := qryEmpresa.FieldByName('NmObs').AsWideString;
          Data.FieldByName('NmEmail').AsString                  := qryEmpresa.FieldByName('NmEmail').AsString;
          Data.FieldByName('NmSitio').AsString                  := qryEmpresa.FieldByName('NmSitio').AsString;
          Data.FieldByName('NmFantasiaNmRazaoSocial').AsString  := qryEmpresa.FieldByName('NmFantasiaNmRazaoSocial').AsString;
          Data.FieldByName('NmEndereco').AsString               := qryEmpresa.FieldByName('NmEndereco').AsString;
          Data.FieldByName('NmBairro').AsString                 := qryEmpresa.FieldByName('NmBairro').AsString;
          Data.FieldByName('NmCidade').AsString                 := qryEmpresa.FieldByName('NmCidade').AsString;
          Data.FieldByName('NmSiglaUf').AsString                := qryEmpresa.FieldByName('NmSiglaUf').AsString;
          Data.FieldByName('NmUsuarioCadastro').AsString        := qryEmpresa.FieldByName('NmUsuarioCadastro').AsString;
          Data.FieldByName('ImLogoTipoSoftHouse').AsWideString  :=  qryEmpresa.FieldByName('ImLogoTipoSoftHouse').AsWideString;

          Data.Post;
        end;

        lVerificacao := 0;
        qryEmpresa.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryEmpresa.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TEmpresa.Create;
begin
  Inicializar;
end;

procedure TEmpresa.Inicializar;
begin
  IdEmpresa := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  NmRazaoSocial := '';
  NmFantasia := '';
  NrCnpj := '';
  NrIE := '';
  NrNumero := '';
  NmComplemento := '';
  NrCep := '';
  NrTelefone := '';
  NmObs := '';
  NmEmail := '';
  NmSitio := '';
  NmFantasiaNmRazaoSocial := '';
  NmEndereco := '';
  NmBairro := '';
  NmCidade := '';
  NmSiglaUf := '';
  NmSiglaUf := '';
  NmUsuarioCadastro := '';
end;

function TEmpresa.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryEmpresa: TFDQuery;
begin
  qryEmpresa:= TFDQuery.Create(Nil);
  try
    qryEmpresa.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdEmpresa) then
    begin
      qryEmpresa.SQL.Add('Insert Into Empresa(');
      qryEmpresa.SQL.Add('  IdEmpresa,');
      qryEmpresa.SQL.Add('  IdUsuario,');
      qryEmpresa.SQL.Add('  SnSituacao,');
      qryEmpresa.SQL.Add('  NmRazaoSocial,');
      qryEmpresa.SQL.Add('  NmFantasia,');
      qryEmpresa.SQL.Add('  NrCnpj,');
      qryEmpresa.SQL.Add('  NrIE,');
      qryEmpresa.SQL.Add('  NrNumero,');
      qryEmpresa.SQL.Add('  NmComplemento,');
      qryEmpresa.SQL.Add('  NrCep,');
      qryEmpresa.SQL.Add('  NrTelefone,');
      qryEmpresa.SQL.Add('  NmObs,');
      qryEmpresa.SQL.Add('  NmEmail,');
      qryEmpresa.SQL.Add('  NmSitio)');
      qryEmpresa.SQL.Add('Values (');
      qryEmpresa.SQL.Add('  :IdEmpresa,');
      qryEmpresa.SQL.Add('  :IdUsuario,');
      qryEmpresa.SQL.Add('  :SnSituacao,');
      qryEmpresa.SQL.Add('  :NmRazaoSocial,');
      qryEmpresa.SQL.Add('  :NmFantasia,');
      qryEmpresa.SQL.Add('  :NrCnpj,');
      qryEmpresa.SQL.Add('  :NrIE,');
      qryEmpresa.SQL.Add('  :NrNumero,');
      qryEmpresa.SQL.Add('  :NmComplemento,');
      qryEmpresa.SQL.Add('  :NrCep,');
      qryEmpresa.SQL.Add('  :NrTelefone,');
      qryEmpresa.SQL.Add('  :NmObs,');
      qryEmpresa.SQL.Add('  :NmEmail,');
      qryEmpresa.SQL.Add('  :NmSitio)');

      qryEmpresa.ParamByName('IdUsuario').AsInteger := IdUsuario;
    end else begin
      qryEmpresa.SQL.Add('Update Empresa Set ');
      qryEmpresa.SQL.Add('  SnSituacao = :SnSituacao,');
      qryEmpresa.SQL.Add('  NmRazaoSocial = :NmRazaoSocial,');
      qryEmpresa.SQL.Add('  NmFantasia = :NmFantasia,');
      qryEmpresa.SQL.Add('  NrCnpj = :NrCnpj,');
      qryEmpresa.SQL.Add('  NrIE = :NrIE,');
      qryEmpresa.SQL.Add('  NrNumero = :NrNumero,');
      qryEmpresa.SQL.Add('  NmComplemento = :NmComplemento,');
      qryEmpresa.SQL.Add('  NrCep = :NrCep,');
      qryEmpresa.SQL.Add('  NrTelefone = :NrTelefone,');
      qryEmpresa.SQL.Add('  NmObs = :NmObs,');
      qryEmpresa.SQL.Add('  NmEmail = :NmEmail,');
      qryEmpresa.SQL.Add('  NmSitio = :NmSitio ');
      qryEmpresa.SQL.Add('Where IdEmpresa = :IdEmpresa');
    end;
    qryEmpresa.ParamByName('IdEmpresa').AsInteger := IdEmpresa;
    qryEmpresa.ParamByName('SnSituacao').AsInteger := SnSituacao;
    qryEmpresa.ParamByName('NmRazaoSocial').AsString := NmRazaoSocial;
    qryEmpresa.ParamByName('NmFantasia').AsString := NmFantasia;
    qryEmpresa.ParamByName('NrCnpj').AsString := NrCnpj;
    qryEmpresa.ParamByName('NrIE').AsString := NrIE;
    qryEmpresa.ParamByName('NrNumero').AsString := NrNumero;
    qryEmpresa.ParamByName('NmComplemento').AsString := NmComplemento;
    qryEmpresa.ParamByName('NrCep').AsString := NrCep;
    qryEmpresa.ParamByName('NrTelefone').AsString := NrTelefone;
    qryEmpresa.ParamByName('NmObs').AsWideString := NmObs;
    qryEmpresa.ParamByName('NmEmail').AsString := NmEmail;
    qryEmpresa.ParamByName('NmSitio').AsString := NmSitio;
   try
      qryEmpresa.ExecSQL;
      qryEmpresa.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryEmpresa)
  end;
end;

class function TEmpresa.Inativar(ASQLConnection: TFDConnection; AIdEmpresa: Integer): Boolean;
var
  qryEmpresa: TFDQuery;
begin
  qryEmpresa:= TFDQuery.Create(Nil);
  try
    qryEmpresa.Connection := ASQLConnection;
    qryEmpresa.SQL.Add('Update Empresa Set ');
    qryEmpresa.SQL.Add('  SnSituacao = 0 ');
    qryEmpresa.SQL.Add('Where 1 = 1');
    qryEmpresa.SQL.Add('  And IdEmpresa = ' + IntToStr(AIdEmpresa));
   try
      qryEmpresa.ExecSQL;
      qryEmpresa.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryEmpresa)
  end;
end;

class function TEmpresa.Existe(ASQLConnection: TFDConnection; AIdEmpresa: Integer): Boolean;
var
  qryEmpresa: TFDQuery;
begin
  Result := False;
  qryEmpresa:= TFDQuery.Create(Nil);
  try
    qryEmpresa.Connection := ASQLConnection;
    qryEmpresa.SQL.Add('Select IdEmpresa From Empresa');
    qryEmpresa.SQL.Add('Where 1 = 1');
    qryEmpresa.SQL.Add('  And IdEmpresa = ' + IntToStr(AIdEmpresa));
    qryEmpresa.Open;
    if qryEmpresa.Fields[0].Value > 0 then
      Result := True;
    qryEmpresa.Close;
  finally
    FreeAndNil(qryEmpresa)
  end;
end;

class function TEmpresa.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryEmpresa: TFDQuery;
begin
  Result := 0;
  qryEmpresa:= TFDQuery.Create(Nil);
  try
    qryEmpresa.Connection := ASQLConnection;
    qryEmpresa.SQL.Add('Select Max(IdEmpresa) As IdEmpresa From Empresa');
    qryEmpresa.Open;

    if qryEmpresa.FieldByName('IdEmpresa').AsInteger > 0 then
      Result := qryEmpresa.FieldByName('IdEmpresa').AsInteger;
    qryEmpresa.Close;
  finally
    FreeAndNil(qryEmpresa)
  end;
end;

function TEmpresa.Buscar(ASQLConnection: TFDConnection; AIdEmpresa: Integer): Boolean;
var
  qryEmpresa: TFDQuery;
begin
  Result := False;
  qryEmpresa:= TFDQuery.Create(Nil);
  try
    qryEmpresa.Connection := ASQLConnection;
    qryEmpresa.SQL.Add('Select * From VW_GridEmpresa');
    qryEmpresa.SQL.Add('Where IdEmpresa = :IdEmpresa');

    qryEmpresa.ParamByName('IdEmpresa').AsString := IntToStr(AIdEmpresa);

    qryEmpresa.Open;
    if not qryEmpresa.IsEmpty then
    begin
      Result := True;
      IdEmpresa := qryEmpresa.FieldByName('IdEmpresa').AsInteger;
      IdUsuario := qryEmpresa.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryEmpresa.FieldByName('DtCadastro').AsDateTime;
      if qryEmpresa.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end else begin
        SnSituacao := 0
      end;
      NmRazaoSocial := qryEmpresa.FieldByName('NmRazaoSocial').AsString;
      NmFantasia := qryEmpresa.FieldByName('NmFantasia').AsString;
      NrCnpj := qryEmpresa.FieldByName('NrCnpj').AsString;
      NrIE := qryEmpresa.FieldByName('NrIE').AsString;
      NrNumero := qryEmpresa.FieldByName('NrNumero').AsString;
      NmComplemento := qryEmpresa.FieldByName('NmComplemento').AsString;
      NrCep := qryEmpresa.FieldByName('NrCep').AsString;
      NrTelefone := qryEmpresa.FieldByName('NrTelefone').AsString;
      ImLogoTipo := qryEmpresa.FieldByName('ImLogoTipo').AsWideString;
      NmObs := qryEmpresa.FieldByName('NmObs').AsWideString;
      NmEmail := qryEmpresa.FieldByName('NmEmail').AsString;
      NmSitio := qryEmpresa.FieldByName('NmSitio').AsString;
      NmFantasiaNmRazaoSocial := qryEmpresa.FieldByName('NmFantasiaNmRazaoSocial').AsString;
      NmEndereco := qryEmpresa.FieldByName('NmEndereco').AsString;
      NmBairro := qryEmpresa.FieldByName('NmBairro').AsString;
      NmCidade := qryEmpresa.FieldByName('NmCidade').AsString;
      NmSiglaUf := qryEmpresa.FieldByName('NmSiglaUf').AsString;
      NmUsuarioCadastro := qryEmpresa.FieldByName('NmUsuarioCadastro').AsString;
      ImLogoTipoSoftHouse := qryEmpresa.FieldByName('ImLogoTipoSoftHouse').AsWideString;
    end;
    qryEmpresa.Close;
  finally
    FreeAndNil(qryEmpresa)
  end;
end;

function TEmpresa.BuscarImagem(ASQLConnection: TFDConnection; AIdEmpresa: Integer; Data: TClientDataSet): Boolean;
var
  qryEmpresa: TFDQuery;
  I         : Integer;
begin
  Result                  := False;

  qryEmpresa              := TFDQuery.Create(nil);
  try
    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('ImLogoTipo', ftBlob);
      Data.FieldDefs.Add('IdRetorno', ftInteger);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    qryEmpresa.Params.Clear;
    qryEmpresa.SQL.Clear;

    qryEmpresa.Connection := ASQLConnection;

    qryEmpresa.SQL.Add('Select ImLogoTipo From Empresa');
    qryEmpresa.SQL.Add('Where IdEmpresa = :IdEmpresa  ');

    qryEmpresa.ParamByName('IdEmpresa').AsInteger := AIdEmpresa;

    qryEmpresa.Open;
    qryEmpresa.First;

    while not qryEmpresa.Eof do
    begin
      Data.Append;
      Data.FieldByName('ImLogoTipo').AsBytes        := qryEmpresa.FieldByName('ImLogoTipo').AsBytes;
      Data.Post;
      qryEmpresa.Next;
      Result := True;
    end;
  finally
    qryEmpresa.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

function TEmpresa.ExisteCadastro(ASQLConnection: TFDConnection): Boolean;
var
  qryEmpresa: TFDQuery;
begin
  Result      := False;
  qryEmpresa  := TFDQuery.Create(Nil);

  qryEmpresa.Connection := ASQLConnection;

  try
    qryEmpresa.SQL.Add('Select Count(*) From Empresa');
    qryEmpresa.Open;
    if qryEmpresa.Fields[0].Value > 0 then
    begin
      Result := True;
    end;
    qryEmpresa.Close;
  finally
    FreeAndNil(qryEmpresa)
  end;
end;

end.

