inherited FrmCidade: TFrmCidade
  Caption = 'Cadastrar Cidade'
  ClientHeight = 151
  ExplicitWidth = 802
  ExplicitHeight = 180
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlCampos: TPanel
    Height = 64
    ExplicitHeight = 64
    object Label2: TLabel [0]
      Left = 28
      Top = 42
      Width = 72
      Height = 13
      Caption = '* Descri'#231#227'o:'
    end
    object Label3: TLabel [1]
      Left = 473
      Top = 43
      Width = 42
      Height = 13
      Caption = '* Ibge:'
    end
    object Label6: TLabel [2]
      Left = 622
      Top = 43
      Width = 28
      Height = 13
      Caption = '* Uf:'
    end
    inherited GrbIdentificador: TGroupBox
      inherited Label9: TLabel
        Left = 202
        ExplicitLeft = 202
      end
      inherited ChkSnSituacao: TcxCheckBox
        ExplicitHeight = 21
      end
    end
    object EdtNmCidade: TcxTextEdit
      Left = 101
      Top = 39
      TabOrder = 1
      OnEditing = CamposEdicao
      Width = 356
    end
    object CbbIdUf: TcxComboBox
      Left = 652
      Top = 39
      TabOrder = 3
      OnEditing = CamposEdicao
      Width = 110
    end
    object EdtNrIbge: TcxTextEdit
      Left = 516
      Top = 39
      TabOrder = 2
      OnEditing = CamposEdicao
      Width = 97
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
  inherited CdsCopula: TClientDataSet
    Left = 653
  end
  inherited CdsRetorno: TClientDataSet
    Left = 709
  end
end
