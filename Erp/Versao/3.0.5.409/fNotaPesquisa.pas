unit fNotaPesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fPesquisa, Data.DB, Datasnap.DBClient, Vcl.ComCtrls, Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, dxSkinsCore, dxSkinsDefaultPainters, cxTextEdit, Vcl.Menus, cxButtons;

type
  TFrmNotaPesquisa = class(TFrmPesquisa)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNotaPesquisa: TFrmNotaPesquisa;

implementation

{$R *.dfm}

end.
