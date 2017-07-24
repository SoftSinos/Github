inherited FrmTipoPessoa: TFrmTipoPessoa
  Caption = 'Cadastrar Tipo de Pessoa'
  ClientHeight = 216
  ExplicitWidth = 802
  ExplicitHeight = 245
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlCampos: TPanel
    Height = 129
    ExplicitHeight = 129
    object Label2: TLabel [0]
      Left = 38
      Top = 42
      Width = 61
      Height = 13
      Caption = 'Descri'#231#227'o:'
    end
    inherited GrbIdentificador: TGroupBox
      inherited ChkSnSituacao: TcxCheckBox
        OnEditing = CamposEdicao
        ExplicitHeight = 21
      end
    end
    object GroupBox1: TGroupBox
      Left = 101
      Top = 60
      Width = 536
      Height = 63
      Caption = '  Caracteristicas  '
      TabOrder = 1
      object ChkSnCliente: TcxCheckBox
        Left = 25
        Top = 23
        Caption = 'Cliente'
        ParentBackground = False
        ParentColor = False
        Style.Color = clWhite
        TabOrder = 0
        OnEditing = CamposEdicao
        Width = 121
      end
      object ChkSnFornecedor: TcxCheckBox
        Left = 202
        Top = 23
        Caption = 'Fornecedor'
        ParentBackground = False
        ParentColor = False
        Style.Color = clWhite
        TabOrder = 1
        OnEditing = CamposEdicao
        Width = 121
      end
      object ChkSnFuncionario: TcxCheckBox
        Left = 412
        Top = 23
        Caption = 'Profissional'
        ParentBackground = False
        ParentColor = False
        Style.Color = clWhite
        TabOrder = 2
        OnEditing = CamposEdicao
        Width = 121
      end
    end
    object EdtNmTpPessoa: TcxTextEdit
      Left = 101
      Top = 39
      TabOrder = 2
      OnEditing = CamposEdicao
      Width = 360
    end
  end
  inherited StbPrincipal: TStatusBar
    Top = 194
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 194
  end
  inherited CdsCopula: TClientDataSet
    Left = 645
    Top = 99
  end
  inherited CdsRetorno: TClientDataSet
    Left = 645
    Top = 147
  end
end
