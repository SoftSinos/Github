inherited FrmOperacaoFinanceira: TFrmOperacaoFinanceira
  Caption = 'FrmOperacaoFinanceira'
  ClientHeight = 211
  ClientWidth = 356
  ExplicitWidth = 362
  PixelsPerInch = 96
  TextHeight = 13
  inherited StbPrincipal: TStatusBar
    Top = 189
    Width = 350
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitWidth = 1140
  end
  inherited PnlPrincipal: TPanel
    Width = 350
    ExplicitWidth = 1140
    inherited BtnFechar: TcxButton
      Left = 197
      ExplicitLeft = 197
      ExplicitTop = 4
    end
    inherited BtnAjuda: TcxButton
      Left = 295
      ExplicitLeft = 265
    end
    inherited BtnInicializar: TcxButton
      Left = 440
    end
    inherited BtnSalvar: TcxButton
      Left = 636
      ExplicitLeft = 295
    end
    inherited BtnExecutar: TcxButton
      Left = 734
      ExplicitLeft = 393
    end
    inherited BtnLimpar: TcxButton
      Left = 342
      ExplicitLeft = 393
    end
    inherited BtnCarregar: TcxButton
      Left = 832
      ExplicitLeft = 491
    end
    inherited BtnAgenda: TcxButton
      Left = 1028
      ExplicitLeft = 687
    end
    inherited BtnPeriodo: TcxButton
      Left = 930
      ExplicitLeft = 589
    end
    inherited BtnAtualizar: TcxButton
      Left = 99
      Enabled = True
      Visible = True
      ExplicitLeft = -2
      ExplicitTop = 4
    end
    inherited BtnGerar: TcxButton
      Left = 1
      Enabled = True
      Visible = True
      ExplicitLeft = -21
    end
    inherited BtnPesquisar: TcxButton
      Left = 538
    end
  end
  inherited PnlCampos: TPanel
    Width = 350
    Height = 132
    ExplicitWidth = 1140
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 342
      Height = 61
      Align = alTop
      Caption = '  Caixa Atual  '
      TabOrder = 0
      ExplicitWidth = 440
      object Label3: TLabel
        Left = 22
        Top = 25
        Width = 110
        Height = 19
        Caption = 'Valor Caixa R$:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object EdtVlGeral: TcxTextEdit
        Left = 138
        Top = 17
        Enabled = False
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -20
        Style.Font.Name = 'Verdana'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        TextHint = '0,00'
        Width = 124
      end
    end
    object GrbOperacao: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 71
      Width = 342
      Height = 57
      Align = alClient
      Caption = '  FrmOperacaoFinanceira  '
      TabOrder = 1
      ExplicitTop = 75
      object LblValor: TLabel
        Left = 65
        Top = 25
        Width = 67
        Height = 19
        Alignment = taRightJustify
        BiDiMode = bdLeftToRight
        Caption = 'Valor R$:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
      end
      object cxTextEdit1: TcxTextEdit
        Left = 138
        Top = 17
        ParentFont = False
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -20
        Style.Font.Name = 'Verdana'
        Style.Font.Style = []
        Style.IsFontAssigned = True
        TabOrder = 0
        TextHint = '0,00'
        Width = 124
      end
    end
  end
end