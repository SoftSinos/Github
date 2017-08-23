inherited FrmMarca: TFrmMarca
  Caption = 'Cadastrar Marca'
  ClientHeight = 151
  ExplicitHeight = 180
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlCampos: TPanel
    Height = 72
    ExplicitHeight = 72
    object Label7: TLabel [0]
      Left = 27
      Top = 42
      Width = 72
      Height = 13
      Caption = '* Descri'#231#227'o:'
    end
    object EdtNmMarca: TcxTextEdit
      Left = 101
      Top = 39
      TabOrder = 1
      OnEditing = CamposEdicao
      Width = 360
    end
  end
  inherited StbPrincipal: TStatusBar
    Top = 129
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 129
  end
end
