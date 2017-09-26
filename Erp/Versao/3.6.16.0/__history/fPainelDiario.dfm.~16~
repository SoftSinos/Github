inherited FrmPainelDiario: TFrmPainelDiario
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Painel Di'#225'rio Agendamento'
  ClientHeight = 412
  ClientWidth = 1093
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
      Left = 491
      TabOrder = 4
      ExplicitLeft = 491
    end
    inherited BtnAjuda: TcxButton
      Left = 687
      TabOrder = 5
      OnClick = BtnAjudaClick
      ExplicitLeft = 687
    end
    inherited BtnInicializar: TcxButton
      Left = 930
      TabOrder = 10
      ExplicitLeft = 930
    end
    inherited BtnSalvar: TcxButton
      Left = 1126
      TabOrder = 7
      ExplicitLeft = 1126
    end
    inherited BtnExecutar: TcxButton
      Left = 1224
      TabOrder = 8
      ExplicitLeft = 1224
    end
    inherited BtnLimpar: TcxButton
      Left = 832
      TabOrder = 6
      ExplicitLeft = 832
    end
    inherited BtnCarregar: TcxButton
      Left = 1028
      TabOrder = 9
      ExplicitLeft = 1028
    end
    inherited BtnAgenda: TcxButton
      Left = 295
      Enabled = True
      TabOrder = 2
      Visible = True
      OnClick = BtnAgendaClick
      ExplicitLeft = 295
    end
    inherited BtnPeriodo: TcxButton
      Left = 393
      Enabled = True
      TabOrder = 3
      Visible = True
      OnClick = BtnPeriodoClick
      ExplicitLeft = 393
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
      Left = 734
      TabOrder = 11
      ExplicitLeft = 734
    end
    inherited BtnPesquisar: TcxButton
      Left = 99
      Enabled = True
      TabOrder = 1
      Visible = True
      OnClick = BtnPesquisarClick
      ExplicitLeft = 99
    end
    inherited BtnImprimir: TcxButton
      Left = 589
      ExplicitLeft = 589
    end
    inherited cxButton1: TcxButton
      Left = 197
      ExplicitLeft = 197
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
