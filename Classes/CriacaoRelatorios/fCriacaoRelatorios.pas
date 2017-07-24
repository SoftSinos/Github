
unit fCriacaoRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MSSQL, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, frxExportPDF, frxExportCSV, frxExportMail, frxExportXML, frxExportXLS, frxExportRTF, frxClass, frxExportText, frxDBSet,
  Datasnap.Provider, Datasnap.DBClient, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client, frxChart;

type
  TFrmCriacaoRelatorios = class(TForm)
    FDConnection: TFDConnection;
    QRYRelEmpresa: TFDQuery;
    CDSRelEmpresa: TClientDataSet;
    DSPRelEmpresa: TDataSetProvider;
    DBDRelEmpresa: TfrxDBDataset;
    QRYRelPesquisa: TFDQuery;
    CDSRelPesquisa: TClientDataSet;
    DSPRelPesquisa: TDataSetProvider;
    DBDRelPesquisa: TfrxDBDataset;
    frxReport: TfrxReport;
    frxTextExport: TfrxSimpleTextExport;
    frxRTFExport: TfrxRTFExport;
    frxXLSExport: TfrxXLSExport;
    frxXMLExport: TfrxXMLExport;
    frxMailExport: TfrxMailExport;
    frxCSVExport: TfrxCSVExport;
    frxPDFExport: TfrxPDFExport;
    QRYAux1: TFDQuery;
    CDSAux1: TClientDataSet;
    DSPAux1: TDataSetProvider;
    DBDAux1: TfrxDBDataset;
    DSPAux2: TDataSetProvider;
    QRYAux2: TFDQuery;
    CDSAux2: TClientDataSet;
    DBDAux2: TfrxDBDataset;
    QRYAux3: TFDQuery;
    DSPAux3: TDataSetProvider;
    CDSAux3: TClientDataSet;
    DBDAux3: TfrxDBDataset;
    frxChart: TfrxChartObject;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCriacaoRelatorios: TFrmCriacaoRelatorios;

implementation

{$R *.dfm}

end.
