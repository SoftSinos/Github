unit uServico;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TServico = class
  private
    FIdServico          : Integer;
    FIdUsuario          : Integer;
    FDtCadastro         : TDateTime;
    FSnSituacao         : Integer;
    FIdProfissional     : Integer;
    FIdTpServico        : Integer;
    FNmTpServico        : String;
    FVlServico          : Extended;
    FHrServico          : TTime;
    FNmProfissional     : String;
    FPcComissao         : Extended;
    FNmGrupoServico     : String;
    FNmUsuarioCadastro  : String;
    FIdEmpProfissional  : Integer;
  public
    property IdServico           : Integer  read FIdServico         write FIdServico;
    property IdUsuario          : Integer   read FIdUsuario         write FIdUsuario;
    property DtCadastro         : TDateTime read FDtCadastro        write FDtCadastro;
    property SnSituacao         : Integer   read FSnSituacao        write FSnSituacao;
    property IdProfissional     : Integer   read FIdProfissional    write FIdProfissional;
    property IdTpServico        : Integer   read FIdTpServico       write FIdTpServico;
    property NmTpServico        : String    read FNmTpServico       write FNmTpServico;
    property VlServico          : Extended  read FVlServico         write FVlServico;
    property HrServico          : TTime     read FHrServico         write FHrServico;
    property NmProfissional     : String    read FNmProfissional    write FNmProfissional;
    property PcComissao         : Extended  read FPcComissao        write FPcComissao;
    property NmGrupoServico     : String    read FNmGrupoServico    write FNmGrupoServico;
    property NmUsuarioCadastro  : String    read FNmUsuarioCadastro write FNmUsuarioCadastro;
    property IdEmpProfissional  : Integer   read FIdEmpProfissional write FIdEmpProfissional;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdServico: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdServico: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdServico: Integer): Boolean;
    function BuscarProfissional(ASQLConnection: TFDConnection; ANmTpServico: String; ANmProfissional: String): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; SnQuery: Boolean; ISnSituacao: Integer; AIdServico: Integer; AIdTpServico: Integer; AConsulta: String; Data: TClientDataSet);
    procedure Inicializar;
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TServico.CarregaDbGrid(ASQLConnection: TFDConnection; SnQuery: Boolean; ISnSituacao: Integer; AIdServico: Integer; AIdTpServico: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryServico : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryServico := TFDQuery.Create(nil);
  try
    qryServico.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdServico',         ftInteger);
      Data.FieldDefs.Add('IdUsuario',         ftInteger);
      Data.FieldDefs.Add('DtCadastro',        ftDateTime);
      Data.FieldDefs.Add('SnSituacao',        ftString,   9, False);
      Data.FieldDefs.Add('IdProfissional',    ftInteger);
      Data.FieldDefs.Add('IdTpServico',       ftInteger);
      Data.FieldDefs.Add('NmTpServico',       ftString,   255, False);
      Data.FieldDefs.Add('VlServico',         ftCurrency);
      Data.FieldDefs.Add('HrServico',         ftTime);
      Data.FieldDefs.Add('NmProfissional',    ftString,   255, False);
      Data.FieldDefs.Add('PcComissao',        ftCurrency);
      Data.FieldDefs.Add('NmGrupoServico',    ftString, 10, False);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString,   255, False);
      Data.FieldDefs.Add('IdEmpProfissional', ftInteger);
      Data.CreateDataSet;
    end;

    if SnQuery then
    begin
      Data.EmptyDataSet;
      Data.DisableControls;

      for I := 0 to Data.FieldCount -1 do
      begin
        lCampo := Data.Fields[I];

        qryServico.Params.Clear;
        qryServico.SQL.Clear;
        qryServico.SQL.Add('Select                          ');
        qryServico.SQL.Add('  *                             ');
        qryServico.SQL.Add('From VW_GridServico             ');
        qryServico.SQL.Add('Where 1 = 1                     ');

        if ISnSituacao = 1 then
        begin
           qryServico.SQL.Add('  And SnSituacao = 1         ');
        end
        else
        if ISnSituacao = 0 then
        begin
           qryServico.SQL.Add('  And SnSituacao = 0         ');
        end;

        if AIdServico > 0 then
        begin
          qryServico.SQL.Add('  And IdServico = :IdServico  ');

          qryServico.ParamByName('IdServico').AsInteger := AIdServico
        end;

        if AIdTpServico > 0 then
        begin
          qryServico.SQL.Add('  And IdTpServico = :IdTpServico  ');

          qryServico.ParamByName('IdTpServico').AsInteger := AIdTpServico
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
            qryServico.SQL.Add (lCondicao);
            qryServico.SQL.Add ('Order By     ');
            qryServico.SQL.Add ('  IdServico  ');

            qryServico.Open;
            qryServico.First;
          end;
        end else begin
          qryServico.SQL.Add (lCondicao);
          qryServico.SQL.Add ('Order By     ');
          qryServico.SQL.Add ('  IdServico  ');

          lFinalizaLoop := 1;
          qryServico.Open;
          qryServico.First;
        end;

        while not qryServico.Eof do
        begin
          if Trim(AConsulta) <> '' then
          begin
            if not Data.IsEmpty then
            begin
              Data.First;
              while not Data.Eof do
              begin
                if Data.FieldByName('IdServico').AsInteger = qryServico.FieldByName('IdServico').AsInteger then
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
            Data.FieldByName('IdServico')         .AsInteger  := qryServico.FieldByName('IdServico')        .AsInteger;
            Data.FieldByName('IdUsuario')         .AsInteger  := qryServico.FieldByName('IdUsuario')        .AsInteger;
            Data.FieldByName('DtCadastro')        .AsDateTime := qryServico.FieldByName('DtCadastro')       .AsDateTime;
            if qryServico.FieldByName('SnSituacao').AsBoolean then
            begin
              Data.FieldByName('SnSituacao')      .AsString   := 'Ativo';
            end else begin
              Data.FieldByName('SnSituacao')      .AsString   := 'Inativo';
            end;
            Data.FieldByName('IdProfissional')    .AsInteger  := qryServico.FieldByName('IdProfissional')   .AsInteger;
            Data.FieldByName('IdTpServico')       .AsInteger  := qryServico.FieldByName('IdTpServico')      .AsInteger;
            Data.FieldByName('NmTpServico')       .AsString   := qryServico.FieldByName('NmTpServico')      .AsString;
            Data.FieldByName('VlServico')         .AsFloat    := qryServico.FieldByName('VlServico')        .AsFloat;
            Data.FieldByName('HrServico')         .AsDateTime := qryServico.FieldByName('HrServico')        .AsDateTime;
            Data.FieldByName('NmProfissional')    .AsString   := qryServico.FieldByName('NmProfissional')   .AsString;
            Data.FieldByName('PcComissao')        .AsFloat    := qryServico.FieldByName('PcComissao')       .AsFloat;
            Data.FieldByName('NmGrupoServico')    .AsString   := qryServico.FieldByName('NmGrupoServico')   .AsString;
            Data.FieldByName('NmUsuarioCadastro') .AsString   := qryServico.FieldByName('NmUsuarioCadastro').AsString;
            Data.FieldByName('IdEmpProfissional') .AsInteger  := qryServico.FieldByName('IdEmpProfissional').AsInteger;
            Data.Post;
          end;

          lVerificacao := 0;
          qryServico.Next;
        end;
        if lFinalizaLoop = 1 then
        begin
          Break;
        end;
      end;
    end;
  finally
    qryServico.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TServico.Create;
