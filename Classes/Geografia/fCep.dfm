inherited FrmCep: TFrmCep
  Caption = 'Cadastrar Cep'
  ClientHeight = 174
  ClientWidth = 828
  ExplicitWidth = 834
  ExplicitHeight = 203
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlPrincipal: TPanel
    Width = 822
    ExplicitWidth = 822
  end
  inherited PnlCampos: TPanel
    Width = 822
    Height = 87
    ExplicitWidth = 822
    ExplicitHeight = 87
    object Label8: TLabel [0]
      Left = 42
      Top = 43
      Width = 57
      Height = 13
      Caption = '* N'#186' CEP:'
    end
    object Label2: TLabel [1]
      Left = 188
      Top = 42
      Width = 40
      Height = 13
      Caption = '* Tipo:'
    end
    object Label3: TLabel [2]
      Left = 377
      Top = 42
      Width = 81
      Height = 13
      Caption = '* Logradouro:'
    end
    object Label4: TLabel [3]
      Left = 48
      Top = 64
      Width = 51
      Height = 13
      Caption = '* Bairro:'
    end
    object Label5: TLabel [4]
      Left = 402
      Top = 65
      Width = 56
      Height = 13
      Caption = '* Cidade:'
    end
    object Label6: TLabel [5]
      Left = 237
      Top = 65
      Width = 28
      Height = 13
      Caption = '* Uf:'
    end
    inherited GrbIdentificador: TGroupBox
      Width = 814
      TabOrder = 6
      ExplicitWidth = 814
      inherited ChkSnSituacao: TcxCheckBox
        ExplicitHeight = 21
      end
    end
    object EdtNmBairro: TcxTextEdit
      Left = 100
      Top = 61
      TabOrder = 3
      OnEditing = CamposEdicao
      Width = 121
    end
    object EdtNmTpLogradouro: TcxTextEdit
      Left = 234
      Top = 39
      TabOrder = 1
      OnEditing = CamposEdicao
      Width = 121
    end
    object EdtNmLogradouro: TcxTextEdit
      Left = 459
      Top = 39
      TabOrder = 2
      OnEditing = CamposEdicao
      Width = 340
    end
    object CbbIdUf: TcxComboBox
      Left = 267
      Top = 61
      TabOrder = 4
      OnEditing = CamposEdicao
      Width = 110
    end
    object CbbIdCidade: TcxComboBox
      Left = 459
      Top = 61
      TabOrder = 5
      OnEditing = CamposEdicao
      Width = 340
    end
    object MkeNrCep: TcxMaskEdit
      Left = 101
      Top = 39
      Properties.EditMask = '00\.000\-000;1;_'
      Properties.OnValidate = MkeNrCepPropertiesValidate
      TabOrder = 0
      Text = '  .   -   '
      OnEditing = CamposEdicao
      Width = 83
    end
  end
  inherited StbPrincipal: TStatusBar
    Top = 152
    Width = 822
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 152
    ExplicitWidth = 822
  end
  inherited CdsCopula: TClientDataSet
    Left = 645
    Top = 3
  end
end
