inherited FrmServicoPesquisa: TFrmServicoPesquisa
  Caption = 'Pesquisar Servi'#231'o'
  ClientWidth = 798
  ExplicitWidth = 804
  ExplicitHeight = 398
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 792
    ExplicitWidth = 792
    inherited GroupBox1: TGroupBox
      Width = 784
      ExplicitWidth = 784
    end
  end
  inherited DbgPesquisa: TDBGrid
    Width = 792
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IdServico'
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
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmProfissional'
        Title.Alignment = taCenter
        Title.Caption = 'Profissional'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmTpServico'
        Title.Alignment = taCenter
        Title.Caption = 'Tipo de Servi'#231'o'
        Width = 150
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'VlServico'
        Title.Alignment = taCenter
        Title.Caption = 'Valor'
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'HrServico'
        Title.Alignment = taCenter
        Title.Caption = 'Tempo'
        Visible = True
      end>
  end
  inherited Panel2: TPanel
    Width = 792
    ExplicitWidth = 792
    inherited GroupBox2: TGroupBox
      Width = 784
      ExplicitWidth = 784
    end
  end
  inherited PnlPrincipal: TPanel
    Width = 792
    ExplicitWidth = 792
  end
  inherited PrbPesquisa: TProgressBar
    Width = 792
    ExplicitWidth = 792
  end
  inherited StbPrincipal: TStatusBar
    Width = 792
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
    ExplicitWidth = 792
  end
end
