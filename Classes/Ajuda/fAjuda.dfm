inherited FrmAjuda: TFrmAjuda
  Caption = 'Pesquisar...'
  ClientWidth = 1020
  ExplicitWidth = 1026
  ExplicitHeight = 398
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 1014
    ExplicitWidth = 1225
    inherited GroupBox1: TGroupBox
      Width = 1006
      ExplicitWidth = 1217
    end
  end
  inherited DbgPesquisa: TDBGrid
    Width = 1014
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NmTopico'
        Title.Alignment = taCenter
        Title.Caption = 'T'#243'pico'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmAjuda'
        Title.Caption = 'Ajuda'
        Width = 1500
        Visible = True
      end>
  end
  inherited Panel2: TPanel
    Width = 1014
    ExplicitWidth = 1225
    inherited GroupBox2: TGroupBox
      Width = 1006
      ExplicitWidth = 1217
    end
  end
  inherited PnlPrincipal: TPanel
    Width = 1014
    ExplicitWidth = 1225
    inherited BtnIncluir: TcxButton
      Enabled = False
    end
    inherited BtnAlterar: TcxButton
      Enabled = False
    end
  end
  inherited PrbPesquisa: TProgressBar
    Width = 1014
    ExplicitWidth = 1225
  end
  inherited StbPrincipal: TStatusBar
    Width = 1014
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
    ExplicitWidth = 1225
  end
end
