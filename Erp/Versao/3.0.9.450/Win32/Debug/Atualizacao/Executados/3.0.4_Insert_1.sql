If (Select Count(*) From Licenca Where NmMenu = 'MenManManualSginERP') = 0
  Begin
    Insert Into Licenca (NmMenu, NmLicenca) Values ('MenManManualSginERP', 'Full')
  End
GO
  
