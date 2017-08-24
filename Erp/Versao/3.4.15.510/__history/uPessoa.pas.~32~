unit uPessoa;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes, Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
     FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
     Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI;

type
  TPessoa = class
  private
    FIdPessoa: Integer;
    FIdEmpresa: Integer;
    FIdUsuario: Integer;
    FDtCadastro: TDateTime;
    FSnSituacao: Integer;
    FNmPessoa: String;
    FIdTpPessoa: Integer;
    FNmObs: WideString;
    FNrCpfCnpj: String;
    FNrRgIe: String;
    FNmApelido: String;
    FNmEmail: String;
    FNmComplemento: String;
    FNrNumero: String;
    FNrFixo: String;
    FNrCelular: String;
    FNrCelular2: String;
    FNrWhatsApp: String;
    FNmFacebook: String;
    FNmInstagran: String;
    FNrCep: String;
    FTpCadastro: String;
    FNmOperCelular: String;
    FNmOperCelular2: String;
    FNmOperWhatsApp: String;
    FDtNascimento: TDateTime;
    FNmRazaoSocialNmFantasia: String;
    FNmTpPessoa: String;
    FNmTpLogradouro: String;
    FNmLogradouro: String;
    FNmEndereco: String;
    FNmBairro: String;
    FIdCidade: Integer;
    FNmCidade: String;
    FNrIbgeCidade: String;
    FIdUf: Integer;
    FNmUf: String;
    FNmSiglaUf: String;
    FNrIbgeUf: String;
    FIdRegiao: Integer;
    FNmRegiao: String;
    FIdPais: Integer;
    FNmPais: String;
    FNmSiglaPais: String;
    FNrIbgePais: String;
    FDtUltimoMovto: TDateTime;
    FQtdAgdRealizada: Integer;
    FNmUsuarioCadastro: String;
  public
    property IdPessoa: Integer read FIdPessoa write FIdPessoa;
    property IdEmpresa: Integer read FIdEmpresa write FIdEmpresa;
    property IdUsuario: Integer read FIdUsuario write FIdUsuario;
    property DtCadastro: TDateTime read FDtCadastro write FDtCadastro;
    property SnSituacao: Integer read FSnSituacao write FSnSituacao;
    property NmPessoa: String read FNmPessoa write FNmPessoa;
    property IdTpPessoa: Integer read FIdTpPessoa write FIdTpPessoa;
    property NmObs: WideString read FNmObs write FNmObs;
    property NrCpfCnpj: String read FNrCpfCnpj write FNrCpfCnpj;
    property NrRgIe: String read FNrRgIe write FNrRgIe;
    property NmApelido: String read FNmApelido write FNmApelido;
    property NmEmail: String read FNmEmail write FNmEmail;
    property NmComplemento: String read FNmComplemento write FNmComplemento;
    property NrNumero: String read FNrNumero write FNrNumero;
    property NrFixo: String read FNrFixo write FNrFixo;
    property NrCelular: String read FNrCelular write FNrCelular;
    property NrCelular2: String read FNrCelular2 write FNrCelular2;
    property NrWhatsApp: String read FNrWhatsApp write FNrWhatsApp;
    property NmFacebook: String read FNmFacebook write FNmFacebook;
    property NmInstagran: String read FNmInstagran write FNmInstagran;
    property NrCep: String read FNrCep write FNrCep;
    property TpCadastro: String read FTpCadastro write FTpCadastro;
    property NmOperCelular: String read FNmOperCelular write FNmOperCelular;
    property NmOperCelular2: String read FNmOperCelular2 write FNmOperCelular2;
    property NmOperWhatsApp: String read FNmOperWhatsApp write FNmOperWhatsApp;
    property DtNascimento: TDateTime read FDtNascimento write FDtNascimento;
    property NmRazaoSocialNmFantasia: String read FNmRazaoSocialNmFantasia write FNmRazaoSocialNmFantasia;
    property NmTpPessoa: String read FNmTpPessoa write FNmTpPessoa;
    property NmTpLogradouro: String read FNmTpLogradouro write FNmTpLogradouro;
    property NmLogradouro: String read FNmLogradouro write FNmLogradouro;
    property NmEndereco: String read FNmEndereco write FNmEndereco;
    property NmBairro: String read FNmBairro write FNmBairro;
    property IdCidade: Integer read FIdCidade write FIdCidade;
    property NmCidade: String read FNmCidade write FNmCidade;
    property NrIbgeCidade: String read FNrIbgeCidade write FNrIbgeCidade;
    property IdUf: Integer read FIdUf write FIdUf;
    property NmUf: String read FNmUf write FNmUf;
    property NmSiglaUf: String read FNmSiglaUf write FNmSiglaUf;
    property NrIbgeUf: String read FNrIbgeUf write FNrIbgeUf;
    property IdRegiao: Integer read FIdRegiao write FIdRegiao;
    property NmRegiao: String read FNmRegiao write FNmRegiao;
    property IdPais: Integer read FIdPais write FIdPais;
    property NmPais: String read FNmPais write FNmPais;
    property NmSiglaPais: String read FNmSiglaPais write FNmSiglaPais;
    property NrIbgePais: String read FNrIbgePais write FNrIbgePais;
    property DtUltimoMovto: TDateTime read FDtUltimoMovto write FDtUltimoMovto;
    property QtdAgdRealizada: Integer read FQtdAgdRealizada write FQtdAgdRealizada;
    property NmUsuarioCadastro: String read FNmUsuarioCadastro write FNmUsuarioCadastro;
    constructor Create;
    function Salvar(ASQLConnection: TFDConnection): Boolean;
    class function Inativar(ASQLConnection: TFDConnection; AIdPessoa: Integer): Boolean;
    class function Existe(ASQLConnection: TFDConnection; AIdPessoa: Integer): Boolean;
    function Buscar(ASQLConnection: TFDConnection;  AIdEmpresa: Integer; AIdPessoa: Integer): Boolean;
    function BuscarNrCelular(ASQLConnection: TFDConnection;  ANrCelular: String): Boolean;
    class function BuscaMaxId(ASQLConnection: TFDConnection): Integer;
    function BuscarImagem(ASQLConnection: TFDConnection; AIdPessoa: Integer; Data: TClientDataSet): Boolean;
    procedure CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdPessoa: Integer; AConsulta: String; IIdTpPessoa: Integer; Data: TClientDataSet);
    procedure Inicializar;
  end;

