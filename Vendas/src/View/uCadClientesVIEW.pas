unit uCadClientesVIEW;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls, VCLTee.TeCanvas,
  VCLTee.TeeEdiGrad, System.ImageList, Vcl.ImgList, uClienteControl,
  Datasnap.Provider, uEnumerado, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB,
  FireDAC.Phys.FBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.IBBase, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGrid, dxPSGlbl, dxPSUtl, dxPSEngn, dxPrnPg,
  dxBkgnd, dxWrap, dxPrnDev, dxPSCompsProvider, dxPSFillPatterns,
  dxPSEdgePatterns, dxPSPDFExportCore, dxPSPDFExport, cxDrawTextUtils,
  dxPSPrVwStd, dxPSPrVwAdv, dxPSPrVwRibbon, dxPScxPageControlProducer,
  dxPScxGridLnk, dxPScxGridLayoutViewLnk, dxPScxEditorProducers,
  dxPScxExtEditorProducers, dxPSCore, dxPScxCommon, Vcl.Menus, cxButtons;

type
  TfrmCad_Clientes = class(TForm)
    pn_Clientes: TPanel;
    Panel1: TPanel;
    ds_CadClientes: TDataSource;
    pn_Controls: TPanel;
    Label1: TLabel;
    DBEdtCodigo: TDBEdit;
    Label2: TLabel;
    DBEdtNomeCli: TDBEdit;
    Label3: TLabel;
    DBEdtCEP: TDBEdit;
    Label4: TLabel;
    DBEdtEndereco: TDBEdit;
    Label5: TLabel;
    DBEdtBairro: TDBEdit;
    Label6: TLabel;
    DBEdtCidade: TDBEdit;
    Label7: TLabel;
    DBEdtNumero: TDBEdit;
    Label8: TLabel;
    DBEdtUF: TDBEdit;
    Shape1: TShape;
    Shape2: TShape;
    Label9: TLabel;
    EdtPesquisa: TEdit;
    DBButtons: TDBNavigator;
    btnConsultar: TButtonGradient;
    ImageListIco: TImageList;
    TB_Clientes: TClientDataSet;
    TB_ClientesCODIGO: TIntegerField;
    TB_ClientesNOME: TStringField;
    TB_ClientesENDERECO: TStringField;
    TB_ClientesBAIRRO: TStringField;
    TB_ClientesCIDADE: TStringField;
    TB_ClientesNUMERO: TIntegerField;
    TB_ClientesCEP: TStringField;
    TB_ClientesUF: TStringField;
    DSP_Clientes: TDataSetProvider;
    Prn_Cliente: TdxComponentPrinter;
    Prn_ClienteLink1: TdxGridReportLink;
    cxButton1: TcxButton;
    pn_Grid: TPanel;
    grd_Clientes: TcxGrid;
    grd_ClientesDBTableView1: TcxGridDBTableView;
    grd_ClientesCodigo: TcxGridDBColumn;
    grd_ClientesNome: TcxGridDBColumn;
    grd_ClientesEndereco: TcxGridDBColumn;
    grd_ClientesNumero: TcxGridDBColumn;
    grd_ClientesCidade: TcxGridDBColumn;
    grd_ClientesCEP: TcxGridDBColumn;
    grd_ClientesUF: TcxGridDBColumn;
    grd_ClientesLevel1: TcxGridLevel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PintaEdit(Sender: TObject);
    procedure PreencheDataSetCliente;
    procedure btnConsultarClick(Sender: TObject);
    procedure TB_ClientesBeforeEdit(DataSet: TDataSet);
    procedure TB_ClientesBeforeInsert(DataSet: TDataSet);
    procedure TB_ClientesBeforePost(DataSet: TDataSet);
    procedure TB_ClientesBeforeDelete(DataSet: TDataSet);
    procedure cxButton1Click(Sender: TObject);
  private
    { Private declarations }
    Cliente: TClienteControl;
    ATipo: TAcao;
  public
    { Public declarations }
  end;

var
  frmCad_Clientes: TfrmCad_Clientes;

implementation

{$R *.dfm}

procedure TfrmCad_Clientes.btnConsultarClick(Sender: TObject);
begin
  if StrToIntDef(EdtPesquisa.Text, 0) = 0 then  //tem letras
  begin
    TB_Clientes.IndexFieldNames :='NOME';
    TB_Clientes.Locate('NOME',EdtPesquisa.Text,[loPartialKey, loCaseInsensitive]);
  end
  else
  begin
    TB_Clientes.IndexFieldNames :='CODIGO';
    TB_Clientes.Locate('CODIGO',EdtPesquisa.Text,[]);
  end;
end;

procedure TfrmCad_Clientes.cxButton1Click(Sender: TObject);
begin
  Prn_Cliente.Preview(true);
end;

procedure TfrmCad_Clientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := cafree;
end;

