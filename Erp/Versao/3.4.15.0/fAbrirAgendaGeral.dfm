inherited FrmAbrirAgendaGeral: TFrmAbrirAgendaGeral
  Caption = 'Abrir Agenda Geral'
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
    ExplicitTop = 104
  end
  inherited PnlPrincipal: TPanel
    Width = 270
    inherited BtnFechar: TcxButton
      Left = 108
      ExplicitLeft = 103
      ExplicitTop = -2
    end
    inherited BtnAjuda: TcxButton
      Left = 212
      OnClick = BtnAjudaClick
      ExplicitLeft = 212
    end
    inherited BtnInicializar: TcxButton
      Left = 369
      ExplicitLeft = 369
    end
    inherited BtnSalvar: TcxButton
      Left = 265
      ExplicitLeft = 340
      ExplicitTop = 10
    end
    inherited BtnExecutar: TcxButton
      Left = 473
      ExplicitLeft = 473
    end
    inherited BtnLimpar: TcxButton
      Left = 889
      ExplicitLeft = 889
    end
    inherited BtnCarregar: TcxButton
      Left = 577
      ExplicitLeft = 577
    end
    inherited BtnAgenda: TcxButton
      Left = 785
      ExplicitLeft = 785
    end
    inherited BtnPeriodo: TcxButton
      Left = 681
      ExplicitLeft = 681
    end
    inherited BtnAtualizar: TcxButton
      Left = 993
      ExplicitLeft = 993
    end
    inherited BtnGerar: TcxButton
      Left = 4
      Enabled = True
      Visible = True
      OnClick = BtnGerarClick
      ExplicitLeft = -20
      ExplicitTop = 10
    end
  end
  inherited PnlCampos: TPanel
    Width = 270
    Height = 67
    ExplicitHeight = 39
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 262
      Height = 59
      Align = alClient
      Caption = '  Data  '
      TabOrder = 0
      ExplicitTop = 120
      ExplicitHeight = 67
      object Label26: TLabel
        Left = 42
        Top = 26
        Width = 78
        Height = 13
        Caption = '* Ano Gera'#231#227'o :'
      end
      object CbbNrAno: TcxComboBox
        Left = 126
        Top = 22
        Properties.DropDownListStyle = lsFixedList
        TabOrder = 0
        Width = 89
      end
    end
  end
end
