inherited FrmPessoaRapido: TFrmPessoaRapido
  Top = 110
  Caption = 'Cadastrar Cliente - "R'#225'pido"'
  ClientHeight = 315
  ClientWidth = 783
  ExplicitWidth = 789
  ExplicitHeight = 344
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlPrincipal: TPanel
    Width = 777
    ExplicitWidth = 850
  end
  inherited PnlCampos: TPanel
    Width = 777
    Height = 236
    ExplicitWidth = 850
    ExplicitHeight = 236
    inherited GrbIdentificador: TGroupBox
      Width = 769
      ExplicitWidth = 842
      inherited EdtIdRegistro: TcxTextEdit
        ExplicitWidth = 101
        Width = 101
      end
      inherited ChkSnSituacao: TcxCheckBox
        OnEditing = CamposEdicao
        ExplicitHeight = 21
      end
    end
    object GroupBox2: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 42
      Width = 769
      Height = 81
      Align = alTop
      Caption = '  Dados B'#225'sicos  '
      TabOrder = 1
      ExplicitWidth = 842
      object LblDtNascFund: TLabel
        Left = 30
        Top = 59
        Width = 74
        Height = 13
        Caption = '* Data Nasc:'
      end
      object LblPessoaRazaoSocial: TLabel
        Left = 11
        Top = 19
        Width = 93
        Height = 13
        Alignment = taRightJustify
        Caption = '* Nome Cliente:'
      end
      object LblNmApelido: TLabel
        Left = 57
        Top = 38
        Width = 47
        Height = 13
        Alignment = taRightJustify
        Caption = 'Apelido:'
      end
      object Label2: TLabel
        Left = 297
        Top = 39
        Width = 57
        Height = 13
        Caption = '* Celular:'
      end
      object DtpDtNascimento: TcxDateEdit
        Left = 105
        Top = 56
        Properties.AssignedValues.DisplayFormat = True
        Properties.AssignedValues.EditFormat = True
        Properties.DateButtons = []
        Style.Color = clWindow
        TabOrder = 2
        OnEditing = CamposEdicao
        Width = 92
      end
      object EdtNmPessoa: TcxTextEdit
        Left = 105
        Top = 16
        TabOrder = 0
        OnEditing = CamposEdicao
        Width = 360
      end
      object EdtNmApelido: TcxTextEdit
        Left = 105
        Top = 36
        TabOrder = 1
        OnEditing = CamposEdicao
        Width = 186
      end
      object MkeNrCelular: TcxMaskEdit
        Left = 356
        Top = 36
        Enabled = False
        Properties.EditMask = '\(00\)00000-0000;1;_'
        Properties.OnValidate = MkeNrCelularPropertiesValidate
        TabOrder = 3
        Text = '(  )     -    '
        OnEditing = CamposEdicao
        Width = 109
      end
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 129
      Width = 769
      Height = 103
      Align = alClient
      Caption = '  Dados Endere'#231'o  '
      TabOrder = 2
      ExplicitWidth = 842
      object Label8: TLabel
        Left = 45
        Top = 24
        Width = 50
        Height = 13
        Caption = ' N'#186' CEP:'
      end
      object Label15: TLabel
        Left = 155
        Top = 48
        Width = 40
        Height = 13
        Caption = 'Bairro:'
      end
      object Label16: TLabel
        Left = 76
        Top = 51
        Width = 19
        Height = 13
        Caption = 'N'#186':'
      end
      object Label13: TLabel
        Left = 243
        Top = 24
        Width = 58
        Height = 13
        Caption = 'Endere'#231'o:'
      end
      object Label17: TLabel
        Left = 155
        Top = 75
        Width = 85
        Height = 13
        Caption = 'Complemento:'
      end
      object Label5: TLabel
        Left = 356
        Top = 50
        Width = 45
        Height = 13
        Caption = 'Cidade:'
      end
      object Label10: TLabel
        Left = 76
        Top = 75
        Width = 19
        Height = 13
        Caption = 'UF:'
      end
      object BtnCepPesquisa: TcxButton
        Left = 176
        Top = 21
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
        TabOrder = 1
        TabStop = False
        OnClick = BtnCepPesquisaClick
      end
      object EdtNmComplemento: TcxTextEdit
        Left = 241
        Top = 72
        TabOrder = 7
        OnEditing = CamposEdicao
        Width = 446
      end
      object MkeNrCep: TcxMaskEdit
        Left = 97
        Top = 21
        Properties.EditMask = '00\.000\-000;1;_'
        Properties.OnValidate = MkeNrCepPropertiesValidate
        TabOrder = 0
        Text = '  .   -   '
        OnEditing = CamposEdicao
        OnExit = MkeNrCepExit
        OnKeyPress = MkeNrCepKeyPress
        Width = 80
      end
      object EdtNmCidade: TcxTextEdit
        Left = 403
        Top = 46
        Enabled = False
        TabOrder = 5
        Width = 284
      end
      object EdtNmUf: TcxTextEdit
        Left = 97
        Top = 72
        Enabled = False
        TabOrder = 6
        Width = 41
      end
      object EdtNrNumero: TcxTextEdit
        Left = 97
        Top = 46
        TabOrder = 3
        OnEditing = CamposEdicao
        Width = 41
      end
      object EdtNmBairro: TcxTextEdit
        Left = 196
        Top = 46
        Enabled = False
        TabOrder = 4
        Width = 152
      end
      object EdtNmEndereco: TcxTextEdit
        Left = 303
        Top = 21
        Enabled = False
        TabOrder = 2
        Width = 384
      end
    end
  end
  inherited StbPrincipal: TStatusBar
    Top = 293
    Width = 777
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 293
    ExplicitWidth = 850
  end
  inherited CdsCopula: TClientDataSet
    Left = 541
    Top = 91
  end
  inherited CdsRetorno: TClientDataSet
    Left = 613
    Top = 91
  end
  object DtsRetorno: TDataSource
    DataSet = CdsRetorno
    Left = 616
    Top = 136
  end
end
