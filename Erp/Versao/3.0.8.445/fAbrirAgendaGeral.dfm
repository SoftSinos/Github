inherited FrmAbrirAgendaGeral: TFrmAbrirAgendaGeral
  Caption = 'Abrir Agenda Geral'
  ClientHeight = 126
  ExplicitWidth = 500
  ExplicitHeight = 155
  PixelsPerInch = 96
  TextHeight = 13
  inherited StbPrincipal: TStatusBar
    Top = 104
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 104
  end
  inherited PnlPrincipal: TPanel
    inherited BtnFechar: TcxButton
      Left = 105
      TabOrder = 1
      ExplicitLeft = 105
    end
    inherited BtnAjuda: TcxButton
      Left = 204
      TabOrder = 2
      OnClick = BtnAjudaClick
      ExplicitLeft = 204
    end
    object BtnGerar: TcxButton
      Left = 6
      Top = 3
      Width = 98
      Height = 39
      Hint = 'Carregar'
      Caption = 'Gerar'
      OptionsImage.Glyph.Data = {
        36100000424D3610000000000000360000002800000020000000200000000100
        2000000000000010000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000400000C10000010100000
        0004FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
        000000000002000E172C0A131520FFFFFF00603B2040884112CB843E10CB502F
        1741FFFFFF000E1414200010182C0000000200000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00081F
        3D077F4A1B8CA15111EE844815B7FFFFFF006C43236DB24C0DFFAC4709FF5731
        166EFFFFFF00883C11B7913A0BEE6C32128D000E2D07FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000000000001FFFFFF000021
        7A04AD6523D3BE580BFFAA510CFD693910A0904610D0B04B09FFAD4708FF863C
        0CD167300EA1A23E07FDAB3C03FF943C0ED300074904FFFFFF00000000010000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000000C82541B976A4719810000
        130E845321A0BD6115FFBE6521FFBE6724FFBD611EFFB35616FFB35518FFB95A
        1FFFB5571FFFAF4F18FFA94209FF6E3311A000002E0E693012816A3011970000
        1A0DFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009464238FC46E14FFB86815FF8D53
        15CCB8651AFBCD8649FFC78D5AF5BE8D62B2A47B569BC0763FFEB96F3BF8A176
        5695BC8864B9C08158F9BE6D3EFF9F420DFA7C350DCCA13B08FFA03906FF7234
        1290FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00A47C3C6FC5791FF9C56C13FFC96E
        19FFC67D37FFAF84568F726A551EFFFFFF0000000C19B46425FCA5571DEC0000
        0009FFFFFF00847C6C24AF81609CB76330FFAC4209FFA53C06FFA33C09F9863D
        186FFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00000000000000000E0000001300000007A46F26C7CD7B1EFFC47A
        2AF38E632E58FFFFFF00FFFFFF00000000053B302059B35911FEA6510EF6101A
        1B4B00000003FFFFFF00FFFFFF0095674468B25C26F8AD460DFF833A11C70000
        28070000181300000E0E00000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0096742B8CA97F2AD3805F23A7C37815F8C87716FF684B
        2081FFFFFF00FFFFFF00392E1B488D5418B8AB5A11F6B8580BFFB6560BFFA150
        10F37C4415B11E1D193EFFFFFF00FFFFFF00794A2995AD4408FF9D3E08F86833
        13A788380DD36C32128CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0039392E1ACC9A30FAE09F29FFD79627FFD08720FFCF821FFFA769
        15DF57401A755F411B77B36617F8C2650FFFC16516FFC3712BFFC06C28FFBB5A
        10FFB7540AFF9C4F11F1452E186E6235147E9C440BE6B24F14FFAB440AFFA73F
        05FFAB3C03FF953B0BFA2221271BFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0076715911C39F47AAD6A43DF7DDA645FFD6A657F8C59C5DD9D692
        37FFC17414FFBE7016FFC56C12FFC8782BFFCD8D50FFC89562E6C89462E8C986
        4DFFBD6420FFB6530BFFAA500DFFAE4D0BFFBE6931FFB37A54D8B76735FBAF50
        1BFFA74711F799481CAA51423311FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000000000FFFFFF00FFFFFF009A814397E5B353FFB9954DBB0000C8059F88
        5873C77F1EFAC97615FFCA7C24FFC4843DED9A7D5656004B6E0A2966840DA288
        6763C07D40F5BB601AFFB6540DFFAD5312F58E6749640017B506AC693ACDB75B
        24FF74401D97FFFFFF00FFFFFF0000000000FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00000000025B4E24466D5C2873B68F31D0E1AA33FF9A792C83FFFFFF000000
        161ABE7E20F2CE8221FFC67D22FF77531C5BFFFFFF00FFFFFF00FFFFFF00FFFF
        FF008E653570BD6921FFBC5E17FF9E5012E40000000CFFFFFF0094522197B24C
        0CFF883F0FD057301573462A154700000002FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000000001C1A03CCCDFB133FFE1AE31FFD9A732FF7E672B60FFFFFF007566
        3742CF932BFFD0831BFFB4731AEA00001D14FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0021343522B3641BF6BC5C10FFAB5712FC372F1E30FFFFFF0086502575AF4E
        0DFFAC4607FFA94508FF8D4110CC00007601FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000000000CAAA43C9E6BD48FFE7BE54FFDAAC38FF7A652A65FFFFFF00796B
        3F3CD4A036FFDA9728FFB47A1EED00000B1EFFFFFF00FFFFFF00FFFFFF00FFFF
        FF002029252CB46317F7BD5E0EFFAE5A13FA3E35212BFFFFFF00834C1F79B253
        11FFBA6128FFB25418FF944612C900007E00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00A0915331B6A66859CDB267CAE5B83FFF93792E8DFFFFFF000000
        2120CB9C37F2DDA02CFFD2982DFF614F2578FFFFFF00FFFFFF00FFFFFF00FFFF
        FF007D4F1D8BC06613FFC0610EFFA35915E400001A13FFFFFF00914F19A0B958
        13FFA76739CA9E6D465984553231FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00927F3A9AEEC142FFAF9138C800000C2C8B72
        2C96DAA737FDDEA93FFFDEA130FFC5912DF86C572683060E13380F11103B7650
        1B8EBB6A14FCC26913FFC46B1BFFB25E11F9633F168900031C2FA35717D7B956
        0CFF6C3C129AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF004A473119AF9844B8DBB846F9EAC046FFDBB442FCBF9D3CEEE6B9
        47FFE3BF6FFFE1C07CFFE3B65FFFDEA436FFD49A2EFFBF8C2EF8BB7F22F9C575
        12FFC87417FFCF8940FFCC9358FFCB8643FFBD6513FF9D5614EDB4590FFDB756
        0BFFA8510DF9834815B933292019FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF003F413C17DFC35AF7F4D36AFFEED075FFECC659FFEBC049FFCEAE
        56CFA49B804699937B49DABE7DEAE6BE70FFE1AD4CFFDCA034FFDB9D34FFDB9E
        48FFD99F56FFC59250E086785D3FA7987B50B7742FD8C2620EFFBF681DFFC679
        3AFFC36823FFAA530FF72F2B2817FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00BEAC617EDBC677C7BBB08795E8CD79F8E8C458FF7164
        3487FFFFFF00FFFFFF00706C4C1DC6AE7393D9BA79E8E3B667FFE1B366FFD3AE
        70E2BD9C5F8A46431B14FFFFFF00FFFFFF007F511E9AC26816FFC27734F8A987
        6494B97C42C795561C7EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00BCA75BC8F2CF5EFFDBBB
        57FC7366398100000009FFFFFF00FFFFFF004B4E4339DEB86CFDD2AA5EF41017
        1428FFFFFF00FFFFFF000000000E83632D90CA8429FFCD791EFF996122C8FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF009F90507BE6CB69FAF0D47AFFF4D5
        74FFE3C361FF9E8B4BB43835244C000000110000002AD9B054FBC79F46EC0000
        001D000000154A3E2453A37D39BFD6993CFFDDA04DFFD99C50FFC78835FA7E5E
        2B7BFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C0B16C86F2DC8BFFEFDDA0FFCFC1
        90BFEBD07DF8EFCD68FFD7B961FFB69C53D29F894BBCE3BB5DFED9B157FA977E
        42B8B79346D7D1A24AFFE0A747FFDAA95DF8C5A980BFE0BA8AFFD99E54FFA576
        3186FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6B97F84BFB1756BFFFF
        FF00AC9C649BF0D379FFF0D179FFF2D27CFFF2CF74FFE7C166FFE7BF63FFEEC4
        6BFFEAC06DFFE5B762FFE0B05BFF987E4A9BFFFFFF00B59B6B6AB5915584FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
        0003D3BE71D5FAE5A2FFEAD8A0FDB9AD888CD2BF8AC8EED188FFECCD85FFCDB6
        81C9B8A9858CE6CB99FDF0CB8BFFBB9853D600000003FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000103
        0004C7B87D7CE6D59AE7CAB97EACFFFFFF0093865860F3DDA3FFEFD79CFF7F71
        4461FFFFFF00C9B582ACDDC084E7B99C5E7D00000004FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF001017141045421E0DFFFFFF00978A5634D6C48ABFD2BE84BF8676
        4235FFFFFF004643210D141E1110FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 0
      OnClick = BtnGerarClick
    end
  end
  inherited PnlCampos: TPanel
    Height = 39
    ExplicitHeight = 39
    object Label26: TLabel
      Left = 21
      Top = 13
      Width = 78
      Height = 13
      Caption = '* Ano Gera'#231#227'o :'
    end
    object CbbNrAno: TcxComboBox
      Left = 105
      Top = 9
      Properties.DropDownListStyle = lsFixedList
      TabOrder = 0
      Width = 89
    end
  end
end
