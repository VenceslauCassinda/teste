abstract class ProvedorAutenticacaoSistemaI {
  Future<void> iniciarAutenticacao(
      {required Function? accaoNaDevolucaoDadoRequisitado(
          dynamic dadoRequisitado)});
}
