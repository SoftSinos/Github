inherited FrmUsuario: TFrmUsuario
  Caption = 'Cadastrar Usu'#225'rio'
  ClientHeight = 223
  ExplicitWidth = 802
  ExplicitHeight = 252
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlCampos: TPanel
    Height = 136
    ExplicitHeight = 136
    object Label2: TLabel [0]
      Left = 33
      Top = 45
      Width = 66
      Height = 13
      Caption = '* Empresa:'
    end
    object Label4: TLabel [1]
      Left = 40
      Top = 91
      Width = 59
      Height = 13
      Caption = '* Usu'#225'rio:'
    end
    object Label5: TLabel [2]
      Left = 47
      Top = 114
      Width = 52
      Height = 13
      Caption = '* Senha:'
    end
    object Label6: TLabel [3]
      Left = 299
      Top = 91
      Width = 56
      Height = 13
      Caption = '* N'#186' CPF:'
    end
    object Label7: TLabel [4]
      Left = 50
      Top = 68
      Width = 49
      Height = 13
      Caption = '* Nome:'
    end
    object Label8: TLabel [5]
      Left = 259
      Top = 114
      Width = 74
      Height = 13
      Caption = '* Confirmar:'
    end
    inherited GrbIdentificador: TGroupBox
      inherited ChkSnSituacao: TcxCheckBox
        ExplicitHeight = 21
      end
    end
    object EdtNmSenhaConfere: TcxTextEdit
      Left = 334
      Top = 111
      TabOrder = 1
      OnEditing = CamposEdicao
      Width = 127
    end
    object EdtNmSenha: TcxTextEdit
      Left = 100
      Top = 111
      TabOrder = 2
      OnEditing = CamposEdicao
      Width = 127
    end
    object EdtNmLogin: TcxTextEdit
      Left = 100
      Top = 88
      TabOrder = 3
      OnEditing = CamposEdicao
      Width = 173
    end
    object EdtNmUsuarioCompleto: TcxTextEdit
      Left = 100
      Top = 65
      TabOrder = 4
      OnEditing = CamposEdicao
      Width = 361
    end
    object MkeNrCpf: TcxMaskEdit
      Left = 357
      Top = 88
      Properties.EditMask = '000\.000\.000\-00;1;_'
      Properties.OnValidate = MkeNrCpfPropertiesValidate
      TabOrder = 6
      Text = '   .   .   -  '
      OnEditing = CamposEdicao
      Width = 104
    end
    object CbbIdEmpresa: TcxComboBox
      Left = 100
      Top = 42
      TabOrder = 5
      OnEditing = CamposEdicao
      Width = 341
    end
    object BtnEmpresaPesquisa: TcxButton
      Left = 440
      Top = 42
      Width = 21
      Height = 21
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = True
      OptionsImage.Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF004E4E4E004E4E4E004E4E4E104E4E4E1A4E4E4E1F4E4E
        4E164E4E4E084E4E4E004E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF004E4E4E004E4E4E174E4E4E334E4E4E334E4E4E334E4E
        4E334E4E4E324E4E4E034E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF004E4E4E064E4E4E204E4E4EFF4E4E4EFF4E4E
        4E274E4E4E17FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004E4E4E004E4E4E004E4E4E004E4E4E004E4E4EFF4E4E4EFF4E4E
        4E004E4E4E004E4E4E004E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004E4E4E004E4E4E004E4E4E004E4E4E004E4E4EFF4E4E4EFF4E4E
        4E004E4E4E004E4E4E004E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E
        4EFF4E4E4EFF4E4E4EFF4E4E4EFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E
        4EFF4E4E4EFF4E4E4EFF4E4E4EFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 7
      TabStop = False
      OnClick = BtnEmpresaPesquisaClick
    end
    object ChkSnAdministrador: TcxCheckBox
      Left = 501
      Top = 43
      Caption = 'Administrador'
      ParentBackground = False
      ParentColor = False
      Style.Color = clWhite
      TabOrder = 8
      OnEditing = CamposEdicao
      Width = 121
    end
  end
  inherited StbPrincipal: TStatusBar
    Top = 201
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 201
  end
end
