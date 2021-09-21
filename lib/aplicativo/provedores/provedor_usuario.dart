import 'package:oku_sanga_erp/aplicativo/dominio/casos_uso/contratos/provedor_usuario_i.dart';
import 'package:oku_sanga_erp/aplicativo/solucaoes_uteis/visuais/mensagens_sistema.dart';
import 'package:oku_sanga_erp/solucao_uteis/funcionais/novo_paradgma/mediador_crud.dart';

class ProvedorUsuario implements ProvedorUsuarioI {
  late String linkRepositorioWeb;
  late MediadorCrudI _mediadorCrud;

  ProvedorUsuario(this.linkRepositorioWeb);

  @override
  Future<List<Map>> pegarLista() async {
    mostrar("-----------» ${await _mediadorCrud.pegarInfoSubRepositorioUm()}");
    return [];
  }

  @override
  Future<void> prepararMdeiador({Function? accaoNaFinalizacaoPreparo}) async {
    _mediadorCrud = MediadorCrud(linkRepositorioWeb);
    _mediadorCrud.contruirMediador();
  }
}
