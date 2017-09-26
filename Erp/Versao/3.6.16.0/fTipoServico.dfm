inherited FrmTipoServico: TFrmTipoServico
  Caption = 'Cadastrar Tipo de Servi'#231'o'
  ClientHeight = 196
  ExplicitHeight = 225
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlPrincipal: TPanel
    OnClick = PnlPrincipalClick
  end
  inherited PnlCampos: TPanel
    Height = 117
    ExplicitHeight = 117
    object Label7: TLabel [0]
      Left = 27
      Top = 66
      Width = 72
      Height = 13
      Caption = '* Descri'#231#227'o:'
    end
    object Label22: TLabel [1]
      Left = 7
      Top = 89
      Width = 92
      Height = 13
      Caption = '* Valor Servi'#231'o:'
    end
    object Label2: TLabel [2]
      Left = 48
      Top = 42
      Width = 51
      Height = 13
      Caption = '* Grupo:'
    end
    object Label3: TLabel [3]
      Left = 199
      Top = 87
      Width = 184
      Height = 13
      Caption = 'Tempo de Execu'#231#227'o do Servi'#231'o:'
    end
    inherited GrbIdentificador: TGroupBox
      TabOrder = 4
      inherited ChkSnSituacao: TcxCheckBox
        OnEditing = CamposEdicao
      end
    end
    object MkeVlServico: TcxMaskEdit
      Left = 100
      Top = 84
      Properties.ValidationOptions = []
      TabOrder = 3
      TextHint = '0,00'
      OnEditing = CamposEdicao
      Width = 85
    end
    object EdtNmTpServico: TcxTextEdit
      Left = 100
      Top = 62
      TabOrder = 2
      OnEditing = CamposEdicao
      Width = 340
    end
    object CbbIdGrupoServico: TcxComboBox
      Left = 100
      Top = 39
      TabOrder = 0
      OnEditing = CamposEdicao
      Width = 340
    end
    object BtnGrupoServicoPesquisa: TcxButton
      Left = 440
      Top = 39
      Width = 21
      Height = 21
      BiDiMode = bdLeftToRight
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
      ParentBiDiMode = False
      TabOrder = 1
      TabStop = False
      OnClick = BtnGrupoServicoPesquisaClick
    end
    object DtpHrServico: TcxTimeEdit
      Left = 385
      Top = 84
      EditValue = 0d
      Style.ButtonStyle = btsUltraFlat
      TabOrder = 5
      OnEditing = CamposEdicao
      Width = 76
    end
    object BtnCores: TcxButton
      Left = 440
      Top = 62
      Width = 21
      Height = 21
      BiDiMode = bdLeftToRight
      LookAndFeel.Kind = lfUltraFlat
      LookAndFeel.NativeStyle = True
      OptionsImage.Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000019242124565D5B6B79727591737979925D58
        586C251A1B250000000000000000000000000000000000000000000000000000
        000000000000010604068387849CE897B3FFF16392FFEB588BFF5AE9DEFF61F2
        E5FF94E7E1FF8688859E07070207000000000000000000000000000000000000
        000002060406AFA2ABC9F163B8FFF42F72FFF63576FFEB447FFF47E8DEFF36F6
        E6FF30F7E4FF5F95EEFFA19CB2CB070703070000000000000000000000000000
        00008386859AEC64D2FFF032B4FFF24071FFF53C72FFEB4678FF49E8D3FF3CF5
        DAFF40F9D7FF3379EEFF5F7AF1FF8888889E000000000000000000000000181D
        171DE19CE8FFDF2FFAFFE240D8FFF33F51FFF53C55FFEB465BFF49E8ABFF3CF5
        B1FF3FF8ADFF4098E4FF2F71F6FF95B3EAFF20201A2000000000000000005960
        5866E367EFFFE138F9FFE53FD6FFF33E53FFF53B57FFEB455DFF49E8AFFF3CF5
        B5FF3FF8B1FF3F95E5FF3976F5FF6294EFFF61605C6900000000000000007A76
        7C8BDA53F0FFD83CF8FFDE40D6FFF34252FFF53F56FFEB495CFF4AE8A7FF3DF5
        ADFF40F8A9FF3F98E4FF3D7CF5FF4E8BF1FF757A808F00000000000000007775
        7B8A7153F0FF593AF9FF7C4AD1FFF87B39FFF57740FFEC7E40FF61EC44FF56F4
        44FF5AF53BFF45BCCEFF3CACFAFF4EB4F1FF757C808E00000000000000005E5F
        58637B67EFFF4D35FAFF754AD1FFF87F38FFF57B3FFFEC823FFF62EC3DFF57F4
        3DFF5BF534FF45BFCDFF38ADFAFF62BCEFFF615E5C6700000000000000001A1A
        171AA89CEAFF482DFAFF794AD1FFF87938FFF5753FFFEC7C3FFF5FEC3FFF53F4
        3FFF57F536FF45BDCDFF2EA9FBFF96CCEBFF1D1D191D00000000000000000000
        000085858493635FF5FF574ED2FFFADE38FFF3D73FFFEED83FFFA1F13FFF9AF2
        3FFFA1F336FF46D9CEFF5BD5F7FF868789980000000000000000000000000000
        0000030302039A9BB5C18081D0FFF5F32EFFF4F138FFEFF03DFFB1F23DFFABF2
        39FFABF42CFF74E3CCFF9DB1B9C5040403040000000000000000000000000000
        0000000000000202020287888393E7E49AFDF0EA65FFEEEB50FFB5F050FFB7EF
        63FFC7EA96FE8886839503030303000000000000000000000000000000000000
        0000000000000000000000000000191A1D1D55565C60797A7187777A71875957
        5C611E1A1E1E0000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000}
      ParentBiDiMode = False
      TabOrder = 6
      TabStop = False
      OnClick = BtnCoresClick
    end
    object BtnMostrarCor: TcxButton
      Left = 464
      Top = 39
      Width = 73
      Height = 66
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ParentCustomHint = False
      BiDiMode = bdLeftToRight
      Colors.Default = clBtnFace
      Colors.DefaultText = clBtnFace
      Colors.Normal = clBtnFace
      Colors.NormalText = clBtnFace
      Colors.Hot = clBtnFace
      Colors.HotText = clBtnFace
      Colors.Pressed = clBtnFace
      Colors.PressedText = clBtnFace
      Colors.Disabled = clWhite
      Colors.DisabledText = clWhite
      Enabled = False
      ParentBiDiMode = False
      ParentShowHint = False
      ShowHint = False
      SpeedButtonOptions.CanBeFocused = False
      TabOrder = 7
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
  end
  inherited StbPrincipal: TStatusBar
    Top = 174
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 174
  end
  object ClrDialog: TColorDialog
    Left = 731
    Top = 91
  end
end