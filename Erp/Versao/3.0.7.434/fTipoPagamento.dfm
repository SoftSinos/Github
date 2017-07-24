inherited FrmTipoPagamento: TFrmTipoPagamento
  Caption = 'Cadastrar Tipo de Pagamento'
  ClientHeight = 154
  ExplicitWidth = 802
  ExplicitHeight = 183
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlCampos: TPanel
    Height = 67
    ExplicitHeight = 67
    object Label7: TLabel [0]
      Left = 27
      Top = 42
      Width = 72
      Height = 13
      Caption = '* Descri'#231#227'o:'
    end
    inherited GrbIdentificador: TGroupBox
      inherited ChkSnSituacao: TcxCheckBox
        OnEditing = CamposEdicao
        ExplicitHeight = 21
      end
    end
    object EdtNmTpPagamento: TcxTextEdit
      Left = 101
      Top = 39
      TabOrder = 1
      OnEditing = CamposEdicao
      Width = 360
    end
  end
  inherited StbPrincipal: TStatusBar
    Top = 132
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 132
  end
end
