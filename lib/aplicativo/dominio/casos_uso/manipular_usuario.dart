import 'package:oku_sanga_erp/aplicativo/dominio/casos_uso/contratos/provedor_usuario_i.dart';
import 'package:oku_sanga_erp/aplicativo/dominio/entidades/usuario.dart';
import 'package:oku_sanga_erp/aplicativo/vista/contratos/manipular_usuario_cu_i.dart';

class ManipularUsuarioCU implements ManipularUsuarioCUI {
  @override
  List<Usuario> lista = [];

  late ProvedorUsuarioI _provedorUsuario;

  ManipularUsuarioCU(this._provedorUsuario);

  @override
  Future<List<Usuario>> pegarLista() async {
    var listaTemportaria = (await _provedorUsuario.pegarLista())
        .map((e) => Usuario(e["nome"]))
        .toList();
    lista.addAll(listaTemportaria);
    return listaTemportaria;
  }

  @override
  Future<void> prepararMdeiador({Function? accaoNaFinalizacaoPreparo}) async{
    await _provedorUsuario.prepararMdeiador();
  }
}
