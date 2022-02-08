unit uClass.Mov.Pedido;
interface

uses
  System.Classes, FireDAC.Comp.Client, Winapi.Windows;

type
  TMovPedidoItem = class;

  TMovPedido = class
  private
    fListItems: TList;
    fOwner: TObject;
    fConnection: TFDConnection;

    fCodPedido: Integer;
    fCodCliente: Integer;
    fDataPedido: TDateTime;
    fNomeCliente: string;
    function GetValorTotalItens: Double;
    function GetCount: Integer;
    function GetItems(Index: Integer): TMovPedidoItem;
    procedure SetCodCliente(const Value: Integer);
  public
    constructor Create( aOwner: TObject; aConnection: TFDConnection ); virtual;
    destructor Destroy; override;

    function Add : TMovPedidoItem;
    procedure Clear;
    function Delete(aCodPedido: Integer): Boolean;
    function RemoveItem( aItem: TMovPedidoItem ): Boolean;
    function Load(aCodPedido: Integer): Boolean;
    function Save: Boolean;
    function Valid_CodCliente(aCodCliente: Integer): Boolean;

    property CodPedido: Integer read fCodPedido write fCodPedido;
    property DataPedido: TDateTime read fDataPedido write fDataPedido;
    property CodCliente: Integer read fCodCliente write SetCodCliente;
    property NomeCliente: string read fNomeCliente;
    property ValorTotal: Double read GetValorTotalItens;
    property Count: Integer read GetCount;
    property Itens[ Index: Integer ]: TMovPedidoItem read GetItems;
  end;

  TMovPedidoItem = class
  private
    fMovPedido: TMovPedido;
    fValorUnitario: Double;
    fCodItem: Integer;
    fValorTotal: Double;
    fQuantidade: Double;
    fCodProduto: Integer;
    fNomeProduto: string;
    procedure SetQuantidade(const Value: Double);
    procedure SetValorUnitario(const Value: Double);

    procedure CalculaValorTotalItem;
    procedure SetCodProduto(const Value: Integer);


  public
    constructor Create( aMovPedido: TMovPedido ); virtual;
    destructor Destroy; override;

    function Valid_CodProduto(aCodProduto: Integer): Boolean;

    property CodItem: Integer read fCodItem write fCodItem;
    property CodProduto: Integer read fCodProduto write SetCodProduto;
    property NomeProduto: string read fNomeProduto;
    property ValorUnitario: Double read fValorUnitario write SetValorUnitario;
    property Quantidade: Double read fQuantidade write SetQuantidade;
    property ValorTotal: Double read fValorTotal;
  end;

implementation

uses
  FireDAC.Stan.Param,
  Data.DB,
  System.SysUtils, Vcl.Forms;

{ TMovPedido }

function TMovPedido.Add: TMovPedidoItem;
begin
  Result := TMovPedidoItem.Create( Self );

  Self.fListItems.Add( Result );
end;

procedure TMovPedido.Clear;
var
  I: Integer;
begin
  for I := Self.fListItems.Count - 1 downto 0 do
  begin
    TMovPedidoItem( Self.fListItems.Items[ I ] ).Free;
    Self.fListItems.Delete( I );
  end;

  Self.fListItems.Clear;
end;

constructor TMovPedido.Create(aOwner: TObject; aConnection: TFDConnection);
begin
  Self.fOwner := aOwner;
  Self.fConnection := aConnection;

  Self.fListItems := TList.Create;
  Self.fDataPedido := Now();
end;

function TMovPedido.Delete(aCodPedido: Integer): Boolean;
const
  cSQL = 'DELETE FROM PEDIDOS WHERE PEDIDO = :pPEDIDO';
  cSQLItem = 'DELETE FROM PEDIDOITENS WHERE PEDIDO = :pPEDIDO';
var
  vQry: TFDQuery;
