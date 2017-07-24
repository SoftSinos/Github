unit uFuncao;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes,   Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.ComCtrls, ShellApi, Winsock;

function EncontraIP                                                                 : String;
function NomeComputador                                                             : String;
function SerialHD                                                                   : String;
function MacAdd                                                                     : String;

function RetornaZeroI(ANome: Integer)                                               : Integer;
function RetornaZeroA(ANome: String)                                                : String;

function FinalizarAplicacao(ANome: String)                                          : Integer;

function MsgInformacao(AMensagem: String)                                           : Boolean;
function MsgAtencao(AMensagem: String)                                              : Boolean;
function MsgErro(AMensagem: String)                                                 : Boolean;
function MsgConfirmacao(AMensagem: String)                                          : Boolean;

function PermitePesquisa(AField: TField; AConsulta: String)                         : Boolean;

function InicialMaiuscula(ATexto: String)                                           : String;

function NomeDoMes(I: word; Tipo: Integer)                                          : String;
function DiaDaSemana(I: word; Tipo: Integer)                                        : String;
function DataPorExtenso(AData: TDateTime)                                           : String;

function VersaoExecutavel(Executavel: String)                                       : String;
function VersaoExe(ArquivoExe: string)                                              : String;
function VersaoAtu(ArquivoExe: string)                                              : String;
function VersaoBd(ASQLConnection: TFDConnection)                                    : String;
function DataVersaoApp : String;

function ConexaoRede                                                                : Boolean;

function VerificaCpfCnpj(ANumero: String)                                           : Boolean;

function SafetyOpen(ASQLConnection: TFDConnection; AIdEmpresa: Integer)             : Boolean;

function SoNumeros(Const ATexto: String)                                            : String;

function SalvaImagem(ASQLConnection: TFDConnection; IChave: Integer; ATabela, ACaminho: String)         : Boolean;

function Milimentro(const X, Y: Double)                                                                 : TPoint;

function RemoveCaracteres(ATexto: String)                                                               : String;
function RemoveMoeda(ATexto: String)                                                                    : String;
function ContaCaracteres(ATexto: String)                                                                : Integer;
function DescobreSeELetrasOuNumeres(ATexto: string; IModo: Integer)                                     : Boolean;

function VerdadeiroFalso(ATexto: String)                                                                : String;

function ConverteDataBrasilEmIngles(ATexto: String)                                                     : String;
function AdicionaDiaEmData(const AValue: TDate; const ANumberOfDays: Integer = 1)                       : TDateTime;

function ConverteDataPorNumero(ASQLConnection: TFDConnection; ADtCadastro: TDatetime)                   : Integer;
function ConverteHoraPorMinuto(ASQLConnection: TFDConnection; AHrCadastro: String; ATpChamada: String)  : Integer;
function ConverteMinutoPorHora(ASQLConnection: TFDConnection; AHrCadastro: String; ATpChamada: String)  : String;
function ConverteHoraPorDecimal(ASQLConnection: TFDConnection; AHrCadastro: String)                     : String;
function ConverteMinutoPorDecimal(ASQLConnection: TFDConnection; AHrCadastro: String)                   : String;
function ConverteMinutoPorHoraNoturno(ASQLConnection: TFDConnection; AHrCadastro: String)               : String;
function ConverteDecimalPorHora(ASQLConnection: TFDConnection; AHrCadastro: Double)                     : String;

function ECpfCnpj(ANumero: String)                                                  : Integer;

function AdicionaCaracter(ATexto: String)                                           : String;

function AbrirExplorer(OpenAtPath: string; OpenWithExplorer, OpenAsRoot: Boolean)   : Boolean;

function Hora24(ATime: TTime)                                                       : TTime;

function SomatorioDeValores(VValor01: Currency; VValor02: Currency; ASinal: String) : Currency;

function AdicionaDiasData(QtdFatura: Integer; SnAVista: Integer)                    : TDate;

function RetornoLog(ASQLConnection: TFDConnection)                                  : Integer;

function ContaArquivos(Pasta: String; Nome: String)                                 : Integer;

function ListarArquivos(Pasta: String; Nome: String; Sub: Boolean)                  : Integer;

function AtributoArquivos(Attr, Val: Integer)                                       : Boolean;

function RetornaValorEmReal(AValor: Currency)                                       : String;

function NumeroRandom                                                               : Integer;

implementation

uses fPrincipal, dPrincipal, uConfiguracao, dArquivos, uProcedure, uMensagem;

var
  unConfiguracao : TConfiguracao;

function NumeroRandom : Integer;
var
  Num, Num2: Integer;
begin

  Num2:= 0;

  Randomize;

  Num:= Random(999999999);

  if Num = Num2 then
  begin
    Num:= Random(999999999);
  end;

  Result := Num;
end;

function RetornaValorEmReal(AValor: Currency): String;
var
  AMascara : String;
