unit uCalendario;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TCalendario = class
  private
    FIdCalendario       : Integer;
    FIdUsuario          : Integer;
    FDtCalendario       : TDate;
    FNrAno              : Integer;
    FNmMes              : String;
    FNrMes              : Integer;
    FNrDia              : Integer;
    FNmDiaSemana        : String;
    FDtInicioSemana     : TDate;
    FDtFinalSemana      : TDate;
    FDtInicioMes        : TDate;
    FDtFinalMes         : TDate;
    FDtInicioTrimestre  : TDate;
    FDtFinalTrimestre   : TDate;
    FDtInicioAno        : TDate;
    FDtFinalAno         : TDate;
    FSnDiaUtil          : Integer;
    FSnDiaNaoUtil       : Integer;
    FSnFinalSemana      : Integer;
    FSnFeriado          : Integer;
    FSnDiaSemana        : Integer;
    FNmDescricaoFeriado : String;
    FDtCadastro         : TDateTime;
    FNmFeriadoTrocado   : String;
    FNrSemana           : Integer;
    FNmUsuarioCadastro  : String;
    procedure Inicializar();
  public
    property IdCalendario       : Integer   read FIdCalendario        write FIdCalendario;
    property IdUsuario          : Integer   read FIdUsuario           write FIdUsuario;
    property DtCalendario       : TDate     read FDtCalendario        write FDtCalendario;
    property NrAno              : Integer   read FNrAno               write FNrAno;
    property NmMes              : String    read FNmMes               write FNmMes;
    property NrMes              : Integer   read FNrMes               write FNrMes;
    property NrDia              : Integer   read FNrDia               write FNrDia;
    property NmDiaSemana        : String    read FNmDiaSemana         write FNmDiaSemana;
    property DtInicioSemana     : TDate     read FDtInicioSemana      write FDtInicioSemana;
    property DtFinalSemana      : TDate     read FDtFinalSemana       write FDtFinalSemana;
    property DtInicioMes        : TDate     read FDtInicioMes         write FDtInicioMes;
    property DtFinalMes         : TDate     read FDtFinalMes          write FDtFinalMes;
    property DtInicioTrimestre  : TDate     read FDtInicioTrimestre   write FDtInicioTrimestre;
    property DtFinalTrimestre   : TDate     read FDtFinalTrimestre    write FDtFinalTrimestre;
    property DtInicioAno        : TDate     read FDtInicioAno         write FDtInicioAno;
    property DtFinalAno         : TDate     read FDtFinalAno          write FDtFinalAno;
    property SnDiaUtil          : Integer   read FSnDiaUtil           write FSnDiaUtil;
    property SnDiaNaoUtil       : Integer   read FSnDiaNaoUtil        write FSnDiaNaoUtil;
    property SnFinalSemana      : Integer   read FSnFinalSemana       write FSnFinalSemana;
    property SnFeriado          : Integer   read FSnFeriado           write FSnFeriado;
    property SnDiaSemana        : Integer   read FSnDiaSemana         write FSnDiaSemana;
    property NmDescricaoFeriado : String    read FNmDescricaoFeriado  write FNmDescricaoFeriado;
    property DtCadastro         : TDateTime read FDtCadastro          write FDtCadastro;
    property NmFeriadoTrocado   : String    read FNmFeriadoTrocado    write FNmFeriadoTrocado;
    property NrSemana           : Integer   read FNrSemana            write FNrSemana;
    property NmUsuarioCadastro  : String    read FNmUsuarioCadastro   write FNmUsuarioCadastro;
    constructor Create(ASQLConnection: TFDConnection);
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; ADtCalendario: TDate): Boolean;
    class function Existe(ASQLConnection: TFDConnection; ADtCalendario: TDate): Boolean;
    function Buscar(ASQLConnection: TFDConnection; DDtCalendario: TDateTime): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; AIdCalendario: Integer; AConsulta: String; ATpChamadaClasse: String; DDtCalendarioInicio: TDate; DDtCalendarioFinal: TDate; Data: TClientDataSet);
  end;

implementation

uses uFuncao, uMensagem;

procedure TCalendario.CarregaDbGrid(ASQLConnection: TFDConnection; AIdCalendario: Integer; AConsulta: String; ATpChamadaClasse: String; DDtCalendarioInicio: TDate; DDtCalendarioFinal: TDate; Data: TClientDataSet);
var
  qryCalendario : TFDQuery;
  I             : Integer;
  lCampo        : TField;
  lCondicao     : String;
  lVerificacao  : Integer;
  lFinalizaLoop : Integer;
