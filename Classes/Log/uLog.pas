unit uLog;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Winsock, ACBrBase, ACBrMail;

 type
  TLog = class
    InACBrMail      : TACBrMail;
  private
    FIdEmpresa      : Integer;
    FIdUsuario      : Integer;
    FDtCadastro     : TDateTime;
    FDtPesquisa     : TDate;
    FIdLog          : Integer;
    FNmModulo       : String;
    FNmOperacao     : String;
    FNmTabela       : String;
    FNmClasse       : String;
    FNmMetodo       : String;
    FNmVersao       : String;
    FNmMensagem     : WideString;
    FNmComputador   : string;
    FPk1            : String;
    FPk2            : String;
    FPk3            : String;
    FPk4            : String;
    FPk5            : String;
    FPk6            : String;
    FPk7            : String;
    FPk8            : String;
    FPk9            : String;
    FNmUsuario      : String;
    FNrCpf          : String;
    FNmLogin        : String;
  public
    LogConexao : Boolean;
    property IdEmpresa    : Integer     read FIdEmpresa     write FIdEmpresa;
    property IdUsuario    : Integer     read FIdUsuario     write FIdUsuario;
    property DtCadastro   : TDateTime   read FDtCadastro    write FDtCadastro;
    property DtPesquisa   : TDate       read FDtPesquisa    write FDtPesquisa;
    property IdLog        : Integer     read FIdLog         write FIdLog;
    property NmModulo     : String      read FNmModulo      write FNmModulo;
    property NmOperacao   : String      read FNmOperacao    write FNmOperacao;
    property NmTabela     : String      read FNmTabela      write FNmTabela;
    property NmClasse     : String      read FNmClasse      write FNmClasse;
    property NmMetodo     : String      read FNmMetodo      write FNmMetodo;
    property NmVersao     : String      read FNmVersao      write FNmVersao;
    property NmMensagem   : WideString  read FNmMensagem    write FNmMensagem;
    property NmComputador : String      read FNmComputador  write FNmComputador;
    property PK1          : String      read FPK1           write FPK1;
    property PK2          : String      read FPK2           write FPK2;
    property PK3          : String      read FPK3           write FPK3;
    property PK4          : String      read FPK4           write FPK4;
    property PK5          : String      read FPK5           write FPK5;
    property PK6          : String      read FPK6           write FPK6;
    property PK7          : String      read FPK7           write FPK7;
    property PK8          : String      read FPK8           write FPK8;
    property PK9          : String      read FPK9           write FPK9;
    property NmUsuario    : String      read FNmUsuario     write FNmUsuario;
    property NrCpf        : String      read FNrCpf         write FNrCpf;
    property NmLogin      : String      read FNmLogin       write FNmLogin;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    function GerarLog(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdEmpresa: Integer; AIdLog: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdEmpresa: Integer; AIdLog: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdLog: Integer): Boolean;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; AIdEmpresa: Integer; AIdLog: Integer; AConsulta: String; ADtInicial: TDate; ADtFinal: TDate; ATpChamada: Integer; Data: TClientDataSet);
    procedure Inicializar;
  end;

implementation

uses uFuncao, uConfiguracao;

var
  unConfiguracao : TConfiguracao;

