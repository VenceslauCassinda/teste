import 'package:get/get.dart';
import 'package:oku_sanga_erp/aplicativo/solucaoes_uteis/visuais/mensagens_sistema.dart';
import 'package:oku_sanga_erp/aplicativo/vista/layouts_para_dialogos/processo_execucao/layout_carregando_circualr.dart';
import 'package:oku_sanga_erp/recursos/contantes.dart';
import 'package:oku_sanga_erp/solucao_uteis/visuais/gestao_estado.dart';
import 'dominio/casos_uso/autenticar_sistema_cu.dart';
import 'provedores/provedor_autenticacao_sistema.dart';
import 'solucaoes_uteis/funcionais/execucao_funcoes.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AplicacaoC extends GetxController {
  RxMap configuracao = RxMap();
  RxMap rotas = RxMap();
  RxMap usuariosAderindio = RxMap();
  RxMap usuariosCadastrados = RxMap();

  AutenticarSistemaCU? autenticarSistemaCU;

  AplicacaoC() {
    autenticarSistemaCU = AutenticarSistemaCU(ProvedorAutenticacaoSistema());
  }

  @override
  void onInit() async {
    super.onInit();
    await iniciarAutenticacaoSistema();
  }

  Future<void> iniciarAutenticacaoSistema() async {
    executarAccaoNoTempoEmMilissegundos(1000, () {
      _gerarDialogoAutenticandoSistema();
    });
    await autenticarSistemaCU!.iniciarAutenticacao(
        accaoNaDevolucaoDadoRequisitado: (dynamic dado) {
      (dado as List<Map>).forEach((element) {
        if (element["id"] == ID_CONFIGURACAO) {
          configuracao.value = element;
        }
        if (element["id"] == ID_ROTAS) {
          rotas.value = element;
        }
        if (element["id"] == ID_USUARIOS_ADERINDO) {
          usuariosAderindio.value = element;
        }
        if (element["id"] == ID_USUARIOS_CADASTRADOS) {
          usuariosCadastrados.value = element;
        }
      });
      fecharDialogoCasoAberto();
    });
  }

  _gerarDialogoAutenticandoSistema() {
    fecharDialogoCasoAberto();
    Get.defaultDialog(
        barrierDismissible: false,
        title: "",
        content: LayoutCarregandoCircrular("Autenticando o Sistema"));
  }

  bool sistemaAutenticado() {
    mostrar(configuracao);
    mostrar(rotas);
    mostrar(usuariosAderindio);
    mostrar(usuariosCadastrados);
    return ((configuracao != null) ||
        (rotas != null) ||
        (usuariosAderindio != null) ||
        (usuariosCadastrados != null));
  }
}
