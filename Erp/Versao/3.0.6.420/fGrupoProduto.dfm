inherited FrmGrupoProduto: TFrmGrupoProduto
  Caption = 'Cadastrar Grupo Produto'
  ClientHeight = 151
  ExplicitWidth = 802
  ExplicitHeight = 180
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlCampos: TPanel
    Height = 64
    ExplicitHeight = 64
    object Label7: TLabel [0]
      Left = 28
      Top = 42
      Width = 72
      Height = 13
      Caption = '* Descri'#231#227'o:'
    end
    inherited GrbIdentificador: TGroupBox
      inherited ChkSnSituacao: TcxCheckBox
        ExplicitHeight = 21
      end
    end
    object EdtNmGrupoProduto: TcxTextEdit
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