implementation

uses uFuncao, dPrincipal, uMensagem, uLog, uProcedure, dRelatorios, fProcessando;

procedure TPessoa.CarregaDbGrid(ASQLConnection: TFDConnection; ISnSituacao: Integer; AIdPessoa: Integer; AConsulta: String; IIdTpPessoa: Integer; Data: TClientDataSet);
var
  qryPessoa : TFDQuery;
  I            : Integer;
  lCampo       : TField;
  lCondicao    : String;
  lVerificacao : Integer;
  lFinalizaLoop: Integer;
begin
  lVerificacao := 0;
  lFinalizaLoop:= 0;

  qryPessoa := TFDQuery.Create(nil);
  try
    qryPessoa.Connection := ASQLConnection;

    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('IdPessoa', ftInteger);
      Data.FieldDefs.Add('IdEmpresa', ftInteger);
      Data.FieldDefs.Add('IdUsuario', ftInteger);
      Data.FieldDefs.Add('DtCadastro', ftDateTime);
      Data.FieldDefs.Add('SnSituacao', ftString, 9, False);
      Data.FieldDefs.Add('NmPessoa', ftString, 255, False);
      Data.FieldDefs.Add('IdTpPessoa', ftInteger);
      Data.FieldDefs.Add('NmObs', ftWideString, 4000, False);
      Data.FieldDefs.Add('NrCpfCnpj', ftString, 20, False);
      Data.FieldDefs.Add('NrRgIe', ftString, 20, False);
      Data.FieldDefs.Add('NmApelido', ftString, 255, False);
      Data.FieldDefs.Add('NmEmail', ftString, 255, False);
      Data.FieldDefs.Add('NmComplemento', ftString, 255, False);
      Data.FieldDefs.Add('NrNumero', ftString, 10, False);
      Data.FieldDefs.Add('NrFixo', ftString, 20, False);
      Data.FieldDefs.Add('NrCelular', ftString, 20, False);
      Data.FieldDefs.Add('NrCelular2', ftString, 20, False);
      Data.FieldDefs.Add('NrWhatsApp', ftString, 20, False);
      Data.FieldDefs.Add('NmFacebook', ftString, 255, False);
      Data.FieldDefs.Add('NmInstagran', ftString, 255, False);
      Data.FieldDefs.Add('NrCep', ftString, 10, False);
      Data.FieldDefs.Add('TpCadastro', ftString, 1, False);
      Data.FieldDefs.Add('NmOperCelular', ftString, 20, False);
      Data.FieldDefs.Add('NmOperCelular2', ftString, 20, False);
      Data.FieldDefs.Add('NmOperWhatsApp', ftString, 20, False);
      Data.FieldDefs.Add('DtNascimento', ftDateTime);
      Data.FieldDefs.Add('NmRazaoSocialNmFantasia', ftString, 255, False);
      Data.FieldDefs.Add('NmTpPessoa', ftString, 255, False);
      Data.FieldDefs.Add('NmTpLogradouro', ftString, 255, False);
      Data.FieldDefs.Add('NmLogradouro', ftString, 255, False);
      Data.FieldDefs.Add('NmEndereco', ftString, 255, False);
      Data.FieldDefs.Add('NmBairro', ftString, 255, False);
      Data.FieldDefs.Add('IdCidade', ftInteger);
      Data.FieldDefs.Add('NmCidade', ftString, 255, False);
      Data.FieldDefs.Add('NrIbgeCidade', ftString, 10, False);
      Data.FieldDefs.Add('IdUf', ftInteger);
      Data.FieldDefs.Add('NmUf', ftString, 255, False);
      Data.FieldDefs.Add('NmSiglaUf', ftString, 2, False);
      Data.FieldDefs.Add('NrIbgeUf', ftString, 10, False);
      Data.FieldDefs.Add('IdRegiao', ftInteger);
      Data.FieldDefs.Add('NmRegiao', ftString, 255, False);
      Data.FieldDefs.Add('IdPais', ftInteger);
      Data.FieldDefs.Add('NmPais', ftString, 255, False);
      Data.FieldDefs.Add('NmSiglaPais', ftString, 2, False);
      Data.FieldDefs.Add('NrIbgePais', ftString, 10, False);
      Data.FieldDefs.Add('DtUltimoMovto', ftDateTime);
      Data.FieldDefs.Add('QtdAgdRealizada', ftInteger);
      Data.FieldDefs.Add('NmUsuarioCadastro', ftString, 255, False);
      Data.FieldDefs.Add('ImPessoa', ftBlob);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    for I := 0 to Data.FieldCount -1 do
    begin
      lCampo := Data.Fields[I];

      qryPessoa.Params.Clear;
      qryPessoa.SQL.Clear;
      qryPessoa.SQL.Add('Select');
      qryPessoa.SQL.Add('  *');
      qryPessoa.SQL.Add('From VW_GridPessoa');
      qryPessoa.SQL.Add('Where 1 = 1');

      if ISnSituacao = 1 then
      begin
         qryPessoa.SQL.Add('  And SnSituacao = 1');
      end
      else
      if ISnSituacao = 0 then
      begin
         qryPessoa.SQL.Add('  And SnSituacao = 0');
      end;

      if AIdPessoa > 0 then
      begin
        qryPessoa.SQL.Add('  And IdPessoa = :IdPessoa');

        qryPessoa.ParamByName('IdPessoa').AsInteger := AIdPessoa
      end;

      if IIdTpPessoa > 0 then
      begin
        qryPessoa.SQL.Add('  And IdTpPessoa = :IdTpPessoa');

        qryPessoa.ParamByName('IdTpPessoa').AsInteger := IIdTpPessoa
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
          qryPessoa.SQL.Add (lCondicao);
          qryPessoa.SQL.Add ('Order By');
          qryPessoa.SQL.Add ('  IdPessoa');

          qryPessoa.Open;
          qryPessoa.First;
        end;
      end else begin
        qryPessoa.SQL.Add (lCondicao);
        qryPessoa.SQL.Add ('Order By');
        qryPessoa.SQL.Add ('  IdPessoa');

        lFinalizaLoop := 1;
        qryPessoa.Open;
        qryPessoa.First;
      end;

      while not qryPessoa.Eof do
      begin
        if Trim(AConsulta) <> '' then
        begin
          if not Data.IsEmpty then
          begin
            Data.First;
            while not Data.Eof do
            begin
              if Data.FieldByName('IdPessoa').AsInteger = qryPessoa.FieldByName('IdPessoa').AsInteger then
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
          Data.FieldByName('IdPessoa').AsInteger := qryPessoa.FieldByName('IdPessoa').AsInteger;
          Data.FieldByName('IdEmpresa').AsInteger := qryPessoa.FieldByName('IdEmpresa').AsInteger;
          Data.FieldByName('IdUsuario').AsInteger := qryPessoa.FieldByName('IdUsuario').AsInteger;
          Data.FieldByName('DtCadastro').AsDateTime := qryPessoa.FieldByName('DtCadastro').AsDateTime;
          if qryPessoa.FieldByName('SnSituacao').AsBoolean then
          begin
            Data.FieldByName('SnSituacao').AsString  := 'Ativo';
          end else begin
            Data.FieldByName('SnSituacao').AsString  := 'Inativo';
          end;
          Data.FieldByName('NmPessoa').AsString := qryPessoa.FieldByName('NmPessoa').AsString;
          Data.FieldByName('IdTpPessoa').AsInteger := qryPessoa.FieldByName('IdTpPessoa').AsInteger;
          Data.FieldByName('NmObs').AsWideString := qryPessoa.FieldByName('NmObs').AsWideString;
          Data.FieldByName('NrCpfCnpj').AsString := qryPessoa.FieldByName('NrCpfCnpj').AsString;
          Data.FieldByName('NrRgIe').AsString := qryPessoa.FieldByName('NrRgIe').AsString;
          Data.FieldByName('NmApelido').AsString := qryPessoa.FieldByName('NmApelido').AsString;
          Data.FieldByName('NmEmail').AsString := qryPessoa.FieldByName('NmEmail').AsString;
          Data.FieldByName('NmComplemento').AsString := qryPessoa.FieldByName('NmComplemento').AsString;
          Data.FieldByName('NrNumero').AsString := qryPessoa.FieldByName('NrNumero').AsString;
          Data.FieldByName('NrFixo').AsString := qryPessoa.FieldByName('NrFixo').AsString;
          Data.FieldByName('NrCelular').AsString := FormatMaskText('\(99\)99999\-9999;0;_', qryPessoa.FieldByName('NrCelular').AsString);
          Data.FieldByName('NrCelular2').AsString := qryPessoa.FieldByName('NrCelular2').AsString;
          Data.FieldByName('NrWhatsApp').AsString := qryPessoa.FieldByName('NrWhatsApp').AsString;
          Data.FieldByName('NmFacebook').AsString := qryPessoa.FieldByName('NmFacebook').AsString;
          Data.FieldByName('NmInstagran').AsString := qryPessoa.FieldByName('NmInstagran').AsString;
          Data.FieldByName('NrCep').AsString := qryPessoa.FieldByName('NrCep').AsString;
          Data.FieldByName('TpCadastro').AsString := qryPessoa.FieldByName('TpCadastro').AsString;
          Data.FieldByName('NmOperCelular').AsString := qryPessoa.FieldByName('NmOperCelular').AsString;
          Data.FieldByName('NmOperCelular2').AsString := qryPessoa.FieldByName('NmOperCelular2').AsString;
          Data.FieldByName('NmOperWhatsApp').AsString := qryPessoa.FieldByName('NmOperWhatsApp').AsString;
          Data.FieldByName('DtNascimento').AsDateTime := qryPessoa.FieldByName('DtNascimento').AsDateTime;
          Data.FieldByName('NmRazaoSocialNmFantasia').AsString := qryPessoa.FieldByName('NmRazaoSocialNmFantasia').AsString;
          Data.FieldByName('NmTpPessoa').AsString := qryPessoa.FieldByName('NmTpPessoa').AsString;
          Data.FieldByName('NmTpLogradouro').AsString := qryPessoa.FieldByName('NmTpLogradouro').AsString;
          Data.FieldByName('NmLogradouro').AsString := qryPessoa.FieldByName('NmLogradouro').AsString;
          Data.FieldByName('NmEndereco').AsString := qryPessoa.FieldByName('NmEndereco').AsString;
          Data.FieldByName('NmBairro').AsString := qryPessoa.FieldByName('NmBairro').AsString;
          Data.FieldByName('IdCidade').AsInteger := qryPessoa.FieldByName('IdCidade').AsInteger;
          Data.FieldByName('NmCidade').AsString := qryPessoa.FieldByName('NmCidade').AsString;
          Data.FieldByName('NrIbgeCidade').AsString := qryPessoa.FieldByName('NrIbgeCidade').AsString;
          Data.FieldByName('IdUf').AsInteger := qryPessoa.FieldByName('IdUf').AsInteger;
          Data.FieldByName('NmUf').AsString := qryPessoa.FieldByName('NmUf').AsString;
          Data.FieldByName('NmSiglaUf').AsString := qryPessoa.FieldByName('NmSiglaUf').AsString;
          Data.FieldByName('NrIbgeUf').AsString := qryPessoa.FieldByName('NrIbgeUf').AsString;
          Data.FieldByName('IdRegiao').AsInteger := qryPessoa.FieldByName('IdRegiao').AsInteger;
          Data.FieldByName('NmRegiao').AsString := qryPessoa.FieldByName('NmRegiao').AsString;
          Data.FieldByName('IdPais').AsInteger := qryPessoa.FieldByName('IdPais').AsInteger;
          Data.FieldByName('NmPais').AsString := qryPessoa.FieldByName('NmPais').AsString;
          Data.FieldByName('NmSiglaPais').AsString := qryPessoa.FieldByName('NmSiglaPais').AsString;
          Data.FieldByName('NrIbgePais').AsString := qryPessoa.FieldByName('NrIbgePais').AsString;
          if qryPessoa.FieldByName('DtUltimoMovto').AsDateTime > 1 then
          begin
            Data.FieldByName('DtUltimoMovto').AsDateTime := qryPessoa.FieldByName('DtUltimoMovto').AsDateTime;
          end;
          Data.FieldByName('QtdAgdRealizada').AsInteger := qryPessoa.FieldByName('QtdAgdRealizada').AsInteger;
          Data.FieldByName('NmUsuarioCadastro').AsString := qryPessoa.FieldByName('NmUsuarioCadastro').AsString;
          Data.Post;
        end;

        lVerificacao := 0;
        qryPessoa.Next;
      end;
      if lFinalizaLoop = 1 then
      begin
        Break;
      end;
    end;
  finally
    qryPessoa.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

