inherited FrmCalendarioPesquisa: TFrmCalendarioPesquisa
  Caption = 'Pesquisar Calend'#225'rio'
  ClientHeight = 404
  ClientWidth = 752
  ExplicitWidth = 758
  ExplicitHeight = 433
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 746
    ExplicitWidth = 746
    inherited GroupBox1: TGroupBox
      Width = 738
      ExplicitWidth = 738
      object Label13: TLabel [0]
        Left = 212
        Top = 8
        Width = 78
        Height = 13
        Caption = '* Calend'#225'rio:'
      end
      inherited Label2: TLabel
        Left = 399
        Top = 8
        ExplicitLeft = 399
        ExplicitTop = 8
      end
      inherited EdtPesquisa: TcxTextEdit
        Left = 488
        Top = 5
        TabOrder = 3
        ExplicitLeft = 488
        ExplicitTop = 5
        ExplicitWidth = 246
        Width = 246
      end
      object RdbCalendario: TRadioButton
        Left = 9
        Top = 5
        Width = 89
        Height = 17
        Caption = 'Calendario'
        TabOrder = 0
        TabStop = True
        OnClick = RdbCalendarioClick
      end
      object RdbDiaNominal: TRadioButton
        Left = 104
        Top = 5
        Width = 102
        Height = 17
        Caption = 'Dia Nominal'
        TabOrder = 1
        TabStop = True
        OnClick = RdbDiaNominalClick
      end
      object DtpDtCalendario: TcxDateEdit
        Left = 296
        Top = 5
        Properties.AssignedValues.DisplayFormat = True
        Properties.DateButtons = []
        TabOrder = 2
        OnKeyPress = DtpDtCalendarioKeyPress
        Width = 92
      end
    end
  end
  inherited DbgPesquisa: TDBGrid
    Width = 746
    Height = 210
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IdCalendario'
        Title.Alignment = taCenter
        Title.Caption = 'Registro'
        Visible = False
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DtCadastro'
        Title.Alignment = taCenter
        Title.Caption = 'Cadastro'
        Visible = False
      end
      item
        Alignment = taCenter
        Expanded = False
        Title.Alignment = taCenter
        Title.Caption = 'Situa'#231#227'o'
        Visible = False
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DtCalendario'
        Title.Alignment = taCenter
        Title.Caption = 'Calend'#225'rio'
        Width = 130
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmDiaSemana'
        Title.Alignment = taCenter
        Title.Caption = 'Dia da Semana'
        Width = 168
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmDescricaoFeriado'
        Title.Alignment = taCenter
        Title.Caption = 'Feriado'
        Width = 399
        Visible = True
      end>
  end
  inherited Panel2: TPanel
    Top = 341
    Width = 746
    ExplicitTop = 341
    ExplicitWidth = 746
    inherited GroupBox2: TGroupBox
      Width = 738
      ExplicitWidth = 738
    end
  end
  inherited PnlPrincipal: TPanel
    Width = 746
    ExplicitWidth = 746
  end
  inherited PrbPesquisa: TProgressBar
    Top = 318
    Width = 746
    ExplicitTop = 318
    ExplicitWidth = 746
  end
  inherited StbPrincipal: TStatusBar
    Top = 382
    Width = 746
    Panels = <
      item
        Alignment = taRightJustify
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 382
    ExplicitWidth = 746
  end
end
