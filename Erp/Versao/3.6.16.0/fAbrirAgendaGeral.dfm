inherited FrmAbrirAgendaGeral: TFrmAbrirAgendaGeral
  Caption = 'Abrir Agenda Geral'
  ClientHeight = 145
  ClientWidth = 354
  ExplicitWidth = 360
  ExplicitHeight = 174
  PixelsPerInch = 96
  TextHeight = 13
  inherited StbPrincipal: TStatusBar
    Top = 123
    Width = 348
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
    ExplicitWidth = 270
  end
  inherited PnlPrincipal: TPanel
    Width = 348
    ExplicitWidth = 270
    inherited BtnFechar: TcxButton
      Left = 197
      ExplicitLeft = 197
    end
    inherited BtnAjuda: TcxButton
      Left = 295
      OnClick = BtnAjudaClick
      ExplicitLeft = 295
    end
    inherited BtnInicializar: TcxButton
      Left = 538
      ExplicitLeft = 538
    end
    inherited BtnSalvar: TcxButton
      Left = 342
      ExplicitLeft = 342
    end
    inherited BtnExecutar: TcxButton
      Left = 734
      ExplicitLeft = 734
    end
    inherited BtnLimpar: TcxButton
      Left = 1126
      ExplicitLeft = 1126
    end
    inherited BtnCarregar: TcxButton
      Left = 832
      ExplicitLeft = 832
    end
    inherited BtnAgenda: TcxButton
      Left = 1028
      ExplicitLeft = 1028
    end
    inherited BtnPeriodo: TcxButton
      Left = 930
      ExplicitLeft = 930
    end
    inherited BtnAtualizar: TcxButton
      Left = 1224
      ExplicitLeft = 1224
    end
    inherited BtnGerar: TcxButton
      Left = 1
      Enabled = True
      Visible = True
      OnClick = BtnGerarClick
      ExplicitLeft = 1
    end
    inherited BtnPesquisar: TcxButton
      Left = 440
      ExplicitLeft = 440
    end
    inherited BtnImprimir: TcxButton
      Left = 636
      ExplicitLeft = 636
    end
  end
  inherited PnlCampos: TPanel
    Width = 348
    Height = 66
    ExplicitWidth = 270
    ExplicitHeight = 75
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 340
      Height = 58
      Align = alClient
      Caption = '  Data  '
      TabOrder = 0
      ExplicitWidth = 262
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
