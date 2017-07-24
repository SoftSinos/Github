unit uCriaPastas;

interface

uses Windows, TLHelp32, Forms, Controls, DateUtils, WinInet, MaskUtils, StdCtrls, Variants, DbTables, SysUtils, Classes,   Contnrs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Datasnap.DBClient, FireDAC.UI.Intf, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Vcl.ComCtrls, ShellApi;

procedure CriarPastas;

implementation

uses dPrincipal;

procedure CriarPastas;
begin

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Atualizacao') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Atualizacao')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Atualizacao\Executados') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Atualizacao\Executados')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Banco') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Banco')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Configuracao') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Configuracao')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Exportacao') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Exportacao')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Exportacao\' + FormatDateTime('YYYY',Date)) then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Exportacao\' + FormatDateTime('YYYY',Date))
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Exportacao\' + FormatDateTime('YYYY',Date) + '\' + FormatDateTime('MM',Date)) then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Exportacao\' + FormatDateTime('YYYY',Date) + '\' + FormatDateTime('MM',Date))
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Fechamento') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Fechamento')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Fechamento\' + FormatDateTime('YYYY',Date)) then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Fechamento\' + FormatDateTime('YYYY',Date))
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Fechamento\' + FormatDateTime('YYYY',Date) + '\' + FormatDateTime('MM',Date)) then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Fechamento\' + FormatDateTime('YYYY',Date) + '\' + FormatDateTime('MM',Date))
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Imagem') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Imagem')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Imagem\Pessoal') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Imagem\Pessoal')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Imagem\Sistema') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Imagem\Sistema')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Imagem\Produto') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Imagem\Produto')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Log') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Log')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Log\' + FormatDateTime('YYYY',Date)) then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Log\' + FormatDateTime('YYYY',Date))
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Log\' + FormatDateTime('YYYY',Date) + '\' + FormatDateTime('MM',Date)) then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Log\' + FormatDateTime('YYYY',Date) + '\' + FormatDateTime('MM',Date))
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Log\' + FormatDateTime('YYYY',Date) + '\' + FormatDateTime('MM',Date) + '\' + FormatDateTime('DD',Date)) then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Log\' + FormatDateTime('YYYY',Date) + '\' + FormatDateTime('MM',Date) + '\' + FormatDateTime('DD',Date))
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Relatorio') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Relatorio')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\Domingo') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\Domingo')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\Segunda-Feira') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\Segunda-Feira')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\Ter�a-Feira') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\Ter�a-Feira')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\Quarta-Feira') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\Quarta-Feira')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\Quinta-Feira') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\Quinta-Feira')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\Sexta-Feira') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\Sexta-Feira')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\S�bado') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Seguranca\S�bado')
  end;

  if not DirectoryExists(DtmPrincipal.NmCaminhoExecutavel + 'Instalacao') then
  begin
    CreateDir(DtmPrincipal.NmCaminhoExecutavel + 'Instalacao')
  end;
end;

end.
