unit dRelatorios;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL,FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, frxExportText, frxExportRTF, frxExportXLS, frxExportXML,
  frxExportMail, frxExportCSV, frxClass, frxExportPDF, frxDBSet, Datasnap.Provider, Datasnap.DBClient, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, stdctrls, frxChart;

type
  TDtmRelatorios = class(TDataModule)
    CDSRelEmpresa : TClientDataSet;
    DBDRelEmpresa : TfrxDBDataset;
    CDSRelPesquisa: TClientDataSet;
    DBDRelPesquisa: TfrxDBDataset;
    frxReport     : TfrxReport;
    frxPDFExport  : TfrxPDFExport;
    frxXLSExport  : TfrxXLSExport;
    frxRTFExport  : TfrxRTFExport;
    CDSAux1       : TClientDataSet;
    DBDAux1       : TfrxDBDataset;
    CDSAux2       : TClientDataSet;
    DBDAux2       : TfrxDBDataset;
    CDSAux3       : TClientDataSet;
    DBDAux3       : TfrxDBDataset;
    frxChart      : TfrxChartObject;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DtmRelatorios: TDtmRelatorios;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses dPrincipal, uEmpresa;

{$R *.dfm}

end.
