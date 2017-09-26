unit uAgendaPremium;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TAgendaPremium = class
  private
    FIdAgendaPremium: Integer;
    FKeyField: String;
    FStartTime: TDateTime;
    FEndTime: TDateTime;
    FSubject: String;
    FNotes: String;
    FColor: Integer;
    FImage: Integer;
    FCaption: Integer;
    FRecurrency: String;
    FResource: Integer;
    FMinTime: TDateTime;
    FMaxTime: TDateTime;
    procedure Inicializar;
  public
    property IdAgendaPremium: Integer read FIdAgendaPremium write FIdAgendaPremium;
    property KeyField: String read FKeyField write FKeyField;
    property StartTime: TDateTime read FStartTime write FStartTime;
    property EndTime: TDateTime read FEndTime write FEndTime;
    property Subject: String read FSubject write FSubject;
    property Notes: String read FNotes write FNotes;
    property Color: Integer read FColor write FColor;
    property Image: Integer read FImage write FImage;
    property Caption: Integer read FCaption write FCaption;
    property Recurrency: String read FRecurrency write FRecurrency;
    property Resource: Integer read FResource write FResource;
    property MinTime: TDateTime read FMinTime write FMinTime;
    property MaxTime: TDateTime read FMaxTime write FMaxTime;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdAgendaPremium: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AKeyField: String): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdAgendaPremium: Integer): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdAgendaPremium: Integer; AConsulta: String; Data: TClientDataSet);
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TAgendaPremium.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdAgendaPremium: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryAgendaPremium : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryAgendaPremium := TFDQuery.Create(nil);
  try
    qryAgendaPremium.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdAgendaPremium', ftInteger);
      Data.FieldDefs.Add('KeyField', ftString, 10, False);
      Data.FieldDefs.Add('StartTime', ftDateTime);
      Data.FieldDefs.Add('EndTime', ftDateTime);
      Data.FieldDefs.Add('Subject', ftString, 10, False);
      Data.FieldDefs.Add('Notes', ftString, 10, False);
      Data.FieldDefs.Add('Color', ftInteger);
      Data.FieldDefs.Add('Image', ftInteger);
      Data.FieldDefs.Add('Caption', ftInteger);
      Data.FieldDefs.Add('Recurrency', ftString, 10, False);
      Data.FieldDefs.Add('Resource', ftInteger);
      Data.FieldDefs.Add('MinTime', ftDateTime);
      Data.FieldDefs.Add('MaxTime', ftDateTime);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryAgendaPremium.Params.Clear;
      qryAgendaPremium.SQL.Clear;
      qryAgendaPremium.SQL.Add('Select');
      qryAgendaPremium.SQL.Add('  IdAgendaPremium,');
      qryAgendaPremium.SQL.Add('  KeyField,');
      qryAgendaPremium.SQL.Add('  StartTime,');
      qryAgendaPremium.SQL.Add('  EndTime,');
      qryAgendaPremium.SQL.Add('  Subject,');
      qryAgendaPremium.SQL.Add('  Notes,');
      qryAgendaPremium.SQL.Add('  Color,');
      qryAgendaPremium.SQL.Add('  Image,');
      qryAgendaPremium.SQL.Add('  Caption,');
      qryAgendaPremium.SQL.Add('  Recurrency,');
      qryAgendaPremium.SQL.Add('  Resource,');
      qryAgendaPremium.SQL.Add('  MinTime,');
      qryAgendaPremium.SQL.Add('  MaxTime');
      qryAgendaPremium.SQL.Add('From AgendaPremium');
      qryAgendaPremium.SQL.Add('Where 1 = 1');
      if ISnSituacao = 1 then
      begin
         qryAgendaPremium.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryAgendaPremium.SQL.Add('  And SnSituacao = 0');
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
          qryAgendaPremium.SQL.Add (lCondicao);
          qryAgendaPremium.SQL.Add ('Order By');
          qryAgendaPremium.SQL.Add ('  IdAgendaPremium');

          qryAgendaPremium.Open;
          qryAgendaPremium.First;
        end;
      end else begin
        qryAgendaPremium.SQL.Add (lCondicao);
        qryAgendaPremium.SQL.Add ('Order By');
        qryAgendaPremium.SQL.Add ('  IdAgendaPremium');

        lFinalizaLoop := 1;
        qryAgendaPremium.Open;
        qryAgendaPremium.First;
      end;

      while not qryAgendaPremium.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdAgendaPremium').AsInteger = qryAgendaPremium.FieldByName('IdAgendaPremium').AsInteger then
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
          Data.FieldByName('IdAgendaPremium').AsInteger := qryAgendaPremium.FieldByName('IdAgendaPremium').AsInteger;
          Data.FieldByName('KeyField').AsString := qryAgendaPremium.FieldByName('KeyField').AsString;
          Data.FieldByName('StartTime').AsDateTime := qryAgendaPremium.FieldByName('StartTime').AsDateTime;
          Data.FieldByName('EndTime').AsDateTime := qryAgendaPremium.FieldByName('EndTime').AsDateTime;
          Data.FieldByName('Subject').AsString := qryAgendaPremium.FieldByName('Subject').AsString;
          Data.FieldByName('Notes').AsString := qryAgendaPremium.FieldByName('Notes').AsString;
          Data.FieldByName('Color').AsInteger := qryAgendaPremium.FieldByName('Color').AsInteger;
          Data.FieldByName('Image').AsInteger := qryAgendaPremium.FieldByName('Image').AsInteger;
          Data.FieldByName('Caption').AsInteger := qryAgendaPremium.FieldByName('Caption').AsInteger;
          Data.FieldByName('Recurrency').AsString := qryAgendaPremium.FieldByName('Recurrency').AsString;
          Data.FieldByName('Resource').AsInteger := qryAgendaPremium.FieldByName('Resource').AsInteger;
          Data.FieldByName('MinTime').AsDateTime := qryAgendaPremium.FieldByName('MinTime').AsDateTime;
          Data.FieldByName('MaxTime').AsDateTime := qryAgendaPremium.FieldByName('MaxTime').AsDateTime;
          Data.Post;
        end;

        lVerificacao := 0;
        qryAgendaPremium.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryAgendaPremium.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TAgendaPremium.Create;