begin
  lVerificacao  := 0;
  lFinalizaLoop := 0;

  qryCalendario := TFDQuery.Create(nil);
  try
    qryCalendario.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdCalendario', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCalendario', ftDate);
      Data.FieldDefs.Add('NrAno', ftInteger);
      Data.FieldDefs.Add('NmMes', ftString, 50, False);
      Data.FieldDefs.Add('NrMes', ftInteger);
      Data.FieldDefs.Add('NrDia', ftInteger);
      Data.FieldDefs.Add('NmDiaSemana', ftString, 255, False);
      Data.FieldDefs.Add('DtInicioSemana', ftDate);
      Data.FieldDefs.Add('DtFinalSemana', ftDate);
      Data.FieldDefs.Add('DtInicioMes', ftDate);
      Data.FieldDefs.Add('DtFinalMes', ftDate);
      Data.FieldDefs.Add('DtInicioTrimestre', ftDate);
      Data.FieldDefs.Add('DtFinalTrimestre', ftDate);
      Data.FieldDefs.Add('DtInicioAno', ftDate);
      Data.FieldDefs.Add('DtFinalAno', ftDate);
      Data.FieldDefs.Add('SnDiaUtil', ftInteger);
      Data.FieldDefs.Add('SnDiaNaoUtil', ftInteger);
      Data.FieldDefs.Add('SnFinalSemana', ftInteger);
      Data.FieldDefs.Add('SnFeriado', ftInteger);
      Data.FieldDefs.Add('SnDiaSemana', ftInteger);
      Data.FieldDefs.Add('NmDescricaoFeriado', ftString, 255, False);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('NmFeriadoTrocado', ftString, 255, False);
      Data.FieldDefs.Add('NrSemana', ftInteger);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 50, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount - 1 do
    begin
      lCampo := Data.Fields[I];

      qryCalendario.Params.Clear;
      qryCalendario.SQL.Clear;
      qryCalendario.SQL.Add('Select                 ');
      qryCalendario.SQL.Add('  *                    ');
      qryCalendario.SQL.Add('From VW_GridCalendario ');
      qryCalendario.SQL.Add('Where 1 = 1            ');

      if AIdCalendario > 0 then
      begin
        qryCalendario.SQL.Add('  And IdCalendario = :IdCalendario');
        qryCalendario.ParamByName('IdCalendario').AsInteger := AIdCalendario;
      end;

      if ATpChamadaClasse = '0' then
      begin
        qryCalendario.SQL.Add('  And DtCalendario = :DtCalendario');

        qryCalendario.ParamByName('DtCalendario').AsDate := DDtCalendarioInicio;
      end;

      if ATpChamadaClasse = '1' then
      begin
        qryCalendario.SQL.Add('  And DtCalendario Between :DtCalendarioInicio And :DtCalendarioFinal');

        qryCalendario.ParamByName('DtCalendarioInicio').AsDate := DDtCalendarioInicio;
        qryCalendario.ParamByName('DtCalendarioFinal').AsDate := DDtCalendarioFinal;
      end;

      if AIdCalendario > 0 then
      begin
         qryCalendario.SQL.Add('  And IdCalendario = :IdCalendario');

         qryCalendario.ParamByName('IdCalendario').AsInteger := AIdCalendario;
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
          qryCalendario.SQL.Add(lCondicao);
          qryCalendario.SQL.Add('Order By');
          qryCalendario.SQL.Add('  DtCalendario');

          qryCalendario.Open;
          qryCalendario.First;
        end;
      end
      else
      begin
        qryCalendario.SQL.Add(lCondicao);
        qryCalendario.SQL.Add('Order By');
        qryCalendario.SQL.Add('  DtCalendario');

        lFinalizaLoop := 1;
        qryCalendario.Open;
        qryCalendario.First;
      end;

      while not qryCalendario.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('DtCalendario').AsDateTime = qryCalendario.FieldByName('DtCalendario').AsDateTime then
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
          Data.FieldByName('IdCalendario').AsInteger        := qryCalendario.FieldByName('IdCalendario').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger           := qryCalendario.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCalendario').AsDateTime       := qryCalendario.FieldByName('DtCalendario').AsDateTime;
          Data.FieldByName('NrAno').AsInteger               := qryCalendario.FieldByName('NrAno').AsInteger;
          Data.FieldByName('NmMes').AsString                := qryCalendario.FieldByName('NmMes').AsString;
          Data.FieldByName('NrMes').AsInteger               := qryCalendario.FieldByName('NrMes').AsInteger;
          Data.FieldByName('NrDia').AsInteger               := qryCalendario.FieldByName('NrDia').AsInteger;
          Data.FieldByName('NmDiaSemana').AsString          := qryCalendario.FieldByName('NmDiaSemana').AsString;
          Data.FieldByName('DtInicioSemana').AsDateTime     := qryCalendario.FieldByName('DtInicioSemana').AsDateTime;
          Data.FieldByName('DtFinalSemana').AsDateTime      := qryCalendario.FieldByName('DtFinalSemana').AsDateTime;
          Data.FieldByName('DtInicioMes').AsDateTime        := qryCalendario.FieldByName('DtInicioMes').AsDateTime;
          Data.FieldByName('DtFinalMes').AsDateTime         := qryCalendario.FieldByName('DtFinalMes').AsDateTime;
          Data.FieldByName('DtInicioTrimestre').AsDateTime  := qryCalendario.FieldByName('DtInicioTrimestre').AsDateTime;
          Data.FieldByName('DtFinalTrimestre').AsDateTime   := qryCalendario.FieldByName('DtFinalTrimestre').AsDateTime;
          Data.FieldByName('DtInicioAno').AsDateTime        := qryCalendario.FieldByName('DtInicioAno').AsDateTime;
          Data.FieldByName('DtFinalAno').AsDateTime         := qryCalendario.FieldByName('DtInicioAno').AsDateTime;
          Data.FieldByName('SnDiaUtil').AsInteger           := qryCalendario.FieldByName('SnDiaUtil').AsInteger;
          Data.FieldByName('SnDiaNaoUtil').AsInteger        := qryCalendario.FieldByName('SnDiaNaoUtil').AsInteger;
          Data.FieldByName('SnFinalSemana').AsInteger       := qryCalendario.FieldByName('SnFinalSemana').AsInteger;
          Data.FieldByName('SnFeriado').AsInteger           := qryCalendario.FieldByName('SnFeriado').AsInteger;
          Data.FieldByName('SnDiaSemana').AsInteger         := qryCalendario.FieldByName('SnDiaSemana').AsInteger;
          Data.FieldByName('NmDescricaoFeriado').AsString   := qryCalendario.FieldByName('NmDescricaoFeriado').AsString;
          Data.FieldByName('DtCadastro').AsDateTime         := qryCalendario.FieldByName('DtCadastro').AsDateTime;
          Data.FieldByName('NmFeriadoTrocado').AsString     := qryCalendario.FieldByName('NmFeriadoTrocado').AsString;
          Data.FieldByName('NrSemana').AsInteger            := qryCalendario.FieldByName('NrSemana').AsInteger;
          Data.FieldByName('NmUsuarioCadastro').AsString    := qryCalendario.FieldByName('NmUsuarioCadastro').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryCalendario.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryCalendario.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TCalendario.Create;