constructor TPessoa.Create;
begin
  Inicializar;
end;

procedure TPessoa.Inicializar;
begin
  IdPessoa := 0;
  IdEmpresa := 0;
  IdUsuario := 0;
  DtCadastro := 0;
  SnSituacao := 0;
  NmPessoa := '';
  IdTpPessoa := 0;
  NmObs := '';
  NrCpfCnpj := '';
  NrRgIe := '';
  NmApelido := '';
  NmEmail := '';
  NmComplemento := '';
  NrNumero := '';
  NrFixo := '';
  NrCelular := '';
  NrCelular2 := '';
  NrWhatsApp              := '';
  NmFacebook              := '';
  NmInstagran             := '';
  NrCep                   := '';
  TpCadastro              := '';
  NmOperCelular           := '';
  NmOperCelular2          := '';
  NmOperWhatsApp          := '';
  DtNascimento            := 0;
  NmRazaoSocialNmFantasia := '';
  NmTpPessoa              := '';
  NmTpLogradouro          := '';
  NmLogradouro            := '';
  NmEndereco              := '';
  NmBairro                := '';
  IdCidade := 0;
  NmCidade := '';
  NrIbgeCidade := '';
  IdUf := 0;
  NmUf := '';
  NmSiglaUf := '';
  NrIbgeUf := '';
  IdRegiao := 0;
  NmRegiao := '';
  IdPais := 0;
  NmPais := '';
  NmSiglaPais := '';
  NrIbgePais := '';
  DtUltimoMovto     := 0;
  QtdAgdRealizada   := 0;
  NmUsuarioCadastro := '';
