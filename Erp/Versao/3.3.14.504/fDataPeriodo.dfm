inherited FrmDataPeriodo: TFrmDataPeriodo
  Caption = 'Carregar Data'
  ClientHeight = 154
  ClientWidth = 276
  ExplicitWidth = 282
  ExplicitHeight = 183
  PixelsPerInch = 96
  TextHeight = 13
  inherited StbPrincipal: TStatusBar
    Top = 132
    Width = 270
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
    ExplicitWidth = 1106
  end
  inherited PnlPrincipal: TPanel
    Width = 270
    ExplicitWidth = 1106
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
      Left = 473
      ExplicitLeft = 473
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
      Left = 577
      ExplicitLeft = 577
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
      Left = 265
      ExplicitLeft = 265
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
    Width = 270
    Height = 67
    ExplicitWidth = 1106
    ExplicitHeight = 67
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 262
      Height = 59
      Align = alClient
      Caption = '  Data  '
      TabOrder = 0
      ExplicitWidth = 1098
      object Label9: TLabel
        Left = 55
        Top = 25
        Width = 49
        Height = 13
        Caption = 'Selecione:'
      end
      object DtpDtPeriodoInicio: TcxDateEdit
        Left = 106
        Top = 22
        Properties.AssignedValues.DisplayFormat = True
        Properties.DateButtons = []
        Properties.DateOnError = deNull
        TabOrder = 0
        Width = 96
      end
    end
  end
end
