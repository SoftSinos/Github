inherited FrmExecutaScriptSQL: TFrmExecutaScriptSQL
  Caption = 'Executar Script SQL'
  ClientHeight = 556
  ClientWidth = 899
  ExplicitWidth = 905
  ExplicitHeight = 585
  PixelsPerInch = 96
  TextHeight = 13
  inherited StbPrincipal: TStatusBar
    Top = 534
    Width = 893
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 534
    ExplicitWidth = 865
  end
  inherited PnlPrincipal: TPanel
    Width = 893
    TabOrder = 0
    ExplicitWidth = 865
    inherited BtnFechar: TcxButton
      Left = 420
      ExplicitLeft = 420
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAjuda: TcxButton
      Left = 524
      OnClick = BtnAjudaClick
      ExplicitLeft = 524
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnInicializar: TcxButton
      Left = 577
      ExplicitLeft = 577
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnSalvar: TcxButton
      Enabled = True
      Visible = True
      OnClick = BtnSalvarClick
      ExplicitLeft = 212
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnExecutar: TcxButton
      Left = 108
      Enabled = True
      Visible = True
      OnClick = BtnExecutarClick
      ExplicitLeft = 108
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnLimpar: TcxButton
      Left = 316
      Enabled = True
      Visible = True
      OnClick = BtnLimparClick
      ExplicitLeft = 316
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnCarregar: TcxButton
      Left = 4
      Enabled = True
      Visible = True
      OnClick = BtnCarregarClick
      ExplicitLeft = 4
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAgenda: TcxButton
      Left = 889
      ExplicitLeft = 889
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnPeriodo: TcxButton
      Left = 785
      ExplicitLeft = 785
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAtualizar: TcxButton
      Left = 993
      ExplicitLeft = 993
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnGerar: TcxButton
      Left = 681
      ExplicitLeft = 681
      ExplicitTop = 4
      ExplicitHeight = 38
    end
  end
  inherited PnlCampos: TPanel
    Top = 138
    Width = 893
    Height = 326
    TabOrder = 3
    ExplicitTop = 138
    ExplicitWidth = 865
    ExplicitHeight = 326
    object MemSQL: TcxMemo
      AlignWithMargins = True
      Left = 4
      Top = 4
      Align = alClient
      ParentFont = False
      Properties.ScrollBars = ssBoth
      Style.Color = clWindowText
      Style.Font.Charset = DEFAULT_CHARSET
      Style.Font.Color = clLime
      Style.Font.Height = -13
      Style.Font.Name = 'Tahoma'
      Style.Font.Style = []
      Style.IsFontAssigned = True
      TabOrder = 0
      OnEditing = CamposEdicao
      ExplicitWidth = 857
      Height = 318
      Width = 885
    end
  end
  object Panel2: TPanel
    AlignWithMargins = True
    Left = 3
    Top = 493
    Width = 893
    Height = 35
    Align = alBottom
    BevelInner = bvSpace
    BevelOuter = bvNone
    BiDiMode = bdLeftToRight
    ParentBiDiMode = False
    TabOrder = 4
    ExplicitWidth = 865
    object GroupBox2: TGroupBox
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 885
      Height = 27
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 857
      object Label1: TLabel
        Left = 7
        Top = 5
        Width = 156
        Height = 18
        Caption = 'Total de Registros:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
      object LbtTotalRegistros: TLabel
        Left = 169
        Top = 5
        Width = 143
        Height = 18
        Caption = 'LbtTotalRegistros'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Verdana'
        Font.Style = []
        ParentFont = False
      end
    end
  end
  object GroupBox1: TGroupBox
    AlignWithMargins = True
    Left = 3
    Top = 59
    Width = 893
    Height = 73
    Align = alTop
    Caption = '  Op'#231#245'es de Execu'#231#227'o  '
    TabOrder = 1
    ExplicitWidth = 865
    object ChkGerarLog: TcxCheckBox
      Left = 15
      Top = 21
      TabStop = False
      Caption = 'Gerar Log de Execu'#231#227'o'
      ParentBackground = False
      ParentColor = False
      State = cbsChecked
      Style.Color = clWhite
      TabOrder = 0
      Width = 152
    end
    object ChkExcluirScriptSQL: TcxCheckBox
      Left = 15
      Top = 44
      TabStop = False
      Caption = 'Excluir e Mover Script SQL'
      ParentBackground = False
      ParentColor = False
      State = cbsChecked
      Style.Color = clWhite
      TabOrder = 1
      Width = 152
    end
    object ChkExecutarSemSalvar: TcxCheckBox
      Left = 195
      Top = 21
      TabStop = False
      Caption = 'Executar Sem Salvar'
      ParentBackground = False
      ParentColor = False
      Style.Color = clWhite
      TabOrder = 2
      OnClick = ChkExecutarSemSalvarClick
      Width = 121
    end
  end
  object PrbPesquisa: TProgressBar
    AlignWithMargins = True
    Left = 3
    Top = 470
    Width = 893
    Height = 17
    Align = alBottom
    Step = 15
    TabOrder = 5
    ExplicitWidth = 865
  end
  object OpdSQL: TOpenDialog
    Left = 664
    Top = 8
  end
  object ExeSQL: TFDScript
    SQLScripts = <>
    Params = <>
    Macros = <>
    Left = 721
    Top = 8
  end
end
