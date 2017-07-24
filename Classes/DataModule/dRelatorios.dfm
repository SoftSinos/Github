object DtmRelatorios: TDtmRelatorios
  OldCreateOrder = False
  Height = 274
  Width = 440
  object CDSRelEmpresa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 268
    Top = 14
  end
  object DBDRelEmpresa: TfrxDBDataset
    UserName = 'DBDRelEmpresa'
    CloseDataSource = False
    DataSet = CDSRelEmpresa
    BCDToCurrency = False
    Left = 354
    Top = 14
  end
  object CDSRelPesquisa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 268
    Top = 64
  end
  object DBDRelPesquisa: TfrxDBDataset
    UserName = 'DBDRelPesquisa'
    CloseDataSource = False
    DataSet = CDSRelPesquisa
    BCDToCurrency = False
    Left = 354
    Top = 64
  end
  object frxReport: TfrxReport
    Version = '4.15.10'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = 'Default'
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42268.484540775500000000
    ReportOptions.LastChange = 42268.592226712960000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 104
    Top = 133
    Datasets = <
      item
        DataSet = DBDRelEmpresa
        DataSetName = 'DBDRelEmpresa'
      end
      item
        DataSet = DBDRelPesquisa
        DataSetName = 'DBDRelPesquisa'
      end>
    Variables = <>
    Style = <
      item
        Name = 'Title'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Header'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
      end
      item
        Name = 'Group header'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftBottom]
      end
      item
        Name = 'Data'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
      end
      item
        Name = 'Group footer'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftTop]
      end
      item
        Name = 'Header line'
        Color = clNone
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = []
        Frame.Typ = [ftBottom]
        Frame.Width = 2.000000000000000000
      end>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object RelEmpresas: TfrxReportTitle
        Height = 45.354360000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        object Memo1: TfrxMemoView
          Align = baWidth
          Width = 1046.929810000000000000
          Height = 37.795300000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = [fsBold, fsItalic]
          Frame.Typ = [ftBottom]
          Frame.Width = 3.000000000000000000
          Memo.UTF8W = (
            'Relat'#243'rio de Empresas')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object PageHeader1: TfrxPageHeader
        Height = 26.456710000000000000
        Top = 86.929190000000000000
        Width = 1046.929810000000000000
        object Memo2: TfrxMemoView
          Top = 18.897650000000000000
          Width = 1046.929346220000000000
          Height = 11.338590000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Frame.Width = 2.000000000000000000
          ParentFont = False
          Style = 'Header line'
        end
        object DBDEmpresaNmRazaoSocial: TfrxMemoView
          Left = 68.031540000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmRazaoSocial'
          DataSet = DBDRelEmpresa
          DataSetName = 'DBDRelEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDEmpresa."NmRazaoSocial"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo3: TfrxMemoView
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Empresa:')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupHeader1: TfrxGroupHeader
        Top = 173.858380000000000000
        Width = 1046.929810000000000000
        Condition = 'DBDPesquisa."IdEmpresa"'
      end
      object MasterData1: TfrxMasterData
        Height = 86.929190000000000000
        Top = 196.535560000000000000
        Width = 1046.929810000000000000
        DataSet = DBDRelPesquisa
        DataSetName = 'DBDRelPesquisa'
        RowCount = 0
        object DBDPesquisaIdEmpresa: TfrxMemoView
          Top = 3.779530000000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'IdEmpresa'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."IdEmpresa"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNmRazaoSocial: TfrxMemoView
          Left = 30.236240000000000000
          Top = 3.779530000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmRazaoSocial'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NmRazaoSocial"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNmFantasia: TfrxMemoView
          Left = 430.866420000000000000
          Top = 3.779530000000000000
          Width = 136.063080000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmFantasia'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NmFantasia"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNrCpfCnpj: TfrxMemoView
          Left = 566.929500000000000000
          Top = 3.779530000000000000
          Width = 98.267780000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NrCpfCnpj'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NrCpfCnpj"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNrCei: TfrxMemoView
          Left = 665.197280000000000000
          Top = 3.779530000000000000
          Width = 113.385900000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NrCei'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NrCei"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNmEndereco: TfrxMemoView
          Top = 22.677180000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmEndereco'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NmEndereco"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNmBairro: TfrxMemoView
          Left = 400.630180000000000000
          Top = 22.677180000000000000
          Width = 128.504020000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmBairro'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NmBairro"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Left = 529.134200000000000000
          Top = 22.677180000000000000
          Width = 15.118120000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            'N'#186)
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNrNumero: TfrxMemoView
          Left = 544.252320000000000000
          Top = 22.677180000000000000
          Width = 45.354360000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NrNumero'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NrNumero"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNmComplemento: TfrxMemoView
          Left = 593.386210000000000000
          Top = 22.677180000000000000
          Width = 453.543600000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmComplemento'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NmComplemento"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNmSitio: TfrxMemoView
          Left = 774.803650000000000000
          Top = 3.779530000000000000
          Width = 272.126160000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmSitio'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NmSitio"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNmCidade: TfrxMemoView
          Top = 41.574830000000000000
          Width = 139.842610000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmCidade'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NmCidade"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNmUf: TfrxMemoView
          Left = 139.842610000000000000
          Top = 41.574830000000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmUf'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NmUf"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNrTelefone: TfrxMemoView
          Left = 173.858380000000000000
          Top = 41.574830000000000000
          Width = 90.708720000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NrTelefone'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NrTelefone"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNmEmail: TfrxMemoView
          Left = 268.346630000000000000
          Top = 41.574830000000000000
          Width = 400.630180000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmEmail'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NmEmail"]')
          ParentFont = False
          VAlign = vaCenter
        end
        object DBDPesquisaNmComplemento1: TfrxMemoView
          Top = 64.252010000000000000
          Width = 1046.929810000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmComplemento'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDPesquisa."NmComplemento"]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GroupFooter1: TfrxGroupFooter
        Top = 306.141930000000000000
        Width = 1046.929810000000000000
      end
      object PageFooter1: TfrxPageFooter
        Height = 79.370130000000000000
        Top = 366.614410000000000000
        Width = 1046.929810000000000000
        object Memo40: TfrxMemoView
          Align = baWidth
          Width = 1046.929810000000000000
          ShowHint = False
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
        end
        object Memo41: TfrxMemoView
          Top = 1.000000000000000000
          Height = 22.677180000000000000
          ShowHint = False
          AutoWidth = True
          Memo.UTF8W = (
            '[Date] [Time]')
        end
        object Memo42: TfrxMemoView
          Align = baRight
          Left = 971.339210000000000000
          Top = 1.000000000000000000
          Width = 75.590600000000000000
          Height = 22.677180000000000000
          ShowHint = False
          HAlign = haRight
          Memo.UTF8W = (
            'Page [Page#]')
        end
      end
      object ImLogoTipo: TfrxPictureView
        Align = baRight
        Left = 914.646260000000000000
        Width = 132.283550000000000000
        Height = 34.015770000000000000
        Hint = '.Br Sistemas.'
        ShowHint = True
        Center = True
        DataField = 'ImLogoTipo'
        DataSet = DBDRelEmpresa
        DataSetName = 'DBDRelEmpresa'
        URL = 'www.BRSISTEMAS.inf.br'
        HightQuality = True
        Transparent = True
        TransparentColor = clWhite
      end
    end
  end
  object frxPDFExport: TfrxPDFExport
    ShowDialog = False
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    CheckboxAsShape = False
    Left = 36
    Top = 20
  end
  object frxXLSExport: TfrxXLSExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    ExportEMF = True
    AsText = False
    Background = True
    FastExport = True
    PageBreaks = True
    EmptyLines = True
    SuppressPageHeadersFooters = True
    Left = 106
    Top = 21
  end
  object frxRTFExport: TfrxRTFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PictureType = gpPNG
    Wysiwyg = True
    Creator = 'FastReport'
    SuppressPageHeadersFooters = True
    HeaderFooterMode = hfText
    AutoSize = False
    Left = 174
    Top = 21
  end
  object CDSAux1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPAux1'
    Left = 267
    Top = 112
  end
  object DBDAux1: TfrxDBDataset
    UserName = 'DBDAux1'
    CloseDataSource = False
    DataSet = CDSAux1
    BCDToCurrency = False
    Left = 353
    Top = 112
  end
  object CDSAux2: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPAux2'
    Left = 267
    Top = 161
  end
  object DBDAux2: TfrxDBDataset
    UserName = 'DBDAux2'
    CloseDataSource = False
    DataSet = CDSAux2
    BCDToCurrency = False
    Left = 353
    Top = 162
  end
  object CDSAux3: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPAux3'
    Left = 267
    Top = 213
  end
  object DBDAux3: TfrxDBDataset
    UserName = 'DBDAux3'
    CloseDataSource = False
    DataSet = CDSAux3
    BCDToCurrency = False
    Left = 353
    Top = 212
  end
  object frxChart: TfrxChartObject
    Left = 104
    Top = 74
  end
end
