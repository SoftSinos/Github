inherited FrmServico: TFrmServico
  Caption = 'Cadastrar Servi'#231'o'
  ClientHeight = 179
  ExplicitLeft = 8
  ExplicitHeight = 208
  PixelsPerInch = 96
  TextHeight = 13
  inherited PnlCampos: TPanel
    Height = 92
    ExplicitLeft = 3
    ExplicitHeight = 92
    object Label2: TLabel [0]
      Left = 18
      Top = 46
      Width = 81
      Height = 13
      Caption = '* Profissional:'
    end
    object Label3: TLabel [1]
      Left = 12
      Top = 69
      Width = 87
      Height = 13
      Caption = '* Tipo Servi'#231'o:'
    end
    object Label22: TLabel [2]
      Left = 501
      Top = 69
      Width = 72
      Height = 13
      Caption = '* Comiss'#227'o:'
    end
    inherited GrbIdentificador: TGroupBox
      inherited ChkSnSituacao: TcxCheckBox
        OnEditing = CamposEdicao
      end
    end
    object MkePcComissao: TcxMaskEdit
      Left = 576
      Top = 65
      TabOrder = 1
      TextHint = '% 0,00'
      OnEditing = CamposEdicao
      Width = 85
    end
    object CbbIdTpServico: TcxComboBox
      Left = 100
      Top = 66
      TabOrder = 3
      OnEditing = CamposEdicao
      Width = 340
    end
    object CbbIdProfissional: TcxComboBox
      Left = 100
      Top = 43
      TabOrder = 2
      OnEditing = CamposEdicao
      Width = 340
    end
    object BtnPessoaPesquisa: TcxButton
      Left = 440
      Top = 43
      Width = 21
      Height = 21
      BiDiMode = bdLeftToRight
      LookAndFeel.Kind = lfStandard
      OptionsImage.Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF004E4E4E004E4E4E004E4E4E104E4E4E1A4E4E4E1F4E4E
        4E164E4E4E084E4E4E004E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF004E4E4E004E4E4E174E4E4E334E4E4E334E4E4E334E4E
        4E334E4E4E324E4E4E034E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF004E4E4E064E4E4E204E4E4EFF4E4E4EFF4E4E
        4E274E4E4E17FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004E4E4E004E4E4E004E4E4E004E4E4E004E4E4EFF4E4E4EFF4E4E
        4E004E4E4E004E4E4E004E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004E4E4E004E4E4E004E4E4E004E4E4E004E4E4EFF4E4E4EFF4E4E
        4E004E4E4E004E4E4E004E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E
        4EFF4E4E4EFF4E4E4EFF4E4E4EFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E
        4EFF4E4E4EFF4E4E4EFF4E4E4EFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      ParentBiDiMode = False
      TabOrder = 4
      TabStop = False
      OnClick = BtnPessoaPesquisaClick
    end
    object BtnTipoServicoPesquisa: TcxButton
      Left = 440
      Top = 66
      Width = 21
      Height = 21
      BiDiMode = bdLeftToRight
      LookAndFeel.Kind = lfStandard
      OptionsImage.Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF004E4E4E004E4E4E004E4E4E104E4E4E1A4E4E4E1F4E4E
        4E164E4E4E084E4E4E004E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF004E4E4E004E4E4E174E4E4E334E4E4E334E4E4E334E4E
        4E334E4E4E324E4E4E034E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF004E4E4E064E4E4E204E4E4EFF4E4E4EFF4E4E
        4E274E4E4E17FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004E4E4E004E4E4E004E4E4E004E4E4E004E4E4EFF4E4E4EFF4E4E
        4E004E4E4E004E4E4E004E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004E4E4E004E4E4E004E4E4E004E4E4E004E4E4EFF4E4E4EFF4E4E
        4E004E4E4E004E4E4E004E4E4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E
        4EFF4E4E4EFF4E4E4EFF4E4E4EFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E4EFF4E4E
        4EFF4E4E4EFF4E4E4EFF4E4E4EFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004E4E4EFF4E4E4EFF4E4E
        4E00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      ParentBiDiMode = False
      TabOrder = 5
      TabStop = False
      OnClick = BtnTipoServicoPesquisaClick
    end
  end
  inherited StbPrincipal: TStatusBar
    Top = 157
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 157
  end
end
