unit uUsuario;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TUsuario = class
  private
    FNmRazaoSocialNmFantasia : String;
    FIdEmpresa        : Integer;
    FIdUsuario        : Integer;
    FDtCadastro       : TDateTime;
    FSnSituacao       : Integer;
    FIdUsuarioCadastro: Integer;
    FNmUsuarioCadastro  : String;
    FNmUsuario        : String;
    FNmLogin          : String;
    FNmSenha          : String;
    FNrCpf            : String;
    FSnAdministrador  : Integer;
    FSnSuporte: Integer;
    procedure Inicializar();
  public
    property IdEmpresa:         Integer   read FIdEmpresa         write FIdEmpresa;
    property NmRazaoSocialNmFantasia:     String   read FNmRazaoSocialNmFantasia  write FNmRazaoSocialNmFantasia;
    property IdUsuario:         Integer   read FIdUsuario         write FIdUsuario;
    property DtCadastro:        TDateTime read FDtCadastro        write FDtCadastro;
    property SnSituacao:        Integer   read FSnSituacao        write FSnSituacao;
    property IdUsuarioCadastro: Integer   read FIdUsuarioCadastro write FIdUsuarioCadastro;
    property NmUsuarioCadastro:   String    read FNmUsuarioCadastro   write FNmUsuarioCadastro;
    property NmUsuario:         String    read FNmUsuario         write FNmUsuario;
    property NmLogin:           String    read FNmLogin           write FNmLogin;
    property NmSenha:           String    read FNmSenha           write FNmSenha;
    property NrCpf:             String    read FNrCpf             write FNrCpf;
    property SnAdministrador:   Integer   read FSnAdministrador   write FSnAdministrador;
    property SnSuporte:         Integer   read FSnSuporte         write FSnSuporte;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdUsuario: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdUsuario: Integer): Boolean;
    function ExisteCadastro(ASQLConnection: TFDConnection): Boolean;
    function Buscar(ASQLConnection: TFDConnection; AIdUsuario: Integer): Boolean;
    function BuscarUsuario(ASQLConnection: TFDConnection; ANmLogin: String): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer;  AIdUsuario: Integer; AConsulta: String; Data: TClientDataSet);
    function ValidaUsuarioSenha(ASQLConnection: TFDConnection): String;
  end;

implementation

uses uFuncao;

procedure TUsuario.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer;  AIdUsuario: Integer; AConsulta: String; Data: TClientDataSet);
var
  qryUsuario    : TFDQuery;
  I             : Integer;
  lCampo        : TField;
  lCondicao     : String;
  lVerificacao  : Integer;
  lFinalizaLoop : Integer;