begin
  Inicializar();
end;

procedure TCalendario.Inicializar;
begin
  IdCalendario      := 0;
  IdUsuario         := 0;
  DtCalendario      := 0;
  NrAno             := 0;
  NmMes             := '';
  NrMes             := 0;
  NrDia             := 0;
  NmDiaSemana       := '';
  DtInicioSemana    := 0;
  DtFinalSemana     := 0;
  DtInicioMes       := 0;
  DtFinalMes        := 0;
  DtInicioTrimestre := 0;
  DtFinalTrimestre  := 0;
  DtInicioAno       := 0;
  DtFinalAno        := 0;
  SnDiaUtil         := 0;
  SnDiaNaoUtil      := 0;
  SnFinalSemana     := 0;
  SnFeriado         := 0;
  SnDiaSemana       := 0;
  NmDescricaoFeriado:= '';
  DtCadastro        := 0;
  NmFeriadoTrocado  := '';
  NrSemana          := 0;
  NmUsuarioCadastro := '';
end;

function TCalendario.Salvar(ASQLConnection: TFDConnection): Boolean;
var
  qryCalendario: TFDQuery;
begin
  qryCalendario := TFDQuery.Create(Nil);
  try

    qryCalendario.Connection := ASQLConnection;
    if not Existe(ASQLConnection, DtCalendario) then
    begin
      qryCalendario.SQL.Add('Insert Into Calendario(');
      qryCalendario.SQL.Add('  DtCalendario,');
      qryCalendario.SQL.Add('  IdUsuario,');
      qryCalendario.SQL.Add('  NrAno,');
      qryCalendario.SQL.Add('  NmMes,');
      qryCalendario.SQL.Add('  NrMes,');
      qryCalendario.SQL.Add('  NrDia,');
      qryCalendario.SQL.Add('  NmDiaSemana,');
      qryCalendario.SQL.Add('  DtInicioSemana,');
      qryCalendario.SQL.Add('  DtFinalSemana,');
      qryCalendario.SQL.Add('  DtInicioMes,');
      qryCalendario.SQL.Add('  DtFinalMes,');
      qryCalendario.SQL.Add('  DtInicioTrimestre,');
      qryCalendario.SQL.Add('  DtFinalTrimestre,');
      qryCalendario.SQL.Add('  DtInicioAno,');
      qryCalendario.SQL.Add('  DtFinalAno,');
      qryCalendario.SQL.Add('  SnDiaUtil,');
      qryCalendario.SQL.Add('  SnDiaNaoUtil,');
      qryCalendario.SQL.Add('  SnFinalSemana,');
      qryCalendario.SQL.Add('  SnFeriado,');
      qryCalendario.SQL.Add('  SnDiaSemana,');
      qryCalendario.SQL.Add('  NmDescricaoFeriado,');
      qryCalendario.SQL.Add('  DtCadastro,');
      qryCalendario.SQL.Add('  NmFeriadoTrocado)');
      qryCalendario.SQL.Add('Values (');
      qryCalendario.SQL.Add('  :DtCalendario,');
      qryCalendario.SQL.Add('  :IdUsuario,');
      qryCalendario.SQL.Add('  :NrAno,');
      qryCalendario.SQL.Add('  :NmMes,');
      qryCalendario.SQL.Add('  :NrMes,');
      qryCalendario.SQL.Add('  :NrDia,');
      qryCalendario.SQL.Add('  :NmDiaSemana,');
      qryCalendario.SQL.Add('  :DtInicioSemana,');
      qryCalendario.SQL.Add('  :DtFinalSemana,');
      qryCalendario.SQL.Add('  :DtInicioMes,');
      qryCalendario.SQL.Add('  :DtFinalMes,');
      qryCalendario.SQL.Add('  :DtInicioTrimestre,');
      qryCalendario.SQL.Add('  :DtFinalTrimestre,');
      qryCalendario.SQL.Add('  :DtInicioAno,');
      qryCalendario.SQL.Add('  :DtFinalAno,');
      qryCalendario.SQL.Add('  :SnDiaUtil,');
      qryCalendario.SQL.Add('  :SnDiaNaoUtil,');
      qryCalendario.SQL.Add('  :SnFinalSemana,');
      qryCalendario.SQL.Add('  :SnFeriado,');
      qryCalendario.SQL.Add('  :SnDiaSemana,');
      qryCalendario.SQL.Add('  :NmDescricaoFeriado,');
      qryCalendario.SQL.Add('  :DtCadastro,');
      qryCalendario.SQL.Add('  :NmFeriadoTrocado)');

     qryCalendario.ParamByName('DtCadastro').AsDateTime        := DtCadastro;
     qryCalendario.ParamByName('IdUsuario').AsDate          := IdUsuario;

    end
    else
    begin
      qryCalendario.SQL.Add('Update Calendario Set ');
      qryCalendario.SQL.Add('  DtCalendario = :DtCalendario,');
      qryCalendario.SQL.Add('  NrAno = :NrAno,');
      qryCalendario.SQL.Add('  NmMes = :NmMes,');
      qryCalendario.SQL.Add('  NrMes = :NrMes,');
      qryCalendario.SQL.Add('  NrDia = :NrDia,');
      qryCalendario.SQL.Add('  NmDiaSemana = :NmDiaSemana,');
      qryCalendario.SQL.Add('  DtInicioSemana = :DtInicioSemana,');
      qryCalendario.SQL.Add('  DtFinalSemana = :DtFinalSemana,');
      qryCalendario.SQL.Add('  DtInicioMes = :DtInicioMes,');
      qryCalendario.SQL.Add('  DtFinalMes = :DtFinalMes,');
      qryCalendario.SQL.Add('  DtInicioTrimestre = :DtInicioTrimestre,');
      qryCalendario.SQL.Add('  DtFinalTrimestre = :DtFinalTrimestre,');
      qryCalendario.SQL.Add('  DtInicioAno = :DtInicioAno,');
      qryCalendario.SQL.Add('  DtFinalAno = :DtFinalAno,');
      qryCalendario.SQL.Add('  SnDiaUtil = :SnDiaUtil,');
      qryCalendario.SQL.Add('  SnDiaNaoUtil = :SnDiaNaoUtil,');
      qryCalendario.SQL.Add('  SnFinalSemana = :SnFinalSemana,');
      qryCalendario.SQL.Add('  SnFeriado = :SnFeriado,');
      qryCalendario.SQL.Add('  SnDiaSemana = :SnDiaSemana,');
      qryCalendario.SQL.Add('  NmDescricaoFeriado = :NmDescricaoFeriado');
      qryCalendario.SQL.Add('Where IdCalendario = :IdCalendario');

      qryCalendario.ParamByName('IdCalendario').AsInteger       := IdCalendario;
   end;
    qryCalendario.ParamByName('DtCalendario').AsDate          := DtCalendario;
    qryCalendario.ParamByName('NrAno').AsInteger              := NrAno;
    qryCalendario.ParamByName('NmMes').AsString               := NmMes;
    qryCalendario.ParamByName('NrMes').AsInteger              := NrMes;
    qryCalendario.ParamByName('NrDia').AsInteger              := NrDia;
    qryCalendario.ParamByName('NmDiaSemana').AsString         := NmDiaSemana;
    qryCalendario.ParamByName('DtInicioSemana').AsDate        := DtInicioSemana;
    qryCalendario.ParamByName('DtFinalSemana').AsDate         := DtFinalSemana;
    qryCalendario.ParamByName('DtInicioMes').AsDate           := DtInicioMes;
    qryCalendario.ParamByName('DtFinalMes').AsDate            := DtFinalMes;
    qryCalendario.ParamByName('DtInicioTrimestre').AsDate     := DtInicioTrimestre;
    qryCalendario.ParamByName('DtFinalTrimestre').AsDate      := DtFinalTrimestre;
    qryCalendario.ParamByName('DtInicioAno').AsDate           := DtInicioAno;
    qryCalendario.ParamByName('DtFinalAno').AsDate            := DtFinalAno;
    qryCalendario.ParamByName('SnDiaUtil').AsInteger          := SnDiaUtil;
    qryCalendario.ParamByName('SnDiaNaoUtil').AsInteger       := SnDiaNaoUtil;
    qryCalendario.ParamByName('SnFinalSemana').AsInteger      := SnFinalSemana;
    qryCalendario.ParamByName('SnFeriado').AsInteger          := SnFeriado;
    qryCalendario.ParamByName('SnDiaSemana').AsInteger        := SnDiaSemana;
    qryCalendario.ParamByName('NmDescricaoFeriado').AsString  := NmDescricaoFeriado;
    qryCalendario.ParamByName('NmDescricaoFeriado').AsString  := NmDescricaoFeriado;
    try
      qryCalendario.ExecSQL;
      qryCalendario.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryCalendario)
  end;
