object DtmEmail: TDtmEmail
  OldCreateOrder = False
  Height = 150
  Width = 215
  object InACBrMail: TACBrMail
    Host = '127.0.0.1'
    Port = '25'
    SetSSL = False
    SetTLS = False
    Attempts = 3
    DefaultCharset = UTF_8
    IDECharset = CP1252
    Left = 88
    Top = 48
  end
end
