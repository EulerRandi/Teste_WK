unit uFrmMovPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Data.DB,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.Grids, Vcl.DBGrids, uClass.Mov.Pedido;

type
  TFrmMovPedidos = class(TForm)
    PnlBackground: TPanel;
    PnlDados: TPanel;
    PnlBotton: TPanel;
    BtnFechar: TButton;
    ShpBackGround: TShape;
    PnlFiltro: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    LblEdtCodPedido: TLabeledEdit;
    LblEdtCodCliente: TLabeledEdit;
    LblEdtNomeCliente: TLabeledEdit;
    QryMovPedidos: TFDQuery;
    DataSource: TDataSource;
    DBGrid1: TDBGrid;
    QryMovPedidospedido: TFDAutoIncField;
    QryMovPedidosdata: TDateTimeField;
    QryMovPedidoscliente: TIntegerField;
    QryMovPedidosvr_total: TSingleField;
    QryMovPedidosnome: TStringField;
    BtnApllyFilter: TButton;
    TimerApplyFilter: TTimer;
    BtnAddPedido: TButton;
    BtnUpdPedido: TButton;
    BtnDelPedido: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnApllyFilterClick(Sender: TObject);
    procedure onChange_ApplyFilter(Sender: TObject);
    procedure TimerApplyFilterTimer(Sender: TObject);
    procedure DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnAddPedidoClick(Sender: TObject);
    procedure BtnUpdPedidoClick(Sender: TObject);
    procedure BtnDelPedidoClick(Sender: TObject);
  private
    { Private declarations }
    fConnection: TFDConnection;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; aConnection: TFDConnection; aPanelScreen: TPanel); reintroduce; virtual;
  end;

var
  FrmMovPedidos: TFrmMovPedidos;

implementation

{$R *.dfm}

uses uDm, uFrmMovPedidoItens;

procedure TFrmMovPedidos.BtnAddPedidoClick(Sender: TObject);
var
  vMovPedido: TMovPedido;
  vFrm: TFrmMovPedidoItens;
begin
  vMovPedido := TMovPedido.Create( Self, Self.fConnection );
  try
    vMovPedido.Clear;
    vFrm := TFrmMovPedidoItens.Create(Application.MainForm, Self.fConnection, vMovPedido);
    try
      vFrm.Caption := 'Criando novo pedido';
      vFrm.EdtCodPedido.ReadOnly := True;
      vFrm.EdtCodPedido.TabStop := False;

      if vFrm.ShowModal = mrOk then
      begin
        BtnApllyFilterClick(BtnApllyFilter);
      end;
    finally
      vFrm.Close;
    end;
  finally
    vMovPedido.Free;
  end;
end;

procedure TFrmMovPedidos.BtnApllyFilterClick(Sender: TObject);
const
  cSQL = 'SELECT P.PEDIDO, P.DATA, P.CLIENTE, C.NOME, P.VR_TOTAL ' +
         '  FROM PEDIDOS P '+
         ' INNER JOIN CLIENTES C ON (P.CLIENTE = C.CODIGO) ';
var
  vStrList: TStringList;
  I: Integer;
begin
  vStrList := TStringList.Create;
  try
    if Trim(Self.LblEdtCodPedido.Text) <> EmptyStr then
    begin
      vStrList.Add( 'P.PEDIDO = ' + Trim( Self.LblEdtCodPedido.Text ) );
    end;

    if Trim(Self.LblEdtCodCliente.Text) <> EmptyStr then
    begin
      vStrList.Add( 'P.CLIENTE = ' + Trim( Self.LblEdtCodCliente.Text ) );
    end;

    if Trim(Self.LblEdtNomeCliente.Text) <> EmptyStr then
    begin
      vStrList.Add( 'UPPER(C.NOME) LIKE '+ QuotedStr( '%' + UpperCase( Trim( Self.LblEdtNomeCliente.Text ) ) + '%' ) );
    end;


    Self.QryMovPedidos.SQL.Clear;
    Self.QryMovPedidos.Close;
    Self.QryMovPedidos.SQL.Append(cSQL);
    for I := 0 to vStrList.Count - 1 do
    begin
      if I = 0 then
      begin
        Self.QryMovPedidos.SQL.Append(' WHERE ' + vStrList.Strings[ I ] );
      end
      else
      begin
        Self.QryMovPedidos.SQL.Append(' AND ' + vStrList.Strings[ I ] );
      end;
    end;

    try
      Self.QryMovPedidos.Open;
    except on E: Exception do
      begin
        Application.MessageBox(pChar('Não foi possível aplicar o filtro desejado.' + sLineBreak +
                             sLineBreak +
                             'Erro encontrado:' + sLineBreak +
                             DM.ConfigDB.ErrorMsg
                            ),
                       'Erro de Script SQL',
                       MB_OK+MB_DEFBUTTON1+MB_ICONERROR);
        try
          Self.QryMovPedidos.SQL.Clear;
          Self.QryMovPedidos.Close;
          Self.QryMovPedidos.SQL.Append(cSQL);
          Self.QryMovPedidos.Open;
        except on E: Exception do
          Application.MessageBox(pChar('Não foi possível abrir a tabela sem o filtro informado.' + sLineBreak +
                               sLineBreak +
                               'Erro encontrado:' + sLineBreak +
                               DM.ConfigDB.ErrorMsg
                              ),
                         'Erro de Script SQL',
                         MB_OK+MB_DEFBUTTON1+MB_ICONERROR);
        end;
      end;
    end;

    Self.QryMovPedidos.First;
  finally
    vStrList.Free;
  end;