begin
  AMascara :=  FormatCurr('R$ ###,###,##0.00', AValor);

  Result := AMascara;
end;

function RetornaZeroI(ANome: Integer): Integer;
begin
  if ANome = -1 then
  begin
    Result := 0;
  end
  else
  begin
    Result := ANome;
  end;
end;

function RetornaZeroA(ANome: String): String;
begin
  if ANome = '' then
  begin
    Result := '0';
  end
  else
  begin
    Result := ANome;
  end;
end;

function MacAdd: string;
var
  Lib: Cardinal;
  Func: function(GUID: PGUID): Longint; stdcall;
  GUID1, GUID2: TGUID;
begin
  Result := '';
  Lib := LoadLibrary('rpcrt4.dll');
  if Lib <> 0 then
  begin
    @Func := GetProcAddress(Lib, 'UuidCreateSequential');
    if Assigned(Func) then
    begin
      if (Func(@GUID1) = 0) and
         (Func(@GUID2) = 0) and
         (GUID1.D4[2] = GUID2.D4[2]) and
         (GUID1.D4[3] = GUID2.D4[3]) and
         (GUID1.D4[4] = GUID2.D4[4]) and
         (GUID1.D4[5] = GUID2.D4[5]) and
         (GUID1.D4[6] = GUID2.D4[6]) and
         (GUID1.D4[7] = GUID2.D4[7]) then
      begin
        Result :=
          IntToHex(GUID1.D4[2], 2) + '-' +
          IntToHex(GUID1.D4[3], 2) + '-' +
          IntToHex(GUID1.D4[4], 2) + '-' +
          IntToHex(GUID1.D4[5], 2) + '-' +
          IntToHex(GUID1.D4[6], 2) + '-' +
          IntToHex(GUID1.D4[7], 2);
      end;
    end;
  end;
end;

function SerialHD: string;
var
  lpVolumeNameBuffer        : PChar;
  lpFileSystemNameBuffer    : PChar;
  nVolumeNameSize           : DWORD;
  lpVolumeSerialNumber      : DWORD;
  lpMaximumComponentLength  : DWORD;
  lpFileSystemFlags         : DWORD;
  nFileSystemNameSize       : DWORD;