begin
  vQry := TFDQuery.Create( nil );
  try
    vQry.Connection := Self.fConnection;
    vQry.SQL.Clear;
    vQry.SQL.Add( cSQLItem );
    vQry.ParamByName('pPEDIDO').AsInteger := aCodPedido;
    try
      vQry.ExecSQL;

      vQry.SQL.Clear;
      vQry.SQL.Add( cSQL );
      vQry.ParamByName('pPEDIDO').AsInteger := aCodPedido;
      try
        vQry.ExecSQL;

        Result := True;
      except on E: Exception do
        begin
          Application.MessageBox(pChar('Não foi possível excluir o pedido desejado.' + sLineBreak +
                                 sLineBreak +
                                 'Erro encontrado:' + sLineBreak +
                                 E.Message
                                 ),
                                 'Erro de execução do Script SQL',
                                 MB_OK+MB_DEFBUTTON1+MB_ICONERROR
                               );
          Result := False;
        end;
      end;
    except on E: Exception do
      begin
        Application.MessageBox(pChar('Não foi possível excluir o pedido desejado.' + sLineBreak +
                               sLineBreak +
                               'Erro encontrado:' + sLineBreak +
                               E.Message
                               ),
                               'Erro de execução do Script SQL',
                               MB_OK+MB_DEFBUTTON1+MB_ICONERROR
                             );
        Result := False;
      end;
    end;
  finally
    vQry.Free;
  end;
end;

destructor TMovPedido.Destroy;
begin
  Self.Clear;

  if Assigned( Self.fListItems ) then
  begin
    Self.fListItems.Free;
  end;

  inherited;
end;

function TMovPedido.GetCount: Integer;
begin
  Result := Self.fListItems.Count;
end;

function TMovPedido.GetItems(Index: Integer): TMovPedidoItem;
begin
  Result := TMovPedidoItem( Self.fListItems.Items[ Index ] );
end;

function TMovPedido.Load(aCodPedido: Integer): Boolean;
const
  cSQL = 'SELECT P.PEDIDO, P.DATA, P.CLIENTE, C.NOME, P.VR_TOTAL ' +
         '  FROM PEDIDOS P '+
         ' INNER JOIN CLIENTES C ON (P.CLIENTE = C.CODIGO) ' +
         ' WHERE P.PEDIDO = :pPEDIDO';

  cSQL_Itens = 'SELECT A.ITEM, ' +
               '       A.PRODUTO,' +
               '       B.DESCRICAO,' +
               '       A.VR_UNIT,' +
               '       A.QUANTIDADE,' +
               '       A.VR_TOTAL '+
               '  FROM PEDIDOITENS A' +
               ' INNER JOIN PRODUTOS B ON (A.PRODUTO = B.CODIGO)' +
               ' WHERE A.PEDIDO = :pPEDIDO';
var
  vQry: TFDQuery;
  vItem: TMovPedidoItem;
begin
  vQry := TFDQuery.Create( nil );
  try
    vQry.Connection := Self.fConnection;
    vQry.SQL.Clear;
    vQry.SQL.Add( cSQL );
    vQry.ParamByName('pPEDIDO').AsInteger := aCodPedido;
    vQry.Open;

    if not vQry.IsEmpty and (vQry.RecordCount <> 0) then
    begin
      Self.fCodPedido := vQry.FieldByName('PEDIDO').AsInteger;
      Self.fDataPedido := vQry.FieldByName('DATA').AsDateTime;
      Self.fCodCliente := vQry.FieldByName('CLIENTE').AsInteger;
      Self.fNomeCliente := vQry.FieldByName('NOME').AsString;

      vQry.Close;
      vQry.SQL.Clear;
      vQry.SQL.Add(cSQL_Itens);
      vQry.ParamByName('pPEDIDO').AsInteger := aCodPedido;
      vQry.Open;

      vQry.First;

      while not vQry.Eof do
      begin
        vItem := Self.Add;

        vItem.fCodItem := vQry.FieldByName('ITEM').AsInteger;
        vItem.fCodProduto := vQry.FieldByName('PRODUTO').AsInteger;
        vItem.fNomeProduto := vQry.FieldByName('DESCRICAO').AsString;
        vItem.fValorUnitario := vQry.FieldByName('VR_UNIT').AsInteger;
        vItem.fQuantidade := vQry.FieldByName('QUANTIDADE').AsFloat;
        vItem.fValorTotal := vQry.FieldByName('VR_TOTAL').AsFloat;

        vQry.Next;
      end;

      Result := True;
    end
    else
    begin
      Result := False;
    end;
  finally
    vQry.Free;
  end;
end;

