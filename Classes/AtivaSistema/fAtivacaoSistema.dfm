inherited FrmAtivacaoSistema: TFrmAtivacaoSistema
  Caption = 'Ativar Licen'#231'a'
  ClientHeight = 250
  ExplicitWidth = 802
  ExplicitHeight = 279
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlCampos: TPanel
    Height = 163
    ExplicitHeight = 163
    object Label2: TLabel [0]
      Left = 14
      Top = 94
      Width = 87
      Height = 13
      Caption = '* Computador:'
    end
    object Label3: TLabel [1]
      Left = 388
      Top = 94
      Width = 60
      Height = 13
      Caption = '* N'#186' MAC:'
    end
    object LblNmCpfCnpj: TLabel [2]
      Left = 349
      Top = 117
      Width = 99
      Height = 13
      Alignment = taRightJustify
      Caption = '* N'#186' IP Servidor:'
    end
    object Label4: TLabel [3]
      Left = 13
      Top = 117
      Width = 88
      Height = 13
      Caption = '* N'#186' Serial HD:'
    end
    object Label5: TLabel [4]
      Left = 28
      Top = 140
      Width = 71
      Height = 13
      Alignment = taRightJustify
      Caption = '* N'#186' Chave:'
    end
    inherited GrbIdentificador: TGroupBox
      TabOrder = 1
      inherited Label12: TLabel
        Left = 469
        ExplicitLeft = 469
      end
      inherited EdtNmUsuario: TcxTextEdit
        Left = 519
        ExplicitLeft = 519
      end
      inherited ChkSnSituacao: TcxCheckBox
        Visible = False
        ExplicitHeight = 21
      end
    end
    object RdgNmLicenca: TRadioGroup
      AlignWithMargins = True
      Left = 4
      Top = 43
      Width = 782
      Height = 46
      Align = alTop
      Caption = '  * Tipo de Vers'#227'o  '
      Columns = 3
      Items.Strings = (
        'Starter'
        'Ultimate'
        'Business')
      TabOrder = 11
    end
    object BtnAlterarNmComputador: TBitBtn
      Left = 314
      Top = 91
      Width = 20
      Height = 21
      Caption = 'A'
      TabOrder = 2
      OnClick = BtnAlterarNmComputadorClick
    end
    object BtnAlterarNrHd: TBitBtn
      Left = 314
      Top = 114
      Width = 20
      Height = 21
      Caption = 'A'
      TabOrder = 4
      OnClick = BtnAlterarNrHdClick
    end
    object BtnAlterarNrIp: TBitBtn
      Left = 661
      Top = 114
      Width = 20
      Height = 21
      Caption = 'A'
      TabOrder = 10
      OnClick = BtnAlterarNrIpClick
    end
    object BtnAlterarNrMac: TBitBtn
      Left = 661
      Top = 91
      Width = 20
      Height = 21
      Caption = 'A'
      TabOrder = 8
      OnClick = BtnAlterarNrMacClick
    end
    object BtnAlterarNrChaveAtivacao: TBitBtn
      Left = 314
      Top = 137
      Width = 20
      Height = 21
      Caption = 'A'
      TabOrder = 6
      TabStop = False
      OnClick = BtnAlterarNrChaveAtivacaoClick
    end
    object EdtNmComputador: TcxTextEdit
      Left = 101
      Top = 91
      TabStop = False
      Enabled = False
      Properties.Alignment.Horz = taCenter
      TabOrder = 0
      Width = 214
    end
    object EdtNrHd: TcxTextEdit
      Left = 101
      Top = 114
      TabStop = False
      Enabled = False
      Properties.Alignment.Horz = taCenter
      TabOrder = 3
      Width = 214
    end
    object MkeNrChaveAtivacao: TcxTextEdit
      Left = 101
      Top = 137
      TabStop = False
      Enabled = False
      Properties.Alignment.Horz = taCenter
      TabOrder = 5
      Width = 214
    end
    object EdtNrMac: TcxTextEdit
      Left = 448
      Top = 91
      TabStop = False
      Enabled = False
      Properties.Alignment.Horz = taCenter
      TabOrder = 7
      Width = 214
    end
    object MkeNrIp: TcxTextEdit
      Left = 448
      Top = 114
      TabStop = False
      Enabled = False
      Properties.Alignment.Horz = taCenter
      TabOrder = 9
      Width = 214
    end
  end
  inherited StbPrincipal: TStatusBar
    Top = 228
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 228
  end
end
