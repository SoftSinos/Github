inherited FrmRelatorio: TFrmRelatorio
  Caption = 'FrmRelatorio'
  ClientHeight = 209
  ClientWidth = 484
  ExplicitWidth = 490
  ExplicitHeight = 238
  PixelsPerInch = 96
  TextHeight = 13
  inherited StbPrincipal: TStatusBar
    Top = 187
    Width = 478
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 187
    ExplicitWidth = 478
  end
  inherited PnlPrincipal: TPanel
    Width = 478
    ExplicitWidth = 478
    inherited BtnFechar: TcxButton
      Left = 212
      ExplicitLeft = 212
    end
    inherited BtnAjuda: TcxButton
      Left = 316
      ExplicitLeft = 316
    end
    inherited BtnInicializar: TcxButton
      Left = 369
      ExplicitLeft = 369
    end
    inherited BtnSalvar: TcxButton
      Left = 473
      ExplicitLeft = 473
    end
    inherited BtnExecutar: TcxButton
      Left = 577
      ExplicitLeft = 577
    end
    inherited BtnLimpar: TcxButton
      Left = 108
      Enabled = True
      Visible = True
      ExplicitLeft = 108
    end
    inherited BtnCarregar: TcxButton
      Left = 681
      ExplicitLeft = 681
    end
    inherited BtnAgenda: TcxButton
      Left = 889
      ExplicitLeft = 889
    end
    inherited BtnPeriodo: TcxButton
      Left = 785
      ExplicitLeft = 785
    end
    inherited BtnAtualizar: TcxButton
      Left = 993
      ExplicitLeft = 993
    end
    inherited BtnGerar: TcxButton
      Left = 4
      Enabled = True
      Visible = True
      ExplicitLeft = 4
    end
  end
  inherited PnlCampos: TPanel
    Width = 478
    Height = 122
    ExplicitWidth = 478
    ExplicitHeight = 122
    object PrbPesquisa: TProgressBar
      AlignWithMargins = True
      Left = 4
      Top = 101
      Width = 470
      Height = 17
      Align = alBottom
      TabOrder = 0
    end
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 470
      Height = 91
      Align = alClient
      Caption = '  Op'#231#245'es de Sele'#231#227'o  '
      TabOrder = 1
      object Label3: TLabel
        Left = 35
        Top = 62
        Width = 56
        Height = 13
        Caption = '* Relat'#243'rio:'
      end
      object Label2: TLabel
        Left = 37
        Top = 23
        Width = 54
        Height = 13
        Caption = '* Empresa:'
      end
      object Label13: TLabel
        Left = 42
        Top = 42
        Width = 49
        Height = 13
        Caption = '* Per'#237'odo:'
      end
      object Label1: TLabel
        Left = 180
        Top = 42
        Width = 16
        Height = 13
        Caption = 'at'#233
      end
      object CbbIdRelatorio: TcxComboBox
        Left = 92
        Top = 59
        TabOrder = 3
        Width = 343
      end
      object CbbIdEmpresa: TcxComboBox
        Left = 92
        Top = 19
        Properties.DropDownListStyle = lsFixedList
        TabOrder = 0
        Width = 343
      end
      object DtpDtInicio: TcxDateEdit
        Left = 92
        Top = 39
        Properties.AssignedValues.DisplayFormat = True
        Properties.DateButtons = []
        TabOrder = 1
        Width = 79
      end
      object DtpDtFinal: TcxDateEdit
        Left = 205
        Top = 39
        Properties.AssignedValues.DisplayFormat = True
        Properties.DateButtons = []
        TabOrder = 2
        Width = 79
      end
    end
  end
end