begin
  Inicializar;
end;

procedure TAgendaPremium.Inicializar;
begin
  IdAgendaPremium := 0;
  KeyField := '';
  StartTime := 0;
  EndTime := 0;
  Subject := '';
  Notes := '';
  Color := 0;
  Image := 0;
  Caption := 0;
  Recurrency := '';
  Resource := 0;
  MinTime := 0;
  MaxTime := 0;
end;

function TAgendaPremium.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryAgendaPremium: TFDQuery;
begin
  qryAgendaPremium:= TFDQuery.Create(Nil);
  try
    qryAgendaPremium.Connection := ASQLConnection;
    if not Existe(ASQLConnection, KeyField) then
    begin
      qryAgendaPremium.SQL.Add('Insert Into AgendaPremium(');
      qryAgendaPremium.SQL.Add('  KeyField,');
      qryAgendaPremium.SQL.Add('  StartTime,');
      qryAgendaPremium.SQL.Add('  EndTime,');
      qryAgendaPremium.SQL.Add('  Subject,');
      qryAgendaPremium.SQL.Add('  Notes,');
      qryAgendaPremium.SQL.Add('  Color,');
      qryAgendaPremium.SQL.Add('  Image,');
      qryAgendaPremium.SQL.Add('  Caption,');
      qryAgendaPremium.SQL.Add('  Recurrency,');
      qryAgendaPremium.SQL.Add('  Resource,');
      qryAgendaPremium.SQL.Add('  MinTime,');
      qryAgendaPremium.SQL.Add('  MaxTime)');
      qryAgendaPremium.SQL.Add('Values (');
      qryAgendaPremium.SQL.Add('  :KeyField,');
      qryAgendaPremium.SQL.Add('  :StartTime,');
      qryAgendaPremium.SQL.Add('  :EndTime,');
      qryAgendaPremium.SQL.Add('  :Subject,');
      qryAgendaPremium.SQL.Add('  :Notes,');
      qryAgendaPremium.SQL.Add('  :Color,');
      qryAgendaPremium.SQL.Add('  :Image,');
      qryAgendaPremium.SQL.Add('  :Caption,');
      qryAgendaPremium.SQL.Add('  :Recurrency,');
      qryAgendaPremium.SQL.Add('  :Resource,');
      qryAgendaPremium.SQL.Add('  :MinTime,');
      qryAgendaPremium.SQL.Add('  :MaxTime)');
    end else begin
      qryAgendaPremium.SQL.Add('Update AgendaPremium Set ');
      qryAgendaPremium.SQL.Add('  StartTime = :StartTime,');
      qryAgendaPremium.SQL.Add('  EndTime = :EndTime,');
      qryAgendaPremium.SQL.Add('  Subject = :Subject,');
      qryAgendaPremium.SQL.Add('  Notes = :Notes,');
      qryAgendaPremium.SQL.Add('  Color = :Color,');
      qryAgendaPremium.SQL.Add('  Image = :Image,');
      qryAgendaPremium.SQL.Add('  Caption = :Caption,');
      qryAgendaPremium.SQL.Add('  Recurrency = :Recurrency,');
      qryAgendaPremium.SQL.Add('  Resource = :Resource,');
      qryAgendaPremium.SQL.Add('  MinTime = :MinTime,');
      qryAgendaPremium.SQL.Add('  MaxTime = :MaxTime ');
      qryAgendaPremium.SQL.Add('Where KeyField = :KeyField');

    end;
    qryAgendaPremium.ParamByName('KeyField').AsString := KeyField;
    qryAgendaPremium.ParamByName('StartTime').AsDateTime := StartTime;
    qryAgendaPremium.ParamByName('EndTime').AsDateTime := EndTime;
    qryAgendaPremium.ParamByName('Subject').AsString := Subject;
    qryAgendaPremium.ParamByName('Notes').AsString := Notes;
    qryAgendaPremium.ParamByName('Color').AsInteger := Color;
    qryAgendaPremium.ParamByName('Image').AsInteger := Image;
    qryAgendaPremium.ParamByName('Caption').AsInteger := Caption;
    qryAgendaPremium.ParamByName('Recurrency').AsString := Recurrency;
    qryAgendaPremium.ParamByName('Resource').AsInteger := Resource;
    qryAgendaPremium.ParamByName('MinTime').AsDateTime := MinTime;
    qryAgendaPremium.ParamByName('MaxTime').AsDateTime := MaxTime;
   try
      qryAgendaPremium.ExecSQL;
      qryAgendaPremium.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryAgendaPremium)
  end;
