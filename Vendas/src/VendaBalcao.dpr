program VendaBalcao;

uses
  Vcl.Forms,
  Vcl.Themes,
  Vcl.Styles,
  uClienteControl in 'Controller\uClienteControl.pas',
  uPedidovendaControl in 'Controller\uPedidovendaControl.pas',
  uPedidoXProdutosControl in 'Controller\uPedidoXProdutosControl.pas',
  uProdutoControl in 'Controller\uProdutoControl.pas',
  uSistemaControl in 'Controller\uSistemaControl.pas',
  uClienteModel in 'Model\uClienteModel.pas',
  uProdutoXImagemModel in 'Model\uProdutoXImagemModel.pas',
  uEnumerado in 'Model\uEnumerado.pas',
  uPedidovendaModel in 'Model\uPedidovendaModel.pas',
  uPedidoXProdutosModel in 'Model\uPedidoXProdutosModel.pas',
  uProdutoModel in 'Model\uProdutoModel.pas',
  uClienteDAO in 'DAO\uClienteDAO.pas',
  uConexao in 'Conexao\uConexao.pas',
  uPedidovendaDAO in 'DAO\uPedidovendaDAO.pas',
  uPedidoXProdutosDAO in 'DAO\uPedidoXProdutosDAO.pas',
  uProdutoDAO in 'DAO\uProdutoDAO.pas',
  uProdutoXImagemDAO in 'DAO\uProdutoXImagemDAO.pas',
  UConecta in 'Conexao\UConecta.pas',
  UConexaoBDpas in 'Conexao\UConexaoBDpas.pas' {frmConectaDB},
  uCadClientesVIEW in 'View\uCadClientesVIEW.pas' {frmCad_Clientes},
  UPrincipalVIEW in 'View\UPrincipalVIEW.pas' {frmPrincipal},
  uCadProdutosVIEW in 'View\uCadProdutosVIEW.pas' {frmCadProdutos},
  UPedidoDeVendaVIEW in 'View\UPedidoDeVendaVIEW.pas' {frmMov_PEDVendas},
  uPesquisaVIEW in 'View\uPesquisaVIEW.pas' {FrmPesquisa},
  uPrintPEDVIEW in 'View\uPrintPEDVIEW.pas' {frm_PrintPED},
  uEntradasProdutosModel in 'Model\uEntradasProdutosModel.pas',
  uEntradasProdutosDAO in 'DAO\uEntradasProdutosDAO.pas',
  uEntradasProdutosControl in 'Controller\uEntradasProdutosControl.pas',
  uEntradaProdutoVIEW in 'View\uEntradaProdutoVIEW.pas' {frmEntradaProduto},
  uUsuarioModel in 'Model\uUsuarioModel.pas',
  uUsuarioDAO in 'DAO\uUsuarioDAO.pas',
  uUsuarioControl in 'Controller\uUsuarioControl.pas',
  uLoginVIEW in 'View\uLoginVIEW.pas' {frmLogin},
  uRelVendasdiariasVIEW in 'View\uRelVendasdiariasVIEW.pas' {frmVendasdiaria},
  uRelatorioVendasDiariasModel in 'Model\uRelatorioVendasDiariasModel.pas',
  uRelatorioVendasDiariasDAO in 'DAO\uRelatorioVendasDiariasDAO.pas',
  uRelatorioVendasDiariasControl in 'Controller\uRelatorioVendasDiariasControl.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.ProcessMessages;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
