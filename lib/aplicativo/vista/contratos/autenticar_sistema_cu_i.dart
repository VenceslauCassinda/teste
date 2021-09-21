abstract class AutenticarSistemaCUI {
  Future<void> iniciarAutenticacao(
      {required Function? accaoNaDevolucaoDadoRequisitado(
          dynamic dadoRequisitado)});
}
