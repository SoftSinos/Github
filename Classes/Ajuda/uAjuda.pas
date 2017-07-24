unit uAjuda;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet,
     FireDAC.Comp.Client, Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TAjuda = class
  private
    SQLConnection : TFDConnection;
    FIdEmpresa    : Integer;
    FIdUsuario    : Integer;
    FDtCadastro   : TDateTime;
    FSnSituacao   : Integer;
    FIdAjuda      : Integer;
    FNmTela       : String;
    FNmTopico     : String;
    FNmAjuda      : String;
    procedure Inicializar();
  public
    property IdEmpresa  : Integer   read FIdEmpresa   write FIdEmpresa;
    property IdUsuario  : Integer   read FIdUsuario   write FIdUsuario;
    property DtCadastro : TDateTime read FDtCadastro  write FDtCadastro;
    property SnSituacao : Integer   read FSnSituacao  write FSnSituacao;
    property IdAjuda    : Integer   read FIdAjuda     write FIdAjuda;
    property NmTela     : String    read FNmTela      write FNmTela;
    property NmTopico   : String    read FNmTopico    write FNmTopico;
    property NmAjuda    : String    read FNmAjuda     write FNmAjuda;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdAjuda: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdAjuda: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdAjuda: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; AIdAjuda: Integer; AConsulta: String; ANmTela: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao;

procedure TAjuda.CarregaDbGrid(ASQLConnection: TFDConnection; AIdAjuda: Integer; AConsulta: String; ANmTela: String; Data: TClientDataSet);
var
  qryAjuda      : TFDQuery;
  I             : Integer;
  lCampo        : TField;
  lCondicao     : String;
  lVerificacao  : Integer;
  lFinalizaLoop : Integer;
begin
  lVerificacao  := 0;
  lFinalizaLoop := 0;

  qryAjuda := TFDQuery.Create(nil);
  try
    qryAjuda.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdUsuario',   ftInteger);
      Data.FieldDefs.Add('DtCadastro',  ftDateTime);
      Data.FieldDefs.Add('SnSituacao',  ftString, 7, False);
      Data.FieldDefs.Add('IdAjuda',     ftInteger);
      Data.FieldDefs.Add('NmTela',      ftString, 50, False);
      Data.FieldDefs.Add('NmTopico',    ftString, 50, False);
      Data.FieldDefs.Add('NmAjuda',     ftString, 4000, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount - 1 do
    begin
      lCampo := Data.Fields[I];

      qryAjuda.Params.Clear;
      qryAjuda.SQL.Clear;
      qryAjuda.SQL.Add('Select');
      qryAjuda.SQL.Add('  *');
      qryAjuda.SQL.Add('From VW_GridAjuda');
      qryAjuda.SQL.Add('Where NmTela = :NmTela');

      qryAjuda.ParamByName('NmTela').AsString := ANmTela;

      if AIdAjuda > 0 then
      begin
         qryAjuda.SQL.Add('  And IdAjuda = :IdAjuda');

         qryAjuda.ParamByName('IdAjuda').AsInteger := AIdAjuda;
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
          qryAjuda.SQL.Add(lCondicao);
          qryAjuda.SQL.Add('Order By');
          qryAjuda.SQL.Add(' IdAjuda');

          qryAjuda.Open;
          qryAjuda.First;
        end;
      end
      else
      begin
        qryAjuda.SQL.Add(lCondicao);
        qryAjuda.SQL.Add('Order By');
        qryAjuda.SQL.Add(' IdAjuda');

        lFinalizaLoop := 1;
        qryAjuda.Open;
        qryAjuda.First;
      end;

      while not qryAjuda.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdAjuda').AsInteger = qryAjuda.FieldByName
                ('IdAjuda').AsInteger then
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
          Data.FieldByName('IdUsuario').AsInteger   := qryAjuda.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryAjuda.FieldByName('DtCadastro').AsDateTime;
          if qryAjuda.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'ATIVO';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'INATIVO';
          end;
          Data.FieldByName('IdAjuda').AsInteger     := qryAjuda.FieldByName('IdAjuda').AsInteger;
          Data.FieldByName('NmTela').AsString       := qryAjuda.FieldByName('NmTela').AsString;
          Data.FieldByName('NmTopico').AsString     := qryAjuda.FieldByName('NmTopico').AsString;
          Data.FieldByName('NmAjuda').AsString      := qryAjuda.FieldByName('NmAjuda').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryAjuda.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryAjuda.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TAjuda.Create;
begin
  Inicializar();
end;

procedure TAjuda.Inicializar();
begin
  IdEmpresa   := 0;
  IdUsuario   := 0;
  DtCadastro  := 0;
  SnSituacao  := 0;
  IdAjuda     := 0;
  NmTela      := '';
  NmTopico    := '';
  NmAjuda     := '';
end;

function TAjuda.Salvar(ASQLConnection: TFDConnection): Boolean;
var
  qryAjuda: TFDQuery;
begin
  qryAjuda := TFDQuery.Create(Nil);
  try

    qryAjuda.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdAjuda) then
    begin
      qryAjuda.SQL.Add('Insert Into Ajuda(');
      qryAjuda.SQL.Add('  IdEmpresa,');
      qryAjuda.SQL.Add('  IdUsuario,');
      qryAjuda.SQL.Add('  DtCadastro,');
      qryAjuda.SQL.Add('  SnSituacao,');
      qryAjuda.SQL.Add('  NmTela,');
      qryAjuda.SQL.Add('  NmTopico,');
      qryAjuda.SQL.Add('  NmAjuda)');
      qryAjuda.SQL.Add('Values (');
      qryAjuda.SQL.Add('  :IdEmpresa,');
      qryAjuda.SQL.Add('  :IdUsuario,');
      qryAjuda.SQL.Add('  :DtCadastro,');
      qryAjuda.SQL.Add('  :SnSituacao,');
      qryAjuda.SQL.Add('  :NmTela,');
      qryAjuda.SQL.Add('  :NmTopico,');
      qryAjuda.SQL.Add('  :NmAjuda)');

      qryAjuda.ParamByName('IdEmpresa').AsInteger   := IdEmpresa;
      qryAjuda.ParamByName('IdUsuario').AsInteger   := IdUsuario;
      qryAjuda.ParamByName('DtCadastro').AsDateTime := DtCadastro;

    end
    else
    begin
      qryAjuda.SQL.Add('Update Ajuda Set ');
      qryAjuda.SQL.Add('  SnSituacao = :SnSituacao,');
      qryAjuda.SQL.Add('  NmTela = :NmTela,');
      qryAjuda.SQL.Add('  NmTopico = :NmTopico,');
      qryAjuda.SQL.Add('  NmAjuda = :NmAjuda ');
      qryAjuda.SQL.Add('Where IdAjuda = :IdAjuda');

      qryAjuda.ParamByName('IdAjuda').AsInteger   := IdAjuda;

    end;
    qryAjuda.ParamByName('SnSituacao').AsInteger  := SnSituacao;
    qryAjuda.ParamByName('NmTela').AsString       := NmTela;
    qryAjuda.ParamByName('NmTopico').AsString     := NmTopico;
    qryAjuda.ParamByName('NmAjuda').AsString      := NmAjuda;
    try
      qryAjuda.ExecSQL;
      qryAjuda.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryAjuda)
  end;
