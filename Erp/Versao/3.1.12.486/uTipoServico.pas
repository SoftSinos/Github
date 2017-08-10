unit uTipoServico;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TTipoServico = class
  private
    FIdTpServico        : Integer;
    FIdUsuario          : Integer;
    FDtCadastro         : TDateTime;
    FSnSituacao         : Integer;
    FNmTpServico        : String;
    FVlServico          : Extended;
    FHrServico          : TTime;
    FIdGrupoServico     : Integer;
    FNmGrupoServico     : String;
    FNmUsuarioCadastro  : String;
     procedure Inicializar;
  public
    property IdTpServico        : Integer   read FIdTpServico       write FIdTpServico;
    property IdUsuario          : Integer   read FIdUsuario         write FIdUsuario;
    property DtCadastro         : TDateTime read FDtCadastro        write FDtCadastro;
    property SnSituacao         : Integer   read FSnSituacao        write FSnSituacao;
    property NmTpServico        : String    read FNmTpServico       write FNmTpServico;
    property VlServico          : Extended  read FVlServico         write FVlServico;
    property HrServico          : TTime     read FHrServico         write FHrServico;
    property IdGrupoServico     : Integer   read FIdGrupoServico    write FIdGrupoServico;
    property NmGrupoServico     : String    read FNmGrupoServico    write FNmGrupoServico;
    property NmUsuarioCadastro  : String    read FNmUsuarioCadastro write FNmUsuarioCadastro;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdTpServico: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdTpServico: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdTpServico: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdTpServico: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TTipoServico.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdTpServico: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryTipoServico : TFDQuery;
  I              : Integer;
  lCampo         : TField;
  lCondicao      : String;
  lVerificacao   : Integer;
  lFinalizaLoop  : Integer;
begin
  lVerificacao   := 0;
  lFinalizaLoop  := 0;

  qryTipoServico := TFDQuery.Create(nil);
  try
    qryTipoServico.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdTpServico',       ftInteger);
      Data.FieldDefs.Add('IdUsuario',         ftInteger);
      Data.FieldDefs.Add('DtCadastro',        ftDateTime);
      Data.FieldDefs.Add('SnSituacao',        ftString,   9, False);
      Data.FieldDefs.Add('NmTpServico',       ftString,   255, False);
      Data.FieldDefs.Add('VlServico',         ftCurrency);
      Data.FieldDefs.Add('HrServico',         ftTime);
      Data.FieldDefs.Add('IdGrupoServico',    ftInteger);
      Data.FieldDefs.Add('NmGrupoServico',    ftString,   255, False);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString,   255, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryTipoServico.Params.Clear;
      qryTipoServico.SQL.Clear;
      qryTipoServico.SQL.Add('Select                              ');
      qryTipoServico.SQL.Add('  *                                 ');
      qryTipoServico.SQL.Add('From VW_GridTipoServico             ');
      qryTipoServico.SQL.Add('Where 1 = 1                         ');

      if ISnSituacao = 1 then
      begin
         qryTipoServico.SQL.Add('  And SnSituacao = 1             ');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryTipoServico.SQL.Add('  And SnSituacao = 0             ');
      end;

      if AIdTpServico > 0 then
      begin
        qryTipoServico.SQL.Add('  And IdTpServico = :IdTpServico  ');

        qryTipoServico.ParamByName('IdTpServico').AsInteger := AIdTpServico;
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
          qryTipoServico.SQL.Add (lCondicao);
          qryTipoServico.SQL.Add ('Order By     ');
          qryTipoServico.SQL.Add ('  IdTpServico');

          qryTipoServico.Open;
          qryTipoServico.First;
        end;
      end else begin
        qryTipoServico.SQL.Add (lCondicao);
        qryTipoServico.SQL.Add ('Order By     ');
        qryTipoServico.SQL.Add ('  IdTpServico');

        lFinalizaLoop := 1;
        qryTipoServico.Open;
        qryTipoServico.First;
      end;

      while not qryTipoServico.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdTpServico').AsInteger = qryTipoServico.FieldByName('IdTpServico').AsInteger then
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
          Data.FieldByName('IdTpServico').AsInteger       := qryTipoServico.FieldByName('IdTpServico').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger         := qryTipoServico.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime       := qryTipoServico.FieldByName('DtCadastro').AsDateTime;
          if qryTipoServico.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'ATIVO';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'INATIVO';
          end;
          Data.FieldByName('NmTpServico').AsString        := qryTipoServico.FieldByName('NmTpServico').AsString;
          Data.FieldByName('VlServico').AsFloat           := qryTipoServico.FieldByName('VlServico').AsFloat;
          Data.FieldByName('HrServico').AsDateTime        := qryTipoServico.FieldByName('HrServico').AsDateTime;
          Data.FieldByName('IdGrupoServico').AsInteger    := qryTipoServico.FieldByName('IdGrupoServico').AsInteger;
          Data.FieldByName('NmGrupoServico').AsString     := qryTipoServico.FieldByName('NmGrupoServico').AsString;
          Data.FieldByName('NmUsuarioCadastro').AsString  := qryTipoServico.FieldByName('NmUsuarioCadastro').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryTipoServico.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryTipoServico.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TTipoServico.Create;
