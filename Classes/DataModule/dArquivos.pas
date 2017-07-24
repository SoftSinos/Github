unit dArquivos;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient;

type
  TDtmArquivos = class(TDataModule)
    CdsArquivos: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DtmArquivos: TDtmArquivos;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
