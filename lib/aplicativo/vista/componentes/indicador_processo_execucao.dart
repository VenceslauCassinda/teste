import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oku_sanga_erp/aplicativo/vista/componentes/observadores/observador_processo_execucao_c.dart';

class IndicadorProcessoEmExecucao extends StatelessWidget {
  IndicadorProcessoEmExecucaoC indicadorProcessoEmExecucaoC =
      IndicadorProcessoEmExecucaoC();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (indicadorProcessoEmExecucaoC.estadoIndicadorProcesso.value ==
          EstadoIndicadorProcesso.processando) {
        return LinearProgressIndicator();
      }
      return Container();
    });
  }

  void parar() {
    indicadorProcessoEmExecucaoC.parar();
  }

  void iniciar() {
    indicadorProcessoEmExecucaoC.iniciar();
  }
}