end;

function TPessoa.Salvar(ASQLConnection: TFDConnection): Boolean;
var
 qryPessoa: TFDQuery;
begin
  qryPessoa:= TFDQuery.Create(Nil);
  try
    qryPessoa.Connection := ASQLConnection;
    if not Existe(ASQLConnection, IdPessoa) then
    begin
      qryPessoa.SQL.Add('Insert Into Pessoa(  ');
      qryPessoa.SQL.Add('  IdEmpresa,         ');
      qryPessoa.SQL.Add('  IdUsuario,         ');
      qryPessoa.SQL.Add('  DtCadastro,        ');
      qryPessoa.SQL.Add('  SnSituacao,        ');
      qryPessoa.SQL.Add('  NmPessoa,          ');
      qryPessoa.SQL.Add('  IdTpPessoa,        ');
      qryPessoa.SQL.Add('  NmObs,             ');
      qryPessoa.SQL.Add('  NrCpfCnpj,         ');
      qryPessoa.SQL.Add('  NrRgIe,            ');
      qryPessoa.SQL.Add('  NmApelido,         ');
      qryPessoa.SQL.Add('  NmEmail,           ');
      qryPessoa.SQL.Add('  NmComplemento,     ');
      qryPessoa.SQL.Add('  NrNumero,          ');
      qryPessoa.SQL.Add('  NrFixo,            ');
      qryPessoa.SQL.Add('  NrCelular,         ');
      qryPessoa.SQL.Add('  NrCelular2,        ');
      qryPessoa.SQL.Add('  NrWhatsApp,        ');
      qryPessoa.SQL.Add('  NmFacebook,        ');
      qryPessoa.SQL.Add('  NmInstagran,       ');
      qryPessoa.SQL.Add('  NrCep,             ');
      qryPessoa.SQL.Add('  TpCadastro,        ');
      qryPessoa.SQL.Add('  NmOperCelular,     ');
      qryPessoa.SQL.Add('  NmOperCelular2,    ');
      qryPessoa.SQL.Add('  NmOperWhatsApp,    ');
      qryPessoa.SQL.Add('  DtNascimento)      ');
      qryPessoa.SQL.Add('Values (             ');
      qryPessoa.SQL.Add('  :IdEmpresa,        ');
      qryPessoa.SQL.Add('  :IdUsuario,        ');
      qryPessoa.SQL.Add('  :DtCadastro,       ');
      qryPessoa.SQL.Add('  :SnSituacao,       ');
      qryPessoa.SQL.Add('  :NmPessoa,         ');
      qryPessoa.SQL.Add('  :IdTpPessoa,       ');
      qryPessoa.SQL.Add('  :NmObs,            ');
      qryPessoa.SQL.Add('  :NrCpfCnpj,        ');
      qryPessoa.SQL.Add('  :NrRgIe,           ');
      qryPessoa.SQL.Add('  :NmApelido,        ');
      qryPessoa.SQL.Add('  :NmEmail,          ');
      qryPessoa.SQL.Add('  :NmComplemento,    ');
      qryPessoa.SQL.Add('  :NrNumero,         ');
      qryPessoa.SQL.Add('  :NrFixo,           ');
      qryPessoa.SQL.Add('  :NrCelular,        ');
      qryPessoa.SQL.Add('  :NrCelular2,       ');
      qryPessoa.SQL.Add('  :NrWhatsApp,       ');
      qryPessoa.SQL.Add('  :NmFacebook,       ');
      qryPessoa.SQL.Add('  :NmInstagran,      ');
      qryPessoa.SQL.Add('  :NrCep,            ');
      qryPessoa.SQL.Add('  :TpCadastro,       ');
      qryPessoa.SQL.Add('  :NmOperCelular,    ');
      qryPessoa.SQL.Add('  :NmOperCelular2,   ');
      qryPessoa.SQL.Add('  :NmOperWhatsApp,   ');
      qryPessoa.SQL.Add('  :DtNascimento)     ');

      qryPessoa.ParamByName('IdEmpresa')  .AsInteger    := IdEmpresa;
      qryPessoa.ParamByName('IdUsuario')  .AsInteger    := IdUsuario;
      qryPessoa.ParamByName('DtCadastro') .AsDateTime  := DtCadastro;
      qryPessoa.ParamByName('NrCelular')  .AsString     := NrCelular;

    end else begin
      qryPessoa.SQL.Add('Update Pessoa Set                  ');
      qryPessoa.SQL.Add('  SnSituacao     = :SnSituacao,    ');
      qryPessoa.SQL.Add('  NmPessoa       = :NmPessoa,      ');
      qryPessoa.SQL.Add('  IdTpPessoa     = :IdTpPessoa,    ');
      qryPessoa.SQL.Add('  NmObs          = :NmObs,         ');
      qryPessoa.SQL.Add('  NrCpfCnpj      = :NrCpfCnpj,     ');
      qryPessoa.SQL.Add('  NrRgIe         = :NrRgIe,        ');
      qryPessoa.SQL.Add('  NmApelido      = :NmApelido,     ');
      qryPessoa.SQL.Add('  NmEmail        = :NmEmail,       ');
      qryPessoa.SQL.Add('  NmComplemento  = :NmComplemento, ');
      qryPessoa.SQL.Add('  NrNumero       = :NrNumero,      ');
      qryPessoa.SQL.Add('  NrFixo         = :NrFixo,        ');
      qryPessoa.SQL.Add('  NrCelular2     = :NrCelular2,    ');
      qryPessoa.SQL.Add('  NrWhatsApp     = :NrWhatsApp,    ');
      qryPessoa.SQL.Add('  NmFacebook     = :NmFacebook,    ');
      qryPessoa.SQL.Add('  NmInstagran    = :NmInstagran,   ');
      qryPessoa.SQL.Add('  NrCep          = :NrCep,         ');
      qryPessoa.SQL.Add('  TpCadastro     = :TpCadastro,    ');
      qryPessoa.SQL.Add('  NmOperCelular  = :NmOperCelular, ');
      qryPessoa.SQL.Add('  NmOperCelular2 = :NmOperCelular2,');
      qryPessoa.SQL.Add('  NmOperWhatsApp = :NmOperWhatsApp,');
      qryPessoa.SQL.Add('  DtNascimento   = :DtNascimento   ');
      qryPessoa.SQL.Add('Where IdPessoa   = :IdPessoa       ');

      qryPessoa.ParamByName('IdPessoa').AsInteger := IdPessoa;

    end;
    qryPessoa.ParamByName('SnSituacao')     .AsInteger    := SnSituacao;
    qryPessoa.ParamByName('NmPessoa')       .AsString     := NmPessoa;
    qryPessoa.ParamByName('IdTpPessoa')     .AsInteger    := IdTpPessoa;
    qryPessoa.ParamByName('NmObs')          .AsWideString := NmObs;
    qryPessoa.ParamByName('NrCpfCnpj')      .AsString     := NrCpfCnpj;
    qryPessoa.ParamByName('NrRgIe')         .AsString     := NrRgIe;
    qryPessoa.ParamByName('NmApelido')      .AsString     := NmApelido;
    qryPessoa.ParamByName('NmEmail')        .AsString     := NmEmail;
    qryPessoa.ParamByName('NmComplemento')  .AsString     := NmComplemento;
    qryPessoa.ParamByName('NrNumero')       .AsString     := NrNumero;
    qryPessoa.ParamByName('NrFixo')         .AsString     := NrFixo;
    qryPessoa.ParamByName('NrCelular2')     .AsString     := NrCelular2;
    qryPessoa.ParamByName('NrWhatsApp')     .AsString     := NrWhatsApp;
    qryPessoa.ParamByName('NmFacebook')     .AsString     := NmFacebook;
    qryPessoa.ParamByName('NmInstagran')    .AsString     := NmInstagran;
    qryPessoa.ParamByName('NrCep')          .AsString     := NrCep;
    qryPessoa.ParamByName('TpCadastro')     .AsString     := TpCadastro;
    qryPessoa.ParamByName('NmOperCelular')  .AsString     := NmOperCelular;
    qryPessoa.ParamByName('NmOperCelular2') .AsString     := NmOperCelular2;
    qryPessoa.ParamByName('NmOperWhatsApp') .AsString     := NmOperWhatsApp;
    qryPessoa.ParamByName('DtNascimento')   .AsDateTime   := DtNascimento;
   try
      qryPessoa.ExecSQL;
      qryPessoa.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryPessoa)
  end;