end;

class function TAjuda.Inativar(ASQLConnection: TFDConnection; AIdAjuda: Integer): Boolean;
var
  qryAjuda: TFDQuery;
begin
  qryAjuda := TFDQuery.Create(Nil);
  try
    qryAjuda.Connection := ASQLConnection;
    qryAjuda.SQL.Add('Update Ajuda Set ');
    qryAjuda.SQL.Add('  SnSituacao = 0 ');
    qryAjuda.SQL.Add('Where IdAjuda = ' + IntToStr(AIdAjuda));
    try
      qryAjuda.ExecSQL;
      qryAjuda.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryAjuda)
  end;
end;

class function TAjuda.Existe(ASQLConnection: TFDConnection; AIdAjuda: Integer): Boolean;
var
  qryAjuda: TFDQuery;
begin
  Result := False;
  qryAjuda := TFDQuery.Create(Nil);
  try
    qryAjuda.Connection := ASQLConnection;
    qryAjuda.SQL.Add('Select IdEmpresa From Ajuda');
    qryAjuda.SQL.Add('Where IdAjuda = ' + IntToStr(AIdAjuda));
    qryAjuda.Open;
    if qryAjuda.Fields[0].Value > 0 then
      Result := True;
    qryAjuda.Close;
  finally
    FreeAndNil(qryAjuda)
  end;
end;

class function TAjuda.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryAjuda: TFDQuery;
begin
  Result := 0;
  qryAjuda := TFDQuery.Create(Nil);
  try
    qryAjuda.Connection := ASQLConnection;
    qryAjuda.SQL.Add('Select Max(IdAjuda) As IdAjuda From Ajuda');
    qryAjuda.Open;

    if qryAjuda.FieldByName('IdAjuda').AsInteger > 0 then
      Result := qryAjuda.FieldByName('IdAjuda').AsInteger;
    qryAjuda.Close;
  finally
    FreeAndNil(qryAjuda)
  end;
end;

function TAjuda.Buscar(ASQLConnection: TFDConnection; AIdAjuda: Integer): Boolean;
var
  qryAjuda: TFDQuery;
begin
  Result := False;
  qryAjuda := TFDQuery.Create(Nil);
  try
    qryAjuda.Connection := SQLConnection;
    qryAjuda.SQL.Add('Select * From VW_GridAjuda');
    qryAjuda.SQL.Add('Where IdAjuda = :IdAjuda');

    qryAjuda.ParamByName('IdAjuda').AsString := IntToStr(AIdAjuda);

    qryAjuda.Open;
    if not qryAjuda.IsEmpty then
    begin
      Result        := True;
      IdEmpresa     := qryAjuda.FieldByName('IdEmpresa').AsInteger;
      IdUsuario     := qryAjuda.FieldByName('IdUsuario').AsInteger;
      DtCadastro    := qryAjuda.FieldByName('DtCadastro').AsDateTime;
      if qryAjuda.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao  := 1
      end
      else
      begin
        SnSituacao  := 0
      end;
      IdAjuda       := qryAjuda.FieldByName('IdAjuda').AsInteger;
      NmTela        := qryAjuda.FieldByName('NmTela').AsString;
      NmTopico      := qryAjuda.FieldByName('NmTopico').AsString;
      NmAjuda       := qryAjuda.FieldByName('NmAjuda').AsString;
    end;
    qryAjuda.Close;
  finally
    FreeAndNil(qryAjuda)
  end;
end;

end.