procedure TfrmCad_Clientes.FormCreate(Sender: TObject);
var nI: Integer;
begin
  For nI := 0 to ComponentCount-1 do
  begin
    if Components[nI] is TEdit  then
      (Components[nI] as TEdit).OnEnter := PintaEdit
    else
      if Components[nI] is TDBEdit then
        (Components[nI] as TDBEdit).OnEnter := PintaEdit;
  end;
  PreencheDataSetCliente;
end;

procedure TfrmCad_Clientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    close;
  if Key = VK_RETURN then
   perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfrmCad_Clientes.PintaEdit(Sender: TObject);
var nI: Integer;
begin
  For nI := 0 to ComponentCount-1 do
  begin
    if (Components[nI] is TEdit) then
    begin
    if TEdit(Components[nI]).Focused then
      TEdit(Components[nI]).Color := $00D7FFFF
    else
      TEdit(Components[nI]).Color := clWhite;
    end
    else
      if (Components[nI] is TDBEdit) then
      begin
        if TDBEdit(Components[nI]).Focused then
          TDBEdit(Components[nI]).Color := $00D7FFFF
        else
          TDBEdit(Components[nI]).Color := clWhite;
      end;

  end;
end;

procedure TfrmCad_Clientes.PreencheDataSetCliente;
begin
  try
    Cliente:= TClienteControl.Create;
    DSP_Clientes.DataSet := Cliente.Obter(1,'');
    TB_Clientes.close;
    TB_Clientes.Open;
  finally
    Cliente.Free;
  end;
end;

procedure TfrmCad_Clientes.TB_ClientesBeforeDelete(DataSet: TDataSet);
begin
  ATipo := uEnumerado.tacExcluir;
  if MessageDlg('Deseja realmente exluir essa informação ?',mtConfirmation, [mbYes,mbNo],1) = mrYes then
  begin
    try
      Cliente:= TClienteControl.Create;
      Cliente.ClienteModel.Acao     := ATipo;
      Cliente.ClienteModel.Codigo   := TB_ClientesCODIGO.AsInteger;
      Cliente.Salvar;
    finally
      messagedlg('Dado Excluido com sucesso!',mtinformation,[mbok],0);
      Cliente.Free;
      PreencheDataSetCliente;
    end;
  end;
end;

procedure TfrmCad_Clientes.TB_ClientesBeforeEdit(DataSet: TDataSet);
begin
  TB_ClientesCODIGO.FocusControl;
end;

procedure TfrmCad_Clientes.TB_ClientesBeforeInsert(DataSet: TDataSet);
begin
  TB_ClientesCODIGO.FocusControl;
end;

procedure TfrmCad_Clientes.TB_ClientesBeforePost(DataSet: TDataSet);
begin
  if TB_Clientes.State = dsInsert then  //grava no banco as inserções ou alterações
  begin
    ATipo := uEnumerado.tacIncluir;
    try
      Cliente:= TClienteControl.Create;
      Cliente.ClienteModel.Acao     := ATipo;
      TB_ClientesCODIGO.AsInteger   := Cliente.ClienteModel.GetId;
      Cliente.ClienteModel.Codigo   := TB_ClientesCODIGO.AsInteger; //gera codigo automático
      Cliente.ClienteModel.Nome     := TB_ClientesNOME.AsString;
      Cliente.ClienteModel.Endereco := TB_ClientesENDERECO.AsString;
      Cliente.ClienteModel.Bairro   := TB_ClientesBAIRRO.AsString;
      Cliente.ClienteModel.Cidade   := TB_ClientesCIDADE.AsString;
      Cliente.ClienteModel.Numero   := TB_ClientesNUMERO.AsString;
      Cliente.ClienteModel.Cep      := TB_ClientesCEP.AsString;
      Cliente.ClienteModel.UF       := TB_ClientesUF.AsString;
      Cliente.Salvar;
    finally
      messagedlg('Dados gravados com sucesso!',mtinformation,[mbok],0);
      Cliente.Free;
      PreencheDataSetCliente;
    end;
  end
  else
  if TB_Clientes.State = dsEdit then
  begin
    ATipo := uEnumerado.tacAlterar;
    try
      Cliente:= TClienteControl.Create;
      Cliente.ClienteModel.Acao     := ATipo;
      Cliente.ClienteModel.Codigo   := TB_ClientesCODIGO.AsInteger;
      Cliente.ClienteModel.Nome     := TB_ClientesNOME.AsString;
      Cliente.ClienteModel.Endereco := TB_ClientesENDERECO.AsString;
      Cliente.ClienteModel.Bairro   := TB_ClientesBAIRRO.AsString;
      Cliente.ClienteModel.Cidade   := TB_ClientesCIDADE.AsString;
      Cliente.ClienteModel.Numero   := TB_ClientesNUMERO.AsString;
      Cliente.ClienteModel.Cep      := TB_ClientesCEP.AsString;
      Cliente.ClienteModel.UF       := TB_ClientesUF.AsString;
      Cliente.Salvar;
    finally
      messagedlg('Dados gravados com sucesso!',mtinformation,[mbok],0);
      Cliente.Free;
      PreencheDataSetCliente;
    end;
  end;
  Abort;
end;

end.