begin
  Inicializar;
end;

procedure TServico.Inicializar;
begin
  IdServico         := 0;
  IdUsuario         := 0;
  DtCadastro        := 0;
  SnSituacao        := 0;
  IdProfissional    := 0;
  IdTpServico       := 0;
  NmTpServico       := '';
  VlServico         := 0;
  HrServico         := 0;
  NmProfissional    := '';
  PcComissao        := 0;
  NmGrupoServico    := '';
  NmUsuarioCadastro := '';
  IdEmpProfissional := 0;
end;

function TServico.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryServico: TFDQuery;
begin
  qryServico:= TFDQuery.Create(Nil);
  try
    qryServico.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdServico) then
    begin
      qryServico.SQL.Add('Insert Into Servico(  ');
      qryServico.SQL.Add('  IdUsuario,          ');
      qryServico.SQL.Add('  DtCadastro,         ');
      qryServico.SQL.Add('  SnSituacao,         ');
      qryServico.SQL.Add('  IdProfissional,     ');
      qryServico.SQL.Add('  IdTpServico,        ');
      qryServico.SQL.Add('  IdEmpProfissional,  ');
      qryServico.SQL.Add('  PcComissao)         ');
      qryServico.SQL.Add('Values (              ');
      qryServico.SQL.Add('  :IdUsuario,         ');
      qryServico.SQL.Add('  :DtCadastro,        ');
      qryServico.SQL.Add('  :SnSituacao,        ');
      qryServico.SQL.Add('  :IdProfissional,    ');
      qryServico.SQL.Add('  :IdTpServico,       ');
      qryServico.SQL.Add('  :IdEmpProfissional, ');
      qryServico.SQL.Add('  :PcComissao)        ');

      qryServico.ParamByName('IdUsuario')       .AsInteger  := IdUsuario;
      qryServico.ParamByName('DtCadastro')      .AsDateTime := DtCadastro;

    end else begin
      qryServico.SQL.Add('Update Servico Set                         ');
      qryServico.SQL.Add('  SnSituacao         = :SnSituacao,        ');
      qryServico.SQL.Add('  IdProfissional     = :IdProfissional,    ');
      qryServico.SQL.Add('  IdEmpProfissional  = :IdEmpProfissional, ');
      qryServico.SQL.Add('  IdTpServico        = :IdTpServico,       ');
      qryServico.SQL.Add('  PcComissao         = :PcComissao         ');
      qryServico.SQL.Add('Where IdServico      = :IdServico          ');

      qryServico.ParamByName('IdServico')       .AsInteger  := IdServico;

    end;
    qryServico.ParamByName('SnSituacao')        .AsInteger    := SnSituacao;
    qryServico.ParamByName('IdProfissional')    .AsInteger    := IdProfissional;
    qryServico.ParamByName('IdTpServico')       .AsInteger    := IdTpServico;
    qryServico.ParamByName('IdEmpProfissional') .AsInteger    := IdEmpProfissional;
    qryServico.ParamByName('PcComissao')        .AsCurrency   := PcComissao;
   try
      qryServico.ExecSQL;
      qryServico.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryServico)
  end;
