inherited FrmInformacoes: TFrmInformacoes
  Caption = 'Informa'#231#245'es T'#233'cnicas'
  ClientHeight = 269
  ClientWidth = 590
  ExplicitWidth = 596
  ExplicitHeight = 298
  PixelsPerInch = 96
  TextHeight = 13
  inherited StbPrincipal: TStatusBar
    Top = 247
    Width = 584
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 247
    ExplicitWidth = 576
  end
  inherited PnlPrincipal: TPanel
    Width = 584
    ExplicitWidth = 576
    inherited BtnFechar: TcxButton
      Left = 4
      ExplicitLeft = 4
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAjuda: TcxButton
      Left = 108
      ExplicitLeft = 108
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnInicializar: TcxButton
      Left = 161
      ExplicitLeft = 4
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnSalvar: TcxButton
      Left = 369
      ExplicitLeft = 212
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnExecutar: TcxButton
      Left = 473
      ExplicitLeft = 316
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnLimpar: TcxButton
      Left = 889
      ExplicitLeft = 732
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnCarregar: TcxButton
      Left = 577
      ExplicitLeft = 420
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAgenda: TcxButton
      Left = 785
      ExplicitLeft = 628
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnPeriodo: TcxButton
      Left = 681
      ExplicitLeft = 524
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnAtualizar: TcxButton
      Left = 993
      ExplicitLeft = 836
      ExplicitTop = 4
      ExplicitHeight = 38
    end
    inherited BtnGerar: TcxButton
      Left = 265
      ExplicitLeft = 108
      ExplicitTop = 4
      ExplicitHeight = 38
    end
  end
  inherited PnlCampos: TPanel
    Width = 584
    Height = 182
    ExplicitWidth = 576
    ExplicitHeight = 182
    object MemInformacoes: TMemo
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 576
      Height = 174
      Align = alClient
      Enabled = False
      TabOrder = 0
      ExplicitWidth = 568
    end
  end
end
