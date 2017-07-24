object FrmCriacaoRelatorios: TFrmCriacaoRelatorios
  Left = 0
  Top = 0
  Caption = 'Criar Relatorios'
  ClientHeight = 362
  ClientWidth = 509
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FDConnection: TFDConnection
    Params.Strings = (
      'SERVER=localhost'
      'Database=SoftSinosERP'
      'USER_NAME=SoftSinos'
      'Password=.SS@2017'
      'DriverID=MSSQL')
    Connected = True
    LoginPrompt = False
    Left = 48
    Top = 23
  end
  object QRYRelEmpresa: TFDQuery
    ConstraintsEnabled = True
    Connection = FDConnection
    SQL.Strings = (
      'Select * From VW_GridEmpresa')
    Left = 144
    Top = 23
  end
  object CDSRelEmpresa: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPRelEmpresa'
    Left = 145
    Top = 78
  end
  object DSPRelEmpresa: TDataSetProvider
    DataSet = QRYRelEmpresa
    Left = 224
    Top = 24
  end
  object DBDRelEmpresa: TfrxDBDataset
    UserName = 'DBDRelEmpresa'
    CloseDataSource = False
    DataSet = CDSRelEmpresa
    BCDToCurrency = False
    Left = 223
    Top = 78
  end
  object QRYRelPesquisa: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      
        '  Exec PC_FastCurvaTipoPagamento 1, '#39'2017/01/01'#39', '#39'2017/12/31'#39', ' +
        #39'Periodo'#39)
    Left = 336
    Top = 25
  end
  object CDSRelPesquisa: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPRelPesquisa'
    Left = 337
    Top = 80
  end
  object DSPRelPesquisa: TDataSetProvider
    DataSet = QRYRelPesquisa
    Left = 418
    Top = 25
  end
  object DBDRelPesquisa: TfrxDBDataset
    UserName = 'DBDRelPesquisa'
    CloseDataSource = False
    DataSet = CDSRelPesquisa
    BCDToCurrency = False
    Left = 417
    Top = 80
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
    ReportOptions.LastChange = 42937.950065833300000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'begin'
      ''
      'end.')
    Left = 424
    Top = 280
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
      LeftMargin = 5.000000000000000000
      RightMargin = 5.000000000000000000
      TopMargin = 5.000000000000000000
      BottomMargin = 5.000000000000000000
      object PesquisaImpressaoProduto: TfrxReportTitle
        Height = 90.149660000000000000
        Top = 18.897650000000000000
        Width = 1084.725110000000000000
        object DBDRelEmpresaNmEndereco: TfrxMemoView
          Left = 154.960730000000000000
          Top = 20.456710000000000000
          Width = 755.906000000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = DBDRelEmpresa
          DataSetName = 'DBDRelEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Width = 2.000000000000000000
          Memo.UTF8W = (
            
              '[DBDRelEmpresa."NmEndereco"], N'#186' [DBDRelEmpresa."NrNumero"] - [D' +
              'BDRelEmpresa."NmBairro"] - [DBDRelEmpresa."NmCidade"]/[DBDRelEmp' +
              'resa."NmSiglaUf"]')
          ParentFont = False
        end
        object DBDRelEmpresaNrTelefone: TfrxMemoView
          Left = 154.960730000000000000
          Top = 36.574830000000000000
          Width = 400.630180000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = DBDRelEmpresa
          DataSetName = 'DBDRelEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Width = 2.000000000000000000
          Memo.UTF8W = (
            '[DBDRelEmpresa."NrTelefone"] - [DBDRelEmpresa."NmSitio"]')
          ParentFont = False
        end
        object DBDEmpresaNmRazaoSocial: TfrxMemoView
          Left = 154.960730000000000000
          Top = 5.559060000000000000
          Width = 755.906000000000000000
          Height = 15.118120000000000000
          ShowHint = False
          DataSet = DBDRelEmpresa
          DataSetName = 'DBDRelEmpresa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Width = 2.000000000000000000
          Memo.UTF8W = (
            '[DBDRelEmpresa."NmRazaoSocial"] - [DBDRelEmpresa."NmFantasia"]')
          ParentFont = False
          VAlign = vaBottom
        end
        object Memo3: TfrxMemoView
          Align = baWidth
          Top = 35.118120000000000000
          Width = 1084.725110000000000000
          Height = 22.677180000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Typ = [ftBottom]
          Frame.Width = 3.000000000000000000
          ParentFont = False
        end
        object Memo1: TfrxMemoView
          Left = 661.417750000000000000
          Width = 423.307360000000000000
          Height = 34.015770000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Width = 2.000000000000000000
          HAlign = haRight
          Memo.UTF8W = (
            'Curva ABC Tipos de Pagamentos')
          ParentFont = False
        end
        object Memo22: TfrxMemoView
          Align = baWidth
          Top = 86.370130000000000000
          Width = 1084.725110000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Frame.Width = 1.500000000000000000
          ParentFont = False
        end
        object DBDRelPesquisaDtInicioEntrada: TfrxMemoView
          Left = 52.913420000000000000
          Top = 63.913420000000000000
          Width = 68.031540000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'DtInicioEntrada'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDRelPesquisa."DtInicioEntrada"]')
          ParentFont = False
        end
        object DBDRelPesquisaDtFinalEntrada: TfrxMemoView
          Left = 149.181156060000000000
          Top = 63.913420000000000000
          Width = 68.031496060000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'DtFinalEntrada'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8W = (
            '[DBDRelPesquisa."DtFinalEntrada"]')
          ParentFont = False
        end
        object Memo24: TfrxMemoView
          Top = 63.913420000000000000
          Width = 52.913420000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8W = (
            'Per'#237'odo:')
          ParentFont = False
        end
        object Memo25: TfrxMemoView
          Left = 124.724490000000000000
          Top = 63.913420000000000000
          Width = 22.677180000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8W = (
            'at'#233)
          ParentFont = False
        end
      end
      object PghNmTitulos: TfrxPageHeader
        Height = 30.236240000000000000
        Top = 132.283550000000000000
        Width = 1084.725110000000000000
        object Memo8: TfrxMemoView
          Left = 76.590600000000000000
          Top = 3.779530000000000000
          Width = 234.330860000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Tipo de Pagamento')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Align = baWidth
          Top = 26.456710000000000000
          Width = 1084.725110000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Frame.Width = 1.500000000000000000
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 313.700990000000000000
          Top = 3.779530000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Valor')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 404.409710000000000000
          Top = 3.779530000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Participa'#231#227'o')
          ParentFont = False
        end
        object Memo10: TfrxMemoView
          Top = 3.779530000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Data')
          ParentFont = False
        end
      end
      object MtdDados1: TfrxMasterData
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -9
        Font.Name = 'Arial'
        Font.Style = []
        Height = 18.897650000000000000
        ParentFont = False
        Top = 272.126160000000000000
        Width = 1084.725110000000000000
        DataSet = DBDRelPesquisa
        DataSetName = 'DBDRelPesquisa'
        RowCount = 0
        object DBDRelPesquisaNmTpPagamento: TfrxMemoView
          Left = 75.590600000000000000
          Top = 2.779530000000000000
          Width = 234.330860000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmTpPagamento'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Memo.UTF8W = (
            '[DBDRelPesquisa."NmTpPagamento"]')
        end
        object DBDRelPesquisaVlPagamentos: TfrxMemoView
          Left = 313.700990000000000000
          Top = 2.779530000000000000
          Width = 86.929190000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          DisplayFormat.FormatStr = '%2.2m'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '[DBDRelPesquisa."VlPagamentos"]')
        end
        object DBDRelPesquisaPcParticipacao: TfrxMemoView
          Left = 404.409710000000000000
          Top = 3.000000000000000000
          Width = 26.456710000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          HAlign = haRight
          Memo.UTF8W = (
            '[DBDRelPesquisa."PcParticipacao"]')
        end
        object Memo23: TfrxMemoView
          Left = 432.425480000000000000
          Top = 2.779530000000000000
          Width = 18.897650000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          DisplayFormat.FormatStr = '%g'
          DisplayFormat.Kind = fkNumeric
          Memo.UTF8W = (
            '%')
        end
        object DBDRelPesquisaDtCadastro: TfrxMemoView
          Top = 3.000000000000000000
          Width = 71.811070000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          DisplayFormat.FormatStr = 'dd/MM/yyyy'
          DisplayFormat.Kind = fkDateTime
          Memo.UTF8W = (
            '[DBDRelPesquisa."DtCadastro"]')
        end
      end
      object PgfNmRodape: TfrxPageFooter
        Height = 83.149660000000000000
        Top = 400.630180000000000000
        Width = 1084.725110000000000000
        object Memo2: TfrxMemoView
          Align = baRight
          Left = 793.701300000000000000
          Top = 3.779530000000000000
          Width = 291.023810000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clGray
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'SginERP - "Sistema de Gest'#227'o Integrado - ERP"')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo40: TfrxMemoView
          Align = baWidth
          Top = 3.779530000000000000
          Width = 1084.725110000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          ParentFont = False
        end
        object Memo42: TfrxMemoView
          Align = baRight
          Left = 835.276130000000000000
          Top = 23.677180000000000000
          Width = 249.448980000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Pagina [Page#] de [TotalPages#]')
          ParentFont = False
          VAlign = vaCenter
        end
        object Memo4: TfrxMemoView
          Align = baRight
          Left = 835.276130000000000000
          Top = 62.252010000000000000
          Width = 249.448980000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsItalic]
          HAlign = haRight
          Memo.UTF8W = (
            'Acesso: Alt: 6 - 1 - 1 | Vers'#227'o: 01.00.00.00')
          ParentFont = False
        end
        object Time: TfrxMemoView
          Align = baRight
          Left = 793.701300000000000000
          Top = 42.574830000000000000
          Width = 291.023810000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8W = (
            'Emitido em [Date] '#224's [Time]')
          ParentFont = False
        end
        object Memo6: TfrxMemoView
          Top = 52.913390710000000000
          Width = 245.669450000000000000
          Height = 30.236240000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Memo.UTF8W = (
            'SoftSinos Inform'#225'tica'
            'Desenvolvendo Ideias, Criando Solu'#231#245'es.')
          ParentFont = False
          VAlign = vaCenter
        end
        object ImSoftHouse: TfrxPictureView
          Align = baLeft
          ShiftMode = smDontShift
          Top = 5.133855830000000000
          Width = 154.960730000000000000
          Height = 49.133890000000000000
          ShowHint = False
          DataField = 'ImLogoTipoSoftHouse'
          DataSet = DBDRelEmpresa
          DataSetName = 'DBDRelEmpresa'
          URL = 'www.softsinos.com.br'
          HightQuality = False
          Transparent = True
          TransparentColor = clWhite
        end
      end
      object LogoMarcaEmpresa: TfrxPictureView
        ShiftMode = smDontShift
        Width = 154.960730000000000000
        Height = 49.133890000000000000
        ShowHint = False
        DataField = 'ImLogoTipo'
        DataSet = DBDRelEmpresa
        DataSetName = 'DBDRelEmpresa'
        HightQuality = False
        Transparent = True
        TransparentColor = clWhite
      end
      object ClnResumo: TfrxColumnFooter
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        Height = 26.456710000000000000
        ParentFont = False
        Top = 351.496290000000000000
        Width = 1084.725110000000000000
        object Memo17: TfrxMemoView
          Align = baWidth
          Top = 2.000000000000000000
          Width = 1084.725110000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Frame.Width = 2.000000000000000000
          ParentFont = False
        end
        object Memo18: TfrxMemoView
          Top = 2.000000000000000000
          Width = 117.165430000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Memo.UTF8W = (
            'Total de Registros')
          ParentFont = False
          VAlign = vaCenter
        end
        object Line: TfrxMemoView
          Left = 118.165430000000000000
          Top = 2.000000000000000000
          Width = 79.370130000000000000
          Height = 18.897650000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Verdana'
          Font.Style = []
          Frame.Width = 3.000000000000000000
          Memo.UTF8W = (
            '[Line]')
          ParentFont = False
          VAlign = vaCenter
        end
      end
      object GphNmEmpresa: TfrxGroupHeader
        Height = 26.456710000000000000
        Top = 222.992270000000000000
        Width = 1084.725110000000000000
        Condition = 'DBDRelPesquisa."IdEmpresa"'
        object DBDRelPesquisaNmFantasiaNmRazaoSocial: TfrxMemoView
          Left = 68.031540000000000000
          Top = 3.023622050000000000
          Width = 393.071120000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'NmFantasiaNmRazaoSocial'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Memo.UTF8W = (
            '[DBDRelPesquisa."NmFantasiaNmRazaoSocial"]')
        end
        object DBDRelPesquisaIdEmpresa: TfrxMemoView
          Left = 3.779530000000000000
          Top = 3.023622050000000000
          Width = 30.236240000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataField = 'IdEmpresa'
          DataSet = DBDRelPesquisa
          DataSetName = 'DBDRelPesquisa'
          Memo.UTF8W = (
            '[DBDRelPesquisa."IdEmpresa"]')
        end
        object Memo9: TfrxMemoView
          Align = baWidth
          Top = 24.677180000000000000
          Width = 1084.725110000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Height = -13
          Font.Name = 'Verdana'
          Font.Style = [fsBold]
          Frame.Typ = [ftTop]
          Frame.Width = 1.500000000000000000
          ParentFont = False
        end
      end
    end
  end
  object frxTextExport: TfrxSimpleTextExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Frames = False
    EmptyLines = False
    OEMCodepage = False
    DeleteEmptyColumns = True
    Left = 186
    Top = 280
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
    Left = 158
    Top = 280
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
    Left = 130
    Top = 280
  end
  object frxXMLExport: TfrxXMLExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Background = True
    Creator = 'FastReport'
    EmptyLines = True
    SuppressPageHeadersFooters = False
    RowsCount = 0
    Split = ssNotSplit
    Left = 104
    Top = 280
  end
  object frxMailExport: TfrxMailExport
    FileName = 'Funcionario'
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    CreationTime = 42294.933111041670000000
    DataOnly = False
    Subject = 'Funcionario'
    ShowExportDialog = True
    FromMail = 'clauber.junio@gmail.com'
    FromName = 'Clauber J'#250'nio'
    FromCompany = 'Gmail'
    SmtpHost = 'smtp.brsistemas.inf.br'
    SmtpPort = 587
    Login = 'clauber.galvao@brsistemas.inf.br'
    Password = '12qwaszx'
    UseIniFile = True
    TimeOut = 60
    ConfurmReading = False
    UseMAPI = True
    Left = 77
    Top = 280
  end
  object frxCSVExport: TfrxCSVExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    Separator = ';'
    OEMCodepage = False
    NoSysSymbols = True
    ForcedQuotes = False
    Left = 49
    Top = 280
  end
  object frxPDFExport: TfrxPDFExport
    FileName = 'D:\RelPesqImpPessoas.pdf'
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    CreationTime = 42906.667874953700000000
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 100
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
    Left = 20
    Top = 279
  end
  object QRYAux1: TFDQuery
    Connection = FDConnection
    SQL.Strings = (
      'Select * From VW_GridEspelhoPontoJornadaFuncionario'
      'Where NrPis = '#39'12790870456'#39
      'Order By'
      '  NrJornada')
    Left = 32
    Top = 145
  end
  object CDSAux1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPAux1'
    Left = 33
    Top = 200
  end
  object DSPAux1: TDataSetProvider
    DataSet = QRYAux1
    Left = 82
    Top = 145
  end
  object DBDAux1: TfrxDBDataset
    UserName = 'DBDAux1'
    CloseDataSource = False
    DataSet = CDSAux1
    BCDToCurrency = False
    Left = 81
    Top = 200
  end
  object DSPAux2: TDataSetProvider
    DataSet = QRYAux2
    Left = 266
    Top = 145
  end
  object QRYAux2: TFDQuery
    ConstraintsEnabled = True
    Connection = FDConnection
    SQL.Strings = (
      
        'Exec PC_TotalizaresPonto '#39'2015/05/01'#39', '#39'2015/05/31'#39', '#39'1279087045' +
        '6'#39)
    Left = 216
    Top = 145
  end
  object CDSAux2: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPAux2'
    Left = 217
    Top = 200
  end
  object DBDAux2: TfrxDBDataset
    UserName = 'DBDAux2'
    CloseDataSource = False
    DataSet = CDSAux2
    BCDToCurrency = False
    Left = 265
    Top = 200
  end
  object QRYAux3: TFDQuery
    ConstraintsEnabled = True
    Connection = FDConnection
    SQL.Strings = (
      
        'Exec PC_ResumoJustificativaPonto '#39'2015/05/01'#39', '#39'2015/05/31'#39', '#39'12' +
        '790870456'#39)
    Left = 376
    Top = 145
  end
  object DSPAux3: TDataSetProvider
    DataSet = QRYAux3
    Left = 426
    Top = 145
  end
  object CDSAux3: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSPAux3'
    Left = 377
    Top = 200
  end
  object DBDAux3: TfrxDBDataset
    UserName = 'DBDAux3'
    CloseDataSource = False
    DataSet = CDSAux3
    BCDToCurrency = False
    Left = 425
    Top = 200
  end
  object frxChart: TfrxChartObject
    Left = 296
    Top = 280
  end
end
