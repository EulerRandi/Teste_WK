object FrmMovPedidos: TFrmMovPedidos
  Left = 0
  Top = 0
  BorderStyle = bsNone
  ClientHeight = 501
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ShpBackGround: TShape
    Left = 0
    Top = 0
    Width = 780
    Height = 501
    Align = alClient
    Brush.Color = 15921906
    ExplicitTop = -100
    ExplicitWidth = 554
    ExplicitHeight = 438
  end
  object PnlBackground: TPanel
    AlignWithMargins = True
    Left = 8
    Top = 8
    Width = 764
    Height = 485
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 8
    Margins.Bottom = 8
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object PnlDados: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 87
      Width = 758
      Height = 351
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
      TabOrder = 0
      object DBGrid1: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 752
        Height = 345
        Align = alClient
        BorderStyle = bsNone
        DataSource = DataSource
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clGrayText
        TitleFont.Height = -13
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnKeyUp = DBGrid1KeyUp
        Columns = <
          item
            Expanded = False
            FieldName = 'pedido'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'data'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'cliente'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'nome'
            Width = 315
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'vr_total'
            Width = 120
            Visible = True
          end>
      end
    end
    object PnlBotton: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 444
      Width = 758
      Height = 41
      Margins.Bottom = 0
      Align = alBottom
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
      object BtnFechar: TButton
        AlignWithMargins = True
        Left = 675
        Top = 8
        Width = 75
        Height = 25
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 8
        Align = alRight
        Caption = '&Fechar'
        TabOrder = 0
        OnClick = BtnFecharClick
      end
      object BtnAddPedido: TButton
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
        Caption = '&Adicionar Pedido'
        TabOrder = 1
        OnClick = BtnAddPedidoClick
      end
      object BtnUpdPedido: TButton
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
        Caption = 'Alterar &Pedido'
        TabOrder = 2
        OnClick = BtnUpdPedidoClick
      end
      object BtnDelPedido: TButton
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
        Caption = '&Deletar Pedido'
        TabOrder = 3
        OnClick = BtnDelPedidoClick
      end
    end
    object PnlFiltro: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 0
      Width = 758
      Height = 81
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
      TabOrder = 2
      DesignSize = (
        758
        81)
      object Label1: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 3
        Width = 742
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
      object Panel3: TPanel
        AlignWithMargins = True
        Left = 8
        Top = 22
        Width = 742
        Height = 1
        Margins.Left = 8
        Margins.Top = 0
        Margins.Right = 8
        Align = alTop
        BevelOuter = bvSpace
        Caption = 'Panel1'
        TabOrder = 0
      end
      object LblEdtCodPedido: TLabeledEdit
        Tag = 5
        Left = 8
        Top = 48
        Width = 100
        Height = 22
        Hint = 'Endere'#231'o do servidor de banco de dados'
        BevelInner = bvNone
        Ctl3D = False
        EditLabel.Width = 58
        EditLabel.Height = 13
        EditLabel.Caption = 'C'#243'd. Pedido'
        EditLabel.Font.Charset = DEFAULT_CHARSET
        EditLabel.Font.Color = clGrayText
        EditLabel.Font.Height = -11
        EditLabel.Font.Name = 'Tahoma'
        EditLabel.Font.Style = []
        EditLabel.ParentFont = False
        NumbersOnly = True
        ParentCtl3D = False
        TabOrder = 1
      end
      object LblEdtCodCliente: TLabeledEdit
        Tag = 5
        Left = 114
        Top = 48
        Width = 100
        Height = 22
        Hint = 'Porta de conex'#227'o ao servidor de banco de dados'
        Ctl3D = False
        EditLabel.Width = 69
        EditLabel.Height = 16
        EditLabel.Caption = 'C'#243'd. Cliente'
        NumbersOnly = True
        ParentCtl3D = False
        TabOrder = 2
      end
      object LblEdtNomeCliente: TLabeledEdit
        Tag = 5
        Left = 220
        Top = 48
        Width = 424
        Height = 22
        Anchors = [akLeft, akTop, akRight, akBottom]
        Ctl3D = False
        EditLabel.Width = 76
        EditLabel.Height = 16
        EditLabel.Caption = 'Nome Cliente'
        ParentCtl3D = False
        TabOrder = 3
      end
      object BtnApllyFilter: TButton
        AlignWithMargins = True
        Left = 650
        Top = 46
        Width = 100
        Height = 25
        Margins.Top = 20
        Margins.Right = 8
        Margins.Bottom = 10
        Align = alRight
        Caption = 'Aplicar Filtro'
        TabOrder = 4
        OnClick = BtnApllyFilterClick
      end
    end
  end
  object QryMovPedidos: TFDQuery
    Connection = DM.Connection
    SQL.Strings = (
      'SELECT P.PEDIDO, P.DATA, P.CLIENTE, C.NOME, P.VR_TOTAL'
      'FROM PEDIDOS P'
      'INNER JOIN CLIENTES C ON (P.CLIENTE = C.CODIGO)'
      'LIMIT 0, 1')
    Left = 40
    Top = 217
    object QryMovPedidospedido: TFDAutoIncField
      DisplayLabel = 'C'#243'd. Pedido'
      FieldName = 'pedido'
      Origin = 'pedido'
      ProviderFlags = [pfInWhere, pfInKey]
      ReadOnly = True
      DisplayFormat = '000000'
    end
    object QryMovPedidosdata: TDateTimeField
      DisplayLabel = 'Data do Pedido'
      FieldName = 'data'
      Origin = '`data`'
      Required = True
    end
    object QryMovPedidoscliente: TIntegerField
      DisplayLabel = 'C'#243'd. Cliente'
      FieldName = 'cliente'
      Origin = 'cliente'
      Required = True
      DisplayFormat = '000000'
    end
    object QryMovPedidosnome: TStringField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Nome do Cliente'
      FieldName = 'nome'
      Origin = 'nome'
      ProviderFlags = []
      ReadOnly = True
      Size = 100
    end
    object QryMovPedidosvr_total: TSingleField
      AutoGenerateValue = arDefault
      DisplayLabel = 'Vr. Total Pedido'
      FieldName = 'vr_total'
      Origin = 'vr_total'
      DisplayFormat = '###,###,###,##0.00'
    end
  end
  object DataSource: TDataSource
    AutoEdit = False
    DataSet = QryMovPedidos
    Left = 112
    Top = 217
  end
  object TimerApplyFilter: TTimer
    Enabled = False
    Interval = 1500
    OnTimer = TimerApplyFilterTimer
    Left = 531
    Top = 223
  end
end
