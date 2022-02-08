unit uFrmConfigDB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Vcl.Imaging.pngimage;

type
  TFrmConfigDB = class(TForm)
    ShpBackGround: TShape;
    PnlBackground: TPanel;
    PnlTitle: TPanel;
    PnlConfigNew: TPanel;
    PnlBotton: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    LblEdtNewServer: TLabeledEdit;
    LblEdtNewPort: TLabeledEdit;
    LblEdtNewDatabase: TLabeledEdit;
    LblEdtNewLogin: TLabeledEdit;
    LblEdtNewPass: TLabeledEdit;
    PnlConfigOld: TPanel;
    Label4: TLabel;
    Panel3: TPanel;
    LblEdtOldServer: TLabeledEdit;
    LblEdtOldPort: TLabeledEdit;
    LblEdtOldDatabase: TLabeledEdit;
    LblEdtOldLogin: TLabeledEdit;
    LblEdtOldPass: TLabeledEdit;
    BtnConfirmar: TButton;
    BtnCancelar: TButton;
    procedure BtnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConfigDB: TFrmConfigDB;

implementation

{$R *.dfm}

uses uFuncoes, uDm;

procedure TFrmConfigDB.BtnCancelarClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TFrmConfigDB.BtnConfirmarClick(Sender: TObject);
begin
  uFuncoes.Validar_CamposObrigatorios( Self );

  DM.ConfigDB.Server := Self.LblEdtNewServer.Text;
  DM.ConfigDB.Port := StrToIntDef(Self.LblEdtNewPort.Text, 0);
  DM.ConfigDB.Database := Self.LblEdtNewDatabase.Text;
  DM.ConfigDB.Login := Self.LblEdtNewLogin.Text;
  DM.ConfigDB.Pass := Self.LblEdtNewPass.Text;

  if DM.ConfigDB.SaveConfig then
  begin
    Application.MessageBox(pChar('Configuração salva com sucesso.'),
                           'Configuração da conexão ao banco de dados',
                           MB_OK+MB_DEFBUTTON1+MB_ICONINFORMATION);
    Self.Close;
  end
  else
  begin
    Application.MessageBox(pChar('Não foi possível conectar ao banco de dados.' + sLineBreak +
                                 sLineBreak +
                                 'Erro encontrado:' + sLineBreak +
                                 DM.ConfigDB.ErrorMsg
                                ),
                           'Erro ao conectar ao banco de dados',
                           MB_OK+MB_DEFBUTTON1+MB_ICONERROR);

    Self.LblEdtNewServer.SetFocus;
  end;
end;

procedure TFrmConfigDB.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFrmConfigDB.FormShow(Sender: TObject);
begin
  if DM.ConfigDB.LoadConfig then
  begin
    Self.LblEdtOldServer.Text := DM.ConfigDB.Server;
    Self.LblEdtOldPort.Text := IntToStr(DM.ConfigDB.Port);
    Self.LblEdtOldDatabase.Text := DM.ConfigDB.Database;
    Self.LblEdtOldLogin.Text := DM.ConfigDB.Login;
    Self.LblEdtOldPass.Text := DM.ConfigDB.Pass;
  end;
end;

end.
