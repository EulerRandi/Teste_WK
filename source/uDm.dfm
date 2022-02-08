object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 433
  Width = 675
  object Connection: TFDConnection
    Params.Strings = (
      'Database=testewb'
      'User_Name=Euler'
      'Password=ErcTech@520'
      'Server=localhost'
      'DriverID=MySQL')
    LoginPrompt = False
    Left = 80
    Top = 48
  end
  object MySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 'E:\Erc Tech\Testes\WK\Output\libmysql.dll'
    Left = 80
    Top = 104
  end
  object WaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 80
    Top = 160
  end
end