end;

procedure TFrmMovPedidos.BtnDelPedidoClick(Sender: TObject);
var
  vMovPedido: TMovPedido;
begin
  if not ( Self.QryMovPedidos.IsEmpty )
  and (Self.QryMovPedidos.FieldByName('PEDIDO').AsInteger > 0) then
  begin
    vMovPedido := TMovPedido.Create( Self, Self.fConnection );
    try
      vMovPedido.Delete(Self.QryMovPedidos.FieldByName('PEDIDO').AsInteger);
      BtnApllyFilterClick(BtnApllyFilter);
    finally
      vMovPedido.Free;
    end;
  end
  else
  begin
    Application.MessageBox(pChar('Não existe pedido selecionado para ser excluído.'),
                           'Erro de estrutura do banco de dados',
                           MB_OK+MB_DEFBUTTON1+MB_ICONERROR
                           );
  end;
end;

procedure TFrmMovPedidos.BtnFecharClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmMovPedidos.BtnUpdPedidoClick(Sender: TObject);
var
  vMovPedido: TMovPedido;
  vFrm: TFrmMovPedidoItens;
  vResult: Integer;
begin
  if not ( Self.QryMovPedidos.IsEmpty )
  and (Self.QryMovPedidos.FieldByName('PEDIDO').AsInteger > 0) then
  begin
    vMovPedido := TMovPedido.Create( Self, Self.fConnection );
    try
      if vMovPedido.Load( Self.QryMovPedidos.FieldByName('PEDIDO').AsInteger ) then
      begin
        vFrm := TFrmMovPedidoItens.Create(Application.MainForm, Self.fConnection, vMovPedido);
        try
          vFrm.Caption := 'Editando o pedido: '+ FormatFloat('000000', vMovPedido.CodPedido );
          vFrm.EdtCodPedido.ReadOnly := False;
          vFrm.EdtCodPedido.TabStop := True;

          vResult := vFrm.ShowModal;

          if vResult = mrOk then
          begin
          end;

          BtnApllyFilterClick(BtnApllyFilter);
        finally
          vFrm.Close;
        end;
      end
      else
      begin
        Application.MessageBox(pChar('Não foi possível carregar as informações do pedido desejado.'),
                               'Erro de estrutura do banco de dados',
                               MB_OK+MB_DEFBUTTON1+MB_ICONERROR
                               );
      end;
    finally
       vMovPedido.Free;
    end;
  end
  else
  begin
    Application.MessageBox(pChar('Não existe pedido selecionado para ser alterado.'),
                           'Erro de estrutura do banco de dados',
                           MB_OK+MB_DEFBUTTON1+MB_ICONERROR
                           );
  end;
end;

constructor TFrmMovPedidos.Create(AOwner: TComponent; aConnection: TFDConnection; aPanelScreen: TPanel);
begin
  inherited Create(AOwner);

  Self.Parent := aPanelScreen;
  Self.fConnection := aConnection;
  Self.Position := poDefault;
  Self.Width := aPanelScreen.Width;
  Self.Height := aPanelScreen.Height;

  Self.LblEdtCodPedido.OnChange := Self.onChange_ApplyFilter;
  Self.LblEdtCodCliente.OnChange := Self.onChange_ApplyFilter;
  Self.LblEdtNomeCliente.OnChange := Self.onChange_ApplyFilter;

  Self.QryMovPedidos.Connection := Self.fConnection;
  Self.QryMovPedidos.Open();
end;

procedure TFrmMovPedidos.DBGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_DELETE then
  begin
    BtnDelPedidoClick( BtnDelPedido );
  end;
end;

procedure TFrmMovPedidos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmMovPedidos.onChange_ApplyFilter(Sender: TObject);
begin
  Self.TimerApplyFilter.Enabled := True;
end;

procedure TFrmMovPedidos.TimerApplyFilterTimer(Sender: TObject);
begin
  Self.TimerApplyFilter.Enabled := False;
  Self.BtnApllyFilterClick( Self.BtnApllyFilter );
end;

end.