begin
  lVerificacao  := 0;
  lFinalizaLoop := 0;

  qryUsuario := TFDQuery.Create(nil);
  try
    qryUsuario.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('NmRazaoSocialNmFantasia', ftString, 255, False);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 9, False);
      Data.FieldDefs.Add('IdUsuarioCadastro', ftInteger);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 255, False);
      Data.FieldDefs.Add('NmUsuario', ftString, 255, False);
      Data.FieldDefs.Add('NmLogin', ftString, 255, False);
      Data.FieldDefs.Add('NrCpf', ftString, 255, False);
      Data.FieldDefs.Add('SnAdministrador', ftString, 7, False);
      Data.FieldDefs.Add('SnSuporte', ftString, 7, False);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount - 1 do
    begin
      lCampo := Data.Fields[I];

      qryUsuario.Params.Clear;
      qryUsuario.SQL.Clear;
      qryUsuario.SQL.Add('Select              ');
      qryUsuario.SQL.Add('  *                 ');
      qryUsuario.SQL.Add('From VW_GridUsuario ');
      qryUsuario.SQL.Add('Where 1 = 1         ');

      if ISnSituacao = 1 then
      begin
         qryUsuario.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryUsuario.SQL.Add('  And SnSituacao = 0');
      end;

      if AIdUsuario > 0 then
      begin
        qryUsuario.SQL.Add('  And IdUsuario = :IdUsuario');

        qryUsuario.ParamByName('IdUsuario').AsInteger := AIdUsuario;
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
            lCondicao := ' And Usuario.' + lCampo.FieldName + ' = ' + AConsulta;
          end;
          qryUsuario.SQL.Add(lCondicao);
          qryUsuario.SQL.Add('Order By');
          qryUsuario.SQL.Add('  IdUsuario');

          qryUsuario.Open;
          qryUsuario.First;
        end;
      end
      else
      begin
        qryUsuario.SQL.Add(lCondicao);
        qryUsuario.SQL.Add('Order By');
        qryUsuario.SQL.Add('  IdUsuario');

        lFinalizaLoop := 1;
        qryUsuario.Open;
        qryUsuario.First;
      end;

      while not qryUsuario.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdUsuario').AsInteger = qryUsuario.FieldByName('IdUsuario').AsInteger then
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
          Data.FieldByName('IdEmpresa').AsInteger := qryUsuario.FieldByName('IdEmpresa').AsInteger;
          Data.FieldByName('NmRazaoSocialNmFantasia').AsString := qryUsuario.FieldByName('NmRazaoSocialNmFantasia').AsString;
          Data.FieldByName('IdUsuario').AsInteger := qryUsuario.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryUsuario.FieldByName('DtCadastro').AsDateTime;
          if qryUsuario.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString       := 'ATIVO';
          end else begin
            Data.FieldByName('SnSituacao').AsString       := 'INATIVO';
          end;
          Data.FieldByName('IdUsuarioCadastro').AsInteger := qryUsuario.FieldByName('IdUsuarioCadastro').AsInteger;
          Data.FieldByName('NmUsuarioCadastro').AsString := qryUsuario.FieldByName('NmUsuarioCadastro').AsString;
          Data.FieldByName('NmUsuario').AsString := qryUsuario.FieldByName('NmUsuario').AsString;
          Data.FieldByName('NmLogin').AsString := qryUsuario.FieldByName('NmLogin').AsString;
          Data.FieldByName('NrCpf').AsString := qryUsuario.FieldByName('NrCpf').AsString;
          if qryUsuario.FieldByName('SnAdministrador').AsBoolean then
          begin
            Data.FieldByName('SnAdministrador').AsString := 'Sim';
          end
          else
          begin
            Data.FieldByName('SnAdministrador').AsString := 'N�o';
          end;
          if qryUsuario.FieldByName('SnSuporte').AsBoolean then
          begin
            Data.FieldByName('SnSuporte').AsString := 'Sim';
          end
          else
          begin
            Data.FieldByName('SnSuporte').AsString := 'N�o';
          end;
          Data.Post;
        end;

        lVerificacao := 0;
        qryUsuario.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryUsuario.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TUsuario.Create;
begin
  Inicializar();
end;

procedure TUsuario.Inicializar();
begin
  NmRazaoSocialNmFantasia := '';
  IdEmpresa := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 1;
  IdUsuarioCadastro := 0;
  NmUsuarioCadastro := '';
  NmUsuario := '';
  NmLogin := '';
  NmSenha := '';
  NrCpf := '';
  SnAdministrador := 0;
  SnSuporte := 0;
end;

function TUsuario.Salvar(ASQLConnection: TFDConnection): Boolean;
var
  qryUsuario: TFDQuery;
begin
  qryUsuario := TFDQuery.Create(Nil);
  try
    qryUsuario.Connection := ASQLConnection;

    qryUsuario.SQL.Add('Exec PC_CriarUsuario');
    qryUsuario.SQL.Add(':IdEmpresa,');
    qryUsuario.SQL.Add(':SnSituacao,');
    qryUsuario.SQL.Add(':IdUsuario,');
    qryUsuario.SQL.Add(':IdUsuarioCadastro,');
    qryUsuario.SQL.Add(':NmUsuario,');
    qryUsuario.SQL.Add(':NmLogin,');
    qryUsuario.SQL.Add(':NmSenha,');
    qryUsuario.SQL.Add(':NrCpf,');
    qryUsuario.SQL.Add(':SnAdministrador,');
    qryUsuario.SQL.Add(':TpChamadaClasse');

    if not Existe(ASQLConnection, IdUsuario) then
    begin
      qryUsuario.ParamByName('TpChamadaClasse').Value := 'Criar';
      qryUsuario.ParamByName('IdUsuario').Value := 0;
    end
    else
    begin
      qryUsuario.ParamByName('TpChamadaClasse').Value := 'Alterar';
      qryUsuario.ParamByName('IdUsuario').Value := IdUsuario;
    end;
    qryUsuario.ParamByName('IdEmpresa').Value := IdEmpresa;
    qryUsuario.ParamByName('SnSituacao').Value := SnSituacao;
    qryUsuario.ParamByName('IdUsuario').Value := IdUsuario;
    qryUsuario.ParamByName('IdUsuarioCadastro').Value := IdUsuarioCadastro;
    qryUsuario.ParamByName('NmUsuario').Value := NmUsuario;
    qryUsuario.ParamByName('NmLogin').Value := NmLogin;
    qryUsuario.ParamByName('NmSenha').Value := NmSenha;
    qryUsuario.ParamByName('NrCpf').Value := NrCpf;
    qryUsuario.ParamByName('SnAdministrador').Value := SnAdministrador;

    try
      qryUsuario.ExecSQL;
      qryUsuario.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryUsuario)
  end;
