import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'observadores/observador_menu_drop_down.dart';

class MenuDropDown extends StatelessWidget {
  ObservadorMenuDropDown? observadorMenuDropDown;
  Function? metodoChamadoNaInsersao;
  String? labelMenuDropDown, valorDropdownButtonSeleccionado;
  List<String?>? listaItens;
  List<DropdownMenuItem<String?>>? listaDropdownMenuItem;
  MenuDropDown({
    this.labelMenuDropDown,
    this.metodoChamadoNaInsersao,
    this.listaItens,
  }) {
    observadorMenuDropDown = ObservadorMenuDropDown();
    if (listaItens != null && listaItens!.isNotEmpty) {
      // observadorSistema.mudarValorListaTipoInstituicaoDeReserva(listaItens);
    }

    listaDropdownMenuItem = listaItens != null
        ? listaItens!
            .map((String? valor) => DropdownMenuItem<String?>(
                  value: valor,
                  child: Text(valor!),
                ))
            .toList()
        : [];
  }
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return DropdownButton<String?>(
        items: listaDropdownMenuItem,
        value: observadorMenuDropDown!.valorDropdownButtonSeleccionado.value,
        hint: Text(labelMenuDropDown!),
        onChanged: (novoValor) {
          metodoChamadoNaInsersao!(novoValor);
          observadorMenuDropDown!.mudarValorItemDropdown(novoValor!);
        },
      );
    });
  }
}
