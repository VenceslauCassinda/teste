import 'package:oku_sanga_erp/aplicativo/dominio/entidades/usuario.dart';

abstract class ManipularUsuarioCUI {
  late List<Usuario> lista;
  Future<List<Usuario>> pegarLista();
  Future<void> prepararMdeiador({Function? accaoNaFinalizacaoPreparo});
}
