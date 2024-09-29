unit uRelatorioVendasDiariasDAO;

interface

uses
  FireDAC.Comp.Client, uConexao, uClienteModel, System.SysUtils, uSistemaControl;

type TRelatorioVendasDiariasDAO = class
  private
    FConexao: TConexao;
  public
    constructor Create;

    function Obter(DataIni, DataFin: string): TFDQuery;
end;

implementation

{ TRelatorioVendasDiariasDAO }

constructor TRelatorioVendasDiariasDAO.Create;
begin
  FConexao := TSistemaControl.GetInstance().Conexao;
end;

function TRelatorioVendasDiariasDAO.Obter(DataIni, DataFin: string): TFDQuery;
var
  vQry: TFDQuery;
begin
  vQry := FConexao.CriarQuery();
  vQry.close;
  vQry.SQL.Clear;
  vQry.SQL.Add('select lpad(p.id,6,''0'') as id,                              '+
               '        lpad(p.numpedi,6,''0'') as numpedi,                   '+
               '        p.data_emissao,                                       '+
               '        lpad(p.cod_cliente,6,''0'') as cod_cliente,           '+
               '        c.nome,                                               '+
               '        lpad(pp.id_produto,6,''0'') as id_produto,            '+
               '        lpad(pr.codigo_bar,13,''0'') as codigo_bar,           '+
               '        pr.descricao,                                         '+
               '        pp.quantidade,                                        '+
               '        pp.valor_unitario,                                    '+
               '        pp.valor_total as valor_total_prod                    '+
               ' FROM PEDIDO p                                                '+
               '   INNER JOIN CLIENTES c ON c.codigo = p.cod_cliente          '+
               '   INNER JOIN PEDIDO_PRODUTOS pp ON pp.numpedido = p.numpedi  '+
               '   INNER JOIN PRODUTOS pr ON pr.id = pp.id_produto            ');

  if (DataIni <> '') and (DataFin <> '') then
   begin
     vQry.SQL.Add(' Where p.data_emissao between :DatINI and :DatFIN         ');
     vQry.ParamByName('DatINI').AsString := FormatDateTime('dd.mm.yyyy',StrToDateTime(DataIni));
     vQry.ParamByName('DatFIN').AsString := FormatDateTime('dd.mm.yyyy',StrToDateTime(DataFin));
   end;
   //vQry.SQL.SaveToFile('C:\Sistemas\VendaBalcao\Dados\SQLText.txt');
   vQry.Open;
  Result := vQry;
end;

end.