end;

function TUsuario.ValidaUsuarioSenha(ASQLConnection: TFDConnection): String;
var
  qryUsuario: TFDQuery;
begin
  qryUsuario := TFDQuery.Create(nil);
  try
    qryUsuario.Connection := ASQLConnection;
    qryUsuario.SQL.Add
      ('Select Valida = dbo.FN_ValidaUsuarioSenha(:NmUsuario, :NmSenha)');

    qryUsuario.ParamByName('NmUsuario').AsString := NmUsuario;
    qryUsuario.ParamByName('NmSenha').AsString   := NmSenha;

    qryUsuario.Open;

    Result := qryUsuario.FieldByName('Valida').AsString;
  finally
    FreeAndNil(qryUsuario)
  end;
end;

class function TUsuario.Inativar(ASQLConnection: TFDConnection; AIdUsuario: Integer): Boolean;
var
  qryUsuario: TFDQuery;
begin
  qryUsuario := TFDQuery.Create(Nil);
  try
    qryUsuario.Connection := ASQLConnection;
    qryUsuario.SQL.Add('Update Usuario Set ');
    qryUsuario.SQL.Add('  SnSituacao = 0 ');
    qryUsuario.SQL.Add('Where IdUsuario = ' + IntToStr(AIdUsuario));
    try
      qryUsuario.ExecSQL;
      qryUsuario.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryUsuario)
  end;
end;

class function TUsuario.Existe(ASQLConnection: TFDConnection; AIdUsuario: Integer): Boolean;
var
  qryUsuario: TFDQuery;
begin
  Result := False;
  qryUsuario := TFDQuery.Create(Nil);
  try
    qryUsuario.Connection := ASQLConnection;
    qryUsuario.SQL.Add('Select IdEmpresa From Usuario');
    qryUsuario.SQL.Add('Where IdUsuario = ' + IntToStr(AIdUsuario));
    qryUsuario.Open;
    if qryUsuario.Fields[0].Value > 0 then
      Result := True;
    qryUsuario.Close;
  finally
    FreeAndNil(qryUsuario)
  end;
end;

function TUsuario.ExisteCadastro(ASQLConnection: TFDConnection): Boolean;
var
  qryUsuario: TFDQuery;
begin
  Result := False;
  qryUsuario := TFDQuery.Create(Nil);

  qryUsuario.Connection := aSQLConnection;

  try
    qryUsuario.SQL.Add('Select Count(*) From Usuario');
    qryUsuario.Open;
    if qryUsuario.Fields[0].Value > 0 then
    begin
      Result := True;
    end;
    qryUsuario.Close;
  finally
    FreeAndNil(qryUsuario)
  end;
end;

class function TUsuario.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryUsuario: TFDQuery;
begin
  Result := 0;
  qryUsuario := TFDQuery.Create(Nil);
  try
    qryUsuario.Connection := ASQLConnection;

    qryUsuario.SQL.Add('Select Max(IdUsuario) As IdUsuario From Usuario');
    qryUsuario.Open;

    if qryUsuario.FieldByName('IdUsuario').AsInteger > 0 then
      Result := qryUsuario.FieldByName('IdUsuario').AsInteger;
    qryUsuario.Close;
  finally
    FreeAndNil(qryUsuario)
  end;
end;

