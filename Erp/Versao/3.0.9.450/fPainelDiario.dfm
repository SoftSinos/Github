inherited FrmPainelDiario: TFrmPainelDiario
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Painel Di'#225'rio Agendamento'
  ClientHeight = 412
  ClientWidth = 626
  ExplicitWidth = 626
  ExplicitHeight = 412
  PixelsPerInch = 96
  TextHeight = 13
  inherited StbPrincipal: TStatusBar
    Top = 390
    Width = 620
    Panels = <
      item
        Text = '  SoftSinos Inform'#225'tica    '
        Width = 130
      end
      item
        Text = '  www.softsinos.com.br'
        Width = 130
      end>
    ExplicitTop = 390
    ExplicitWidth = 620
  end
  inherited PnlPrincipal: TPanel
    Width = 620
    Color = clWhite
    ParentBackground = False
    ExplicitWidth = 620
    inherited BtnFechar: TcxButton
      Left = 303
      TabOrder = 3
      ExplicitLeft = 303
    end
    inherited BtnAjuda: TcxButton
      Left = 402
      TabOrder = 4
      OnClick = BtnAjudaClick
      ExplicitLeft = 402
    end
    object BtnAtualizar: TcxButton
      Left = 6
      Top = 3
      Width = 98
      Height = 39
      Caption = '&Atualizar'
      OptionsImage.Glyph.Data = {
        36100000424D3610000000000000360000002800000020000000200000000100
        2000000000000010000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
        0000000000010000000300000004000000050000000600000007000000070000
        00060000000600000004000000030000000200000000FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000000002000000060000000A0000
        000E00000011000000140000001600000018000000190000001A0000001B0000
        001A000000190000001700000015000000120000000F0000000B000000070000
        0003FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00000000030000000A0000000F00000014000000190000
        001D0000002100000025000000270000002A0000002B0000002B000000270000
        00220000001F0000001D0000001D0000001E0000001E0000001A000000150000
        00110000000B00000005FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000000109000000080000000F0000001A0000001F000000250000
        002A0000002F0000003400000036000000300000002F0000003E00002E550000
        5369000066730000686F0000565D0000283F00000020000000180000001F0000
        001C00000015000000100000000900000003FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00000000070000020500009A7100003C290000001A000000270000002D0000
        003400000036000000300000004300005C7A050598B71515B9E11E1ECCF52323
        D6F92323D9F72020D7F31919D0ED0F0FC0E00404A9BE00007D74000000210000
        00180000001D000000150000000F00000009FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000000009FFFFFF000505ABB20000A7C60000001400000026000000300000
        00270000003C00007A901919B8E23131DEFF3D3DF5FF3C3CFCF93737FBEF3333
        F8E73030F5E13030F4D93030F2D32F2FF1CE2828E8D31515D0E50303ACC80000
        5B3F0000000F00000018000000110000000AFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000000006FFFFFF001616B19D5252DCFF0000999B0000000F0000001A0000
        6E6D1919B8E03F3FE6FF4848FFFF3939FFF92C2CFEF72828F9F12929F6EC2929
        F4E62828F1E02828EFD92727EED32727ECCC2929ECC32E2EF3B62323E6C60707
        B4E100006E40000000070000000F00000008FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000909AE9A8F8FF9FF5555DFFF0000827E00009C9A3E3E
        D9FF5050FEFF3838FFF82828FEF82A2AFDF82C2CFCF62929FBF02828F9EA2F2F
        F9E33535FBDD3838FAD63737F8CF3535F7C73333F7BD2E2EF4B52D2DF5AB2626
        ECB50505B2D2000053150000000500000002FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000E0EB4957676F3FF8989FFFA4C4CD7FF6464E9FF7E7E
        FFFB2F2FFFF72424FEF62C2CFEF72828FEF82C2CFFF53E3EFFEF4343FBF43737
        E8FB2828D7F71C1CCBF51515C4F91414C6EF1818CBE22020D8D62C2CF1B53636
        FF951919DDC70000A884FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000E0EB5937A7AF3FF6464FFF88A8AFFF97575FFF96464
        FFF86363FEF93A3AFEF72727FFF64444FFF94848F4FF2E2ED6FF1313BBCF0000
        A38B0000885400007A43000092600000A4AD0202B1B80202B2B60606B8DC1A1A
        D6CC3535FF900707BFC60000840AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000D0DB5937C7CF3FF6666FFF76262FFF76464FFF96666
        FFF86464FFF87979FFF86E6EFAFF3232D5FF0A0AB5AE00008E42FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00000050070404B17A0D0DC76E0909C1650000
        AFB81818D4C71616D7C30000A03FFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000C0CB4927D7DF3FF6767FFF86666FFF76666FFF86565
        FFF87A7AFEF97171E9FD2727BDCB00009340FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000A8270808BB6F0D0DC74C0E0E
        C93A0303B3B11111CBE30101B05FFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000C0CB4927E7EF3FF6767FFF86666FFF86565FFF86E6E
        FFF88888F5FE0000AFD3FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000A40D0707B8500C0CC7370E0E
        C92D0505B93D0303B5F90101B471FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000B0BB4917F7FF3FF6565FFF76464FFF76565FFF86161
        FFF77F7FFFF95B5BE1FC0000A576FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000A6090707B9320C0CC61F0B0B
        C31B3232FF040000B0C70000B17CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000B0BB4918D8DF7FF7B7BFFF87878FFF87777FFF97777
        FFF97171FFF89B9BFFFB4F4FDAFF0101A655FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000202AE070808BB130C0CCB070808
        C803FFFFFF000000B19E0000B16DFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000202B3975353D9FF6666E1FF6262E1FF6262E2FF6161
        E2FF6161E3FF6161E3FF6767E5FF1212BCFF0000A949FFFFFF00FFFFFF000000
        B100FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF000000AB3B0000B228FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000B02900009F4800009B4600009C4800009D4A0000
        9E4C00009E4E00009F500000A1510000B15A0000B146FFFFFF00FFFFFF000000
        B11E0000B1B31515BFB21515BCAE1C1CBCB01C1CBCB01D1DBCB01E1EBCB01F1F
        BCB12121BDB10E0EB8AB0000AD28FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000B1830000B01FFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000A86F3535D2FF6F6FFBFF5151F9FF5858F9FF5A5AF9FF5C5CF9FF5D5D
        F9FF6D6DF9FF5252DDFF00009B46FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000B0C70202B5571313D00F0C0CC51D0A0AC0290404
        B01EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF000000A7784343DEFF4646FFF71F1FFFF52727FFF62626FFF62323
        FFF53838FFF65555E1FF00009A43FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000B0D70101B5A61010CB460C0CC5570909BE710202
        AD3BFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000303A9824C4CE2FD4343FFF72929FFF62C2CFFF62A2A
        FFF63D3DFFF75252E0FF00009B45FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF001010BDC00F0FBCEB0606C28D0C0CC68F0909BEAD0101
        AB5EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0000009C6C3939D0FB5E5EFFF92727FFF52C2CFFF62A2A
        FFF63D3DFFF75050E1FF00009B46FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF001111BFA33F3FD9EA0000B3E70B0BC6CA0C0CC4DC0202
        AEB9FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00000093401414B9C34747E1FF5050FFF82929FFF62C2CFFF62C2CFFF72A2A
        FFF53D3DFFF74E4EE1FF00009C47FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000AB7A5959EEDA3F3FD6E00000B3FF0505C0FA0606
        BBFF0000A68900006304FFFFFF00FFFFFF00FFFFFF0000004C0F00009E551818
        B8B94040D6FF5454F8FE3737FFF32323FFF62C2CFFF72A2AFFF62B2BFFF62929
        FFF53B3BFFF64D4DE1FF00009C49FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF000000942B2828CEE59393FFBB5555E5D61F1FC2F00A0A
        BAFA0000AFFF0000A6DC0000A89C0606AF891A1ABBAF3636CBE25656DFFF7676
        F8FC7C7CFFF06666FFF25151FFF53434FFF62222FFF63131FFF65F5FFEFE5757
        FFFA3636FFF64A4AE1FF00009D4AFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF000303B1A65B5BEFDE8888FFC07D7DFFC86B6B
        F5D45D5DECDE5656E6EC5858E6F76363EDF87373F9F27D7DFFEA7676FFE76868
        FFEB6767FFEE6A6AFFF36A6AFFF76464FFF86868FFF85A5AF1FF1D1DBFE73737
        D3F86969FFFA4646E2FF00009D4BFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF0000008C191515BEDF7070F8D57B7BFFC77474
        FFCD7777FFD07878FFD37676FFD67171FFDB6C6CFFE06A6AFFE36969FFE76969
        FFEB6767FFEE6868FFF27777FFF67E7EFDFF5252DBFF0D0DB3AF00006A150000
        A0634646DEFF5353E9FF00009E4CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000962F1818BFDE5E5EECE67F7F
        FFCD7777FFD07171FFD56E6EFFD86D6DFFDC6C6CFFE06B6BFFE36B6BFFE77171
        FFEB7C7CFFF07777FBFF5353E1FF1D1DC0D800009D57FFFFFF00FFFFFF00FFFF
        FF000000B07E1D1DC6FF0101AD4EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00000082170808B3A43434
        D0EB5959E9EE6D6DF9E67676FFE17878FFE37878FFE87474FEF06B6BF6FB5959
        E7FF3C3CD4FA1616BDC60000A26100000004FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF000000ACA50000B261FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000000
        942C0000AE7B1616BCB22323C6CD2929CAD72626C8D61D1DC2C80C0CB8A70000
        A87100008D2EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF000000AF020000B11BFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF000000370700000004FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 0
      OnClick = BtnAtualizarClick
    end
    object BtnAgenda: TcxButton
      Left = 105
      Top = 3
      Width = 98
      Height = 39
      Caption = 'A&genda'
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
        FF00FFFFFF00FFFFFF000000605200004F9100002E7C00001458000000390000
        00200000000D00000000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00000076041E1C7E8A8983A5FFBEB7C2FF928FB1FF6D6D9FFE4A498DF12D2D
        7BDA0E1264BC0000489D0000297A0000095700000039000000200000000D0000
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000007E1D6D6289FCFFFBB6FFFFF9D4FFFFFDD1FFFFFED8FFFFFEE9FFEEEE
        F5FFBFBFCFFF8583A4FF9293C4FF6E71AEFE4A4B93F12D2F7CD90D1162BC0000
        439D0000297900000A5700000038000000200000000D00000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000007F1E786A89EFFFEDB2FFFBECD3FFFCEFD8FFFDF8EFFFFFFCF4FFFFFF
        E8FFE5E0CEFFC3BFAAFFFFFFF9FFFFFFFAFFFFFFF7FFF3F1F1FFD8D8E5FFB5B4
        D4FF9091C2FF6D70ADFE4A4B93F12D2F7CD80C0F61BB0000429D00002A790000
        0856000000390000001A00000002FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000007F1E766887EFFFF0B7FFFDF5E9FFFEFDF9FFFFFAF0FFFFECC9FFFFFC
        E4FFD1CFD6FF7576A3FFAFB0E7FFC2C2EAFFD2D2EBFFE3E1ECFFFBF7EFFFFFFF
        F4FFFFFFF9FFFFFFF8FFFFFFF7FFF4F2F1FFD8D8E5FFB5B5D5FF8F90C2FF6C6F
        ACFE474894F410125DBE00000020FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000801E766685EFFFF5C4FFFFFFFFFFFFF7E8FFFFE4B0FFFFECC8FFFFFC
        EDFFE8E7DFFFABACB1FFE0E1F5FFD7D9FAFF4F55E0FFA6A7EEFFB4B5EFFFABAD
        EBFF9396E5FFBABAE8FFCBCCEAFFDDDCECFFFFFDF0FFFFFFF4FFFFFFF7FFFFFF
        F9FFFFFFFFFF5C5FA8FE00000037FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000811E766684EFFFF9CEFFFFF6E2FFFFEB99FFFFEFADFFFFF6D5FFFFFF
        F0FFF2F0E0FFABABAAFFFFFFF8FFFFFFFFFF656BE5FFF3F4FEFFFFFFFFFFFDFD
        FFFF5A61E3FFCED0F7FFD1D2F8FFB2B5F1FF6A6FE3FFAEAFECFFADAEEAFFB6B6
        E8FFF6F6F6FF6C6EA8F500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000007F1E766889EFFFF2B6FFF8E3BEFFA79BBBFFB6B7D4FFD7D6E7FFE6E8
        F2FFBBBBE1FFE5E5DEFFFFFFFFFFA6CAF8FF696FE5FFF3F3FDFFFFFFFFFFECF3
        FDFF6E74E5FFF4F3FDFFFFFFFFFFFFFFFFFF6F77E7FFFDFDFFFFF2F2FEFFC1C3
        F6FFDDDCF3FF6F71A9F500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000801E766686EFFFFAC4FFE6EAFFFF686EEDFF767DEEFF6C70E9FF555B
        E3FF232ADCFF787DEDFF8388EAFF677FEAFF4850E0FFC5C6F5FFEBEDFCFF88B1
        F4FF6770E5FFFFFFFFFFFFFFFFFFAFB1F1FF767DE8FFFFFFFFFFFFFFFFFFD7D8
        F8FFE1E1F5FF6E70A9F500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000801E766685EFFFFCC9FFDEE1FCFFC2C3F3FFFFFFFFFFFFFFFFFFE5E6
        FBFF6065E4FFD4D6F7FFB3B6F2FF9E9EEEFF363EDDFF696FE5FF6A6FE5FF6B6F
        E5FF3039DBFF7C81E8FF9699EDFF646AE4FF5C64E3FFE6E7FBFFD7D8F8FF8084
        E9FFEEEEF8FF6E70AAF500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000801E766685EFFFFCC9FFDFE3FCFFB7B9F1FFFFFFFFFFFFFFFFFFE8E8
        FBFF6A6FE5FFFFFFFFFFFFFFFFFFFFFFFFFF6D72E5FFF7F8FEFFFFFFFFFFEEEE
        FCFF6167E3FFB2B4F2FFA4A7EFFF8E92ECFF3841DDFF7074E6FF686DE5FF585C
        E2FFDDDDF7FF7173ABF500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000811E766684EFFFFCC9FFDEE2FEFFA6A8EFFFF3F3FDFFD4E1FBFF769B
        F0FF7879E8FFFFFFFFFFFFFFFFFFC1D7F9FF656BE5FFF0F0FDFFFFFFFFFFFFFF
        FFFF7076E5FFF7F7FEFFFFFFFFFFFFFFFFFF7A80E8FFFFFFFFFFF3F3FDFFC3C3
        F5FFDEDEF8FF6F72ABF500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000811E766684EFFFF9C9FFF6F8FFFFAFB0EEFFA7A9EEFFA4A8EFFF8E96
        ECFF4D52E0FF9A9DEEFFB3B8F2FF7395EEFF5B62E3FFE7E6FAFFFFFFFFFF97BD
        F6FF6B73E6FFFFFFFFFFFFFFFFFFB6CCF7FF747BE7FFFFFFFFFFFFFFFFFFDADC
        F9FFE1E1FAFF6E71ACF500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000811E766684EFFFF7C8FFFFFFFFFFFFFFFCFFFFFEFBFFF6F6FAFFF1F0
        FAFF8D90EAFF8589E9FF8185E9FF7E7EE8FF2B34DAFF5A5FE2FF6C71E5FF6570
        E6FF3841DDFF8F92EBFFA8ADF1FF6685EAFF646BE5FFEDEEFCFFDCE9FCFF80A1
        EFFFEEEAFCFF6E71ACF500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000811E766684EFFFF7C9FFFFFFFFFFFFFEFCFFFFFFFCFFFFFFFCFFFFFE
        FCFFAFB2F1FFFFFFFFFFFFFFFFFFFFFFFFFF676DE4FFDFE0FAFFE5E6FBFFD1D2
        F7FF5058E0FF9093ECFF8F92EBFF8686E9FF343CDCFF656BE5FF676EE5FF5960
        E2FFDEDEFCFF7073ADF500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000811E766684EFFFF7C9FFFFFFFFFFFFFFFDFFFFFEFDFFFFFFFDFFFCFB
        FDFFAAADF0FFFBFBFEFFFFFFFFFFEAF0FDFF666CE4FFEFF0FDFFFFFFFFFFFFFF
        FFFF7479E6FFFCFCFEFFFFFFFFFFFFFFFFFF767DE8FFF7F7FDFFEDEEFCFFC1C1
        F4FFDDDEFDFF6F72ADF500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000811E766684EFFFF7C9FFFFFFFFFFFFFFFEFFFFFFFEFFFFFFFEFFFDFD
        FEFF999CEDFFD9DAF8FFE5E8FBFF7BA3F1FF575EE2FFF1F0FCFFFFFFFFFF9FC2
        F6FF666EE5FFF9F8FEFFFFFFFFFFC5D4F8FF747AE7FFFFFFFFFFFFFFFFFFDDDD
        F9FFE1E2FFFF6E72AEF500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000811E766684EFFFF7C9FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFD2D3F7FFB5B7F2FFB4B6F2FFB3B3F1FF767BE7FFAAACF0FFB9BBF3FF8FA1
        EFFF545CE2FFBDBDF3FFCFD4F8FF7091EDFF5D65E3FFEEEFFCFFD8E5FBFF7595
        EEFFEBE8FFFF6E72AEF500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000821D806F83EEFFFFCCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7F8FFFFF4F5FFFFF1EF
        FFFFE4E6FFFFCBCCF7FFC7C8F5FFCECBF5FFA5A8EFFFB1B3F1FFAAADF0FF9197
        ECFFE9EAFFFF6D71AEF500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF000000801E433E89EE7673A9FF787CC5FF8B8CC8FF9E9ECEFFB5B3D6FFC5C4
        DDFFD9D8E7FFE8E7EEFFF1F0F2FFFAF8F7FFFFFFFCFFFFFFFFFFF4F3E9FFDFDE
        D2FFEAE9DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF666AAEF500000035FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000005C210015A3F1000AC7FF0000C5FF0000C1FF0000BDFF0005BBFF000A
        B7FF0214B6FF0D1EB4FF1B27B4FF2B33B3FF3E46BBFF3D439FFF2E3576FF3B41
        7DFF4B4D82FF666796FFA5A3D3FFC0BADBFFD0CAE1FFE2DCE9FFEEE7EFFFF7F0
        F3FFFFFDFAFF696BADF400000034FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000004F220728ADF20728D8FF0009D6FF0012D8FF0014D9FF0017DBFF001C
        DCFF001EDDFF0020DDFF0023DDFF0025DEFF001BDAFF1F3795FF9195ABFF636E
        9CFF303E86FF63648CFF1333ABFF002AC9FF0031BEFF0835BCFF163BBAFF2540
        B8FF3C52BFFF1B2793F500010D35FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000004922082EB1F2082EDCFF0008D3FF0012D4FF0015D5FF0018D6FF001C
        D7FF0020D8FF0024D9FF0029DAFF0028DFFF183ACAFFDDDCD5FFE5E1D7FFBAB8
        B1FFE2E1D9FFF7F2E6FFB9BEC2FF0E56DDFF0059F0FF005EEDFF005EEDFF005E
        ECFF005FF1FF0027A4F600000136FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00000043220935B6F20936E1FF0008D2FF0012D5FF0015D6FF0019D7FF001D
        D8FF0021D8FF0026DAFF002BDBFF0021DEFF546BC7FFFFFFEFFFCECDCEFFCCCB
        CBFFFEFEFEFFE7E7E7FFE4DACBFF3C6CC8FF0050EBFF005BE7FF005EE8FF0061
        E9FF0068F1FF002CA6F600000036FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000003B210B3BBBF10B3CE6FF0008D1FF0014D5FF0016D6FF001AD7FF001E
        D8FF0023D9FF0027DAFF002CDBFF0024E0FF4A63C4FFF1EAD6FFCDCDCEFFC7C6
        C6FFEBE9E6FFE3E1E0FFE4D9C7FF2E65CAFF0053ECFF005CE8FF005FE9FF0062
        E9FF0068F1FF002CA6F600000036FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0000003F230D45C3F60C45F0FF0003D3FF0011D7FF0014D8FF0019D9FF001F
        DAFF0024DBFF0029DDFF002EDEFF0031E3FF0B36D3FFB7B8BDFFE8E1CCFFBFBB
        AEFFB4B4B5FFE1D9C8FF8597BBFF024EE2FF005AE9FF005DE8FF0060E9FF0062
        E9FF0068F1FF002CA6F600000037FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00000046170831B2EE0E4CDBFF082DD0FF072CD0FF0628D0FF0527D0FF0326
        D0FF0326D0FF0226D1FF0128D3FF002DD5FF002CDCFF143ECAFF6F81C0FF4D70
        C9FF0D47D4FF2159D1FF0050E5FF005AEFFF0061EEFF0065F0FF0069F0FF006A
        F0FF0070F9FF002EA9FA0000002EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000007D32010A8666041B916F0418927E0417938D041695980315
        96A6031296AF021096BA010D97CA000C97D5000D99DA0009A0E00001A1EA0008
        A5F10012A9F70013ADFF001AADFF001EAFFF0023B3FF0028B8FF002DBCFF0032
        C1FF0039C3FF001E9DCB00000009FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00000000010000250600004B0C00005F160000
        671E00006E250000712D000073320000773D00007A4C00007C5800007F630000
        806900006F4B00005610FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 1
      OnClick = BtnAgendaClick
    end
    object BtnPeriodo: TcxButton
      Left = 204
      Top = 3
      Width = 98
      Height = 39
      Caption = '&Periodo'
      OptionsImage.Glyph.Data = {
        B60F0000424DB60F0000000000003600000028000000200000001F0000000100
        200000000000800F000000000000000000000000000000000000FFFFFF00FFFF
        FF05FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFF
        FF07FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFF
        FF07FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFF
        FF07FFFFFF07FFFFFF07FFFFFF07FFFFFF07FFFFFF05FFFFFF00CCEBFF03D4EA
        FF22D4EAFF28D7EBFF27D7ECFF27D7ECFF27D7ECFF27D7ECFF27D6EBFF27DFEF
        FF27EEF7FF27E1F0FF27D6EBFF27D7ECFF27D7ECFF27D7ECFF27D7ECFF27D7EC
        FF27D7ECFF27D7EBFF27E7F3FF27EDF6FF27DAEDFF27D7EBFF27D7ECFF27D7EC
        FF27D7ECFF27D7ECFF27D6EBFF27D4EAFF28D3E9FF21FFFFFF00B1DCFF04B4D9
        FF48C3E1FF53B5D9FF55B3D8FF55B3D8FF55B3D8FF55B3D8FF55B3D8FF55B2D8
        FF55B2D8FF55B2D8FF55B3D8FF55B3D8FF55B3D8FF55B3D8FF55B3D8FF55B3D8
        FF55B3D8FF55B3D8FF55B2D8FF55B2D8FF55B2D8FF55B3D8FF55B3D8FF55B3D8
        FF55B3D8FF55B3D8FF55B6DAFF54C3E0FF54B8DBFF43FFFFFF00FFFFFF0053A8
        FF54208FFFD31086FFE30F86FFE50F86FFE40F86FFE40F86FFE40F86FFE40F86
        FFE40F86FFE40F86FFE40F86FFE40F86FFE40F86FFE40F86FFE40F86FFE40F86
        FFE40F86FFE40F86FFE40F86FFE40F86FFE40F86FFE40F86FFE40F86FFE40F86
        FFE40F86FFE40F86FFE51187FFE21E8EFFD545A2FF5CFFFFFF00078BFF05007D
        FFBF007DFFFF007EFFFF007EFFFF007EFFFF007EFFFF007EFFFF007EFFFF007D
        FFFF0079FFFF007CFFFF007EFFFF007EFFFF007EFFFF007EFFFF007EFFFF007E
        FFFF007EFFFF007EFFFF007BFFFF0079FFFF007EFFFF007EFFFF007EFFFF007E
        FFFF007EFFFF007EFFFF007EFFFF007DFFFF007DFFB7D2FBB4010189FF140080
        FFDD007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007DFFFF007F
        FFFF2E95FFFF0682FFFF007CFFFF007FFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF0080FFFF007AFFFF178AFFFF2A94FFFF007AFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD243AEED070089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007EFFFF047CFFFFB3D8
        FFFFFFFFFFFFCBE4FFFF0980FFFF0077FFFF0075FFFF0074FFFF0075FFFF0076
        FFFF0076FFFF2D94FFFFEFF7FFFFFFFFFFFF74B9FFFF0077FFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD038A9F4080089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007BFFFF188CFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF2591FFFF3695FFFF71B7FFFF8CC5FFFF87C2FFFF63B0
        FFFF1F86FFFF66B2FFFFFFFFFFFFFFFFFFFFDAECFFFF0079FFFF007EFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD00088FF050089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007EFFFF027BFFFF9ECE
        FFFFEDF6FFFFEEF6FFFFCFE6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFAFDFFFFC9E3FFFFF3F9FFFFEBF4FFFF67B2FFFF0078FFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007EFFFF0071
        FFFF85C1FFFFFFFFFFFFFFFFFFFFFFFFFFFFE9F3FFFFCCE4FFFFD1E6FFFFF5FA
        FFFFFFFFFFFFFFFFFFFFF0F7FFFF48A1FFFF0071FFFF0080FFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF0076FFFF4DA5
        FFFFFFFFFFFFFFFFFFFFDDEEFFFF51A4FFFF0980FFFF0079FFFF007AFFFF1686
        FFFF77B9FFFFFBFDFFFFFFFFFFFFE7F3FFFF1B89FFFF007AFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007CFFFF0F84FFFFECF5
        FFFFFFFFFFFFD6EAFFFF1384FFFF0074FFFF007DFFFF007FFFFF007EFFFF007C
        FFFF0071FFFF419EFFFFF9FCFFFFFFFFFFFFB4D9FFFF0077FFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF0075FFFF71B7FFFFFFFF
        FFFFFBFDFFFF2A94FFFF0076FFFF0080FFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007BFFFF0068FFFF6AB4FFFFFFFFFFFFFFFFFFFF2E96FFFF0079FFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF0078FFFFC1E0FFFFFFFF
        FFFFAFD7FFFF0074FFFF007FFFFF007FFFFF007FFFFF007AFFFF0074FFFF0079
        FFFF2C93FFFF7CBCFFFF5AABFFFFDFEFFFFFFFFFFFFF7BBCFFFF0074FFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007DFFFF0380FFFFE4F1FFFFFFFF
        FFFF6DB5FFFF0074FFFF007FFFFF007FFFFF007DFFFF2E93FFFF84BFFFFFD7EA
        FFFFD0E6FFFF75B7FFFF127EFFFFB3D8FFFFFFFFFFFFA5D1FFFF0075FFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007DFFFF0984FFFFEBF5FFFFFFFF
        FFFF5EADFFFF0076FFFF007FFFFF007FFFFF0078FFFFD5E9FFFFF3F9FFFF63AD
        FFFF037DFFFF0075FFFF0074FFFFA8D3FFFFFFFFFFFFAFD6FFFF0076FFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007EFFFF017EFFFFDEEEFFFFFFFF
        FFFF7CBDFFFF0073FFFF007FFFFF007FFFFF0077FFFFCFE7FFFF80BFFFFF006C
        FFFF007EFFFF007FFFFF0077FFFFC4E1FFFFFFFFFFFF9ACCFFFF0074FFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF0076FFFFB0D7FFFFFFFF
        FFFFCCE5FFFF0077FFFF007EFFFF007FFFFF0076FFFFBFDFFFFF73B8FFFF0076
        FFFF007FFFFF007AFFFF198BFFFFF8FBFFFFFFFFFFFF61AFFFFF0076FFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF0077FFFF4EA6FFFFFFFF
        FFFFFFFFFFFF5AACFFFF0071FFFF007FFFFF0075FFFFAFD6FFFF61AFFFFF0077
        FFFF007DFFFF0072FFFFA3D0FFFFFFFFFFFFF5FAFFFF1387FFFF007CFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007EFFFF0079FFFFC5E2
        FFFFFFFFFFFFF7FBFFFF48A1FFFF0072FFFF006CFFFF9ECEFFFF4AA4FFFF006E
        FFFF0076FFFF7EBEFFFFFFFFFFFFFFFFFFFF7CBDFFFF0075FFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF0079FFFF218C
        FFFFEFF7FFFFFFFFFFFFFFFFFFFFA0CEFFFF4599FFFF65AFFFFF459FFFFF58A5
        FFFFC1DFFFFFFFFFFFFFFFFFFFFFC0DFFFFF027AFFFF007EFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF0080FFFF0077
        FFFF2F93FFFFDCEDFFFFFFFFFFFFFFFFFFFFFFFFFFFFF4F9FFFFFDFDFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFB2D8FFFF0A7FFFFF007BFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF0080
        FFFF0078FFFF0A81FFFF76B8FFFFD3E8FFFFFBFDFFFFFFFFFFFFFFFFFFFFF4F9
        FFFFBFDEFFFF54A7FFFF0078FFFF007BFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007EFFFF0682FFFF1287FFFF2490FFFF4BA4FFFF64B0FFFF60AEFFFF419E
        FFFF1B8BFFFF1387FFFF0080FFFF007FFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007BFFFF1E8EFFFFFFFFFFFFFCFEFFFFF5FAFFFFF1F8FFFFF2F8FFFFF7FB
        FFFFFFFFFFFFCFE7FFFF017AFFFF007EFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060089FF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF0076FFFF92C8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF4EA5FFFF0077FFFF007FFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF06038AFF140080
        FFD9007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF007DFFFF017BFFFF92C7FFFFFBFCFFFFFFFFFFFFFFFFFFFFE9F3
        FFFF5FADFFFF0076FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD0008FFF060A8CFF0A007F
        FFD6007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007DFFFF0076FFFF208EFFFF4CA5FFFF45A1FFFF0F85
        FFFF0076FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFD10A92FF03FFFFFF000080
        FFBC007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007BFFFF0077FFFF0078FFFF007D
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007FFFFF007F
        FFFF007FFFFF007FFFFF007FFFFF007FFFFF0180FFB8FFFFFF00FFFFFF000281
        FF310180FFAE007FFFCA007FFFCE007FFFCE017FFFCE017FFFCE017FFFCE007F
        FFCF007FFFCF007FFFCF007FFFCF0080FFCF0180FFD00180FFD00180FFD00180
        FFD00080FFD00080FFD10080FFD10080FFD10180FFD10180FFD20180FFD20180
        FFD20080FFD20080FFD30080FFCE0180FFAC0281FF2BFFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF0050A7FF0189C9FF016EBAFF0162BBFF014EB2FF0232B2
        FF0218A9FF0204A1FF0316A8FF0325AEFF032EB6FF042BB3FF0427B0FF0420AF
        FF0412A7FF0503A0FF050A9CFF0517A1FF061CA3FF061DA3FF061BA0FF07169E
        FF070D99FF070593FF084CE7FF01FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 2
      OnClick = BtnPeriodoClick
    end
  end
  inherited PnlCampos: TPanel
    Width = 620
    Height = 302
    ExplicitWidth = 620
    ExplicitHeight = 302
    object StgGrid: TStringGrid
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 612
      Height = 294
      Align = alClient
      BevelWidth = 5
      Color = clWhite
      ColCount = 1
      DefaultColWidth = 110
      DefaultRowHeight = 70
      DrawingStyle = gdsGradient
      FixedCols = 0
      RowCount = 1
      FixedRows = 0
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      GradientEndColor = clBtnFace
      GridLineWidth = 3
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
      OnDrawCell = StgGridDrawCell
      ExplicitLeft = 8
      ExplicitTop = 0
    end
  end
  object PrbPesquisa: TProgressBar
    AlignWithMargins = True
    Left = 3
    Top = 367
    Width = 620
    Height = 17
    Align = alBottom
    TabOrder = 3
  end
  object CdsHorarios: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 550
    Top = 91
  end
  object CdsProfissionais: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 550
    Top = 187
  end
  object CdsAgenda: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 552
    Top = 138
  end
end
