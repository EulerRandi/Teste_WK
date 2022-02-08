unit uFrmMovPedidoItens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uClass.Mov.Pedido, uDm,
  FireDAC.Comp.Client, Data.DB, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.Mask, Vcl.Buttons, Vcl.WinXPickers, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet;

type
  TFrmMovPedidoItens = class(TForm)
    PnlBackground: TPanel;
    PnlDados: TPanel;
    DBGrid1: TDBGrid;
    PnlBotton: TPanel;
    BtnFechar: TButton;
    BtnAddProduto: TButton;
    BtnUpdProduto: TButton;
    BtnDelProduto: TButton;
    PnlCabecalho: TPanel;
    LblTitulo: TLabel;
    PnlTitulo_Traco: TPanel;
    ShpBackGround: TShape;
    LblCodPedido: TLabel;
    LblDataPedido: TLabel;
    LblCodCliente: TLabel;
    LblNomeCliente: TLabel;
    EdtCodPedido: TMaskEdit;
    EdtCodCliente: TMaskEdit;
    EdtNomeCliente: TEdit;
    SBtnLookUpCliente: TSpeedButton;
    EdtDataPedido: TDatePicker;
    MemTableItem: TFDMemTable;
    MemTableItemFieldList: TIntegerField;
    DataSource1: TDataSource;
    MemTableItemCodItem: TIntegerField;
    MemTableItemCodProduto: TIntegerField;
    MemTableItemNomeProduto: TStringField;
    MemTableItemValorUnitario: TFloatField;
    MemTableItemQuantidade: TFloatField;
    MemTableItemValorTotal: TFloatField;
    Panel1: TPanel;
    Label1: TLabel;
    LblTituloValorTotal: TLabel;
    LblValorTotalPedido: TLabel;
    BtnGravarPedido: TButton;
    procedure FormShow(Sender: TObject);
    procedure EdtCodClienteExit(Sender: TObject);
    procedure SBtnLookUpClienteClick(Sender: TObject);
    procedure BtnAddProdutoClick(Sender: TObject);
    procedure MemTableItemCalcFields(DataSet: TDataSet);
    procedure BtnUpdProdutoClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnDelProdutoClick(Sender: TObject);
    procedure BtnGravarPedidoClick(Sender: TObject);
    procedure BtnFecharClick(Sender: TObject);
  private
    { Private declarations }
    fMovPedido: TMovPedido;

    procedure ShowCliente;
  public
    { Public declarations }

    constructor Create(AOwner: TComponent; aConnection: TFDConnection; aMovPedido: TMovPedido); reintroduce; virtual;
  end;

implementation

{$R *.dfm}

uses StrUtils, uFrmMovPedidoItensEdit;

{ TFrmMovPedidoItens }

procedure TFrmMovPedidoItens.BtnAddProdutoClick(Sender: TObject);
var
  vProdItem: TMovPedidoItem;
  vFrm: TFrmMovPedidoItensEdit;
begin
  vProdItem := Self.fMovPedido.Add;

  vFrm := TFrmMovPedidoItensEdit.Create( Self, vProdItem );
  try
    if vFrm.ShowModal = mrOk then
    begin
      Self.MemTableItem.Append;
      Self.MemTableItem.Fields[0].AsInteger := Integer( vProdItem );
      Self.MemTableItem.Post;

      Self.LblValorTotalPedido.Caption := FormatFloat('###,###,###,##0.00', Self.fMovPedido.ValorTotal);
    end;
  finally
    vFrm.Free;
  end;
end;

procedure TFrmMovPedidoItens.BtnDelProdutoClick(Sender: TObject);
var
  vProdItem: TMovPedidoItem;
begin
  vProdItem := TMovPedidoItem( Pointer(Self.MemTableItemFieldList.Value ) );

  if Application.MessageBox('Deseja excluir o produto selecionado?', 'Confirmação de Exclusão', MB_YESNO+MB_ICONQUESTION+MB_DEFBUTTON2) = IDYES then
  begin
    Self.MemTableItem.Delete;
    Self.fMovPedido.RemoveItem( vProdItem );
    Self.LblValorTotalPedido.Caption := FormatFloat('###,###,###,##0.00', Self.fMovPedido.ValorTotal);
  end;
end;

procedure TFrmMovPedidoItens.BtnFecharClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmMovPedidoItens.BtnGravarPedidoClick(Sender: TObject);
begin
  if Self.fMovPedido.Save then
  begin
    Self.ModalResult := mrOk;
    Self.Close;
  end;
end;