end;

class function TServico.Inativar(ASQLConnection: TFDConnection; AIdServico: Integer): Boolean;
var
  qryServico: TFDQuery;
begin
  qryServico:= TFDQuery.Create(Nil);
  try
    qryServico.Connection := ASQLConnection;
    qryServico.SQL.Add('Update Servico Set ');
    qryServico.SQL.Add('  SnSituacao = 0 ');
    qryServico.SQL.Add('Where 1 = 1');
    qryServico.SQL.Add('  And IdServico = ' + IntToStr(AIdServico));
   try
      qryServico.ExecSQL;
      qryServico.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryServico)
  end;
end;

class function TServico.Existe(ASQLConnection: TFDConnection; AIdServico: Integer): Boolean;
var
  qryServico: TFDQuery;
begin
  Result := False;
  qryServico:= TFDQuery.Create(Nil);
  try
    qryServico.Connection := ASQLConnection;
    qryServico.SQL.Add('Select IdServico From Servico');
    qryServico.SQL.Add('Where 1 = 1');
    qryServico.SQL.Add('  And IdServico = ' + IntToStr(AIdServico));
    qryServico.Open;
    if qryServico.Fields[0].Value > 0 then
      Result := True;
    qryServico.Close;
  finally
    FreeAndNil(qryServico)
  end;
end;

class function TServico.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryServico: TFDQuery;
begin
  Result := 0;
  qryServico:= TFDQuery.Create(Nil);
  try
    qryServico.Connection := ASQLConnection;
    qryServico.SQL.Add('Select Max(IdServico) As IdServico From Servico');
    qryServico.Open;

    if qryServico.FieldByName('IdServico').AsInteger > 0 then
      Result := qryServico.FieldByName('IdServico').AsInteger;
    qryServico.Close;
  finally
    FreeAndNil(qryServico)
  end;
