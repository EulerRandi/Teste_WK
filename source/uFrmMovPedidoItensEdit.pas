unit uFrmMovPedidoItensEdit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask, Vcl.Buttons,
  Vcl.ExtCtrls, FireDAC.Comp.Client, uClass.Mov.Pedido;

type
  TFrmMovPedidoItensEdit = class(TForm)
    PnlBackground: TPanel;
    PnlBotton: TPanel;
    BtnCancelar: TButton;
    PnlCabecalho: TPanel;
    LblTitulo: TLabel;
    LblCodProduto: TLabel;
    LblNomeProduto: TLabel;
    SBtnLookUpProduto: TSpeedButton;
    PnlTitulo_Traco: TPanel;
    EdtCodProduto: TMaskEdit;
    EdtNomeProduto: TEdit;
    LblVrUnitario: TLabel;
    EdtValorUnitario: TMaskEdit;
    LblQuantidade: TLabel;
    EdtQuantidade: TMaskEdit;
    Label3: TLabel;
    EdtValorProduto: TMaskEdit;
    BtnConfirmar: TButton;
    procedure EdtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure EdtQuantidadeKeyPress(Sender: TObject; var Key: Char);
    procedure EdtValorProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure EdtCodProdutoExit(Sender: TObject);
    procedure EdtValorUnitarioExit(Sender: TObject);
    procedure EdtQuantidadeExit(Sender: TObject);
    procedure EdtValorProdutoExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    fMovPedidoItem: TMovPedidoItem;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent; aMovPedidoItem: TMovPedidoItem); reintroduce; virtual;
  end;

implementation

uses
  uFuncoes;

{$R *.dfm}

constructor TFrmMovPedidoItensEdit.Create(AOwner: TComponent; aMovPedidoItem: TMovPedidoItem);
begin
  inherited Create(aOwner);

  Self.fMovPedidoItem := aMovPedidoItem;
end;

procedure TFrmMovPedidoItensEdit.EdtCodProdutoExit(Sender: TObject);
var
  vCodProduto: Integer;
begin
  vCodProduto := StrToIntDef( Trim( Self.EdtCodProduto.Text ), 0 );

  if Self.fMovPedidoItem.Valid_CodProduto( vCodProduto ) then
  begin
    Self.fMovPedidoItem.CodProduto := vCodProduto;
    Self.EdtNomeProduto.Text := Self.fMovPedidoItem.NomeProduto;
    Self.EdtValorUnitario.Text := FormatFloat('###,###,###,##0.00', Self.fMovPedidoItem.ValorUnitario );
    Self.EdtQuantidade.Text := FormatFloat('###,###,###,##0.00', Self.fMovPedidoItem.Quantidade );
    Self.EdtValorProduto.Text := FormatFloat('###,###,###,##0.00', Self.fMovPedidoItem.ValorTotal );
  end
  else
  begin
    Application.MessageBox('Produto não localizado ou não cadastrado.', 'Produto inválido', MB_OK+MB_ICONASTERISK+MB_DEFBUTTON1);
    Self.fMovPedidoItem.CodProduto := 0;
    Self.EdtNomeProduto.Text := EmptyStr;
    Self.EdtValorUnitario.Text := FormatFloat('###,###,###,##0.00', 0 );
    Self.EdtQuantidade.Text := FormatFloat('###,###,###,##0.00', 0 );
    Self.EdtValorProduto.Text := FormatFloat('###,###,###,##0.00', 0 );
  end;
end;

procedure TFrmMovPedidoItensEdit.EdtValorUnitarioExit(Sender: TObject);
var
  vValorUnitario: Double;
  vQuantidade: Double;
  vValorTotal: Double;
begin
  vValorUnitario := StrToFloatDef( StringReplace( StringReplace( Trim( Self.EdtValorUnitario.Text ), '.', '', [rfReplaceAll, rfIgnoreCase] ), '.', ',', [rfReplaceAll, rfIgnoreCase] ), 0);
  vQuantidade := StrToFloatDef( StringReplace( StringReplace( Trim( Self.EdtQuantidade.Text ), '.', '', [rfReplaceAll, rfIgnoreCase] ), '.', ',', [rfReplaceAll, rfIgnoreCase] ), 0);

  vValorTotal := vValorUnitario * vQuantidade;
  Self.EdtValorProduto.Text := FormatFloat('###,###,###,##0.00', vValorTotal );

  Self.fMovPedidoItem.ValorUnitario := vValorUnitario;
