/* VERSIONAMENTO */
If (Select Count(*) From Versao Where NrVersaoBd = '3.0.10.459') = 0
  Begin
    Insert Into Versao (NrVersaoBd, NrVersaoApp) Values ('3.0.10.459', '3.0.10.459')
  End	
Go