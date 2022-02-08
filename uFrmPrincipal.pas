unit uFrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TFrmPrincipal = class(TForm)
    PnlBackround: TPanel;
    PnlMenu: TPanel;
    PnlScreen: TPanel;
    PnlInformation: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    PnlAction: TPanel;
    SbtnConfigDB: TSpeedButton;
    SbtnMovPedidos: TSpeedButton;
    procedure SbtnConfigDBClick(Sender: TObject);
    procedure SbtnMovPedidosClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

uses uFrmConfigDB, uFrmMovPedidos, uDm;

procedure TFrmPrincipal.SbtnConfigDBClick(Sender: TObject);
begin
  FrmConfigDB := TFrmConfigDB.Create(Self);
  FrmConfigDB.Parent := PnlScreen;
  FrmConfigDB.Position := poDefault;
  FrmConfigDB.Width := PnlScreen.Width;
  FrmConfigDB.Height := PnlScreen.Height;

  FrmConfigDB.Show;
end;

procedure TFrmPrincipal.SbtnMovPedidosClick(Sender: TObject);
begin
  FrmMovPedidos := TFrmMovPedidos.Create(Self, DM.Connection, Self.PnlScreen);
  FrmMovPedidos.Show;
end;

end.