end;

class function TPessoa.Inativar(ASQLConnection: TFDConnection; AIdPessoa: Integer): Boolean;
var
  qryPessoa: TFDQuery;
begin
  qryPessoa:= TFDQuery.Create(Nil);
  try
    qryPessoa.Connection := ASQLConnection;
    qryPessoa.SQL.Add('Update Pessoa Set ');
    qryPessoa.SQL.Add('  SnSituacao = 0 ');
    qryPessoa.SQL.Add('Where 1 = 1');
    qryPessoa.SQL.Add('  And IdPessoa = ' + IntToStr(AIdPessoa));
   try
      qryPessoa.ExecSQL;
      qryPessoa.Close;
      Result := True;
    except
      Result := False;
    end;
  finally
    FreeAndNil(qryPessoa)
  end;
end;

class function TPessoa.Existe(ASQLConnection: TFDConnection; AIdPessoa: Integer): Boolean;
var
  qryPessoa: TFDQuery;
begin
  Result := False;
  qryPessoa:= TFDQuery.Create(Nil);
  try
    qryPessoa.Connection := ASQLConnection;
    qryPessoa.SQL.Add('Select IdPessoa From Pessoa');
    qryPessoa.SQL.Add('Where 1 = 1');
    qryPessoa.SQL.Add('  And IdPessoa = ' + IntToStr(AIdPessoa));
    qryPessoa.Open;
    if qryPessoa.Fields[0].Value > 0 then
      Result := True;
    qryPessoa.Close;
  finally
    FreeAndNil(qryPessoa)
  end;
