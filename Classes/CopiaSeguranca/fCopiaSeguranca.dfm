inherited FrmCopiaSeguranca: TFrmCopiaSeguranca
  Caption = 'Backup de Dados'
  ClientHeight = 216
  ClientWidth = 588
  ExplicitWidth = 594
  ExplicitHeight = 245
  PixelsPerInch = 96
  TextHeight = 13
  inherited StbPrincipal: TStatusBar
    Top = 194
    Width = 582
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
    ExplicitWidth = 1207
  end
  inherited PnlPrincipal: TPanel
    Width = 582
    ExplicitWidth = 1207
    inherited BtnFechar: TcxButton
      Left = 108
      ExplicitLeft = 108
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAjuda: TcxButton
      Left = 212
      OnClick = BtnAjudaClick
      ExplicitLeft = 212
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnInicializar: TcxButton
      Left = 265
      ExplicitLeft = 265
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnSalvar: TcxButton
      Left = 369
      ExplicitLeft = 369
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnExecutar: TcxButton
      Left = 473
      ExplicitLeft = 473
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnLimpar: TcxButton
      Left = 889
      ExplicitLeft = 889
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnCarregar: TcxButton
      Left = 577
      ExplicitLeft = 577
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAgenda: TcxButton
      Left = 785
      ExplicitLeft = 785
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnPeriodo: TcxButton
      Left = 681
      ExplicitLeft = 681
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAtualizar: TcxButton
      Left = 993
      ExplicitLeft = 993
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnGerar: TcxButton
      Left = 4
      Enabled = True
      Visible = True
      OnClick = BtnGerarClick
      ExplicitLeft = 4
      ExplicitTop = 4
      ExplicitHeight = 38
    end
  end
  inherited PnlCampos: TPanel
    Width = 582
    Height = 106
    ExplicitWidth = 1207
    ExplicitHeight = 106
    object Label1: TLabel
      Left = 8
      Top = 62
      Width = 103
      Height = 13
      Caption = 'Caminho da C'#243'pia:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblCaminhoCopia: TLabel
      Left = 8
      Top = 81
      Width = 81
      Height = 13
      Caption = 'LblCaminhoCopia'
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 574
      Height = 50
      Align = alTop
      Caption = '  Op'#231#245'es  do Banco de Dados  '
      TabOrder = 0
      ExplicitWidth = 1199
      object RdbReduzir: TRadioButton
        Left = 16
        Top = 22
        Width = 145
        Height = 17
        Caption = 'Reduzir Banco de Dados'
        TabOrder = 0
      end
    end
  end
  object PrbPesquisa: TProgressBar
    AlignWithMargins = True
    Left = 3
    Top = 171
    Width = 582
    Height = 17
    Align = alBottom
    TabOrder = 3
    ExplicitWidth = 1207
  end
end
