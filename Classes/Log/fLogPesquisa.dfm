inherited FrmLogPesquisa: TFrmLogPesquisa
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Pesquisar Log Sistema'
  ClientHeight = 556
  ClientWidth = 1024
  ExplicitWidth = 1024
  ExplicitHeight = 556
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 1018
    ExplicitWidth = 1018
    inherited GroupBox1: TGroupBox
      Width = 1010
      ExplicitWidth = 1010
      object Label13: TLabel [0]
        Left = 11
        Top = 8
        Width = 50
        Height = 13
        Caption = '* Inicial:'
      end
      inherited Label2: TLabel
        Left = 323
        Top = 8
        ExplicitLeft = 323
        ExplicitTop = 8
      end
      object Label3: TLabel [2]
        Left = 179
        Top = 8
        Width = 42
        Height = 13
        Caption = '* Final:'
      end
      inherited EdtPesquisa: TcxTextEdit
        Left = 407
        TabOrder = 2
        ExplicitLeft = 407
        ExplicitWidth = 246
        Width = 246
      end
      object DtpDtInicial: TcxDateEdit
        Left = 62
        Top = 4
        Properties.AssignedValues.DisplayFormat = True
        Properties.DateButtons = []
        TabOrder = 0
        Width = 92
      end
      object DtpDtFinal: TcxDateEdit
        Left = 222
        Top = 4
        Properties.AssignedValues.DisplayFormat = True
        Properties.DateButtons = []
        TabOrder = 1
        Width = 92
      end
    end
  end
  inherited DbgPesquisa: TDBGrid
    Width = 1018
    Height = 362
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IdEmpresa'
        Title.Alignment = taCenter
        Title.Caption = 'Emp'
        Width = 38
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmLogin'
        Title.Alignment = taCenter
        Title.Caption = 'Usu'#225'rio'
        Width = 100
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NrCpf'
        Title.Alignment = taCenter
        Title.Caption = 'Cpf'
        Visible = False
      end
      item
        Expanded = False
        FieldName = 'DtCadastro'
        Title.Alignment = taCenter
        Title.Caption = 'Cadastro'
        Width = 133
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmComputador'
        Title.Alignment = taCenter
        Title.Caption = 'Maquina'
        Width = 149
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmModulo'
        Title.Alignment = taCenter
        Title.Caption = 'M'#243'dulo'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmOperacao'
        Title.Alignment = taCenter
        Title.Caption = 'Opera'#231#227'o'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmTabela'
        Title.Alignment = taCenter
        Title.Caption = 'Tabela'
        Width = 96
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmClasse'
        Title.Alignment = taCenter
        Title.Caption = 'Classe'
        Width = 170
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmMetodo'
        Title.Alignment = taCenter
        Title.Caption = 'M'#233'todo'
        Width = 170
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmVersao'
        Title.Alignment = taCenter
        Title.Caption = 'Vers'#227'o'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmMensagem'
        Title.Alignment = taCenter
        Title.Caption = 'Mensagem'
        Width = 656
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pk1'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pk2'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pk3'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pk4'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pk5'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pk6'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pk7'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pk8'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Pk9'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end>
  end
  inherited Panel2: TPanel
    Top = 493
    Width = 1018
    ExplicitTop = 493
    ExplicitWidth = 1018
    inherited GroupBox2: TGroupBox
      Width = 1010
      ExplicitWidth = 1010
    end
  end
  inherited PnlPrincipal: TPanel
    Width = 1018
    ExplicitWidth = 1018
    inherited BtnIncluir: TcxButton
      ExplicitLeft = 4
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAlterar: TcxButton
      ExplicitLeft = 108
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnPesquisar: TcxButton
      ExplicitLeft = 212
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnImprimir: TcxButton
      ExplicitLeft = 316
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnLimpar: TcxButton
      ExplicitLeft = 420
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnFechar: TcxButton
      ExplicitLeft = 524
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAjuda: TcxButton
      ExplicitLeft = 628
      ExplicitTop = 4
      ExplicitHeight = 38
    end
  end
  inherited PrbPesquisa: TProgressBar
    Top = 470
    Width = 1018
    ExplicitTop = 470
    ExplicitWidth = 1018
  end
  inherited StbPrincipal: TStatusBar
    Top = 534
    Width = 1018
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    Visible = False
    ExplicitTop = 534
    ExplicitWidth = 1018
  end
  inherited CdsPesquisa: TClientDataSet
    Left = 760
    Top = 0
  end
  inherited DtsPesquisa: TDataSource
    Left = 704
    Top = 0
  end
end
