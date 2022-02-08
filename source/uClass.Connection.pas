unit uClass.Connection;

interface

uses
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf;

type
  TConnectionApp = class
  private
    fConnection: TFDConnection;
    fServer: string;
    fPort: Integer;
    fDatabase: string;
    fLogin: string;
    fPass: string;
    fErrorMsg: string;
  public
    constructor Create( aConnection: TFDConnection);
    destructor Destroy; override;

    function ConnectDataBase: Boolean;
    function SaveConfig: Boolean;
    function LoadConfig: Boolean;

    property Connection: TFDConnection read fConnection write fConnection;
    property Server: string read fServer write fServer;
    property Port: Integer read fPort write fPort;
    property Database: string read fDatabase write fDatabase;
    property Login: string read fLogin write fLogin;
    property Pass: string read fPass write fPass;
    property ErrorMsg: string read fErrorMsg write fErrorMsg;
  end;

implementation

uses
  System.SysUtils, System.IniFiles, Vcl.Forms, uFuncoes;


{ TConnectionApp }

function TConnectionApp.ConnectDataBase: Boolean;
begin
  if Self.LoadConfig then
  begin
    try
      Self.fConnection.Params.Clear;

      Self.fConnection.Params.Add('Server= '+Self.fServer);
      Self.fConnection.Params.Add('user_name= '+Self.fLogin);
      Self.fConnection.Params.Add('password= '+Self.fPass);
      Self.fConnection.Params.Add('port= '+IntToStr(Self.fPort) );
      Self.fConnection.Params.Add('Database= '+Self.fDatabase);
      Self.fConnection.Params.Add('DriverID= '+'MySQL');

      try
        Self.fConnection.Connected := True;
      except on E: Exception do
        begin
          Self.ErrorMsg := E.Message;
        end;
      end;
    finally
      Result := fConnection.Connected;
    end;
  end
  else
  begin
    Result := False;
    Self.fErrorMsg := 'Arquivo de configuração não encontrado.';
  end;
end;

constructor TConnectionApp.Create(aConnection: TFDConnection);
begin
  Self.fConnection := aConnection;
end;

destructor TConnectionApp.Destroy;
begin
  Self.fConnection.Connected := False;

  inherited;
end;

function TConnectionApp.LoadConfig: Boolean;
var
  vIniFile: string;
  vIni: TIniFile;
begin
  vIniFile := ChangeFileExt(Application.ExeName, '.ini');

  if FileExists(vIniFile) then
  begin
    vIni := TIniFile.Create(vIniFile);

    try
      try
        Self.fServer := vIni.ReadString('ConfigDB', 'Server', EmptyStr);
        Self.fPort := vIni.ReadInteger('ConfigDB', 'Port', 0);
        Self.fDatabase := vIni.ReadString('ConfigDB', 'Database', EmptyStr);
        Self.fLogin := vIni.ReadString('ConfigDB', 'Login', EmptyStr);
        Self.fPass := Cript( vIni.ReadString('ConfigDB', 'Pass', EmptyStr), 'DeuCerto');
      except on E: Exception do
        begin
          Self.ErrorMsg := E.Message;
        end;
      end;

      Result := True;
    finally
      vIni.Free;
    end;
  end
  else
  begin
    Result := False;
  end;
end;

function TConnectionApp.SaveConfig: Boolean;
var
  vIniFile: string;
  vIni: TIniFile;
begin
  vIniFile := ChangeFileExt(Application.ExeName, '.ini');

  vIni := TIniFile.Create(vIniFile);
  try
    try
      vIni.WriteString('ConfigDB', 'Server', Self.fServer);
      vIni.WriteInteger('ConfigDB', 'Port', Self.fPort);
      vIni.WriteString('ConfigDB', 'Database', Self.fDatabase);
      vIni.WriteString('ConfigDB', 'Login', Self.fLogin);
      vIni.WriteString('ConfigDB', 'Pass', Cript(Self.fPass, 'DeuCerto'));
    except on E: Exception do
      begin
        Self.ErrorMsg := E.Message;
      end;
    end;

    Result := True;
  finally
    vIni.Free;
  end;
end;

end.
