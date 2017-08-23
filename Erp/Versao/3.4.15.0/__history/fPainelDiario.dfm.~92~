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
    ExplicitWidth = 997
  end
  inherited PnlPrincipal: TPanel
    Width = 997
    Color = clWhite
    ParentBackground = False
    ExplicitWidth = 997
    inherited BtnFechar: TcxButton
      Left = 295
      TabOrder = 3
      ExplicitLeft = 295
      ExplicitTop = 1
      ExplicitHeight = 36
    end
    inherited BtnAjuda: TcxButton
      Left = 393
      TabOrder = 4
      OnClick = BtnAjudaClick
      ExplicitLeft = 393
      ExplicitTop = 1
      ExplicitHeight = 36
    end
    inherited BtnInicializar: TcxButton
      Left = 636
      TabOrder = 9
      ExplicitLeft = 636
      ExplicitTop = 1
      ExplicitHeight = 36
    end
    inherited BtnSalvar: TcxButton
      Left = 832
      TabOrder = 5
      ExplicitLeft = 832
      ExplicitTop = 1
      ExplicitHeight = 36
    end
    inherited BtnExecutar: TcxButton
      Left = 930
      TabOrder = 6
      ExplicitLeft = 930
      ExplicitTop = 1
      ExplicitHeight = 36
    end
    inherited BtnLimpar: TcxButton
      Left = 538
      TabOrder = 7
      ExplicitLeft = 538
      ExplicitTop = 1
      ExplicitHeight = 36
    end
    inherited BtnCarregar: TcxButton
      Left = 734
      TabOrder = 8
      ExplicitLeft = 734
      ExplicitTop = 1
      ExplicitHeight = 36
    end
    inherited BtnAgenda: TcxButton
      Left = 99
      Enabled = True
      TabOrder = 0
      Visible = True
      OnClick = BtnAgendaClick
      ExplicitLeft = 99
      ExplicitTop = 1
      ExplicitHeight = 36
    end
    inherited BtnPeriodo: TcxButton
      Left = 197
      Enabled = True
      TabOrder = 1
      Visible = True
      OnClick = BtnPeriodoClick
      ExplicitLeft = 197
      ExplicitTop = 1
      ExplicitHeight = 36
    end
    inherited BtnAtualizar: TcxButton
      Left = 1
      Enabled = True
      TabOrder = 2
      Visible = True
      OnClick = BtnAtualizarClick
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitHeight = 36
    end
    inherited BtnGerar: TcxButton
      Left = 440
      ExplicitLeft = 440
      ExplicitTop = 1
      ExplicitHeight = 36
    end
  end
  inherited PnlCampos: TPanel
    Width = 997
    Height = 310
    ExplicitTop = 51
    ExplicitWidth = 997
    ExplicitHeight = 310
    object StgGrid: TStringGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 989
      Height = 302
      Align = alClient
      BevelWidth = 5
      Color = clWhite
      ColCount = 1
      DefaultColWidth = 115
      DefaultRowHeight = 80
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