begin
  Result := '';
  GetMem( lpVolumeNameBuffer, MAX_PATH + 1 );
  GetMem( lpFileSystemNameBuffer, MAX_PATH + 1 );

  try
    nVolumeNameSize := MAX_PATH + 1;
    nFileSystemNameSize := MAX_PATH + 1;
    if GetVolumeInformation( PChar( 'C:\' ), lpVolumeNameBuffer, nVolumeNameSize, @lpVolumeSerialNumber, lpMaximumComponentLength, lpFileSystemFlags, lpFileSystemNameBuffer, nFileSystemNameSize ) then
    begin
      Result := IntToStr(lpVolumeSerialNumber);
    end;
  finally
    FreeMem( lpVolumeNameBuffer );
    FreeMem( lpFileSystemNameBuffer );
  end;
end;

function AtributoArquivos(Attr, Val: Integer): Boolean;
begin
  Result := Attr and Val = Val;
end;

function ListarArquivos(Pasta: String; Nome: String; Sub: Boolean): Integer;
var
  F: TSearchRec;
  Ret: Integer;
  TempNome: string;
begin
  Ret := FindFirst(Pasta + Nome, faAnyFile, F);
  try
    while Ret = 0 do
    begin
      if AtributoArquivos(F.Attr, faDirectory) then
      begin
        if (F.Name <> '.') And (F.Name <> '..') then
          if Sub = True then
          begin
            TempNome := Pasta + F.Name;
            ListarArquivos(TempNome, Nome, True);
          end;
      end
      else
      begin
        if DtmArquivos.CdsArquivos.FieldCount = 0 then
        begin
          DtmArquivos.CdsArquivos.FieldDefs.Add('NmCaminho', ftString, 1000, False);
          DtmArquivos.CdsArquivos.FieldDefs.Add('NmArquivo', ftString, 255, False);
          DtmArquivos.CdsArquivos.CreateDataSet;
        end;

        DtmArquivos.CdsArquivos.Append;
        DtmArquivos.CdsArquivos.FieldByName('NmCaminho').AsString := Pasta;
        DtmArquivos.CdsArquivos.FieldByName('NmArquivo').AsString := F.Name;
        DtmArquivos.CdsArquivos.Post;
      end;
        Ret := FindNext(F);
    end;
  finally
    FindClose(F);
  end;
end;

function ContaArquivos(Pasta, Nome:string): Integer;
var
   Rec      : TSearchRec;
   Procura  : Integer;
   Contador : Integer;
begin
   procura:=SysUtils.FindFirst(Pasta+Nome,faAnyFile, Rec);
   Contador:=0;
   while procura = 0 do
      begin
      inc(Contador);
      procura:=SysUtils.FindNext(Rec)
      end;
   SysUtils.FindClose(Rec);
   Result:=Contador;
end;

function RetornoLog(ASQLConnection: TFDConnection): Integer;
var
  qryFuncao: TFDQuery;
begin
  qryFuncao := TFDQuery.Create(nil);
  try
    qryFuncao.Connection := ASQLConnection;
    qryFuncao.SQL.Add('Select Count(*) As NrLog From Log');

 	  qryFuncao.Open;

    Result := qryFuncao.FieldByName('NrLog').AsInteger;
  finally
    FreeAndNil(qryFuncao)
  end;
end;

function EncontraIP: string;
var
  WSAData : TWSAData;
  HostEnt : PHostEnt;
  Name    :string;
begin
  WSAStartup(2, WSAData);
  SetLength(Name, 255);
  Gethostname(PAnsiChar(Name), 255);
  SetLength(Name, StrLen(PAnsiChar(Name)));
  HostEnt   := gethostbyname(PAnsiChar(Name));
  with HostEnt^ do
  begin
    Result  := Format('%d.%d.%d.%d',
    [Byte(h_addr^[0]),Byte(h_addr^[1]),
    Byte(h_addr^[2]),Byte(h_addr^[3])]);
  end;
    WSACleanup;
end;

function NomeComputador: String;
var
  lpBuffer  : PChar;
  nSize     : DWord;
  const Buff_Size = MAX_COMPUTERNAME_LENGTH + 1;
begin
  nSize     := Buff_Size;
  lpBuffer  := StrAlloc(Buff_Size);
  GetComputerName(lpBuffer,nSize);
  Result    := String(lpBuffer);
  StrDispose(lpBuffer);
end;

function AdicionaDiasData(QtdFatura: Integer; SnAVista: Integer) : TDate;
var
  Data: TDate;
begin
  Data := Now;

  if SnAVista = 1 then
  begin
    Data := Data;
  end
  else
  begin
    Data := IncMonth(Data, QtdFatura)
  end;
  Result := Data;
end;

function SomatorioDeValores(VValor01: Currency; VValor02: Currency; ASinal: String): Currency;
var
  VValorResult : Currency;
begin
  VValorResult := 0;

  if ASinal = '+' then
  begin
    VValorResult :=  VValor01 + VValor02;
  end
  else if ASinal = '-' then
  begin
    VValorResult :=   + VValor02 - VValor01;
  end;

  Result := VValorResult;
end;

function Hora24(ATime: TTime): TTime;
var
  IMinuto : String;
begin
  Result         := ATime;

  unConfiguracao := TConfiguracao.Create;
  //FECHAR O TERMO 24HORAS "MINUTOS"
  unConfiguracao.Buscar(DtmPrincipal.Conexao, DtmPrincipal.IdEmpresaLogada, 'AMEJ');

  IMinuto        := unConfiguracao.NmValor;

  if ATime = StrToTime('23:59:00') then
  begin
    Result := ATime + StrToTime('00:' + IMinuto + ':00');
  end;
end;

function ConverteMinutoPorHoraNoturno(ASQLConnection: TFDConnection; AHrCadastro: String): String;
var
  qryFuncao: TFDQuery;
begin
  qryFuncao := TFDQuery.Create(nil);
  try
    qryFuncao.Connection := ASQLConnection;
    qryFuncao.SQL.Add('Select dbo.FN_ConverteMinutosPorHoraNoturno(:HrCadastro) As HoraNoturna');

    qryFuncao.ParamByName('HrCadastro').AsString := AHrCadastro;

 	  qryFuncao.Open;

    Result := qryFuncao.FieldByName('HoraNoturna').AsString;
  finally
    FreeAndNil(qryFuncao)
  end;
end;

function ConverteDecimalPorHora(ASQLConnection: TFDConnection; AHrCadastro: Double): String;
var
  qryFuncao: TFDQuery;
begin
  qryFuncao := TFDQuery.Create(nil);
  try
    qryFuncao.Connection := ASQLConnection;
    qryFuncao.SQL.Add('Select dbo.FN_ConverteDecimalPorHora(:HrCadastro) As Decimal');

    qryFuncao.ParamByName('HrCadastro').AsFloat := AHrCadastro;

 	  qryFuncao.Open;

    Result := qryFuncao.FieldByName('Decimal').AsString;
  finally
    FreeAndNil(qryFuncao)
  end;
end;

function ConverteMinutoPorDecimal(ASQLConnection: TFDConnection; AHrCadastro: String): String;
var
  qryFuncao: TFDQuery;
begin
  qryFuncao := TFDQuery.Create(nil);
  try
    qryFuncao.Connection := ASQLConnection;
    qryFuncao.SQL.Add('Select dbo.FN_ConverteMinutoPorDecimal(:HrCadastro) As Decimal');

    qryFuncao.ParamByName('HrCadastro').AsString := AHrCadastro;

 	  qryFuncao.Open;

    Result := qryFuncao.FieldByName('Decimal').AsString;
  finally
    FreeAndNil(qryFuncao)
  end;
end;

function ConverteHoraPorDecimal(ASQLConnection: TFDConnection; AHrCadastro: String): String;
var
  qryFuncao: TFDQuery;
begin
  qryFuncao := TFDQuery.Create(nil);
  try
    qryFuncao.Connection := ASQLConnection;
    qryFuncao.SQL.Add('Select dbo.FN_ConverteHorasDecimal(:HrCadastro) As Decimal');

    qryFuncao.ParamByName('HrCadastro').AsString := AHrCadastro;

 	  qryFuncao.Open;

    Result := qryFuncao.FieldByName('Decimal').AsString;
  finally
    FreeAndNil(qryFuncao)
  end;
end;

function ConverteMinutoPorHora(ASQLConnection: TFDConnection; AHrCadastro: String; ATpChamada: String): String;
var
  qryFuncao: TFDQuery;
begin
  qryFuncao := TFDQuery.Create(nil);
  try
    qryFuncao.Connection := ASQLConnection;
    qryFuncao.SQL.Add('Select dbo.FN_ConverteMinutosPorHora(:HrCadastro) As Hora');

    if ATpChamada = 'D' then
    begin
      qryFuncao.ParamByName('HrCadastro').AsString := Copy(AHrCadastro, 12, 5);
    end else if ATpChamada = 'T' then
    begin
      qryFuncao.ParamByName('HrCadastro').AsString := Copy(AHrCadastro, 1, 5);
    end;

    qryFuncao.Open;

    Result := qryFuncao.FieldByName('Hora').AsString;
  finally
    FreeAndNil(qryFuncao)
  end;
end;

function ConverteHoraPorMinuto(ASQLConnection: TFDConnection; AHrCadastro: String; ATpChamada: String): Integer;
var
  qryFuncao: TFDQuery;
begin
  qryFuncao := TFDQuery.Create(nil);
  try
    qryFuncao.Connection := ASQLConnection;
    qryFuncao.SQL.Add('Select dbo.FN_ConverteHorasPorMinutos(:HrCadastro) As Minuto');

    if ATpChamada = 'D' then
    begin
      if Trim(Copy(AHrCadastro, 12, 5)) = '' then
      begin
        qryFuncao.ParamByName('HrCadastro').AsString := '00:00';
      end else
      begin
        qryFuncao.ParamByName('HrCadastro').AsString := Copy(AHrCadastro, 12, 5);
      end;
    end else if ATpChamada = 'T' then
    begin
      qryFuncao.ParamByName('HrCadastro').AsString := Copy(AHrCadastro, 1, 5);
    end;

    qryFuncao.Open;

    Result := qryFuncao.FieldByName('Minuto').AsInteger;
  finally
    FreeAndNil(qryFuncao)
  end;
end;

function ConverteDataPorNumero(ASQLConnection: TFDConnection; ADtCadastro: TDatetime): Integer;
var
  qryFuncao: TFDQuery;
begin
  qryFuncao := TFDQuery.Create(nil);
  try
    qryFuncao.Connection := ASQLConnection;
    qryFuncao.SQL.Add('Select dbo.FN_ConverteDataPorNumero(:DtCadastro) As Numero');

    qryFuncao.ParamByName('DtCadastro').AsDate := ADtCadastro;

    qryFuncao.Open;

    Result := qryFuncao.FieldByName('Numero').AsInteger;
  finally
    FreeAndNil(qryFuncao)
  end;
end;

function SafetyOpen(ASQLConnection: TFDConnection; AIdEmpresa: Integer): Boolean;
var
  qrySafetyOpen: TFDQuery;
begin
  qrySafetyOpen := TFDQuery.Create(Nil);
  try
    qrySafetyOpen.Connection := ASQLConnection;
    qrySafetyOpen.SQL.Add('Select dbo.FN_SafetyOpen(:IdEmpresa, :TpChamadaClasse) As Retorno');

    qrySafetyOpen.ParamByName('IdEmpresa').AsInteger := AIdEmpresa;
    qrySafetyOpen.ParamByName('TpChamadaClasse').AsString := 'Contra-Senha';
    qrySafetyOpen.Open;

    Result := qrySafetyOpen.FieldByName('Retorno').AsBoolean;
    qrySafetyOpen.Close;
  finally
    FreeAndNil(qrySafetyOpen);
  end;
end;

function AdicionaCaracter(ATexto: String): String;
begin
  if Length(ATexto) = 11 then
  begin
    Result := '0' + ATexto
  end;
end;

function ECpfCnpj(ANumero: String): Integer;
begin
  if Length(ANumero) = 11 then
  begin
    Result := 0
  end else if Length(ANumero) = 14 then
  begin
    Result := 1
  end;
end;

function AbrirExplorer(OpenAtPath: string; OpenWithExplorer, OpenAsRoot: Boolean): boolean;
begin
  if OpenWithExplorer then
  begin
    Result := ShellExecute(Application.Handle,PChar('open'),PChar('explorer.exe'),PChar(OpenAtPath),nil,SW_NORMAL) > 32;
  end;
end;

function AdicionaDiaEmData(const AValue: TDate; const ANumberOfDays: Integer = 1): TDateTime;
begin
  Result := IncHour(AValue, ANumberOfDays * HoursPerDay);
end;

function ConverteDataBrasilEmIngles(ATexto: String): String;
begin
  Result := '';
  try
    Result := Copy(ATexto, 7, 4) + '/' + Copy(ATexto, 4, 2) + '/' +
      Copy(ATexto, 1, 2);
  finally

  end;
end;

function VerdadeiroFalso(ATexto: String): String;
begin
  Result := 'Inativo';

  if ATexto = 'True' then
  begin
    Result := 'Ativo';
  end;
end;

function DescobreHorasDST(ASQLConnection: TFDConnection; IChave: Integer): String;
var
  qryHorasDST: TFDQuery;
begin
  qryHorasDST := TFDQuery.Create(Nil);
  try
    qryHorasDST.Connection := ASQLConnection;
    qryHorasDST.SQL.Add('Select dbo.FN_RetornoHorasDSR(:IdJornada) As HrDST');

    qryHorasDST.ParamByName('IdJornada').AsInteger := IChave;
    qryHorasDST.Open;

    Result := qryHorasDST.FieldByName('HrDST').AsString;
    qryHorasDST.Close;
  finally
    FreeAndNil(qryHorasDST);
  end;
end;

function DescobreSeELetrasOuNumeres(ATexto: String; IModo: Integer): Boolean;
const
  Letras = ['A' .. 'Z', 'a' .. 'z', '_'];
  Numeros = ['0' .. '9'];
var
  I: Integer;
  Value: set of char;
begin
  case IModo of
    1:
      Value := Letras;
    2:
      Value := Numeros;
  end;
  Result := False;
  if (Length(ATexto) = 0) or not(ATexto[1] in Value) then
  begin
    Exit;
  end;

  for I := 2 to Length(ATexto) do
  begin
    if not(ATexto[I] in Value) then
    begin
      Exit;
    end;
  end;

  Result := True;
end;

function ContaCaracteres(ATexto: String): Integer;
begin
  Result := Length(ATexto);
end;

function VerificaCei(ANumero: String): Boolean;
const
  Peso = '74185216374';
var
  Numero: String;
  DV_Dig: String;
  StrSoma: String;
  Soma: Integer;
  I: Integer;
  Valor1: Integer;
  Valor2: Integer;
  Resto: Integer;
  PriDig: Integer;
begin
  Result := True;

  if Length(Trim(ANumero)) = 0 then
  begin
    Exit;
  end;

  Numero := Copy(ANumero, Length(ANumero) - 12 + 1, 12);
  DV_Dig := Copy(Numero, 12, 1);
  Soma := 0;

  for I := 1 to 11 do
  begin
    Soma := Soma + (StrToInt(Copy(Numero, I, 1)) * StrToInt(Copy(Peso, I, 1)));
  end;

  StrSoma := FormatFloat('0000', Soma);
  Valor1 := StrToInt(Copy(StrSoma, 4, 1));
  Valor2 := StrToInt(Copy(StrSoma, 3, 1));
  Resto := (Valor1 + Valor2) Mod 10;

  if Resto <> 0 then
  begin
    PriDig := 10 - Resto;
  end;

  if PriDig <> StrToInt(DV_Dig) then
  begin
    Result := False;
  end;
end;

function RemoveCaracteres(ATexto: String): String;
begin
  ATexto := StringReplace(ATexto, ' ', '', [rfReplaceAll]);
  ATexto := StringReplace(ATexto, '.', '', [rfReplaceAll]);
  ATexto := StringReplace(ATexto, '-', '', [rfReplaceAll]);
  ATexto := StringReplace(ATexto, '_', '', [rfReplaceAll]);
  ATexto := StringReplace(ATexto, '\', '', [rfReplaceAll]);
  ATexto := StringReplace(ATexto, '/', '', [rfReplaceAll]);
  ATexto := StringReplace(ATexto, '(', '', [rfReplaceAll]);
  ATexto := StringReplace(ATexto, ')', '', [rfReplaceAll]);
  ATexto := StringReplace(ATexto, ':', '', [rfReplaceAll]);
  Result := ATexto;
end;

function RemoveMoeda(ATexto: String): String;
begin
  ATexto := StringReplace(ATexto, 'R', '', [rfReplaceAll]);
  ATexto := StringReplace(ATexto, '$', '', [rfReplaceAll]);
  Result := ATexto;
end;

function VersaoBd(ASQLConnection: TFDConnection): String;
var
  qryVersao: TFDQuery;
begin
  qryVersao := TFDQuery.Create(Nil);
  try
    qryVersao.Connection := ASQLConnection;
    qryVersao.SQL.Add('Select                                             ');
    qryVersao.SQL.Add('  (NrVersaoBd) NrVersaoBd                          ');
    qryVersao.SQL.Add('From Versao                                        ');
    qryVersao.SQL.Add('Where IdVersao = (Select Max(IdVersao) from Versao)');

    qryVersao.Open;

    Result := qryVersao.FieldByName('NrVersaoBd').AsString;
    qryVersao.Close;
  finally
    FreeAndNil(qryVersao);
  end;
end;

function DataVersaoApp: String;
begin
  Result := DateTimeToStr(FileDateToDateTime(FileAge(Application.ExeName)));
end;

function VersaoExe(ArquivoExe: string): String;
type
  PFFI = ^vs_FixedFileInfo;
var
  F: PFFI;
  Handle: Dword;
  Len: Longint;
  Data: Pchar;
  Buffer: Pointer;
  Tamanho: Dword;
  Parquivo: Pchar;
  Arquivo: String;
begin
  Arquivo := ArquivoExe;
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := '';
  if Len > 0 then
  begin
    Data := StrAlloc(Len + 1);
    if GetFileVersionInfo(Parquivo, Handle, Len, Data) then
    begin
      VerQueryValue(Data, '', Buffer, Tamanho);
      F := PFFI(Buffer);
      Result := Format('%d.%d.%d.%d', [HiWord(F^.dwFileVersionMs), LoWord(F^.dwFileVersionMs), HiWord(F^.dwFileVersionLs), LoWord(F^.dwFileVersionLs)]);
    end;
    StrDispose(Data);
  end;
  StrDispose(Parquivo);
end;

function VersaoAtu(ArquivoExe: string): String;
type
  PFFI = ^vs_FixedFileInfo;
var
  F: PFFI;
  Handle: Dword;
  Len: Longint;
  Data: Pchar;
  Buffer: Pointer;
  Tamanho: Dword;
  Parquivo: Pchar;
  Arquivo: String;
begin
  Arquivo := ArquivoExe;
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := '';
  if Len > 0 then
  begin
    Data := StrAlloc(Len + 1);
    if GetFileVersionInfo(Parquivo, Handle, Len, Data) then
    begin
      VerQueryValue(Data, '', Buffer, Tamanho);
      F := PFFI(Buffer);
      Result := Format('%d.%d.%d', [HiWord(F^.dwFileVersionMs), LoWord(F^.dwFileVersionMs), HiWord(F^.dwFileVersionLs)]);
    end;
    StrDispose(Data);
  end;
  StrDispose(Parquivo);
end;

function Milimentro(const X, Y: Double): TPoint;
begin
  Result.X := Trunc(DtmPrincipal.ResolucaoX / 25.4 * X);
  Result.Y := Trunc(DtmPrincipal.ResolucaoY / 25.4 * Y);
end;

function VerificaPis(ANumero: String): Boolean;
var
  I, wSoma, wM11, wDv, wDigito: Integer;
begin
  Result := False;

  if Trim(ANumero) <> '' then
  begin
    wDv := StrToInt(Copy(ANumero, 11, 1));
    wSoma := 0;
    wM11 := 2;
    for I := 1 to 10 do
    begin
      wSoma := wSoma + (wM11 * StrToInt(Copy(ANumero, 11 - I, 1)));
      if wM11 < 9 then
      begin
        wM11 := wM11 + 1
      end
      else
      begin
        wM11 := 2;
      end;
    end;
    wDigito := 11 - (wSoma mod 11);
    if wDigito > 9 then
    begin
      wDigito := 0;
    end;
    if wDv = wDigito then
    begin
      Result := True;
    end;
  end;
end;

function SalvaImagem(ASQLConnection: TFDConnection; IChave: Integer; ATabela, ACaminho: String): Boolean;
var
  qryImagem: TFDQuery;
begin
  Result := False;
  try
    qryImagem := TFDQuery.Create(nil);
    qryImagem.Connection := ASQLConnection;

    qryImagem.SQL.Clear;
    qryImagem.Params.Clear;

    if ATabela = 'Empresa' then
    begin
      qryImagem.SQL.Add('Update Empresa Set                                                                                 ');
      qryImagem.SQL.Add('  ImLogoTipo = (Select * From OPENROWSET(BULK N' + QuotedStr(ACaminho) + ', SINGLE_BLOB) AS Imagem)');
      qryImagem.SQL.Add('Where IdEmpresa = :IdEmpresa                                                                       ');

      qryImagem.ParamByName('IdEmpresa').AsInteger := IChave;
      qryImagem.ExecSQL;
      Result := True;
    end
    else
    if ATabela = 'Pessoa' then
    begin
      qryImagem.SQL.Add('Update Pessoa Set                                                                                  ');
      qryImagem.SQL.Add('  ImPessoa = (Select * From OPENROWSET(BULK N' + QuotedStr(ACaminho) + ', SINGLE_BLOB) AS Imagem)  ');
      qryImagem.SQL.Add('Where IdPessoa = :IdPessoa                                                                          ');

      qryImagem.ParamByName('IdPessoa').AsInteger := IChave;
      qryImagem.ExecSQL;
      Result := True;
    end
    else
    if ATabela = 'Produto' then
    begin
      qryImagem.SQL.Add('Update Produto Set                                                                                  ');
      qryImagem.SQL.Add('  ImProduto = (Select * From OPENROWSET(BULK N' + QuotedStr(ACaminho) + ', SINGLE_BLOB) AS Imagem)  ');
      qryImagem.SQL.Add('Where IdProduto = :IdProduto                                                                        ');

      qryImagem.ParamByName('IdProduto').AsInteger := IChave;
      qryImagem.ExecSQL;
      Result := True;
    end;


  finally

  end;
end;

function SoNumeros(Const ATexto: String): String;
var
  I: Integer;
  S: string;
begin
  S := '';

  for I := 1 to Length(ATexto) do
  begin
    if (ATexto[I] in ['0' .. '9', ',']) then
    begin
      S := S + Copy(ATexto, I, 1);
    end;
  end;

  Result := S;
end;

function VerificaCpfCnpj(ANumero: String): Boolean;
var
  n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12: Integer;
  d1, d2: Integer;
  digitado, calculado: string;

begin
  Result := False;

  ANumero := SoNumeros(ANumero);

  if Length(ANumero) = 11 then
  begin
    n1 := StrToInt(ANumero[1]);
    n2 := StrToInt(ANumero[2]);
    n3 := StrToInt(ANumero[3]);
    n4 := StrToInt(ANumero[4]);
    n5 := StrToInt(ANumero[5]);
    n6 := StrToInt(ANumero[6]);
    n7 := StrToInt(ANumero[7]);
    n8 := StrToInt(ANumero[8]);
    n9 := StrToInt(ANumero[9]);

    d1 := n9 * 2 + n8 * 3 + n7 * 4 + n6 * 5 + n5 * 6 + n4 * 7 + n3 * 8 + n2 * 9 + n1 * 10;
    d1 := 11 - (d1 mod 11);

    if d1 >= 10 then
    begin
      d1 := 0;
    end;

    d2 := d1 * 2 + n9 * 3 + n8 * 4 + n7 * 5 + n6 * 6 + n5 * 7 + n4 * 8 + n3 * 9 + n2 * 10 + n1 * 11;
    d2 := 11 - (d2 mod 11);

    if d2 >= 10 then
    begin
      d2 := 0;
    end;

    calculado := inttostr(d1) + inttostr(d2);
    digitado := ANumero[10] + ANumero[11];

    if calculado = digitado then
    begin
      Result := True;
    end;
  end;

  if Length(ANumero) = 14 then
  begin
    n1 := StrToInt(ANumero[1]);
    n2 := StrToInt(ANumero[2]);
    n3 := StrToInt(ANumero[3]);
    n4 := StrToInt(ANumero[4]);
    n5 := StrToInt(ANumero[5]);
    n6 := StrToInt(ANumero[6]);
    n7 := StrToInt(ANumero[7]);
    n8 := StrToInt(ANumero[8]);
    n9 := StrToInt(ANumero[9]);
    n10 := StrToInt(ANumero[10]);
    n11 := StrToInt(ANumero[11]);
    n12 := StrToInt(ANumero[12]);

    d1 := n12 * 2 + n11 * 3 + n10 * 4 + n9 * 5 + n8 * 6 + n7 * 7 + n6 * 8 + n5 * 9 + n4 * 2 + n3 * 3 + n2 * 4 + n1 * 5;
    d1 := 11 - (d1 mod 11);
    if d1 >= 10 then
    begin
      d1 := 0;
    end;

    d2 := d1 * 2 + n12 * 3 + n11 * 4 + n10 * 5 + n9 * 6 + n8 * 7 + n7 * 8 + n6 * 9 + n5 * 2 + n4 * 3 + n3 * 4 + n2 * 5 + n1 * 6;
    d2 := 11 - (d2 mod 11);
    if d2 >= 10 then
    begin
      d2 := 0;
    end;

    calculado := inttostr(d1) + inttostr(d2);
    digitado := ANumero[13] + ANumero[14];

    if calculado = digitado then
    begin
      Result := True;
    end;

  end;

end;

function ConexaoRede: Boolean;
var
  flags: Dword;
begin
  Result := internetgetconnectedstate(@flags, 0);
end;

function VersaoExecutavel(Executavel: string): String;
type
  PFFI = ^vs_FixedFileInfo;
var
  F: PFFI;
  Handle: Dword;
  Len: Longint;
  Data: Pchar;
  Buffer: Pointer;
  Tamanho: Dword;
  Parquivo: Pchar;
  Arquivo: String;
begin
  Arquivo := Executavel;
  Parquivo := StrAlloc(Length(Arquivo) + 1);
  StrPcopy(Parquivo, Arquivo);
  Len := GetFileVersionInfoSize(Parquivo, Handle);
  Result := '';
  if Len > 0 then
  begin
    Data := StrAlloc(Len + 1);
    if GetFileVersionInfo(Parquivo, Handle, Len, Data) then
    begin
      VerQueryValue(Data, '', Buffer, Tamanho);
      F := PFFI(Buffer);
      Result := Format('%d.%d.%d.%d', [HiWord(F^.dwFileVersionMs), LoWord(F^.dwFileVersionMs), HiWord(F^.dwFileVersionLs), LoWord(F^.dwFileVersionLs)]);
    end;
    StrDispose(Data);
  end;
  StrDispose(Parquivo);
end;

function NomeDoMes(I: word; Tipo: Integer): String;
const
  Mes: array [1 .. 12] of string = ('Janeiro', 'Fevereiro', 'Mar�o', 'Abril', 'Maio', 'Junho', 'Julho', 'Agosto', 'Setembro', 'Outubro', 'Novembro', 'Dezembro');
begin
  if (Tipo = 0) then
  begin
    NomeDoMes := Mes[I]
  end
  else
  begin
    NomeDoMes := Copy(Mes[I], 1, 3);
  end;
end;

function DiaDaSemana(I: word; Tipo: Integer): String;
const
  DSemama: array [1 .. 7] of string = ('Domingo', 'Segunda-Feira', 'Ter�a-Feira', 'Quarta-Feira', 'Quinta-Feira', 'Sexta-Feira', 'S�bado');
begin
  if (Tipo = 0) then
  begin
    DiaDaSemana := DSemama[I];
  end
  else
  begin
    DiaDaSemana := Copy(DSemama[I], 1, 3);
  end;
end;

function DataPorExtenso(AData: TDateTime): String;
var
  Dia, Mes, Ano, DiaSemana: word;
begin
  DecodeDate(AData, Ano, Mes, Dia);
  DiaSemana := DayOfWeek(AData);
  DataPorExtenso := DiaDaSemana(DiaSemana, 0) + ' ' + inttostr(Dia) + ' de ' + NomeDoMes(Mes, 0) + ' de ' + inttostr(Ano);
end;

function InicialMaiuscula(ATexto: String): String;
var
  I: Integer;
  Condicao: Boolean;
begin
  Condicao := True;
  Result := ATexto;

  for I := 1 to Length(ATexto) do
  begin
    if Condicao then
    begin
      if not(Result[I] in [' ', '-']) then
      begin
        Result[I] := UpCase(Result[I]);
        Condicao := False;
      end;
    end
    else if (Result[I] in [' ', '-']) then
    begin
      Condicao := True;
    end;
  end;
end;

function PermitePesquisa(AField: TField; AConsulta: String): Boolean;
var
  N: Integer;
begin
  Result := AField.Visible and (AField.DataType in [ftString, ftInteger]);

  if Result and (AField.DataType = ftString) then
  begin
    Result := (AField.Size >= (Length(AConsulta) + 2));
  end;

  if Result and (AField.DataType = ftInteger) then
  begin
    Result := TryStrToInt(AConsulta, N);
  end;
end;

function FinalizarAplicacao(ANome: String): Integer;
const
  PROCESS_TERMINATE = $0001;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  if MsgConfirmacao(uMensagem.DesejaRealizarCopiaSeguranca) then
  begin
    uProcedure.CopiaSeguranca;
  end;

  Result                 := 0;
  FSnapshotHandle        := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop           := Process32First(FSnapshotHandle, FProcessEntry32);

  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(ANome)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(ANome))) then
      Result       := Integer(TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0), FProcessEntry32.th32ProcessID), 0));
      ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

function MsgInformacao(AMensagem: String): Boolean;
begin
  Application.MessageBox(Pchar(AMensagem), 'INFORMA��O', MB_OK + MB_ICONINFORMATION);
  Result := True;
end;

function MsgAtencao(AMensagem: String): Boolean;
begin
  Application.MessageBox(Pchar(AMensagem), 'ATEN��O',  MB_OK + MB_ICONEXCLAMATION);
  Result := True;
end;

function MsgErro(AMensagem: String): Boolean;
begin
  Application.MessageBox(Pchar(AMensagem), 'ERRO', MB_OK + MB_ICONERROR);
  Result := True;
end;

function MsgConfirmacao(AMensagem: String): Boolean;
begin
  Result := False;
  if (Application.MessageBox(Pchar(AMensagem), 'CONFIRMA��O', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = mrYes) then
  begin
    Result := True;
  end;
end;

end.