end;

class function TCalendario.Inativar(ASQLConnection: TFDConnection; ADtCalendario: TDate): Boolean;
var
  qryCalendario: TFDQuery;
begin
  qryCalendario := TFDQuery.Create(Nil);
  try
    qryCalendario.Connection := ASQLConnection;
    qryCalendario.SQL.Add('Update Calendario Set ');
    qryCalendario.SQL.Add('  SnSituacao = 0 ');
    qryCalendario.SQL.Add('Where DtCalendario = :DtCalendario');

    qryCalendario.ParamByName('DtCalendario').AsDate := ADtCalendario;
    try
      qryCalendario.ExecSQL;
      qryCalendario.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryCalendario)
  end;
end;

class function TCalendario.Existe(ASQLConnection: TFDConnection; ADtCalendario: TDate): Boolean;
var
  qryCalendario: TFDQuery;
begin
  Result := False;
  qryCalendario := TFDQuery.Create(Nil);
  try
    qryCalendario.Connection := ASQLConnection;
    qryCalendario.SQL.Add('Select * From Calendario');
    qryCalendario.SQL.Add('Where DtCalendario = :DtCalendario');

    qryCalendario.ParamByName('DtCalendario').AsDate := ADtCalendario;

    qryCalendario.Open;
    if qryCalendario.Fields[0].Value > 0 then
      Result := True;
    qryCalendario.Close;
  finally
    FreeAndNil(qryCalendario)
  end;
