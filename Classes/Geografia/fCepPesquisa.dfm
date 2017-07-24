inherited FrmCepPesquisa: TFrmCepPesquisa
  Caption = 'Pesquisar Cep'
  ClientWidth = 910
  ExplicitWidth = 916
  ExplicitHeight = 398
  PixelsPerInch = 96
  TextHeight = 13
  inherited Panel1: TPanel
    Width = 904
    ExplicitWidth = 904
    inherited GroupBox1: TGroupBox
      Width = 896
      ExplicitWidth = 896
      object Label6: TLabel [0]
        Left = 7
        Top = 6
        Width = 28
        Height = 13
        Caption = '* Uf:'
      end
      object Label5: TLabel [1]
        Left = 155
        Top = 6
        Width = 56
        Height = 13
        Caption = '* Cidade:'
      end
      inherited Label2: TLabel
        Left = 557
        ExplicitLeft = 557
      end
      inherited EdtPesquisa: TcxTextEdit
        Left = 643
        TabOrder = 2
        ExplicitLeft = 643
        ExplicitWidth = 246
        Width = 246
      end
      object CbbIdCidade: TcxComboBox
        Left = 212
        Top = 3
        TabOrder = 1
        OnKeyPress = CbbIdCidadeKeyPress
        Width = 335
      end
      object CbbIdUf: TcxComboBox
        Left = 36
        Top = 3
        TabOrder = 0
        OnEditing = CbbIdUfEditing
        OnKeyPress = CbbIdUfKeyPress
        Width = 110
      end
    end
  end
  inherited DbgPesquisa: TDBGrid
    Width = 904
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'IdCep'
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
        FieldName = 'NrCep'
        Title.Alignment = taCenter
        Title.Caption = 'N'#186' Cep'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmEndereco'
        Title.Alignment = taCenter
        Title.Caption = 'Endere'#231'o'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmBairro'
        Title.Alignment = taCenter
        Title.Caption = 'Bairro'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NmCidade'
        Title.Alignment = taCenter
        Title.Caption = 'Cidade'
        Width = 300
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'NmSiglaUf'
        Title.Alignment = taCenter
        Title.Caption = 'Uf'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IdCidade'
        Visible = False
      end>
  end
  inherited Panel2: TPanel
    Width = 904
    ExplicitWidth = 904
    inherited GroupBox2: TGroupBox
      Width = 896
      ExplicitWidth = 896
    end
  end
  inherited PnlPrincipal: TPanel
    Width = 904
    ExplicitWidth = 904
  end
  inherited PrbPesquisa: TProgressBar
    Width = 904
    ExplicitWidth = 904
  end
  inherited StbPrincipal: TStatusBar
    Width = 904
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
    ExplicitWidth = 904
  end
end