function TMovPedido.RemoveItem( aItem: TMovPedidoItem ): Boolean;
var
  I: Integer;
begin
  for I := Self.fListItems.Count - 1 downto 0 do
  begin
    if TMovPedidoItem( Self.fListItems.Items[ I ] ) = aItem then
    begin
      TMovPedidoItem( Self.fListItems.Items[ I ] ).Free;
      Self.fListItems.Delete( I );
    end;
  end;
end;

function TMovPedido.Save: Boolean;
const
  SQL_INSERT = 'INSERT INTO PEDIDOS (' +
                 'DATA, ' +
                 'CLIENTE, ' +
                 'VR_TOTAL '+
               ') VALUES ( ' +
                 ':pDATA,  ' +
                 ':pCLIENTE, ' +
                 ':pVR_TOTAL ' +
               ')';
  SQL_INSERT_ITENS = 'INSERT INTO PEDIDOITENS ( ' +
                     '  PEDIDO,' +
                     '  PRODUTO,' +
                     '  VR_UNIT,' +
                     '  QUANTIDADE,' +
                     '  VR_TOTAL' +
                     ') VALUES (' +
                     '  :pPEDIDO,' +
                     '  :pPRODUTO,' +
                     '  :pVR_UNIT,' +
                     '  :pQUANTIDADE,' +
                     '  :pVR_TOTAL' +
                     ')';
  SQL_UPDATE = 'UPDATE' +
               '   PEDIDOS' +
               ' SET' +
               '   DATA = :pDATA,' +
               '   CLIENTE = :pCLIENTE,' +
               '   VR_TOTAL = :pVR_TOTAL' +
               ' WHERE PEDIDO = :pPEDIDO';

  SQL_UPDATE_ITENS = 'UPDATE '+
                     '   PEDIDOITENS '+
                     ' SET '+
                     '   PRODUTO = :pPRODUTO, '+
                     '   VR_UNIT = :pVR_UNIT, '+
                     '   QUANTIDADE = :pQUANTIDADE, '+
                     '   VR_TOTAL = :pVR_TOTAL '+
                     ' WHERE ITEM = :pITEM '+
                     '   AND PEDIDO = :pPEDIDO';

var
  vQry: TFDQuery;
  I: Integer;
  vStrAux: string;
  vSQLDeleteItem: string;