procedure TLog.CarregaDbGrid(ASQLConnection: TFDConnection; AIdEmpresa, AIdLog: Integer; AConsulta: String; ADtInicial: TDate; ADtFinal: TDate; ATpChamada: Integer; Data: TClientDataSet);
var
  qryLog       : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryLog := TFDQuery.Create(nil);
  try
    qryLog.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('DtPesquisa', ftDate);
      Data.FieldDefs.Add('IdLog', ftInteger);
      Data.FieldDefs.Add('NmModulo', ftString, 20, False);
      Data.FieldDefs.Add('NmOperacao', ftString, 15, False);
      Data.FieldDefs.Add('NmTabela', ftString, 20, False);
      Data.FieldDefs.Add('NmClasse', ftString, 50, False);
      Data.FieldDefs.Add('NmMetodo', ftString, 50, False);
      Data.FieldDefs.Add('NmVersao', ftString, 20, False);
      Data.FieldDefs.Add('NmMensagem', ftWideString, 255, False);
      Data.FieldDefs.Add('NmComputador', ftString, 30, False);
      Data.FieldDefs.Add('Pk1', ftString, 10, False);
      Data.FieldDefs.Add('Pk2', ftString, 10, False);
      Data.FieldDefs.Add('Pk3', ftString, 10, False);
      Data.FieldDefs.Add('Pk4', ftString, 10, False);
      Data.FieldDefs.Add('Pk5', ftString, 10, False);
      Data.FieldDefs.Add('Pk6', ftString, 10, False);
      Data.FieldDefs.Add('Pk7', ftString, 10, False);
      Data.FieldDefs.Add('Pk8', ftString, 10, False);
      Data.FieldDefs.Add('Pk9', ftString, 10, False);
      Data.FieldDefs.Add('NmUsuario', ftString, 25, False);
      Data.FieldDefs.Add('NrCpf', ftString, 20, False);
      Data.FieldDefs.Add('NmLogin', ftString, 50, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryLog.Params.Clear;
      qryLog.SQL.Clear;
      qryLog.SQL.Add('Select                ');
      qryLog.SQL.Add('  *                   ');
      qryLog.SQL.Add('From VW_GridLogSistema');
      qryLog.SQL.Add('Where 1 = 1           ');

      if ATpChamada = 1 then
      begin
        qryLog.SQL.Add('  And DtPesquisa BetWeen :DtInicio And :DtFinal');

        qryLog.ParamByName('DtInicio').AsDate := ADtInicial;
        qryLog.ParamByName('DtFinal').AsDate  := ADtFinal;
      end
      else if ATpChamada = 2 then
      begin
        qryLog.SQL.Add('  And IdLog = :IdLog');

        qryLog.ParamByName('IdLog').AsInteger := AIdLog;
      end;

       if AIdLog > 0 then
      begin
         qryLog.SQL.Add('  And IdLog = :IdLog');

         qryLog.ParamByName('IdLog').AsInteger := AIdLog;
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
          qryLog.SQL.Add (lCondicao);
          qryLog.SQL.Add ('Order By');
          qryLog.SQL.Add ('  IdLog Desc');

          qryLog.Open;
          qryLog.First;
        end;
      end else begin
        qryLog.SQL.Add (lCondicao);
        qryLog.SQL.Add ('Order By');
        qryLog.SQL.Add ('  IdLog Desc');

        lFinalizaLoop := 1;
        qryLog.Open;
        qryLog.First;
      end;

      while not qryLog.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdLog').AsInteger = qryLog.FieldByName('IdLog').AsInteger then
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
          Data.FieldByName('IdEmpresa').AsInteger     := qryLog.FieldByName('IdEmpresa').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger     := qryLog.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime   := qryLog.FieldByName('DtCadastro').AsDateTime;
          Data.FieldByName('IdLog').AsInteger         := qryLog.FieldByName('IdLog').AsInteger;
          Data.FieldByName('NmModulo').AsString       := qryLog.FieldByName('NmModulo').AsString;
          Data.FieldByName('NmOperacao').AsString     := qryLog.FieldByName('NmOperacao').AsString;
          Data.FieldByName('NmTabela').AsString       := qryLog.FieldByName('NmTabela').AsString;
          Data.FieldByName('NmClasse').AsString       := qryLog.FieldByName('NmClasse').AsString;
          Data.FieldByName('NmMetodo').AsString       := qryLog.FieldByName('NmMetodo').AsString;
          Data.FieldByName('NmVersao').AsString       := qryLog.FieldByName('NmVersao').AsString;
          Data.FieldByName('NmMensagem').AsWideString := qryLog.FieldByName('NmMensagem').AsWideString;
          Data.FieldByName('NmComputador').AsString   := qryLog.FieldByName('NmComputador').AsString;
          Data.FieldByName('Pk1').AsString            := qryLog.FieldByName('Pk1').AsString;
          Data.FieldByName('Pk2').AsString            := qryLog.FieldByName('Pk2').AsString;
          Data.FieldByName('Pk3').AsString            := qryLog.FieldByName('Pk3').AsString;
          Data.FieldByName('Pk4').AsString            := qryLog.FieldByName('Pk4').AsString;
          Data.FieldByName('Pk5').AsString            := qryLog.FieldByName('Pk5').AsString;
          Data.FieldByName('Pk6').AsString            := qryLog.FieldByName('Pk6').AsString;
          Data.FieldByName('Pk7').AsString            := qryLog.FieldByName('Pk7').AsString;
          Data.FieldByName('Pk8').AsString            := qryLog.FieldByName('Pk8').AsString;
          Data.FieldByName('Pk9').AsString            := qryLog.FieldByName('Pk9').AsString;
          Data.FieldByName('NmUsuario').AsString      := qryLog.FieldByName('NmUsuario').AsString;
          Data.FieldByName('NrCpf').AsString          := qryLog.FieldByName('NrCpf').AsString;
          Data.FieldByName('NmLogin').AsString        := qryLog.FieldByName('NmLogin').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryLog.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryLog.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TLog.Create;
begin
   Inicializar;

   unConfiguracao := TConfiguracao.Create;
end;

procedure TLog.Inicializar();
begin
  IdEmpresa     := 0;
  IdUsuario     := 0;
  DtCadastro    := 0;
  DtPesquisa    := 0;
  IdLog         := 0;
  FNmModulo     := '';
  NmOperacao    := '';
  NmTabela      := '';
  NmClasse      := '';
  NmMetodo      := '';
  NmVersao      := '';
  NmMensagem    := '';
  NmComputador  := '';
  PK1           := '';
  PK2           := '';
  PK3           := '';
  PK4           := '';
  PK5           := '';
  PK6           := '';
  PK7           := '';
  PK8           := '';
  PK9           := '';
  NmUsuario     := '';
  NrCpf         := '';
  NmLogin       := '';
end;

function TLog.Salvar(ASQLConnection: TFDConnection): Boolean;
var
  qryLog: TFDQuery;
begin
  qryLog:= TFDQuery.Create(Nil);
  try
    qryLog.Connection := ASQLConnection;
    qryLog.SQL.Add('Insert Into Log(');
    qryLog.SQL.Add('  IdEmpresa,');
    qryLog.SQL.Add('  IdUsuario,');
    qryLog.SQL.Add('  NmModulo,');
    qryLog.SQL.Add('  NmOperacao,');
    qryLog.SQL.Add('  NmTabela,');
    qryLog.SQL.Add('  NmClasse,');
    qryLog.SQL.Add('  NmMetodo,');
    qryLog.SQL.Add('  NmVersao,');
    qryLog.SQL.Add('  NmMensagem,');
    qryLog.SQL.Add('  NmComputador,');
    qryLog.SQL.Add('  Pk1,');
    qryLog.SQL.Add('  Pk2,');
    qryLog.SQL.Add('  Pk3,');
    qryLog.SQL.Add('  Pk4,');
    qryLog.SQL.Add('  Pk5,');
    qryLog.SQL.Add('  Pk6,');
    qryLog.SQL.Add('  Pk7,');
    qryLog.SQL.Add('  Pk8,');
    qryLog.SQL.Add('  Pk9)');
    qryLog.SQL.Add('Values (');
    qryLog.SQL.Add('  :IdEmpresa,');
    qryLog.SQL.Add('  :IdUsuario,');
    qryLog.SQL.Add('  :NmModulo,');
    qryLog.SQL.Add('  :NmOperacao,');
    qryLog.SQL.Add('  :NmTabela,');
    qryLog.SQL.Add('  :NmClasse,');
    qryLog.SQL.Add('  :NmMetodo,');
    qryLog.SQL.Add('  :NmVersao,');
    qryLog.SQL.Add('  :NmMensagem,');
    qryLog.SQL.Add('  :NmComputador,');
    qryLog.SQL.Add('  :Pk1,');
    qryLog.SQL.Add('  :Pk2,');
    qryLog.SQL.Add('  :Pk3,');
    qryLog.SQL.Add('  :Pk4,');
    qryLog.SQL.Add('  :Pk5,');
    qryLog.SQL.Add('  :Pk6,');
    qryLog.SQL.Add('  :Pk7,');
    qryLog.SQL.Add('  :Pk8,');
    qryLog.SQL.Add('  :Pk9)');

    qryLog.ParamByName('IdEmpresa').AsInteger     := IdEmpresa;
    qryLog.ParamByName('IdUsuario').AsInteger     := IdUsuario;
    qryLog.ParamByName('NmModulo').AsString       := NmModulo;
    qryLog.ParamByName('NmOperacao').AsString     := NmOperacao;
    qryLog.ParamByName('NmTabela').AsString       := NmTabela;
    qryLog.ParamByName('NmClasse').AsString       := NmClasse;
    qryLog.ParamByName('NmMetodo').AsString       := NmMetodo;
    qryLog.ParamByName('NmVersao').AsString       := NmVersao;
    qryLog.ParamByName('NmMensagem').AsWideString := NmMensagem;
    qryLog.ParamByName('NmComputador').AsString   := NmComputador;
    qryLog.ParamByName('Pk1').AsString            := Pk1;
    qryLog.ParamByName('Pk2').AsString            := Pk2;
    qryLog.ParamByName('Pk3').AsString            := Pk3;
    qryLog.ParamByName('Pk4').AsString            := Pk4;
    qryLog.ParamByName('Pk5').AsString            := Pk5;
    qryLog.ParamByName('Pk6').AsString            := Pk6;
    qryLog.ParamByName('Pk7').AsString            := Pk7;
    qryLog.ParamByName('Pk8').AsString            := Pk8;
    qryLog.ParamByName('Pk9').AsString            := Pk9;
    qryLog.ExecSQL;
    qryLog.Close;

    Result := True;
  finally
    FreeAndNil(qryLog)
  end;
end;

class function TLog.Inativar(ASQLConnection: TFDConnection; AIdEmpresa: Integer; AIdLog: Integer): Boolean;
var
  qryLog: TFDQuery;
begin
  qryLog:= TFDQuery.Create(Nil);
  try
    qryLog.Connection := ASQLConnection;
    qryLog.SQL.Add('Update Log Set                             ');
    qryLog.SQL.Add('  SnSituacao = 0                           ');
    qryLog.SQL.Add('Where IdEmpresa = ' + IntToStr(AIdEmpresa)  );
    qryLog.SQL.Add('  And IdLog = ' + IntToStr(AIdLog)          );
    qryLog.ExecSQL;
    qryLog.Close;

    Result := True;
  finally
    FreeAndNil(qryLog)
  end;
end;

class function TLog.Existe(ASQLConnection: TFDConnection; AIdEmpresa: Integer; AIdLog: Integer): Boolean;
var
  qryLog: TFDQuery;
begin
  Result := False;
  qryLog:= TFDQuery.Create(Nil);
  try
    qryLog.Connection := ASQLConnection;
    qryLog.SQL.Add('Select IdEmpresa From Log                ');
    qryLog.SQL.Add('where IdEmpresa = ' + IntToStr(AIdEmpresa));
    qryLog.SQL.Add('  And IdLog = ' + IntToStr(AIdLog)        );
    qryLog.Open;
    if qryLog.Fields[0].Value > 0 then
      Result := True;
    qryLog.Close;
  finally
    FreeAndNil(qryLog)
  end;
end;

function TLog.GerarLog(ASQLConnection: TFDConnection): Boolean;
begin
  unConfiguracao.Inicializar;
  //LOG DA APLICA��O "CLIQUEIS DO EXECUTAVEL" {SIM/NAO}
  unConfiguracao.BuscarSigla(ASQLConnection, 'LAPP');

  if unConfiguracao.NmValor = 'S' then
  begin
    Salvar(ASQLConnection);
    Result := True;
  end
  else
  if LogConexao then
  begin
    Salvar(ASQLConnection);
    Result := True;
  end;
end;

function TLog.Buscar(ASQLConnection: TFDConnection; AIdLog: Integer): Boolean;
var
  qryLog: TFDQuery;
begin
  qryLog:= TFDQuery.Create(Nil);
  try
    qryLog.Connection := ASQLConnection;
    qryLog.SQL.Add('Select                                   ');
    qryLog.SQL.Add('  *                                      ');
    qryLog.SQL.Add('From VW_GridLogSistema                   ');
    qryLog.SQL.Add('Where IdLog = :IdLog                     ');

    qryLog.ParamByName('IdLog').AsString := IntToStr(AIdLog);

    qryLog.Open;
    if not qryLog.IsEmpty then
    begin
      Result        := True;
      IdEmpresa     := qryLog.FieldByName('IdEmpresa').AsInteger;
      IdUsuario     := qryLog.FieldByName('IdUsuario').AsInteger;
      DtCadastro    := qryLog.FieldByName('DtCadastro').AsDateTime;
      IdLog         := qryLog.FieldByName('IdLog').AsInteger;
      NmModulo      := qryLog.FieldByName('NmMetodo').AsString;
      NmOperacao    := qryLog.FieldByName('NmOperacao').AsString;
      NmTabela      := qryLog.FieldByName('NmTabela').AsString;
      NmClasse      := qryLog.FieldByName('NmClasse').AsString;
      NmMetodo      := qryLog.FieldByName('NmMetodo').AsString;
      NmVersao      := qryLog.FieldByName('NmVersao').AsString;
      NmMensagem    := qryLog.FieldByName('NmMensagem').AsWideString;
      NmComputador  := qryLog.FieldByName('NmComputador').AsString;
      Pk1           := qryLog.FieldByName('Pk1').AsString;
      Pk2           := qryLog.FieldByName('Pk2').AsString;
      Pk3           := qryLog.FieldByName('Pk3').AsString;
      Pk4           := qryLog.FieldByName('Pk4').AsString;
      Pk5           := qryLog.FieldByName('Pk5').AsString;
      Pk6           := qryLog.FieldByName('Pk6').AsString;
      Pk7           := qryLog.FieldByName('Pk7').AsString;
      Pk8           := qryLog.FieldByName('Pk8').AsString;
      Pk9           := qryLog.FieldByName('Pk9').AsString;
      NmUsuario     := qryLog.FieldByName('NmUsuario').AsString;
      NrCpf         := qryLog.FieldByName('NrCpf').AsString;
      NmLogin       := qryLog.FieldByName('NmLogin').AsString;

    end;
    qryLog.Close;

    Result := True;
  finally
    FreeAndNil(qryLog)
  end;
end;

end.

