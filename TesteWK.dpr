program TesteWK;

uses
  Vcl.Forms,
  Winapi.Windows,
  uFrmPrincipal in 'uFrmPrincipal.pas' {FrmPrincipal},
  uDm in 'source\uDm.pas' {DM: TDataModule},
  uFrmConfigDB in 'source\uFrmConfigDB.pas' {FrmConfigDB},
  uClass.Connection in 'source\uClass.Connection.pas',
  uFuncoes in 'source\uFuncoes.pas',
  uFrmMovPedidos in 'source\uFrmMovPedidos.pas' {FrmMovPedidos},
  uClass.Mov.Pedido in 'source\uClass.Mov.Pedido.pas',
  uFrmMovPedidoItens in 'source\uFrmMovPedidoItens.pas' {FrmMovPedidoItens},
  uFrmMovPedidoItensEdit in 'source\uFrmMovPedidoItensEdit.pas' {FrmMovPedidoItensEdit};

{$R *.res}




begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDM, DM);
  if DM.ConfigDB.ConnectDataBase then
  begin
    Application.CreateForm(TFrmPrincipal, FrmPrincipal);
    Application.Run;
  end
  else
  begin
    Application.MessageBox(pChar('Não foi possível conectar ao banco de dados.' + sLineBreak +
                                 sLineBreak +
                                 'Erro encontrado:' + sLineBreak +
                                 DM.ConfigDB.ErrorMsg
                                ),
                           'Erro ao conectar ao banco de dados',
                           MB_OK+MB_DEFBUTTON1+MB_ICONASTERISK);

    Application.CreateForm(TFrmConfigDB, FrmConfigDB);
    Application.Run;
  end;

end.