end;

class function TCalendario.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryCalendario: TFDQuery;
begin
  Result := 0;
  qryCalendario := TFDQuery.Create(Nil);
  try
    qryCalendario.Connection := ASQLConnection;
    qryCalendario.SQL.Add
      ('Select Max(IdCalendario) As IdCalendario From Calendario');
    qryCalendario.Open;

    if qryCalendario.FieldByName('IdCalendario').AsInteger > 0 then
      Result := qryCalendario.FieldByName('IdCalendario').AsInteger;
    qryCalendario.Close;
  finally
    FreeAndNil(qryCalendario)
  end;
end;

function TCalendario.Buscar(ASQLConnection: TFDConnection; DDtCalendario: TDateTime): Boolean;
var
  qryCalendario: TFDQuery;
begin
  Result := False;
  qryCalendario := TFDQuery.Create(Nil);
  try
    qryCalendario.Connection := ASQLConnection;
    qryCalendario.SQL.Add('Select * From VW_GridCalendario');
    qryCalendario.SQL.Add('Where DtCalendario = :DtCalendario');

    qryCalendario.ParamByName('DtCalendario').AsDateTime := DDtCalendario;

    qryCalendario.Open;
    if not qryCalendario.IsEmpty then
    begin
      Result := True;
      IdCalendario        := qryCalendario.FieldByName('IdCalendario').AsInteger;
      IdUsuario           := qryCalendario.FieldByName('IdUsuario').AsInteger;
      DtCalendario        := qryCalendario.FieldByName('DtCalendario').AsDateTime;
      NrAno               := qryCalendario.FieldByName('NrAno').AsInteger;
      NmMes               := qryCalendario.FieldByName('NmMes').AsString;
      NrMes               := qryCalendario.FieldByName('NrMes').AsInteger;
      NrDia               := qryCalendario.FieldByName('NrDia').AsInteger;
      NmDiaSemana         := qryCalendario.FieldByName('NmDiaSemana').AsString;
      DtInicioSemana      := qryCalendario.FieldByName('DtInicioSemana').AsDateTime;
      DtFinalSemana       := qryCalendario.FieldByName('DtFinalSemana').AsDateTime;
      DtInicioMes         := qryCalendario.FieldByName('DtInicioMes').AsDateTime;
      DtFinalMes          := qryCalendario.FieldByName('DtFinalMes').AsDateTime;
      DtInicioTrimestre   := qryCalendario.FieldByName('DtInicioTrimestre').AsDateTime;
      DtFinalTrimestre    := qryCalendario.FieldByName('DtFinalTrimestre').AsDateTime;
      DtInicioAno         := qryCalendario.FieldByName('DtInicioAno').AsDateTime;
      DtFinalAno          := qryCalendario.FieldByName('DtFinalAno').AsDateTime;
      SnDiaUtil           := qryCalendario.FieldByName('SnDiaUtil').AsInteger;
      SnDiaNaoUtil        := qryCalendario.FieldByName('SnDiaNaoUtil').AsInteger;
      SnFinalSemana       := qryCalendario.FieldByName('SnFinalSemana').AsInteger;
      SnFeriado           := qryCalendario.FieldByName('SnFeriado').AsInteger;
      SnDiaSemana         := qryCalendario.FieldByName('SnDiaSemana').AsInteger;
      NmDescricaoFeriado  := qryCalendario.FieldByName('NmDescricaoFeriado').AsString;
      DtCadastro          := qryCalendario.FieldByName('DtCadastro').AsDateTime;
      NmDescricaoFeriado  := qryCalendario.FieldByName('NmDescricaoFeriado').AsString;
      NrSemana            := qryCalendario.FieldByName('NrSemana').AsInteger;
      NmUsuarioCadastro   := qryCalendario.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryCalendario.Close;
  finally
    FreeAndNil(qryCalendario)
  end;
end;

end.
