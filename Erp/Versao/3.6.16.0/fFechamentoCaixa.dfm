inherited FrmFechamentoCaixa: TFrmFechamentoCaixa
  Caption = 'Fechamento de Caixa'
  ClientHeight = 376
  ClientWidth = 653
  ExplicitWidth = 659
  ExplicitHeight = 405
  PixelsPerInch = 96
  TextHeight = 13
  inherited StbPrincipal: TStatusBar
    Top = 354
    Width = 647
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 354
    ExplicitWidth = 647
  end
  inherited PnlPrincipal: TPanel
    Width = 647
    ExplicitWidth = 647
    inherited BtnFechar: TcxButton
      Left = 491
      ExplicitLeft = 491
    end
    inherited BtnAjuda: TcxButton
      Left = 589
      ExplicitLeft = 589
    end
    inherited BtnInicializar: TcxButton
      Left = 636
      ExplicitLeft = 636
    end
    inherited BtnSalvar: TcxButton
      Left = 832
      ExplicitLeft = 832
    end
    inherited BtnExecutar: TcxButton
      Left = 930
      ExplicitLeft = 930
    end
    inherited BtnLimpar: TcxButton
      Left = 1224
      ExplicitLeft = 1224
    end
    inherited BtnCarregar: TcxButton
      Left = 197
      Enabled = True
      Visible = True
      ExplicitLeft = 197
    end
    inherited BtnAgenda: TcxButton
      Left = 1126
      ExplicitLeft = 1126
    end
    inherited BtnPeriodo: TcxButton
      Left = 1028
      ExplicitLeft = 1028
    end
    inherited BtnAtualizar: TcxButton
      Left = 295
      Enabled = True
      Visible = True
      ExplicitLeft = 295
    end
    inherited BtnGerar: TcxButton
      Left = 99
      Enabled = True
      Visible = True
    end
    inherited BtnPesquisar: TcxButton
      Left = 734
      ExplicitLeft = 734
    end
    inherited BtnImprimir: TcxButton
      Visible = True
      ExplicitLeft = 393
    end
    inherited cxButton1: TcxButton
      Left = 1
      Caption = '&Encerrar'
      ExplicitLeft = 1
    end
  end
  inherited PnlCampos: TPanel
    Width = 647
    Height = 297
    ExplicitWidth = 647
    ExplicitHeight = 297
    object GroupBox1: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 639
      Height = 63
      Align = alTop
      Caption = '  Caixa  '
      TabOrder = 0
      object Label2: TLabel
        Left = 33
        Top = 19
        Width = 49
        Height = 13
        Caption = '* Usu'#225'rio:'
      end
      object Label9: TLabel
        Left = 17
        Top = 38
        Width = 65
        Height = 13
        Caption = '* Movimento:'
      end
      object LblSnFinalizada: TLabel
        Left = 245
        Top = 37
        Width = 183
        Height = 19
        Caption = 'Caixa Aberto/Fechado'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object CbbIdEmpresa: TcxComboBox
        Left = 83
        Top = 15
        Properties.DropDownListStyle = lsFixedList
        TabOrder = 0
        Width = 325
      end
      object BtnEmpresaPesquisa: TcxButton
        Left = 407
        Top = 15
        Width = 21
        Height = 21
        BiDiMode = bdLeftToRight
        LookAndFeel.Kind = lfUltraFlat
        LookAndFeel.NativeStyle = True
        OptionsImage.Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF004E4E4E004E4E4E004E4E4E104E4E4E1A4E4E4E1F4E4E
          4E164E4E4E084E4E4E004E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF004E4E4E004E4E4E174E4E4E334E4E4E334E4E4E334E4E
          4E334E4E4E324E4E4E034E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF004E4E4E064E4E4E204E4E4EFF4E4E4EFF4E4E
          4E274E4E4E17FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
          4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF004E4E4E004E4E4E004E4E4E004E4E4E004E4E4EFF4E4E4EFF4E4E
          4E004E4E4E004E4E4E004E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF004E4E4E004E4E4E004E4E4E004E4E4E004E4E4EFF4E4E4EFF4E4E
          4E004E4E4E004E4E4E004E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF004E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E
          4EFF4E4E4EFF4E4E4EFF4E4E4EFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF004E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E
          4EFF4E4E4EFF4E4E4EFF4E4E4EFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
          4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
          4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
          4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
          4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        OptionsImage.Layout = blGlyphBottom
        PaintStyle = bpsGlyph
        ParentBiDiMode = False
        ParentShowHint = False
        PopupAlignment = paCenter
        ShowHint = False
        TabOrder = 1
        TabStop = False
      end
      object DtpDtPeriodoInicio: TcxDateEdit
        Left = 83
        Top = 35
        Properties.AssignedValues.DisplayFormat = True
        Properties.DateButtons = []
        Properties.DateOnError = deNull
        TabOrder = 2
        Width = 96
      end
    end
    object GroupBox2: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 73
      Width = 639
      Height = 220
      Align = alClient
      Caption = '  Lista  '
      TabOrder = 1
      object DbgPagamento: TDBGrid
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 629
        Height = 197
        Align = alClient
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'IdTpPagamento'
            Visible = False
          end
          item
            Expanded = False
            FieldName = 'NmTpPagamento'
            Title.Alignment = taCenter
            Title.Caption = 'Tipo de Pagamento'
            Width = 209
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'VlPagamento'
            Title.Alignment = taCenter
            Title.Caption = 'Valor Caixa'
            Width = 95
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QtdNotaPagamento'
            Title.Alignment = taCenter
            Title.Caption = 'Gaveta de Caixa'
            Width = 95
            Visible = True
          end
          item
            Expanded = False
            Title.Alignment = taCenter
            Title.Caption = 'Resultado'
            Width = 95
            Visible = True
          end>
      end
    end
  end
end
