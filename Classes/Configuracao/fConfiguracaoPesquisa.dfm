inherited FrmConfiguracaoPesquisa: TFrmConfiguracaoPesquisa
  Caption = 'Pesquisar Configura'#231#227'o'
  ClientWidth = 1041
  ExplicitWidth = 1047
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 1035
    ExplicitWidth = 1035
    inherited GroupBox1: TGroupBox
      Width = 1027
      ExplicitWidth = 1027
    end
  end
  inherited DbgPesquisa: TDBGrid
    Width = 1035
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IdConfiguracao'
        Title.Alignment = taCenter
        Title.Caption = 'Identificador'
        Visible = False
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'DtCadastro'
        Title.Alignment = taCenter
        Title.Caption = 'Cadastro'
        Width = 130
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SnSituacao'
        Title.Alignment = taCenter
        Title.Caption = 'Situa'#231#227'o'
        Width = 80
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IdEmpresa'
        Title.Alignment = taCenter
        Title.Caption = 'Empresa'
        Width = 62
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NmSigla'
        Title.Alignment = taCenter
        Title.Caption = 'Sigla'
        Width = 46
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmConfiguracao'
        Title.Alignment = taCenter
        Title.Caption = 'Configura'#231#227'o'
        Width = 491
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmValor'
        Title.Alignment = taCenter
        Title.Caption = 'Valor'
        Width = 409
        Visible = True
      end>
  end
  inherited Panel2: TPanel
    Width = 1035
    ExplicitWidth = 1035
    inherited GroupBox2: TGroupBox
      Width = 1027
      ExplicitWidth = 1027
    end
  end
  inherited PnlPrincipal: TPanel
    Width = 1035
    ExplicitWidth = 1035
  end
  inherited PrbPesquisa: TProgressBar
    Width = 1035
    ExplicitWidth = 1035
  end
  inherited StbPrincipal: TStatusBar
    Width = 1035
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitWidth = 1035
  end
end
