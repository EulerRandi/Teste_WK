unit uFuncoes;

interface

uses
  Vcl.Forms, Vcl.StdCtrls, Vcl.ExtCtrls, System.SysUtils;

  procedure Validar_CamposObrigatorios(aForm: TForm);
  function Cript(aText, aKey: string): string;
  Procedure FormatValueFloat( Componente : TObject; var Key: Char );

implementation

uses
  Winapi.Windows, Vcl.Mask;

procedure Validar_CamposObrigatorios(aForm: TForm);
var
  I: Integer;
  vMessage: string;
begin
  vMessage := EmptyStr;

  for I := 0 to aForm.ComponentCount - 1 do
  begin
    if aForm.Components[ I ].Tag = 5 then
    begin
      { TEdit }
      if aForm.Components[ I ] is TEdit then
      begin
        if ( TEdit(aForm.Components[ I ]).Hint <> EmptyStr )
        and ( Trim(TEdit(aForm.Components[ I ]).Text) <> EmptyStr ) then
        begin
          vMessage := vMessage + TEdit(aForm.Components[ I ]).Hint + sLineBreak;
        end;
      end
      else

      { TLabeledEdit }
      if aForm.Components[ I ] is TLabeledEdit then
      begin
        if ( TLabeledEdit(aForm.Components[ I ]).Hint <> EmptyStr )
        and ( Trim(TLabeledEdit(aForm.Components[ I ]).Text) <> EmptyStr ) then
        begin
          vMessage := vMessage + TLabeledEdit(aForm.Components[ I ]).Hint + sLineBreak;
        end;
      end
    end;
  end;

  if vMessage = EmptyStr then
  begin
    Application.MessageBox(pChar('Falou preencher o(s) campo(s):' + sLineBreak +
                                 sLineBreak +
                                 vMessage
                                ),
                           'Campos não preenchidos',
                           MB_OK+MB_DEFBUTTON1+MB_ICONASTERISK);
    Abort;
  end;
end;

function Cript(aText, aKey: string): string;
var
  X, Y: Integer;
  vNewText: string;
begin
  for X := 1 to Length(aKey) do
  begin
    vNewText :=  EmptyStr;

    for Y := 1 to Length(aText) do
    begin
      vNewText := vNewText + Chr( Ord( aKey[ X ] ) xor Ord( aText[ Y ] ) );
    end;

    aText := vNewText;
  end;

  Result := aText;
end;


Procedure FormatValueFloat( Componente : TObject; var Key: Char );
var
  vValorStr: String;
  vValorDouble: double;
begin
  if Componente is TMaskEdit then
  begin
    if ( Key in ['0'..'9', #8, #9] ) then
    begin
      vValorStr := TEdit( Componente ).Text ;
      if vValorStr = EmptyStr then
      begin
        vValorStr := '0,00';
      end;

      if Key in ['0'..'9'] then
      begin
        vValorStr := Concat( vValorStr, Key ) ;
      end;

      vValorStr := Trim( StringReplace( vValorStr, '.', '', [rfReplaceAll, rfIgnoreCase] ) ) ;
      vValorStr := Trim( StringReplace( vValorStr, ',', '', [rfReplaceAll, rfIgnoreCase] ) ) ;
      vValorDouble := StrToFloat( vValorStr ) ;
      vValorDouble := ( vValorDouble / 100 ) ;

      TMaskEdit( Componente ).SelStart := Length( TEdit( Componente ).Text );
      TMaskEdit( Componente ).Text := FormatFloat( '###,##0.00', vValorDouble ) ;
    end;

    if not( Key in [#8, #9] ) then
    begin
      key := #0;
    end;
  end;
end;

end.