end;

class function TPessoa.BuscaMaxId(ASQLConnection: TFDConnection): Integer;
var
  qryPessoa: TFDQuery;
begin
  Result := 0;
  qryPessoa:= TFDQuery.Create(Nil);
  try
    qryPessoa.Connection := ASQLConnection;
    qryPessoa.SQL.Add('Select Max(IdPessoa) As IdPessoa From Pessoa');
    qryPessoa.Open;

    if qryPessoa.FieldByName('IdPessoa').AsInteger > 0 then
      Result := qryPessoa.FieldByName('IdPessoa').AsInteger;
    qryPessoa.Close;
  finally
    FreeAndNil(qryPessoa)
  end;
end;

function TPessoa.Buscar(ASQLConnection: TFDConnection; AIdEmpresa: Integer; AIdPessoa: Integer): Boolean;
var
  qryPessoa: TFDQuery;
begin
  Result := False;
  qryPessoa:= TFDQuery.Create(Nil);
  try
    qryPessoa.Connection := ASQLConnection;
    qryPessoa.SQL.Add('Select * From VW_GridPessoa');
    qryPessoa.SQL.Add('Where IdPessoa = :IdPessoa');

    qryPessoa.ParamByName('IdPessoa').AsString := IntToStr(AIdPessoa);

    if AIdEmpresa > 0 then
    begin
      qryPessoa.SQL.Add('  And IdEmpresa = ' + IntToStr(AIdEmpresa));
    end;

    qryPessoa.Open;
    if not qryPessoa.IsEmpty then
    begin
      Result                  := True;
      IdPessoa                := qryPessoa.FieldByName('IdPessoa').AsInteger;
      IdEmpresa               := qryPessoa.FieldByName('IdEmpresa').AsInteger;
      IdUsuario               := qryPessoa.FieldByName('IdUsuario').AsInteger;
      DtCadastro              := qryPessoa.FieldByName('DtCadastro').AsDateTime;
      if qryPessoa.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao            := 1
      end else begin
        SnSituacao            := 0
      end;
      NmPessoa                := qryPessoa.FieldByName('NmPessoa').AsString;
      IdTpPessoa              := qryPessoa.FieldByName('IdTpPessoa').AsInteger;
      NmObs                   := qryPessoa.FieldByName('NmObs').AsWideString;
      NrCpfCnpj               := qryPessoa.FieldByName('NrCpfCnpj').AsString;
      NrRgIe                  := qryPessoa.FieldByName('NrRgIe').AsString;
      NmApelido               := qryPessoa.FieldByName('NmApelido').AsString;
      NmEmail                 := qryPessoa.FieldByName('NmEmail').AsString;
      NmComplemento           := qryPessoa.FieldByName('NmComplemento').AsString;
      NrNumero                := qryPessoa.FieldByName('NrNumero').AsString;
      NrFixo                  := qryPessoa.FieldByName('NrFixo').AsString;
      NrCelular               := qryPessoa.FieldByName('NrCelular').AsString;
      NrCelular2              := qryPessoa.FieldByName('NrCelular2').AsString;
      NrWhatsApp              := qryPessoa.FieldByName('NrWhatsApp').AsString;
      NmFacebook              := qryPessoa.FieldByName('NmFacebook').AsString;
      NmInstagran             := qryPessoa.FieldByName('NmInstagran').AsString;
      NrCep                   := qryPessoa.FieldByName('NrCep').AsString;
      TpCadastro              := qryPessoa.FieldByName('TpCadastro').AsString;
      NmOperCelular           := qryPessoa.FieldByName('NmOperCelular').AsString;
      NmOperCelular2          := qryPessoa.FieldByName('NmOperCelular2').AsString;
      NmOperWhatsApp          := qryPessoa.FieldByName('NmOperWhatsApp').AsString;
      DtNascimento            := qryPessoa.FieldByName('DtNascimento').AsDateTime;
      NmRazaoSocialNmFantasia := qryPessoa.FieldByName('NmRazaoSocialNmFantasia').AsString;
      NmTpPessoa              := qryPessoa.FieldByName('NmTpPessoa').AsString;
      NmTpLogradouro          := qryPessoa.FieldByName('NmTpLogradouro').AsString;
      NmLogradouro            := qryPessoa.FieldByName('NmLogradouro').AsString;
      NmEndereco              := qryPessoa.FieldByName('NmEndereco').AsString;
      NmBairro                := qryPessoa.FieldByName('NmBairro').AsString;
      IdCidade                := qryPessoa.FieldByName('IdCidade').AsInteger;
      NmCidade                := qryPessoa.FieldByName('NmCidade').AsString;
      NrIbgeCidade            := qryPessoa.FieldByName('NrIbgeCidade').AsString;
      IdUf                    := qryPessoa.FieldByName('IdUf').AsInteger;
      NmUf                    := qryPessoa.FieldByName('NmUf').AsString;
      NmSiglaUf               := qryPessoa.FieldByName('NmSiglaUf').AsString;
      NrIbgeUf                := qryPessoa.FieldByName('NrIbgeUf').AsString;
      IdRegiao                := qryPessoa.FieldByName('IdRegiao').AsInteger;
      NmRegiao                := qryPessoa.FieldByName('NmRegiao').AsString;
      IdPais                  := qryPessoa.FieldByName('IdPais').AsInteger;
      NmPais                  := qryPessoa.FieldByName('NmPais').AsString;
      NmSiglaPais             := qryPessoa.FieldByName('NmSiglaPais').AsString;
      NrIbgePais              := qryPessoa.FieldByName('NrIbgePais').AsString;
      DtUltimoMovto           := qryPessoa.FieldByName('DtUltimoMovto').AsDateTime;
      QtdAgdRealizada         := qryPessoa.FieldByName('QtdAgdRealizada').AsInteger;
      NmUsuarioCadastro       := qryPessoa.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryPessoa.Close;
  finally
    FreeAndNil(qryPessoa)
  end;