end;

class function TAgendaPremium.Inativar(ASQLConnection: TFDConnection; AIdAgendaPremium: Integer): Boolean;
var
  qryAgendaPremium: TFDQuery;
begin
  qryAgendaPremium:= TFDQuery.Create(Nil);
  try
    qryAgendaPremium.Connection := ASQLConnection;
    qryAgendaPremium.SQL.Add('Update AgendaPremium Set ');
    qryAgendaPremium.SQL.Add('  SnSituacao = 0 ');
    qryAgendaPremium.SQL.Add('Where 1 = 1');
    qryAgendaPremium.SQL.Add('  And IdAgendaPremium = ' + IntToStr(AIdAgendaPremium));
   try
      qryAgendaPremium.ExecSQL;
      qryAgendaPremium.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryAgendaPremium)
  end;
end;

class function TAgendaPremium.Existe(ASQLConnection: TFDConnection; AKeyField: String): Boolean;
var
  qryAgendaPremium: TFDQuery;
begin
  Result := False;
  qryAgendaPremium:= TFDQuery.Create(Nil);
  try
    qryAgendaPremium.Connection := ASQLConnection;
    qryAgendaPremium.SQL.Add('Select IdAgendaPremium From AgendaPremium');
    qryAgendaPremium.SQL.Add('Where 1 = 1');
    qryAgendaPremium.SQL.Add('  And KeyField = ' + QuotedStr(AKeyField));
    qryAgendaPremium.Open;
    if qryAgendaPremium.Fields[0].Value > 0 then
      Result := True;
    qryAgendaPremium.Close;
  finally
    FreeAndNil(qryAgendaPremium)
  end;
end;

class function TAgendaPremium.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryAgendaPremium: TFDQuery;
begin
  Result := 0;
  qryAgendaPremium:= TFDQuery.Create(Nil);
  try
    qryAgendaPremium.Connection := ASQLConnection;
    qryAgendaPremium.SQL.Add('Select Max(IdAgendaPremium) As IdAgendaPremium From AgendaPremium');
    qryAgendaPremium.Open;

    if qryAgendaPremium.FieldByName('IdAgendaPremium').AsInteger > 0 then
      Result := qryAgendaPremium.FieldByName('IdAgendaPremium').AsInteger;
    qryAgendaPremium.Close;
  finally
    FreeAndNil(qryAgendaPremium)
  end;
end;

function TAgendaPremium.Buscar(ASQLConnection: TFDConnection; AIdAgendaPremium: Integer): Boolean;
var
  qryAgendaPremium: TFDQuery;
begin
  Result := False;
  qryAgendaPremium:= TFDQuery.Create(Nil);
  try
    qryAgendaPremium.Connection := ASQLConnection;
    qryAgendaPremium.SQL.Add('Select * From AgendaPremium');
    qryAgendaPremium.SQL.Add('Where 1 = 1');
    if AIdAgendaPremium > 0 then
    begin
      qryAgendaPremium.SQL.Add('  And IdAgendaPremium = ' + IntToStr(AIdAgendaPremium));
    end;

    qryAgendaPremium.Open;
    if not qryAgendaPremium.IsEmpty then
    begin
      Result := True;
      IdAgendaPremium := qryAgendaPremium.FieldByName('IdAgendaPremium').AsInteger;
      KeyField := qryAgendaPremium.FieldByName('KeyField').AsString;
      StartTime := qryAgendaPremium.FieldByName('StartTime').AsDateTime;
      EndTime := qryAgendaPremium.FieldByName('EndTime').AsDateTime;
      Subject := qryAgendaPremium.FieldByName('Subject').AsString;
      Notes := qryAgendaPremium.FieldByName('Notes').AsString;
      Color := qryAgendaPremium.FieldByName('Color').AsInteger;
      Image := qryAgendaPremium.FieldByName('Image').AsInteger;
      Caption := qryAgendaPremium.FieldByName('Caption').AsInteger;
      Recurrency := qryAgendaPremium.FieldByName('Recurrency').AsString;
      Resource := qryAgendaPremium.FieldByName('Resource').AsInteger;
      MinTime := qryAgendaPremium.FieldByName('MinTime').AsDateTime;
      MaxTime := qryAgendaPremium.FieldByName('MaxTime').AsDateTime;
    end;
    qryAgendaPremium.Close;
  finally
    FreeAndNil(qryAgendaPremium)
  end;
end;

end.