begin
  if Self.fCodPedido = 0 then
  begin
    {$REGION ' INSERT '}
    vQry := TFDQuery.Create( nil );
    try
      try
        Self.fConnection.StartTransaction;
        vQry.Connection := Self.fConnection;
        vQry.SQL.Clear;
        vQry.SQL.Add( SQL_INSERT );

        vQry.ParamByName('pDATA').AsDateTime := Self.DataPedido;
        vQry.ParamByName('pCLIENTE').AsInteger := Self.CodCliente;
        vQry.ParamByName('pVR_TOTAL').AsFloat := Self.ValorTotal;

        vQry.ExecSQL;

        vQry.SQL.Clear;
        vQry.Open('SELECT LAST_INSERT_ID()');

        if not vQry.Eof then
        begin
          Self.fCodPedido := vQry.Fields[0].AsInteger;
        end;

        for I := 0 to Self.Count - 1 do
        begin
          vQry.SQL.Clear;
          vQry.SQL.Add( SQL_INSERT_ITENS );

          vQry.ParamByName('pPEDIDO').AsInteger := Self.CodPedido;
          vQry.ParamByName('pPRODUTO').AsInteger := Self.Itens[ I ].CodProduto;
          vQry.ParamByName('pVR_UNIT').AsFloat := Self.Itens[ I ].ValorUnitario;
          vQry.ParamByName('pQUANTIDADE').AsFloat := Self.Itens[ I ].Quantidade;
          vQry.ParamByName('pVR_TOTAL').AsFloat := Self.Itens[ I ].ValorTotal;
          vQry.ExecSQL;

          vQry.SQL.Clear;
          vQry.Open('SELECT LAST_INSERT_ID()');

          if not vQry.Eof then
          begin
            Self.Itens[ I ].CodItem := vQry.Fields[0].AsInteger;
          end;
        end;

        Self.fConnection.Commit;
        Result := True;
      except on E: Exception do
        begin
          Result := False;
          Self.fConnection.Rollback;
        end;
      end;
    finally
      vQry.Free;
    end;
    {$ENDREGION}
  end
  else
  begin
    {$REGION ' UPDATE '}
    vQry := TFDQuery.Create( nil );
    try
      try
        Self.fConnection.StartTransaction;
        vQry.Connection := Self.fConnection;
        vQry.SQL.Clear;
        vQry.SQL.Add( SQL_UPDATE );

        vQry.ParamByName('pPEDIDO').AsInteger := Self.CodPedido;
        vQry.ParamByName('pDATA').AsDateTime := Self.DataPedido;
        vQry.ParamByName('pCLIENTE').AsInteger := Self.CodCliente;
        vQry.ParamByName('pVR_TOTAL').AsFloat := Self.ValorTotal;

        vQry.ExecSQL;

        vStrAux := EmptyStr;
        for I := 0 to Self.Count - 1 do
        begin
          if Self.Itens[ I ].CodItem <> 0 then
          begin
            if vStrAux <> EmptyStr then
            begin
              vStrAux := vStrAux + ', ';
            end;

            vStrAux := vStrAux + IntToStr( Self.Itens[ I ].CodItem );
          end;
        end;

        if vStrAux <> EmptyStr then
        begin
          vSQLDeleteItem := 'DELETE FROM PEDIDOITENS WHERE PEDIDO = :pPEDIDO AND ITEM NOT IN (' + vStrAux+')';
          vQry.SQL.Clear;
          vQry.SQL.Add( vSQLDeleteItem );
          vQry.ParamByName('pPEDIDO').AsInteger := Self.CodPedido;
          vQry.ExecSQL;
        end;

        for I := 0 to Self.Count - 1 do
        begin
          vQry.SQL.Clear;

          if Self.Itens[ I ].CodItem = 0 then
          begin
            vQry.SQL.Add( SQL_INSERT_ITENS );

            vQry.ParamByName('pPEDIDO').AsInteger := Self.CodPedido;
            vQry.ParamByName('pPRODUTO').AsInteger := Self.Itens[ I ].CodProduto;
            vQry.ParamByName('pVR_UNIT').AsFloat := Self.Itens[ I ].ValorUnitario;
            vQry.ParamByName('pQUANTIDADE').AsFloat := Self.Itens[ I ].Quantidade;
            vQry.ParamByName('pVR_TOTAL').AsFloat := Self.Itens[ I ].ValorTotal;
            vQry.ExecSQL;

            vQry.SQL.Clear;
            vQry.Open('SELECT LAST_INSERT_ID()');

            if not vQry.Eof then
            begin
              Self.Itens[ I ].CodItem := vQry.Fields[0].AsInteger;
            end;
          end
          else
          begin
            vQry.SQL.Add( SQL_UPDATE_ITENS );

            vQry.ParamByName('pPEDIDO').AsInteger := Self.CodPedido;
            vQry.ParamByName('pITEM').AsInteger := Self.Itens[ I ].CodItem;
            vQry.ParamByName('pPRODUTO').AsInteger := Self.Itens[ I ].CodProduto;
            vQry.ParamByName('pVR_UNIT').AsFloat := Self.Itens[ I ].ValorUnitario;
            vQry.ParamByName('pQUANTIDADE').AsFloat := Self.Itens[ I ].Quantidade;
            vQry.ParamByName('pVR_TOTAL').AsFloat := Self.Itens[ I ].ValorTotal;
            vQry.ExecSQL;
          end;
        end;

        Self.fConnection.Commit;
        Result := True;
      except on E: Exception do
        begin
          Result := False;
          Self.fConnection.Rollback;
        end;
      end;
    finally
      vQry.Free;
    end;
    {$ENDREGION}
  end;
end;

procedure TMovPedido.SetCodCliente(const Value: Integer);
const
  cSQL = 'SELECT NOME FROM CLIENTES WHERE CODIGO = :pCODIGO';
var
  vQry: TFDQuery;
begin
  Self.fCodCliente := Value;

  vQry := TFDQuery.Create( nil );
  try
    vQry.Connection := Self.fConnection;
    vQry.SQL.Clear;
    vQry.SQL.Add( cSQL );
    vQry.ParamByName('pCODIGO').AsInteger := Self.fCodCliente;
    vQry.Open;

    if not vQry.IsEmpty
    and (vQry.RecordCount = 1) then
    begin
      Self.fNomeCliente := vQry.Fields[0].AsString;
    end;
  finally
    vQry.Free;
  end;