begin
  Inicializar;
end;

procedure TTipoServico.Inicializar;
begin
  IdTpServico       := 0;
  IdUsuario         := 0;
  DtCadastro        := 0;
  SnSituacao        := 0;
  NmTpServico       := '';
  VlServico         := 0;
  HrServico         := 0;
  IdGrupoServico    := 0;
  NmGrupoServico    := '';
  NmUsuarioCadastro := '';
end;

function TTipoServico.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryTipoServico: TFDQuery;
begin
  qryTipoServico:= TFDQuery.Create(Nil);
  try
    qryTipoServico.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdTpServico) then
    begin
      qryTipoServico.SQL.Add('Insert Into TipoServico(');
      qryTipoServico.SQL.Add('  IdUsuario,            ');
      qryTipoServico.SQL.Add('  DtCadastro,           ');
      qryTipoServico.SQL.Add('  SnSituacao,           ');
      qryTipoServico.SQL.Add('  NmTpServico,          ');
      qryTipoServico.SQL.Add('  IdGrupoServico,       ');
      qryTipoServico.SQL.Add('  VlServico,            ');
      qryTipoServico.SQL.Add('  HrServico)            ');
      qryTipoServico.SQL.Add('Values (                ');
      qryTipoServico.SQL.Add('  :IdUsuario,           ');
      qryTipoServico.SQL.Add('  :DtCadastro,          ');
      qryTipoServico.SQL.Add('  :SnSituacao,          ');
      qryTipoServico.SQL.Add('  :NmTpServico,         ');
      qryTipoServico.SQL.Add('  :IdGrupoServico,      ');
      qryTipoServico.SQL.Add('  :VlServico,           ');
      qryTipoServico.SQL.Add('  :HrServico)           ');

      qryTipoServico.ParamByName('IdUsuario'      ).AsInteger   := IdUsuario;
      qryTipoServico.ParamByName('DtCadastro'     ).AsDateTime  := DtCadastro;

    end else begin
      qryTipoServico.SQL.Add('Update TipoServico Set ');
      qryTipoServico.SQL.Add('  SnSituacao      =    :SnSituacao,     ');
      qryTipoServico.SQL.Add('  NmTpServico     =    :NmTpServico,    ');
      qryTipoServico.SQL.Add('  IdGrupoServico  =    :IdGrupoServico, ');
      qryTipoServico.SQL.Add('  VlServico       =    :VlServico,      ');
      qryTipoServico.SQL.Add('  HrServico       =    :HrServico       ');
      qryTipoServico.SQL.Add('Where IdTpServico =    :IdTpServico     ');

      qryTipoServico.ParamByName('IdTpServico').AsInteger := IdTpServico;

    end;
    qryTipoServico.ParamByName('SnSituacao'     ).AsInteger   := SnSituacao;
    qryTipoServico.ParamByName('NmTpServico'    ).AsString    := NmTpServico;
    qryTipoServico.ParamByName('IdGrupoServico' ).AsInteger   := IdGrupoServico;
    qryTipoServico.ParamByName('VlServico'      ).AsFloat     := VlServico;
    qryTipoServico.ParamByName('HrServico'      ).AsTime      := HrServico;
   try
      qryTipoServico.ExecSQL;
      qryTipoServico.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryTipoServico)
  end;
