unit dMail;

interface

uses
  System.SysUtils, System.Classes, ACBrBase, ACBrMail;

type
  TDtmEmail = class(TDataModule)
    InACBrMail: TACBrMail;
  private
    { Private declarations }
  public
    { Public declarations }
    Error : Boolean;
    procedure GerarEmail(EMailPara: String; NomePara: String; Assunto: String; Texto: String; Anexo: Boolean; RetornaErro: Boolean);
  end;

var
  DtmEmail: TDtmEmail;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses dArquivos, uMensagem;

{$R *.dfm}


procedure TDtmEmail.GerarEmail(EMailPara: String; NomePara: String; Assunto: String; Texto: String; Anexo: Boolean; RetornaErro: Boolean);
var
  NmCaminho : String;
  NmArquivo : String;
begin
  Error := False;
  try
    { Quando necessário utilizar.

    InACBrMail.AddCC('clauber.junio@brsistemas.inf.br'); // opcional
    InACBrMail.AddReplyTo('clauber.junio@gmail.com'); // opcional
    InACBrMail.AddBCC('brsistemas@brsistemas.inf.br'); // opcional
    InACBrMail.IsHTML := True; // define que a mensagem é html
     mensagem principal do e-mail. pode ser html ou texto puro
    InACBrMail.Body.Text :=
    '<html>'+#13+#10+
    '<head>'+#13+#10+#13+#10+
    '  <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">'+#13+#10+
    '</head>'+#13+#10+
    '<body text="#000000" bgcolor="#FFFFFF">'+#13+#10+
    '<h1>Texto em HTML.</h1><br>'+#13+#10+
    '</body>'+#13+#10+
    '</html>'+#13+#10;

    }

    InACBrMail.From       := 'log@softsinos.com.br';
    InACBrMail.FromName   := 'SginERP';
    InACBrMail.Host       := 'smtp.softsinos.com.br';
    InACBrMail.Username   := 'log@softsinos.com.br';
    InACBrMail.Password   := '23wesdxc';
    InACBrMail.Port       := '587';
    InACBrMail.AddAddress(EMailPara, NomePara);
    InACBrMail.Subject    := Assunto;
    InACBrMail.IsHTML     := False;

    if Anexo then
    begin
      DtmArquivos.CdsArquivos.First;
      while not DtmArquivos.CdsArquivos.Eof do
      begin
        DtmArquivos.CdsArquivos.RecordCount;
        NmCaminho := DtmArquivos.CdsArquivos.FieldByName('NmCaminho').AsString;
        NmArquivo  := DtmArquivos.CdsArquivos.FieldByName('NmArquivo').AsString;

        InACBrMail.AddAttachment(NmCaminho + NmArquivo, NmArquivo);

        DtmArquivos.CdsArquivos.Next;
      end;
    end;

    InACBrMail.AltBody.Text := Texto;

    try
      InACBrMail.Send;
    except
      if RetornaErro then
      begin
        Error := True;
      end;
    end;
  finally

  end;
end;

end.
