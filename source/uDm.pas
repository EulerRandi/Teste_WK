unit uDm;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client,
  uClass.Connection;

type
  TDM = class(TDataModule)
    Connection: TFDConnection;
    MySQLDriverLink: TFDPhysMySQLDriverLink;
    WaitCursor: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
    fConfigConnection: TConnectionApp;
  public
    { Public declarations }
    property ConfigDB: TConnectionApp read fConfigConnection write fConfigConnection;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  Self.fConfigConnection := TConnectionApp.Create( Self.Connection);
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  if Assigned(Self.fConfigConnection) then
  begin
    Self.fConfigConnection.Free;
  end;
end;

end.
