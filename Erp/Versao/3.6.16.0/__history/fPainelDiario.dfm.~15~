inherited FrmPainelDiario: TFrmPainelDiario
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Painel Di'#225'rio Agendamento'
  ClientHeight = 412
  ClientWidth = 1093
  ExplicitLeft = 8
  ExplicitWidth = 1093
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 13
  inherited StbPrincipal: TStatusBar
    Top = 390
    Width = 1087
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
    ExplicitWidth = 1087
  end
  inherited PnlPrincipal: TPanel
    Width = 1087
    Color = clWhite
    ParentBackground = False
    ExplicitWidth = 1087
    inherited BtnFechar: TcxButton
      Left = 393
      TabOrder = 4
      ExplicitLeft = 393
    end
    inherited BtnAjuda: TcxButton
      Left = 491
      TabOrder = 5
      OnClick = BtnAjudaClick
      ExplicitLeft = 491
    end
    inherited BtnInicializar: TcxButton
      Left = 734
      TabOrder = 10
      ExplicitLeft = 734
    end
    inherited BtnSalvar: TcxButton
      Left = 930
      TabOrder = 7
      ExplicitLeft = 930
    end
    inherited BtnExecutar: TcxButton
      Left = 1028
      TabOrder = 8
      ExplicitLeft = 1028
    end
    inherited BtnLimpar: TcxButton
      Left = 636
      TabOrder = 6
      ExplicitLeft = 636
    end
    inherited BtnCarregar: TcxButton
      Left = 832
      TabOrder = 9
      ExplicitLeft = 832
    end
    inherited BtnAgenda: TcxButton
      Left = 197
      Enabled = True
      TabOrder = 2
      Visible = True
      OnClick = BtnAgendaClick
      ExplicitLeft = 99
    end
    inherited BtnPeriodo: TcxButton
      Left = 295
      Enabled = True
      TabOrder = 3
      Visible = True
      OnClick = BtnPeriodoClick
      ExplicitLeft = 197
    end
    inherited BtnAtualizar: TcxButton
      Left = 1
      Enabled = True
      TabOrder = 0
      Visible = True
      OnClick = BtnAtualizarClick
      ExplicitLeft = 1
    end
    inherited BtnGerar: TcxButton
      Left = 538
      TabOrder = 11
      ExplicitLeft = 538
    end
    inherited BtnPesquisar: TcxButton
      Left = 99
      Enabled = True
      TabOrder = 1
      Visible = True
      OnClick = BtnPesquisarClick
      ExplicitLeft = 93
      ExplicitTop = 4
    end
  end
  inherited PnlCampos: TPanel
    Width = 1087
    Height = 310
    ExplicitWidth = 1087
    ExplicitHeight = 310
    object StgGrid: TStringGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 1079
      Height = 302
      Align = alClient
      BevelWidth = 5
      ColCount = 1
      DefaultColWidth = 200
      DefaultRowHeight = 85
      DrawingStyle = gdsGradient
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
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
    Width = 1087
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
