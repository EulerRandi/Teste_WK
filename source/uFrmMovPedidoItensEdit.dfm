object FrmMovPedidoItensEdit: TFrmMovPedidoItensEdit
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 236
  ClientWidth = 734
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PnlBackground: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 718
    Height = 220
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 708
    ExplicitHeight = 210
    object PnlBotton: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 179
      Width = 712
      Height = 41
      Margins.Bottom = 0
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      ExplicitTop = 169
      ExplicitWidth = 702
      object BtnCancelar: TButton
        AlignWithMargins = True
        Left = 629
        Top = 8
        Width = 75
        Height = 25
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alRight
        Caption = 'C&ancelar'
        ModalResult = 2
        TabOrder = 1
        ExplicitLeft = 619
      end
      object BtnConfirmar: TButton
        AlignWithMargins = True
        Left = 546
        Top = 8
        Width = 75
        Height = 25
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alRight
        Caption = '&Confirmar'
        ModalResult = 1
        TabOrder = 0
        ExplicitLeft = 536
      end
    end
    object PnlCabecalho: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 0
      Width = 712
      Height = 161
      Margins.Top = 0
      Align = alTop
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      ExplicitWidth = 702
      object LblTitulo: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 3
        Width = 696
        Height = 16
        Margins.Left = 8
        Margins.Right = 8
        Align = alTop
        Caption = 'Movimento de Pedidos'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitWidth = 145
      end
      object LblCodProduto: TLabel
        Left = 16
        Top = 30
        Width = 74
        Height = 16
        Caption = 'C'#243'd. Produto'
      end
      object LblNomeProduto: TLabel
        Left = 160
        Top = 30
        Width = 99
        Height = 16
        Caption = 'Nome do Produto'
      end
      object SBtnLookUpProduto: TSpeedButton
        Left = 114
        Top = 49
        Width = 23
        Height = 22
        Caption = '...'
      end
      object LblVrUnitario: TLabel
        Left = 16
        Top = 94
        Width = 65
        Height = 16
        Caption = 'Vr. Unit'#225'rio'
      end
      object LblQuantidade: TLabel
        Left = 161
        Top = 94
        Width = 65
        Height = 16
        Caption = 'Quantidade'
      end
      object Label3: TLabel
        Left = 309
        Top = 94
        Width = 108
        Height = 16
        Caption = 'Valor dos Produtos'
      end
      object PnlTitulo_Traco: TPanel
        AlignWithMargins = True
        Left = 8
        Top = 22
        Width = 696
        Height = 1
        Margins.Left = 8
        Margins.Top = 0
        Margins.Right = 8
        Align = alTop
        BevelOuter = bvSpace
        Caption = 'Panel1'
        TabOrder = 0
        ExplicitWidth = 686
      end
      object EdtCodProduto: TMaskEdit
        Left = 16
        Top = 49
        Width = 98
        Height = 24
        EditMask = '!999999;1; '
        MaxLength = 6
        TabOrder = 1
        Text = '      '
        OnExit = EdtCodProdutoExit
      end
      object EdtNomeProduto: TEdit
        Left = 160
        Top = 52
        Width = 534
        Height = 24
        TabStop = False
        Color = 15921906
        TabOrder = 2
      end
      object EdtValorUnitario: TMaskEdit
        Left = 16
        Top = 116
        Width = 114
        Height = 24
        Alignment = taRightJustify
        TabOrder = 3
        Text = '0,00'
        OnExit = EdtValorUnitarioExit
        OnKeyPress = EdtValorUnitarioKeyPress
      end
      object EdtQuantidade: TMaskEdit
        Left = 160
        Top = 116
        Width = 114
        Height = 24
        Alignment = taRightJustify
        TabOrder = 4
        Text = '0,00'
        OnExit = EdtQuantidadeExit
        OnKeyPress = EdtQuantidadeKeyPress
      end
      object EdtValorProduto: TMaskEdit
        Left = 309
        Top = 116
        Width = 114
        Height = 24
        Alignment = taRightJustify
        TabOrder = 5
        Text = '0,00'
        OnExit = EdtValorProdutoExit
        OnKeyPress = EdtValorProdutoKeyPress
      end
    end
  end
end
