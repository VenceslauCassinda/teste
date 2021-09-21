import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oku_sanga_erp/recursos/contantes.dart';

import 'validadores/validadcao_campos.dart';

class CampoTexto extends StatelessWidget {
  Function? metodoChamadoNaInsersao;
  String? dicaParaCampo;
  String? textoPadrao;
  String? dicaParaErroNoCampo;
  TipoCampoTexto? tipoCampoTexto;
  bool? campoBordado = false;
  bool? campoNaoEditavel = false;
  Icon? icone;
  CampoTexto(
      {this.icone,
      this.campoNaoEditavel,
      this.tipoCampoTexto,
      this.campoBordado,
      this.metodoChamadoNaInsersao,
      this.dicaParaCampo,
      this.dicaParaErroNoCampo,
      this.textoPadrao});
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: COR_ACCENT,
      ),
      child: Container(
        height: 50,
        decoration: campoBordado == false
            ? BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.pink.withOpacity(0.1),
              )
            : BoxDecoration(),
        child: TextFormField(
          keyboardType: tipoCampoTexto == null
              ? TextInputType.name
              : (tipoCampoTexto == TipoCampoTexto.numero
                  ? TextInputType.numberWithOptions(decimal: true)
                  : TextInputType.name),
          readOnly: campoNaoEditavel == true ? true : false,
          controller: TextEditingController(
              text: textoPadrao == null ? "" : "$textoPadrao"),
          obscureText: tipoCampoTexto == TipoCampoTexto.palavra_passe,
          decoration: InputDecoration(
              errorStyle: TextStyle(fontSize: 12),
              icon: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: icone,
              ),
              errorText: dicaParaErroNoCampo,
              hintText: dicaParaCampo,
              border: campoBordado == false
                  ? InputBorder.none
                  : OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20))),
              contentPadding: campoBordado == false
                  ? EdgeInsets.symmetric(horizontal: -10)
                  : EdgeInsets.symmetric(horizontal: 10)),
          onChanged: (valor) {
            if (metodoChamadoNaInsersao != null) {
              metodoChamadoNaInsersao!(valor);
            }
          },
        ),
      ),
    );
  }
}
