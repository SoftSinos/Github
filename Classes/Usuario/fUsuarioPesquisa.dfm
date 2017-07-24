inherited FrmUsuarioPesquisa: TFrmUsuarioPesquisa
  Caption = 'Pesquisar Usu'#225'rio'
  ClientWidth = 882
  ExplicitWidth = 888
  ExplicitHeight = 398
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 876
    ExplicitWidth = 876
    inherited GroupBox1: TGroupBox
      Width = 868
      ExplicitWidth = 868
      inherited EdtPesquisa: TcxTextEdit
        Left = 92
        Top = 5
        ExplicitLeft = 92
        ExplicitTop = 5
      end
    end
  end
  inherited DbgPesquisa: TDBGrid
    Width = 876
    Columns = <
      item
        Expanded = False
        FieldName = 'IdUsuario'
        Title.Alignment = taCenter
        Title.Caption = 'Identificador'
        Visible = False
      end
      item
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
        FieldName = 'NmUsuario'
        Title.Alignment = taCenter
        Title.Caption = 'Nome'
        Width = 268
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NrCpf'
        Title.Alignment = taCenter
        Title.Caption = 'N'#186' CPF'
        Width = 95
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmLogin'
        Title.Alignment = taCenter
        Title.Caption = 'Usu'#225'rio'
        Width = 142
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'SnAdministrador'
        Title.Alignment = taCenter
        Title.Caption = 'AD'
        Width = 40
        Visible = True
      end>
  end
  inherited Panel2: TPanel
    Width = 876
    ExplicitWidth = 876
    inherited GroupBox2: TGroupBox
      Width = 868
      ExplicitWidth = 868
    end
  end
  inherited PnlPrincipal: TPanel
    Width = 876
    ExplicitWidth = 876
  end
  inherited PrbPesquisa: TProgressBar
    Width = 876
    ExplicitWidth = 876
  end
  inherited StbPrincipal: TStatusBar
    Width = 876
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
    ExplicitWidth = 876
  end
end
