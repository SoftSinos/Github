inherited FrmTipoPagamentoPesquisa: TFrmTipoPagamentoPesquisa
  Caption = 'Pesquisar Tipo de Pagamento'
  ExplicitWidth = 741
  ExplicitHeight = 398
  PixelsPerInch = 96
  TextHeight = 13
  inherited DbgPesquisa: TDBGrid
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IdTpPagamento'
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
        FieldName = 'NmTpPagamento'
        Title.Alignment = taCenter
        Title.Caption = 'Tipo de Pagamento'
        Width = 300
        Visible = True
      end>
  end
  inherited StbPrincipal: TStatusBar
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
  end
end