function TUsuario.Buscar(ASQLConnection: TFDConnection; AIdUsuario: Integer): Boolean;
var
  qryUsuario: TFDQuery;
begin
  Result := False;
  qryUsuario := TFDQuery.Create(Nil);
  try
    qryUsuario.Connection := ASQLConnection;

    qryUsuario.SQL.Add('Select * From VW_GridUsuario');
    qryUsuario.SQL.Add('Where IdUsuario = :IdUsuario');

    qryUsuario.ParamByName('IdUsuario').AsString := IntToStr(AIdUsuario);

    qryUsuario.Open;
    if not qryUsuario.IsEmpty then
    begin
      Result := True;
      IdEmpresa := qryUsuario.FieldByName('IdEmpresa').AsInteger;
      NmRazaoSocialNmFantasia := qryUsuario.FieldByName('NmRazaoSocialNmFantasia').AsString;
      IdUsuario := qryUsuario.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryUsuario.FieldByName('DtCadastro').AsDateTime;
      if qryUsuario.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end
      else
      begin
        SnSituacao := 0
      end;
      IdUsuarioCadastro := qryUsuario.FieldByName('IdUsuarioCadastro').AsInteger;
      NmUsuarioCadastro := qryUsuario.FieldByName('NmUsuarioCadastro').AsString;
      NmUsuario := qryUsuario.FieldByName('NmUsuario').AsString;
      NmLogin := qryUsuario.FieldByName('NmLogin').AsString;
      NmSenha := qryUsuario.FieldByName('NmSenha').AsString;
      NrCpf := qryUsuario.FieldByName('NrCpf').AsString;
      if qryUsuario.FieldByName('SnAdministrador').AsBoolean then
      begin
        SnAdministrador := 1
      end
      else
      begin
        SnAdministrador := 0
      end;
      if qryUsuario.FieldByName('SnSuporte').AsBoolean then
      begin
        SnSuporte := 1
      end
      else
      begin
        SnSuporte := 0
      end;
    end;
    qryUsuario.Close;
  finally
    FreeAndNil(qryUsuario)
  end;
end;

function TUsuario.BuscarUsuario(ASQLConnection: TFDConnection; ANmLogin: String): Boolean;
var
  qryUsuario: TFDQuery;
begin
  Result := False;
  qryUsuario := TFDQuery.Create(Nil);
  try
    qryUsuario.Connection := ASQLConnection;

    qryUsuario.SQL.Add('Select * From VW_GridUsuario');
    qryUsuario.SQL.Add('Where NmLogin = :NmLogin');
    qryUsuario.SQL.Add('  And SnSituacao = 1');

    qryUsuario.ParamByName('NmLogin').AsString := ANmLogin;

    qryUsuario.Open;
    if not qryUsuario.IsEmpty then
    begin
      Result := True;
      IdEmpresa := qryUsuario.FieldByName('IdEmpresa').AsInteger;
      NmRazaoSocialNmFantasia := qryUsuario.FieldByName('NmRazaoSocialNmFantasia').AsString;
      IdUsuario := qryUsuario.FieldByName('IdUsuario').AsInteger;
      DtCadastro := qryUsuario.FieldByName('DtCadastro').AsDateTime;
      if qryUsuario.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao := 1
      end
      else
      begin
        SnSituacao := 0
      end;
      IdUsuarioCadastro := qryUsuario.FieldByName('IdUsuarioCadastro').AsInteger;
      NmUsuarioCadastro := qryUsuario.FieldByName('NmUsuarioCadastro').AsString;
      NmUsuario := qryUsuario.FieldByName('NmUsuario').AsString;
      NmLogin := qryUsuario.FieldByName('NmLogin').AsString;
      NmSenha := qryUsuario.FieldByName('NmSenha').AsString;
      NrCpf := qryUsuario.FieldByName('NrCpf').AsString;
      if qryUsuario.FieldByName('SnAdministrador').AsBoolean then
      begin
        SnAdministrador := 1
      end
      else
      begin
        SnAdministrador := 0
      end;
      if qryUsuario.FieldByName('SnSuporte').AsBoolean then
      begin
        SnSuporte := 1
      end
      else
      begin
        SnSuporte := 0
      end;
    end;
    qryUsuario.Close;
  finally
    FreeAndNil(qryUsuario)
  end;
end;

end.
