object DtmPrincipal: TDtmPrincipal
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object Conexao: TFDConnection
    OnError = ConexaoError
    Left = 88
    Top = 48
  end
end