end;

function TMovPedido.Valid_CodCliente(aCodCliente: Integer): Boolean;
const
  cSQL = 'SELECT 1 FROM CLIENTES WHERE CODIGO = :pCODIGO';
var
  vQry: TFDQuery;
begin
  Result := False;

  vQry := TFDQuery.Create( nil );
  try
    vQry.Connection := Self.fConnection;
    vQry.SQL.Clear;
    vQry.SQL.Add( cSQL );
    vQry.ParamByName('pCODIGO').AsInteger := aCodCliente;
    vQry.Open;

    if not vQry.IsEmpty
    and (vQry.RecordCount = 1)
    and (vQry.Fields[0].AsInteger = 1) then
    begin
      Result := True;
    end;

  finally
    vQry.Free;
  end;
end;

function TMovPedido.GetValorTotalItens: Double;
var
  I: Integer;
  vValue: Double;
begin
  vValue := 0;

  for I := 0 to Self.Count - 1 do
  begin
    vValue := vValue + ( Self.Itens[ I ].ValorTotal );
  end;

  Result := vValue;
end;

{ TMovPedidoItems }

procedure TMovPedidoItem.CalculaValorTotalItem;
begin
  if ( Self.fValorUnitario > 0 )
  and ( Self.fQuantidade > 0 ) then
  begin
    Self.fValorTotal := Self.fValorUnitario * Self.fQuantidade;
  end
  else
  begin
    Self.fValorTotal := 0;
  end;
end;

constructor TMovPedidoItem.Create(aMovPedido: TMovPedido);
begin
  Self.fMovPedido := aMovPedido;
end;

destructor TMovPedidoItem.Destroy;
begin
  inherited;
end;

procedure TMovPedidoItem.SetCodProduto(const Value: Integer);
const
  cSQL = 'SELECT DESCRICAO, PRECO_VENDA FROM PRODUTOS WHERE CODIGO = :pCODIGO';
var
  vQry: TFDQuery;
begin

  vQry := TFDQuery.Create( nil );
  try
    vQry.Connection := Self.fMovPedido.fConnection;
    vQry.SQL.Clear;
    vQry.SQL.Add( cSQL );
    vQry.ParamByName('pCODIGO').AsInteger := Value;
    vQry.Open;

    if not vQry.IsEmpty
    and (vQry.RecordCount = 1) then
    begin
      Self.fCodProduto := Value;
      Self.fNomeProduto := vQry.Fields[0].AsString;
      Self.fValorUnitario := vQry.Fields[1].AsFloat;
      if Self.fQuantidade = 0 then
      begin
        Self.fQuantidade := 1;
      end;
      Self.fValorTotal := Trunc( ( vQry.Fields[1].AsFloat * Self.fQuantidade ) * 100 ) / 100;
    end;
  finally
    vQry.Free;
  end;

  Self.fCodProduto := Value;
end;

procedure TMovPedidoItem.SetQuantidade(const Value: Double);
begin
  Self.fQuantidade := Value;
  Self.CalculaValorTotalItem;
end;

procedure TMovPedidoItem.SetValorUnitario(const Value: Double);
begin
  Self.fValorUnitario := Value;
  Self.CalculaValorTotalItem;
end;

function TMovPedidoItem.Valid_CodProduto(aCodProduto: Integer): Boolean;
const
  cSQL = 'SELECT 1 FROM PRODUTOS WHERE CODIGO = :pCODIGO';
var
  vQry: TFDQuery;
begin
  Result := False;

  vQry := TFDQuery.Create( nil );
  try
    vQry.Connection := Self.fMovPedido.fConnection ;
    vQry.SQL.Clear;
    vQry.SQL.Add( cSQL );
    vQry.ParamByName('pCODIGO').AsInteger := aCodProduto;
    vQry.Open;

    if not vQry.IsEmpty
    and (vQry.RecordCount = 1)
    and (vQry.Fields[0].AsInteger = 1) then
    begin
      Result := True;
    end;

  finally
    vQry.Free;
  end;
end;

end.