end;

procedure TFrmMovPedidoItensEdit.EdtValorUnitarioKeyPress(Sender: TObject; var Key: Char);
begin
  uFuncoes.FormatValueFloat( Sender, Key );
end;

procedure TFrmMovPedidoItensEdit.FormShow(Sender: TObject);
begin
  if fMovPedidoItem.CodProduto > 0 then
  begin
    Self.Caption := 'Editação de produto';
    Self.EdtCodProduto.Text := FormatFloat('000000', Self.fMovPedidoItem.CodProduto);
    Self.EdtCodProduto.ReadOnly := True;
    Self.EdtCodProduto.TabStop := False;
    Self.EdtNomeProduto.Text := Self.fMovPedidoItem.NomeProduto;
    Self.EdtValorUnitario.Text := FormatFloat('###,###,###,##0.00', Self.fMovPedidoItem.ValorUnitario);
    Self.EdtQuantidade.Text := FormatFloat('###,###,###,##0.00', Self.fMovPedidoItem.Quantidade);
    Self.EdtValorProduto.Text := FormatFloat('###,###,###,##0.00', Self.fMovPedidoItem.ValorTotal);
  end
  else
  begin
    Self.Caption := 'Adição de produto';
    Self.EdtCodProduto.ReadOnly := False;
    Self.EdtCodProduto.TabStop := True;
  end;
end;

procedure TFrmMovPedidoItensEdit.EdtQuantidadeExit(Sender: TObject);
var
  vValorUnitario: Double;
  vQuantidade: Double;
  vValorTotal: Double;
begin
  vValorUnitario := StrToFloatDef( StringReplace( StringReplace( Trim( Self.EdtValorUnitario.Text ), '.', '', [rfReplaceAll, rfIgnoreCase] ), '.', ',', [rfReplaceAll, rfIgnoreCase] ), 0);
  vQuantidade := StrToFloatDef( StringReplace( StringReplace( Trim( Self.EdtQuantidade.Text ), '.', '', [rfReplaceAll, rfIgnoreCase] ), '.', ',', [rfReplaceAll, rfIgnoreCase] ), 0);

  vValorTotal := vValorUnitario * vQuantidade;
  Self.EdtValorProduto.Text := FormatFloat('###,###,###,##0.00', vValorTotal );

  Self.fMovPedidoItem.Quantidade := vQuantidade;
end;

procedure TFrmMovPedidoItensEdit.EdtQuantidadeKeyPress(Sender: TObject; var Key: Char);
begin
  uFuncoes.FormatValueFloat( Sender, Key );
end;

procedure TFrmMovPedidoItensEdit.EdtValorProdutoExit(Sender: TObject);
var
  vValorUnitario: Double;
  vQuantidade: Double;
  vValorTotal: Double;
begin
  vQuantidade := StrToFloatDef( StringReplace( StringReplace( Trim( Self.EdtQuantidade.Text ), '.', '', [rfReplaceAll, rfIgnoreCase] ), '.', ',', [rfReplaceAll, rfIgnoreCase] ), 0);
  vValorTotal := StrToFloatDef( StringReplace( StringReplace( Trim( Self.EdtValorProduto.Text ), '.', '', [rfReplaceAll, rfIgnoreCase] ), '.', ',', [rfReplaceAll, rfIgnoreCase] ), 0);

  vValorUnitario := vValorTotal / vQuantidade;
  Self.EdtValorUnitario.Text := FormatFloat('###,###,###,##0.00', vValorUnitario );

  Self.fMovPedidoItem.ValorUnitario := vValorUnitario;
end;

procedure TFrmMovPedidoItensEdit.EdtValorProdutoKeyPress(Sender: TObject; var Key: Char);
begin
  uFuncoes.FormatValueFloat( Sender, Key );
end;

end.
