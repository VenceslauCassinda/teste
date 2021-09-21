import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'aplicacao_c.dart';
import 'vista/janelas/autenticacao/login/janela_login.dart';

class Aplicacao extends StatelessWidget {
  String nomeAplicativo;
  late AplicacaoC controlador;

  Aplicacao({required this.nomeAplicativo}) {
    iniciarControladores();
  }

  iniciarControladores() {
    controlador = Get.put(AplicacaoC());
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: nomeAplicativo,
          home: Stack(
            children: [
              // (controlador.autenticarSistemaCU!.fonteAutenticacaoSistemaI
              //         as ProvedorAutenticacaoSistema)
              //     .modeloAccoes!
              //     .mediador!,
              Opacity(
                opacity: .9,
                child: JanelaLogin(),
              ),
            ],
          ),
        );
      },
    );
  }
}