end;

function TPessoa.BuscarImagem(ASQLConnection: TFDConnection; AIdPessoa: Integer; Data: TClientDataSet): Boolean;
var
  qryPessoa : TFDQuery;
  I         : Integer;
begin
  Result                  := False;

  qryPessoa              := TFDQuery.Create(nil);
  try
    if Data.FieldCount = 0 then
    begin
      Data.FieldDefs.Add('ImPessoa', ftBlob);
      Data.FieldDefs.Add('IdRetorno', ftInteger);
      Data.CreateDataSet;
    end;

    Data.EmptyDataSet;
    Data.DisableControls;

    qryPessoa.Params.Clear;
    qryPessoa.SQL.Clear;

    qryPessoa.Connection := ASQLConnection;

    qryPessoa.SQL.Add('Select ImPessoa From Pessoa');
    qryPessoa.SQL.Add('Where IdPessoa = :IdPessoa  ');

    qryPessoa.ParamByName('IdPessoa').AsInteger := AIdPessoa;

    qryPessoa.Open;

    while not qryPessoa.Eof do
    begin
      Data.Append;
      Data.FieldByName('ImPessoa').AsBytes        := qryPessoa.FieldByName('ImPessoa').AsBytes;
      Data.Post;
      qryPessoa.Next;
      Result := True;
    end;
  finally
    qryPessoa.FreeOnRelease;
    Data.EnableControls;
    Data.First;
  end;