end;

class function TTipoServico.Inativar(ASQLConnection: TFDConnection; AIdTpServico: Integer): Boolean;
var
  qryTipoServico: TFDQuery;
begin
  qryTipoServico:= TFDQuery.Create(Nil);
  try
    qryTipoServico.Connection := ASQLConnection;
    qryTipoServico.SQL.Add('Update TipoServico Set ');
    qryTipoServico.SQL.Add('  SnSituacao = 0 ');
    qryTipoServico.SQL.Add('Where 1 = 1');
    qryTipoServico.SQL.Add('  And IdTpServico = ' + IntToStr(AIdTpServico));
   try
      qryTipoServico.ExecSQL;
      qryTipoServico.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryTipoServico)
  end;
end;

class function TTipoServico.Existe(ASQLConnection: TFDConnection; AIdTpServico: Integer): Boolean;
var
  qryTipoServico: TFDQuery;
begin
  Result := False;
  qryTipoServico:= TFDQuery.Create(Nil);
  try
    qryTipoServico.Connection := ASQLConnection;
    qryTipoServico.SQL.Add('Select IdTpServico From TipoServico');
    qryTipoServico.SQL.Add('Where 1 = 1');
    qryTipoServico.SQL.Add('  And IdTpServico = ' + IntToStr(AIdTpServico));
    qryTipoServico.Open;
    if qryTipoServico.Fields[0].Value > 0 then
      Result := True;
    qryTipoServico.Close;
  finally
    FreeAndNil(qryTipoServico)
  end;
end;

class function TTipoServico.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryTipoServico: TFDQuery;
begin
  Result := 0;
  qryTipoServico:= TFDQuery.Create(Nil);
  try
    qryTipoServico.Connection := ASQLConnection;
    qryTipoServico.SQL.Add('Select Max(IdTpServico) As IdTpServico From TipoServico');
    qryTipoServico.Open;

    if qryTipoServico.FieldByName('IdTpServico').AsInteger > 0 then
      Result := qryTipoServico.FieldByName('IdTpServico').AsInteger;
    qryTipoServico.Close;
  finally
    FreeAndNil(qryTipoServico)
  end;
end;

function TTipoServico.Buscar(ASQLConnection: TFDConnection; AIdTpServico: Integer): Boolean;
var
  qryTipoServico: TFDQuery;
begin
  Result := False;
  qryTipoServico:= TFDQuery.Create(Nil);
  try
    qryTipoServico.Connection := ASQLConnection;
    qryTipoServico.SQL.Add('Select * From VW_GridTipoServico');
    qryTipoServico.SQL.Add('Where IdTpServico = :IdTpServico');

    qryTipoServico.ParamByName('IdTpServico').AsString := IntToStr(AIdTpServico);

    qryTipoServico.Open;
    if not qryTipoServico.IsEmpty then
    begin
      Result            := True;
      IdTpServico       := qryTipoServico.FieldByName('IdTpServico'       ).AsInteger;
      IdUsuario         := qryTipoServico.FieldByName('IdUsuario'         ).AsInteger;
      DtCadastro        := qryTipoServico.FieldByName('DtCadastro'        ).AsDateTime;
      if qryTipoServico.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao      := 1
      end else begin
        SnSituacao      := 0
      end;
      NmTpServico       := qryTipoServico.FieldByName('NmTpServico'       ).AsString;
      IdGrupoServico    := qryTipoServico.FieldByName('IdGrupoServico'    ).AsInteger;
      NmGrupoServico    := qryTipoServico.FieldByName('NmGrupoServico'    ).AsString;
      VlServico         := qryTipoServico.FieldByName('VlServico'         ).AsFloat;
      HrServico         := qryTipoServico.FieldByName('HrServico'         ).AsDateTime;
      NmUsuarioCadastro := qryTipoServico.FieldByName('NmUsuarioCadastro' ).AsString;
    end;
    qryTipoServico.Close;
  finally
    FreeAndNil(qryTipoServico)
  end;
end;

end.


