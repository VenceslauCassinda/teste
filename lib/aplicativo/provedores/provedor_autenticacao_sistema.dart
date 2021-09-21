import 'dart:async';

import 'package:oku_sanga_erp/aplicativo/dominio/casos_uso/contratos/provedor_autenticacao_sistema_i.dart';
import 'package:oku_sanga_erp/aplicativo/solucaoes_uteis/visuais/mensagens_sistema.dart';
import 'package:oku_sanga_erp/solucao_uteis/funcionais/entidades/modelo_accoes_mediador.dart';
import 'package:oku_sanga_erp/solucao_uteis/funcionais/novo_paradgma/auttenticacao/accoes_autenticacao.dart';

class ProvedorAutenticacaoSistema implements ProvedorAutenticacaoSistemaI {
  // ModeloAccoesMediador? modeloAccoes;
  late AccoesAutenticacao _accoesAutenticacao;

  ProvedorAutenticacaoSistema() {
    _accoesAutenticacao = AccoesAutenticacao();
    // modeloAccoes = ModeloAccoesMediador(this);
    // modeloAccoes!.construirMediador();
  }

  @override
  Future<void> iniciarAutenticacao(
      {required Function? accaoNaDevolucaoDadoRequisitado(
          dynamic dadoRequisitado)}) async {
    _accoesAutenticacao.prepararMediador(
        accaoNaDevolucaoDadoRequisitado: accaoNaDevolucaoDadoRequisitado);
    // Timer.periodic(Duration(milliseconds: 500), (timer) {
    //   if (modeloAccoes!.mediador != null &&
    //       modeloAccoes!.controladorDados != null) {
    //     modeloAccoes!.orientarIniciacaoAutenticacaoSistema(
    //         accaoNaDevolucaoDadoRequisitado);
    //     timer.cancel();
    //   } else {
    //     mostrar(
    //         "SEM CONDICOES PARA INICIAR AUTH(modeloAccoes!.mediador nulo E modeloAccoes.controladorDados NULO");
    //   }
    // });
  }
}
