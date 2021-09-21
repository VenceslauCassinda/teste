import 'package:flutter/material.dart';

BuildContext? _contexto;

definirContextoGeralDaAppParaResponsividade(BuildContext contexto) {
  _contexto = contexto;
}

pegarAlturaTela() {
  _contexto!.size!.height;
}

pegarLarguraTela() {
  _contexto!.size!.width;
}
