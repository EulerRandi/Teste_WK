object FrmMovPedidoItens: TFrmMovPedidoItens
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'FrmMovPedidoItens'
  ClientHeight = 637
  ClientWidth = 979
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
  object ShpBackGround: TShape
    Left = 0
    Top = 0
    Width = 979
    Height = 637
    Align = alClient
    Brush.Color = 15921906
    ExplicitLeft = -145
    ExplicitTop = -202
    ExplicitWidth = 780
    ExplicitHeight = 501
  end
  object Label1: TLabel
    Left = 480
    Top = 328
    Width = 31
    Height = 13
    Caption = 'Label1'
  end
  object PnlBackground: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 963
    Height = 621
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 953
    ExplicitHeight = 611
    object PnlDados: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 167
      Width = 957
      Height = 363
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGrayText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      ExplicitWidth = 947
      ExplicitHeight = 397
      object DBGrid1: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 951
        Height = 357
        Align = alClient
        BorderStyle = bsNone
        DataSource = DataSource1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clGrayText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyDown = DBGrid1KeyDown
        Columns = <
          item
            Expanded = False
            FieldName = 'CodProduto'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NomeProduto'
            Width = 530
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorUnitario'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Quantidade'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorTotal'
            Width = 100
            Visible = True
          end>
      end
    end
    object PnlBotton: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 580
      Width = 957
      Height = 41
      Margins.Bottom = 0
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 2
      ExplicitTop = 570
      ExplicitWidth = 947
      object BtnFechar: TButton
        AlignWithMargins = True
        Left = 874
        Top = 8
        Width = 75
        Height = 25
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alRight
        Caption = '&Fechar'
        TabOrder = 4
        OnClick = BtnFecharClick
        ExplicitLeft = 864
      end
      object BtnAddProduto: TButton
        AlignWithMargins = True
        Left = 8
        Top = 8
        Width = 100
        Height = 25
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 4
        Margins.Bottom = 8
        Align = alLeft
        Caption = '&Adicionar Produto'
        TabOrder = 0
        OnClick = BtnAddProdutoClick
      end
      object BtnUpdProduto: TButton
        AlignWithMargins = True
        Left = 116
        Top = 8
        Width = 100
        Height = 25
        Margins.Left = 4
        Margins.Top = 8
        Margins.Right = 4
        Margins.Bottom = 8
        Align = alLeft
        Caption = 'Alterar &Produto'
        TabOrder = 1
        OnClick = BtnUpdProdutoClick
      end
      object BtnDelProduto: TButton
        AlignWithMargins = True
        Left = 224
        Top = 8
        Width = 100
        Height = 25
        Margins.Left = 4
        Margins.Top = 8
        Margins.Right = 4
        Margins.Bottom = 8
        Align = alLeft
        Caption = '&Deletar Produto'
        TabOrder = 2
        OnClick = BtnDelProdutoClick
      end
      object BtnGravarPedido: TButton
        AlignWithMargins = True
        Left = 742
        Top = 8
        Width = 100
        Height = 25
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 32
        Margins.Bottom = 8
        Align = alRight
        Caption = '&Gravar Pedido'
        TabOrder = 3
        OnClick = BtnGravarPedidoClick
        ExplicitTop = 5
      end
    end
    object PnlCabecalho: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 0
      Width = 957
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
      ExplicitWidth = 947
      object LblTitulo: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 3
        Width = 941
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
      object LblCodPedido: TLabel
        Left = 16
        Top = 32
        Width = 68
        Height = 16
        Caption = 'C'#243'd. Pedido'
      end
      object LblDataPedido: TLabel
        Left = 160
        Top = 32
        Width = 68
        Height = 16
        Caption = 'Data Pedido'
      end
      object LblCodCliente: TLabel
        Left = 16
        Top = 86
        Width = 69
        Height = 16
        Caption = 'C'#243'd. Cliente'
      end
      object LblNomeCliente: TLabel
        Left = 160
        Top = 86
        Width = 76
        Height = 16
        Caption = 'Nome Cliente'
      end
      object SBtnLookUpCliente: TSpeedButton
        Left = 114
        Top = 105
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = SBtnLookUpClienteClick
      end
      object PnlTitulo_Traco: TPanel
        AlignWithMargins = True
        Left = 8
        Top = 22
        Width = 941
        Height = 1
        Margins.Left = 8
        Margins.Top = 0
        Margins.Right = 8
        Align = alTop
        BevelOuter = bvSpace
        Caption = 'Panel1'
        TabOrder = 0
        ExplicitWidth = 931
      end
      object EdtCodPedido: TMaskEdit
        Left = 16
        Top = 51
        Width = 121
        Height = 24
        Color = 15921906
        TabOrder = 1
        Text = ''
      end
      object EdtCodCliente: TMaskEdit
        Left = 16
        Top = 105
        Width = 98
        Height = 24
        EditMask = '!999999;1; '
        MaxLength = 6
        TabOrder = 3
        Text = '      '
        OnExit = EdtCodClienteExit
      end
      object EdtNomeCliente: TEdit
        Left = 160
        Top = 108
        Width = 534
        Height = 24
        TabStop = False
        Color = 15921906
        TabOrder = 4
      end
      object EdtDataPedido: TDatePicker
        Left = 160
        Top = 51
        Width = 129
        Height = 24
        Date = 44598.000000000000000000
        DateFormat = 'dd/MM/yyyy'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        TabOrder = 2
      end
    end
    object Panel1: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 536
      Width = 957
      Height = 41
      Margins.Bottom = 0
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 3
      ExplicitLeft = 0
      ExplicitTop = 526
      ExplicitWidth = 947
      object LblTituloValorTotal: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 638
        Height = 35
        Margins.Right = 10
        Align = alClient
        Alignment = taRightJustify
        Caption = 'Valor Total do Pedido:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 423
        ExplicitWidth = 208
        ExplicitHeight = 25
      end
      object LblValorTotalPedido: TLabel
        AlignWithMargins = True
        Left = 654
        Top = 3
        Width = 300
        Height = 35
        Align = alRight
        AutoSize = False
        Caption = '0,00'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -21
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        ExplicitLeft = 851
      end
    end
  end
  object MemTableItem: TFDMemTable
    Active = True
    OnCalcFields = MemTableItemCalcFields
    FieldDefs = <
      item
        Name = 'FieldList'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 123
    Top = 303
    object MemTableItemFieldList: TIntegerField
      FieldName = 'FieldList'
      Visible = False
    end
    object MemTableItemCodItem: TIntegerField
      DisplayLabel = 'Item'
      FieldKind = fkCalculated
      FieldName = 'CodItem'
      EditFormat = '000000'
      Calculated = True
    end
    object MemTableItemCodProduto: TIntegerField
      DisplayLabel = 'C'#243'd. Produto'
      FieldKind = fkCalculated
      FieldName = 'CodProduto'
      EditFormat = '000000'
      Calculated = True
    end
    object MemTableItemNomeProduto: TStringField
      DisplayLabel = 'Descri'#231#227'o Produto'
      FieldKind = fkCalculated
      FieldName = 'NomeProduto'
      Size = 100
      Calculated = True
    end
    object MemTableItemValorUnitario: TFloatField
      DisplayLabel = 'Vr. Unit'#225'rio'
      FieldKind = fkCalculated
      FieldName = 'ValorUnitario'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '###,###,##0.00'
      Calculated = True
    end
    object MemTableItemQuantidade: TFloatField
      FieldKind = fkCalculated
      FieldName = 'Quantidade'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '###,###,##0.00'
      Calculated = True
    end
    object MemTableItemValorTotal: TFloatField
      DisplayLabel = 'Valor Total'
      FieldKind = fkCalculated
      FieldName = 'ValorTotal'
      DisplayFormat = '###,###,##0.00'
      EditFormat = '###,###,##0.00'
      Calculated = True
    end
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = MemTableItem
    Left = 387
    Top = 303
  end
end