procedure TFrmMovPedidoItens.BtnUpdProdutoClick(Sender: TObject);
var
  vProdItem: TMovPedidoItem;
  vFrm: TFrmMovPedidoItensEdit;
begin
  vProdItem := TMovPedidoItem( Pointer(Self.MemTableItemFieldList.Value ) );

  vFrm := TFrmMovPedidoItensEdit.Create( Self, vProdItem );
  try
    if vFrm.ShowModal = mrOk then
    begin
      Self.MemTableItem.Edit;
      Self.MemTableItem.Fields[0].AsInteger := Integer( vProdItem );
      Self.MemTableItem.Post;

      Self.LblValorTotalPedido.Caption := FormatFloat('###,###,###,##0.00', Self.fMovPedido.ValorTotal);
    end;
  finally
    vFrm.Free;
  end;
end;

constructor TFrmMovPedidoItens.Create(AOwner: TComponent; aConnection: TFDConnection; aMovPedido: TMovPedido);
begin
  inherited Create(aOwner);

  Self.fMovPedido := aMovPedido;

  Self.MemTableItem.Open;
end;

procedure TFrmMovPedidoItens.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    BtnUpdProdutoClick( Self.BtnUpdProduto );
  end
  else
  if Key = VK_DELETE then
  begin
    BtnDelProdutoClick( Self.BtnDelProduto );
  end;
end;

procedure TFrmMovPedidoItens.EdtCodClienteExit(Sender: TObject);
var
  vCodCliente: Integer;
begin
  vCodCliente := StrToIntDef( Trim( Self.EdtCodCliente.Text ), 0 );

  if Self.fMovPedido.Valid_CodCliente( vCodCliente ) then
  begin
    Self.fMovPedido.CodCliente := vCodCliente;
    Self.ShowCliente;
  end
  else
  begin
    Application.MessageBox('Não existe cliente com o código informado.', 'Código não está cadastrado', MB_OK+MB_ICONASTERISK+MB_DEFBUTTON1);
  end;
end;

procedure TFrmMovPedidoItens.FormShow(Sender: TObject);
var
  I: Integer;
begin
  if Assigned( Self.fMovPedido ) then
  begin
    Self.EdtCodPedido.Text := IfThen( Self.fMovPedido.CodPedido = 0, emptystr, FormatFloat('000000', Self.fMovPedido.CodPedido));
    Self.EdtDataPedido.Date := Self.fMovPedido.DataPedido;
    Self.ShowCliente;

    for I := 0 to Self.fMovPedido.Count - 1 do
    begin
      Self.MemTableItem.Append;
      Self.MemTableItem.Fields[0].AsInteger := Integer( Self.fMovPedido.Itens[ I ] );
      Self.MemTableItem.Post;
    end;

    Self.LblValorTotalPedido.Caption := FormatFloat('###,###,###,##0.00', Self.fMovPedido.ValorTotal);
  end;
end;

procedure TFrmMovPedidoItens.MemTableItemCalcFields(DataSet: TDataSet);
begin
  Self.MemTableItemCodItem.Value := TMovPedidoItem( Pointer( Self.MemTableItemFieldList.Value ) ).CodItem;
  Self.MemTableItemCodProduto.Value := TMovPedidoItem( Pointer( Self.MemTableItemFieldList.Value ) ).CodProduto;
  Self.MemTableItemNomeProduto.Value := TMovPedidoItem( Pointer( Self.MemTableItemFieldList.Value ) ).NomeProduto;
  Self.MemTableItemValorUnitario.Value := TMovPedidoItem( Pointer( Self.MemTableItemFieldList.Value ) ).ValorUnitario;
  Self.MemTableItemQuantidade.Value := TMovPedidoItem( Pointer( Self.MemTableItemFieldList.Value ) ).Quantidade;
  Self.MemTableItemValorTotal.Value := TMovPedidoItem( Pointer( Self.MemTableItemFieldList.Value ) ).ValorTotal;
end;

procedure TFrmMovPedidoItens.SBtnLookUpClienteClick(Sender: TObject);
begin
  Application.MessageBox('Lookup de Cliente não implementado.', 'Falta criar a função', MB_OK+MB_ICONINFORMATION+MB_DEFBUTTON1);
end;

procedure TFrmMovPedidoItens.ShowCliente;
begin
  Self.EdtCodCliente.Text := FormatFloat('000000', Self.fMovPedido.CodCliente);
  Self.EdtNomeCliente.Text := IfThen( Self.fMovPedido.CodCliente = 0, emptystr, Self.fMovPedido.NomeCliente);
end;

end.
