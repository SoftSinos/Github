If (Select Count(*) From Licenca Where NmMenu = 'MenExecutarScriptSQL') = 0
  Begin
    Insert Into Licenca (NmMenu, NmLicenca) Values ('MenExecutarScriptSQL', 'Full')
  End;