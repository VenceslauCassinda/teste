import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'imagem_rede.dart';

class CabecalhoGaveta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool mostrarIcone = true;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            margin: EdgeInsets.only(top: 50),
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(120.0)),
                child: (mostrarIcone == true)
                    ? Icon(
                        Icons.person,
                        size: 60,
                        color: Colors.white,
                      )
                    : ImagemRede(
                        link_imagem: "",
                        // observadorSistema.usuarioActual.imagemPerfil,
                        altura: 100,
                        largura: 100,
                        alturaErro: 100,
                        larguraErro: 100,
                        tamanhoImogiErro: 15,
                        tamanhoTextoErro: 15,
                      ))),
        // Padding(
        //   padding: const EdgeInsets.all(10),
        //   child:
        //       Text(observadorSistema.usuarioActual.toJson()["email_usuario"] == null ? "" : observadorSistema.usuarioActual.toJson()["email_usuario"]),
        // )
      ],
    );
  }
}