end;

function TPessoa.BuscarNrCelular(ASQLConnection: TFDConnection; ANrCelular: String): Boolean;
var
  qryPessoa: TFDQuery;
begin
  Result := False;
  qryPessoa:= TFDQuery.Create(Nil);
  try
    qryPessoa.Connection := ASQLConnection;
    qryPessoa.SQL.Add('Select * From VW_GridPessoa');
    qryPessoa.SQL.Add('Where NrCelular = :NrCelular');

    qryPessoa.ParamByName('NrCelular').AsString := ANrCelular;

    qryPessoa.Open;
    if not qryPessoa.IsEmpty then
    begin
      Result                  := True;
      IdPessoa                := qryPessoa.FieldByName('IdPessoa').AsInteger;
      IdEmpresa               := qryPessoa.FieldByName('IdEmpresa').AsInteger;
      IdUsuario               := qryPessoa.FieldByName('IdUsuario').AsInteger;
      DtCadastro              := qryPessoa.FieldByName('DtCadastro').AsDateTime;
      if qryPessoa.FieldByName('SnSituacao').AsBoolean then
      begin
        SnSituacao            := 1
      end else begin
        SnSituacao            := 0
      end;
      NmPessoa                := qryPessoa.FieldByName('NmPessoa').AsString;
      IdTpPessoa              := qryPessoa.FieldByName('IdTpPessoa').AsInteger;
      NmObs                   := qryPessoa.FieldByName('NmObs').AsWideString;
      NrCpfCnpj               := qryPessoa.FieldByName('NrCpfCnpj').AsString;
      NrRgIe                  := qryPessoa.FieldByName('NrRgIe').AsString;
      NmApelido               := qryPessoa.FieldByName('NmApelido').AsString;
      NmEmail                 := qryPessoa.FieldByName('NmEmail').AsString;
      NmComplemento           := qryPessoa.FieldByName('NmComplemento').AsString;
      NrNumero                := qryPessoa.FieldByName('NrNumero').AsString;
      NrFixo                  := qryPessoa.FieldByName('NrFixo').AsString;
      NrCelular               := qryPessoa.FieldByName('NrCelular').AsString;
      NrCelular2              := qryPessoa.FieldByName('NrCelular2').AsString;
      NrWhatsApp              := qryPessoa.FieldByName('NrWhatsApp').AsString;
      NmFacebook              := qryPessoa.FieldByName('NmFacebook').AsString;
      NmInstagran             := qryPessoa.FieldByName('NmInstagran').AsString;
      NrCep                   := qryPessoa.FieldByName('NrCep').AsString;
      TpCadastro              := qryPessoa.FieldByName('TpCadastro').AsString;
      NmOperCelular           := qryPessoa.FieldByName('NmOperCelular').AsString;
      NmOperCelular2          := qryPessoa.FieldByName('NmOperCelular2').AsString;
      NmOperWhatsApp          := qryPessoa.FieldByName('NmOperWhatsApp').AsString;
      DtNascimento            := qryPessoa.FieldByName('DtNascimento').AsDateTime;
      NmRazaoSocialNmFantasia := qryPessoa.FieldByName('NmRazaoSocialNmFantasia').AsString;
      NmTpPessoa              := qryPessoa.FieldByName('NmTpPessoa').AsString;
      NmTpLogradouro          := qryPessoa.FieldByName('NmTpLogradouro').AsString;
      NmLogradouro            := qryPessoa.FieldByName('NmLogradouro').AsString;
      NmEndereco              := qryPessoa.FieldByName('NmEndereco').AsString;
      NmBairro                := qryPessoa.FieldByName('NmBairro').AsString;
      IdCidade                := qryPessoa.FieldByName('IdCidade').AsInteger;
      NmCidade                := qryPessoa.FieldByName('NmCidade').AsString;
      NrIbgeCidade            := qryPessoa.FieldByName('NrIbgeCidade').AsString;
      IdUf                    := qryPessoa.FieldByName('IdUf').AsInteger;
      NmUf                    := qryPessoa.FieldByName('NmUf').AsString;
      NmSiglaUf               := qryPessoa.FieldByName('NmSiglaUf').AsString;
      NrIbgeUf                := qryPessoa.FieldByName('NrIbgeUf').AsString;
      IdRegiao                := qryPessoa.FieldByName('IdRegiao').AsInteger;
      NmRegiao                := qryPessoa.FieldByName('NmRegiao').AsString;
      IdPais                  := qryPessoa.FieldByName('IdPais').AsInteger;
      NmPais                  := qryPessoa.FieldByName('NmPais').AsString;
      NmSiglaPais             := qryPessoa.FieldByName('NmSiglaPais').AsString;
      NrIbgePais              := qryPessoa.FieldByName('NrIbgePais').AsString;
      DtUltimoMovto           := qryPessoa.FieldByName('DtUltimoMovto').AsDateTime;
      QtdAgdRealizada         := qryPessoa.FieldByName('QtdAgdRealizada').AsInteger;
      NmUsuarioCadastro       := qryPessoa.FieldByName('NmUsuarioCadastro').AsString;
    end;
    qryPessoa.Close;
  finally
    FreeAndNil(qryPessoa)
  end;
end;

end.

