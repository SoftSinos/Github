inherited FrmTipoPessoaPesquisa: TFrmTipoPessoaPesquisa
  Caption = 'Pesquisar Tipo de Pessoa'
  ClientWidth = 691
  ExplicitWidth = 697
  ExplicitHeight = 398
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 685
    ExplicitWidth = 684
    inherited GroupBox1: TGroupBox
      Width = 677
      ExplicitWidth = 676
    end
  end
  inherited DbgPesquisa: TDBGrid
    Width = 685
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IdTpPessoa'
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
        Expanded = False
        FieldName = 'NmTpPessoa'
        Title.Alignment = taCenter
        Title.Caption = 'Tipo de Pessoa'
        Width = 354
        Visible = True
      end>
  end
  inherited Panel2: TPanel
    Width = 685
    ExplicitWidth = 684
    inherited GroupBox2: TGroupBox
      Width = 677
      ExplicitWidth = 676
    end
  end
  inherited PnlPrincipal: TPanel
    Width = 685
    ExplicitWidth = 684
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
    Width = 685
    ExplicitWidth = 684
  end
  inherited StbPrincipal: TStatusBar
    Width = 685
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
    ExplicitWidth = 684
  end
end
