inherited FrmPainelDiario: TFrmPainelDiario
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Painel Di'#225'rio Agendamento'
  ClientHeight = 412
  ClientWidth = 1003
  ExplicitWidth = 1003
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 13
  inherited StbPrincipal: TStatusBar
    Top = 390
    Width = 997
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 390
    ExplicitWidth = 1024
  end
  inherited PnlPrincipal: TPanel
    Width = 997
    Color = clWhite
    ParentBackground = False
    ExplicitWidth = 1024
    inherited BtnFechar: TcxButton
      Left = 316
      TabOrder = 3
      ExplicitLeft = 420
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAjuda: TcxButton
      Left = 420
      TabOrder = 4
      OnClick = BtnAjudaClick
      ExplicitLeft = 524
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnInicializar: TcxButton
      Left = 681
      TabOrder = 9
      ExplicitLeft = 681
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnSalvar: TcxButton
      Left = 889
      TabOrder = 5
      ExplicitLeft = 889
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnExecutar: TcxButton
      Left = 993
      TabOrder = 6
      ExplicitLeft = 993
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnLimpar: TcxButton
      Left = 577
      TabOrder = 7
      ExplicitLeft = 577
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnCarregar: TcxButton
      Left = 785
      TabOrder = 8
      ExplicitLeft = 785
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAgenda: TcxButton
      Left = 108
      Enabled = True
      TabOrder = 0
      Visible = True
      OnClick = BtnAgendaClick
      ExplicitLeft = 4
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnPeriodo: TcxButton
      Left = 212
      Enabled = True
      TabOrder = 1
      Visible = True
      OnClick = BtnPeriodoClick
      ExplicitLeft = 193
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAtualizar: TcxButton
      Left = 4
      Enabled = True
      TabOrder = 2
      Visible = True
      OnClick = BtnAtualizarClick
      ExplicitLeft = 4
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnGerar: TcxButton
      Left = 473
      ExplicitLeft = 532
      ExplicitTop = 10
      ExplicitHeight = 38
    end
  end
  inherited PnlCampos: TPanel
    Width = 997
    Height = 302
    ExplicitWidth = 1024
    ExplicitHeight = 302
    object StgGrid: TStringGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 989
      Height = 294
      Align = alClient
      BevelWidth = 5
      Color = clWhite
      ColCount = 1
      DefaultColWidth = 110
      DefaultRowHeight = 70
      DrawingStyle = gdsGradient
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      GradientEndColor = clBtnFace
      GridLineWidth = 3
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnDrawCell = StgGridDrawCell
      ExplicitWidth = 1016
    end
  end
  object PrbPesquisa: TProgressBar
    AlignWithMargins = True
    Left = 3
    Top = 367
    Width = 997
    Height = 17
    Align = alBottom
    TabOrder = 3
    ExplicitWidth = 1024
  end
  object CdsHorarios: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 550
    Top = 91
  end
  object CdsProfissionais: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 550
    Top = 187
  end
  object CdsAgenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 552
    Top = 138
  end
end
