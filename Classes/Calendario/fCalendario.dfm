inherited FrmCalendario: TFrmCalendario
  Caption = 'Cadastrar Calend'#225'rio'
  ClientHeight = 249
  ClientWidth = 791
  ExplicitWidth = 797
  ExplicitHeight = 278
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlPrincipal: TPanel
    Width = 785
    ExplicitWidth = 785
  end
  inherited PnlCampos: TPanel
    Width = 785
    Height = 162
    ExplicitWidth = 785
    ExplicitHeight = 162
    object Label13: TLabel [0]
      Left = 21
      Top = 42
      Width = 78
      Height = 13
      Caption = '* Calend'#225'rio:'
    end
    object Label14: TLabel [1]
      Left = 64
      Top = 66
      Width = 35
      Height = 13
      Caption = '* Dia:'
    end
    object Label15: TLabel [2]
      Left = 144
      Top = 66
      Width = 38
      Height = 13
      Caption = '* M'#234's:'
    end
    object Label16: TLabel [3]
      Left = 228
      Top = 66
      Width = 38
      Height = 13
      Caption = '* Ano:'
    end
    object Label17: TLabel [4]
      Left = 511
      Top = 42
      Width = 139
      Height = 13
      Caption = '* Nomenclatura do M'#234's:'
    end
    object Label18: TLabel [5]
      Left = 210
      Top = 42
      Width = 205
      Height = 13
      Caption = '* Nomenclatura do Dia da Semana:'
    end
    object Label19: TLabel [6]
      Left = 135
      Top = 66
      Width = 5
      Height = 13
      Caption = '/'
    end
    object Label20: TLabel [7]
      Left = 220
      Top = 66
      Width = 5
      Height = 13
      Caption = '/'
    end
    object Label21: TLabel [8]
      Left = 52
      Top = 115
      Width = 47
      Height = 13
      Caption = '* Troca:'
    end
    object GroupBox1: TGroupBox [9]
      AlignWithMargins = True
      Left = 0
      Top = 245
      Width = 860
      Height = 72
      Caption = '  In'#237'cio do Per'#237'odo  '
      TabOrder = 13
      Visible = False
      object Label2: TLabel
        Left = 7
        Top = 21
        Width = 116
        Height = 13
        Caption = '* In'#237'cio da Semana:'
      end
      object Label4: TLabel
        Left = 12
        Top = 43
        Width = 111
        Height = 13
        Caption = '* Final da Semana:'
      end
      object Label7: TLabel
        Left = 231
        Top = 21
        Width = 91
        Height = 13
        Caption = '* In'#237'cio do M'#234's:'
      end
      object Label8: TLabel
        Left = 236
        Top = 43
        Width = 86
        Height = 13
        Caption = '* Final do M'#234's:'
      end
      object Label10: TLabel
        Left = 436
        Top = 43
        Width = 86
        Height = 13
        Caption = '* Final do Ano:'
      end
      object Label11: TLabel
        Left = 627
        Top = 21
        Width = 123
        Height = 13
        Caption = '* In'#237'cio do Trimestre:'
      end
      object DtpDtInicioSemana: TDateTimePicker
        Left = 129
        Top = 43
        Width = 100
        Height = 21
        Date = 41901.406276064820000000
        Time = 41901.406276064820000000
        TabOrder = 0
      end
      object DtpDtFinalSemana: TDateTimePicker
        Left = 125
        Top = 16
        Width = 100
        Height = 21
        Date = 41901.406276064820000000
        Time = 41901.406276064820000000
        TabOrder = 1
      end
      object DtpDtInicioMes: TDateTimePicker
        Left = 325
        Top = 16
        Width = 100
        Height = 21
        Date = 41901.406276064820000000
        Time = 41901.406276064820000000
        TabOrder = 2
      end
      object DtpDtFinalMes: TDateTimePicker
        Left = 325
        Top = 40
        Width = 100
        Height = 21
        Date = 41901.406276064820000000
        Time = 41901.406276064820000000
        TabOrder = 3
      end
      object DtpDtInicioAno: TDateTimePicker
        Left = 524
        Top = 16
        Width = 100
        Height = 21
        Date = 41901.406276064820000000
        Time = 41901.406276064820000000
        TabOrder = 4
      end
      object DtpDtFinalAno: TDateTimePicker
        Left = 524
        Top = 40
        Width = 100
        Height = 21
        Date = 41901.406276064820000000
        Time = 41901.406276064820000000
        TabOrder = 5
      end
      object DtpDtInicioTrimestre: TDateTimePicker
        Left = 752
        Top = 16
        Width = 100
        Height = 21
        Date = 41901.406276064820000000
        Time = 41901.406276064820000000
        TabOrder = 6
      end
      object DtpDtFinalTrimestre: TDateTimePicker
        Left = 752
        Top = 40
        Width = 100
        Height = 21
        Date = 41901.406276064820000000
        Time = 41901.406276064820000000
        TabOrder = 7
      end
    end
    object DtpDtCalendario: TcxDateEdit [10]
      Left = 101
      Top = 39
      Properties.AssignedValues.DisplayFormat = True
      Properties.DateButtons = []
      TabOrder = 0
      OnEditing = CamposEdicao
      Width = 101
    end
    inherited GrbIdentificador: TGroupBox
      Width = 777
      TabOrder = 14
      ExplicitWidth = 777
      inherited ChkSnSituacao: TcxCheckBox
        ExplicitHeight = 21
      end
    end
    object EdtNmDiaSemana: TcxTextEdit
      Left = 416
      Top = 39
      TabOrder = 1
      OnEditing = CamposEdicao
      Width = 89
    end
    object EdtNmMes: TcxTextEdit
      Left = 651
      Top = 39
      TabOrder = 2
      OnEditing = CamposEdicao
      Width = 89
    end
    object EdtNrDia: TcxTextEdit
      Left = 101
      Top = 63
      TabOrder = 3
      OnEditing = CamposEdicao
      Width = 30
    end
    object EdtNrMes: TcxTextEdit
      Left = 184
      Top = 63
      TabOrder = 4
      OnEditing = CamposEdicao
      Width = 30
    end
    object EdtNrAno: TcxTextEdit
      Left = 267
      Top = 63
      TabOrder = 5
      OnEditing = CamposEdicao
      Width = 41
    end
    object EdtNmDescricaoFeriado: TcxTextEdit
      Left = 101
      Top = 87
      TabOrder = 7
      OnEditing = CamposEdicao
      Width = 639
    end
    object EdtNmFeriadoTrocado: TcxTextEdit
      Left = 101
      Top = 112
      TabOrder = 8
      OnEditing = CamposEdicao
      Width = 639
    end
    object ChkSnDiaSemana: TcxCheckBox
      Left = 101
      Top = 136
      Caption = 'Dia da Semana'
      ParentBackground = False
      ParentColor = False
      Properties.Alignment = taRightJustify
      Style.Color = clWhite
      TabOrder = 9
      OnEditing = CamposEdicao
      Width = 121
    end
    object ChkSnFinalSemana: TcxCheckBox
      Left = 292
      Top = 136
      Caption = 'Final de Semana'
      ParentBackground = False
      ParentColor = False
      Properties.Alignment = taRightJustify
      Style.Color = clWhite
      TabOrder = 10
      OnEditing = CamposEdicao
      Width = 121
    end
    object ChkSnDiaUtil: TcxCheckBox
      Left = 487
      Top = 136
      Caption = 'Dia '#218'til'
      ParentBackground = False
      ParentColor = False
      Properties.Alignment = taRightJustify
      Style.Color = clWhite
      TabOrder = 11
      OnEditing = CamposEdicao
      Width = 67
    end
    object ChkSnDiaNaoUtil: TcxCheckBox
      Left = 648
      Top = 136
      Caption = 'Dia N'#227'o '#218'til'
      ParentBackground = False
      ParentColor = False
      Properties.Alignment = taRightJustify
      Style.Color = clWhite
      TabOrder = 12
      OnEditing = CamposEdicao
      Width = 92
    end
    object ChkSnFeriado: TcxCheckBox
      Left = 26
      Top = 85
      Caption = 'Feriado'
      ParentBackground = False
      ParentColor = False
      Properties.Alignment = taRightJustify
      Style.Color = clWhite
      TabOrder = 6
      OnEditing = CamposEdicao
      Width = 69
    end
  end
  inherited StbPrincipal: TStatusBar
    Top = 227
    Width = 785
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 227
    ExplicitWidth = 785
  end
end
