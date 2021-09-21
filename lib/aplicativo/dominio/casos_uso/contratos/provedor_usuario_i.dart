abstract class ProvedorUsuarioI {
  Future<List<Map>> pegarLista();
  Future<void> prepararMdeiador({Function? accaoNaFinalizacaoPreparo});
}
