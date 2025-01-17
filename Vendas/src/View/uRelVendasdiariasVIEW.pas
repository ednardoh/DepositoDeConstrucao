unit uRelVendasdiariasVIEW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Mask,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  FireDAC.Phys.IBBase, Datasnap.Provider, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Datasnap.DBClient, QRCtrls, QuickRpt, Vcl.ExtCtrls,
  uRelatorioVendasDiariasControl;

type
  TfrmVendasdiaria = class(TForm)
    Edt_DataInicial: TMaskEdit;
    Edt_DataFinal: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    QVendas: TClientDataSet;
    ds_Vendas: TDataSource;
    QuickRepVendas: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRBand2: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRGroup1: TQRGroup;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRBand3: TQRBand;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRDBText7: TQRDBText;
    QRDBText8: TQRDBText;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRBand4: TQRBand;
    QRLabel12: TQRLabel;
    QRExpr1: TQRExpr;
    QRBand5: TQRBand;
    QRLabel13: TQRLabel;
    QRExpr2: TQRExpr;
    QRLabel14: TQRLabel;
    QRDBText9: TQRDBText;
    btnVializa: TButton;
    btnImprimir: TButton;
    DSP_Vendas: TDataSetProvider;
    QVendasID: TStringField;
    QVendasNUMPEDI: TStringField;
    QVendasDATA_EMISSAO: TDateField;
    QVendasCOD_CLIENTE: TStringField;
    QVendasNOME: TStringField;
    QVendasID_PRODUTO: TStringField;
    QVendasCODIGO_BAR: TStringField;
    QVendasDESCRICAO: TStringField;
    QVendasQUANTIDADE: TSingleField;
    QVendasVALOR_UNITARIO: TSingleField;
    QVendasVALOR_TOTAL_PROD: TIntegerField;
    procedure btnVializaClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FRelatorioVendasDiariasControl: TRelatorioVendasDiariasControl;
  public
    { Public declarations }
  end;

var
  frmVendasdiaria: TfrmVendasdiaria;

implementation

{$R *.dfm}

procedure TfrmVendasdiaria.btnImprimirClick(Sender: TObject);
var
  strDatINI, strDatFIN : string;
begin

  if Edt_DataInicial.Text <> '  /  /    ' then
    strDatINI := Edt_DataInicial.Text
  else
    strDatINI := '';

  if Edt_DataFinal.Text <> '  /  /    ' then
    strDatFIN := Edt_DataFinal.Text
  else
    strDatFIN := '';

  FRelatorioVendasDiariasControl := TRelatorioVendasDiariasControl.Create;
  try
    DSP_Vendas.DataSet := FRelatorioVendasDiariasControl.Obter(strDatINI, strDatFIN);
    QVendas.Close;
    QVendas.open;
  finally
    FRelatorioVendasDiariasControl.Free;
  end;

  QuickRepVendas.Print;
end;

procedure TfrmVendasdiaria.btnVializaClick(Sender: TObject);
var
  strDatINI, strDatFIN : string;
begin

  if Edt_DataInicial.Text <> '  /  /    ' then
    strDatINI := Edt_DataInicial.Text
  else
    strDatINI := '';

  if Edt_DataFinal.Text <> '  /  /    ' then
    strDatFIN := Edt_DataFinal.Text
  else
    strDatFIN := '';

  FRelatorioVendasDiariasControl := TRelatorioVendasDiariasControl.Create;
  try
    DSP_Vendas.DataSet := FRelatorioVendasDiariasControl.Obter(strDatINI, strDatFIN);
    QVendas.Close;
    QVendas.open;
  finally
    FRelatorioVendasDiariasControl.Free;
  end;
  QuickRepVendas.Preview;

end;

procedure TfrmVendasdiaria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //Action := cafree;
end;

end.