end;

function TServico.Buscar(ASQLConnection: TFDConnection; AIdServico: Integer): Boolean;
var
  qryServico: TFDQuery;
begin
  Result := False;
  qryServico:= TFDQuery.Create(Nil);
  try
    qryServico.Connection := ASQLConnection;
    qryServico.SQL.Add('Select * From VW_GridServico');
    qryServico.SQL.Add('Where IdServico = :IdServico');

    qryServico.ParamByName('IdServico').AsString := IntToStr(AIdServico);

    qryServico.Open;
    if not qryServico.IsEmpty then
    begin
      Result            := True;
      IdServico         := qryServico.FieldByName('IdServico')        .AsInteger;
      IdUsuario         := qryServico.FieldByName('IdUsuario')        .AsInteger;
      DtCadastro        := qryServico.FieldByName('DtCadastro')       .AsDateTime;
      if qryServico.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao      := 1
      end else begin
        SnSituacao      := 0
      end;
      IdProfissional    := qryServico.FieldByName('IdProfissional')   .AsInteger;
      IdTpServico       := qryServico.FieldByName('IdTpServico')      .AsInteger;
      NmTpServico       := qryServico.FieldByName('NmTpServico')      .AsString;
      VlServico         := qryServico.FieldByName('VlServico')        .AsFloat;
      HrServico         := qryServico.FieldByName('HrServico'         ).AsDateTime;
      NmProfissional    := qryServico.FieldByName('NmProfissional')   .AsString;
      PcComissao        := qryServico.FieldByName('PcComissao')       .AsFloat;
      NmUsuarioCadastro := qryServico.FieldByName('NmUsuarioCadastro').AsString;
      IdEmpProfissional := qryServico.FieldByName('IdEmpProfissional').AsInteger;
    end;
    qryServico.Close;
  finally
    FreeAndNil(qryServico)
  end;
end;

function TServico.BuscarProfissional(ASQLConnection: TFDConnection; ANmTpServico: String; ANmProfissional: String): Boolean;
var
  qryServico: TFDQuery;
begin
  Result := False;
  qryServico:= TFDQuery.Create(Nil);
  try
    qryServico.Connection := ASQLConnection;
    qryServico.SQL.Add('Select * From VW_GridServico            ');
    qryServico.SQL.Add('Where NmProfissional  = :NmProfissional ');
    qryServico.SQL.Add('  And NmTpServico     = :NmTpServico    ');

    qryServico.ParamByName('NmProfissional').AsString := ANmProfissional;
    qryServico.ParamByName('NmTpServico')   .AsString := ANmTpServico;

    qryServico.Open;
    if not qryServico.IsEmpty then
    begin
      Result            := True;
      IdServico         := qryServico.FieldByName('IdServico')        .AsInteger;
      IdUsuario         := qryServico.FieldByName('IdUsuario')        .AsInteger;
      DtCadastro        := qryServico.FieldByName('DtCadastro')       .AsDateTime;
      if qryServico.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao      := 1
      end else begin
        SnSituacao      := 0
      end;
      IdProfissional    := qryServico.FieldByName('IdProfissional')   .AsInteger;
      IdTpServico       := qryServico.FieldByName('IdTpServico')      .AsInteger;
      NmTpServico       := qryServico.FieldByName('NmTpServico')      .AsString;
      VlServico         := qryServico.FieldByName('VlServico')        .AsFloat;
      NmProfissional    := qryServico.FieldByName('NmProfissional')   .AsString;
      PcComissao        := qryServico.FieldByName('PcComissao')       .AsFloat;
      NmGrupoServico    := qryServico.FieldByName('NmGrupoServico').AsString;
      NmUsuarioCadastro := qryServico.FieldByName('NmUsuarioCadastro').AsString;
      IdEmpProfissional := qryServico.FieldByName('IdEmpProfissional').AsInteger;
    end;
    qryServico.Close;
  finally
    FreeAndNil(qryServico)
  end;
end;

end.

