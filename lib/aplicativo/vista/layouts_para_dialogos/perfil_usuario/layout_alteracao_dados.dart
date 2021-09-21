import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oku_sanga_erp/aplicativo/vista/componentes/butoes.dart';
import 'package:oku_sanga_erp/aplicativo/vista/componentes/campo_texto.dart';
import 'package:oku_sanga_erp/aplicativo/vista/componentes/label_erros.dart';
import 'package:oku_sanga_erp/aplicativo/vista/componentes/observadores/observador_butoes.dart';
import 'package:oku_sanga_erp/aplicativo/vista/componentes/observadores/observador_campo_texto.dart';
import 'package:oku_sanga_erp/aplicativo/vista/componentes/validadores/validadcao_campos.dart';

class LayoutQuandoNome extends StatelessWidget {
  ObservadorCampoTexto? _observadorCampoTexto;
  ObservadorButoes? observadorButoes = ObservadorButoes();
  String? nome = "";
  BuildContext? context;

  LayoutQuandoNome() {
    _observadorCampoTexto = ObservadorCampoTexto();
    observadorButoes = ObservadorButoes();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CampoTexto(
              campoBordado: false,
              icone: Icon(Icons.text_fields),
              dicaParaCampo: "Nome da Entidade",
              metodoChamadoNaInsersao: (String valor) {
                nome = valor;
                _observadorCampoTexto!
                    .observarCampo(valor, TipoCampoTexto.nome);
                if (valor.isEmpty) {
                  _observadorCampoTexto!
                      .mudarValorValido(true, TipoCampoTexto.nome);
                }
                observadorButoes!.mudarValorFinalizarCadastroInstituicao(
                    [nome!], [_observadorCampoTexto!.valorNomeValido.value]);
              },
            ),
          ),
          Obx(() {
            return _observadorCampoTexto!.valorNomeValido.value == true
                ? Container()
                : LabelErros(
                    sms: "Este Nome de Entidade ainda é inválido!",
                  );
          }),
          SizedBox(
            height: 20,
          ),
          Obx(() {
            return ModeloButao(
              tituloButao: "Alterar",
              butaoHabilitado:
                  observadorButoes!.butaoFinalizarCadastroInstituicao.value,
              metodoChamadoNoClique: () {},
            );
          }),
        ]);
  }
}

class LayoutQuandoPalavraPasse extends StatelessWidget {
  ObservadorCampoTexto? _observadorCampoTexto;
  ObservadorCampoTexto? _observadorCampoTexto2;
  ObservadorButoes? observadorButoes = ObservadorButoes();
  String? palavraPasse = "", novaPalavraPasse = "";
  BuildContext? context;

  LayoutQuandoPalavraPasse() {
    _observadorCampoTexto = ObservadorCampoTexto();
    _observadorCampoTexto2 = ObservadorCampoTexto();
    observadorButoes = ObservadorButoes();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CampoTexto(
              campoBordado: false,
              icone: Icon(Icons.lock),
              tipoCampoTexto: TipoCampoTexto.palavra_passe,
              dicaParaCampo: "Palavra-Passe antiga",
              metodoChamadoNaInsersao: (String valor) {
                palavraPasse = valor;
                _observadorCampoTexto!
                    .observarCampo(valor, TipoCampoTexto.palavra_passe);
                if (valor.isEmpty) {
                  _observadorCampoTexto!
                      .mudarValorValido(true, TipoCampoTexto.palavra_passe);
                }
                // observadorButoes.mudarValorFinalizarCadastroInstituicao([palavraPasse, novaPalavraPasse],[_observadorCampoTexto!.valorPalavraPasseValido.value, _observadorCampoTexto2.valorPalavraPasseValido.value, palavraPasse == JanelaPainelUsuarioC.usuarioActual.palavraPasse]);
              },
            ),
          ),
          Obx(() {
            return _observadorCampoTexto!.valorPalavraPasseValido.value == true
                ? Container()
                : LabelErros(
                    sms: "A palavra-passe deve ser igual a antiga!",
                  );
          }),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: CampoTexto(
              campoBordado: false,
              icone: Icon(Icons.lock),
              tipoCampoTexto: TipoCampoTexto.palavra_passe,
              dicaParaCampo: "Nova Palavra-Passe",
              metodoChamadoNaInsersao: (String valor) {
                novaPalavraPasse = valor;
                _observadorCampoTexto2!
                    .observarCampo(valor, TipoCampoTexto.palavra_passe);
                if (valor.isEmpty) {
                  _observadorCampoTexto2!
                      .mudarValorValido(true, TipoCampoTexto.palavra_passe);
                }
                observadorButoes!.mudarValorFinalizarCadastroInstituicao([
                  palavraPasse!,
                  novaPalavraPasse!
                ], [
                  _observadorCampoTexto!.valorPalavraPasseValido.value,
                  _observadorCampoTexto2!.valorPalavraPasseValido.value
                ]);
              },
            ),
          ),
          Obx(() {
            return _observadorCampoTexto2!.valorPalavraPasseValido.value == true
                ? Container()
                : LabelErros(
                    sms: "A palavra-passe deve ter mais de 7 caracteres!",
                  );
          }),
          SizedBox(
            height: 20,
          ),
          Obx(() {
            return ModeloButao(
              tituloButao: "Alterar",
              butaoHabilitado:
                  observadorButoes!.butaoFinalizarCadastroInstituicao.value,
              metodoChamadoNoClique: () {},
            );
          }),
        ]);
  }
}

class ConfirmarSalvacaoAlteracoesPerfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, bottom: 20, right: 20),
        child: Column(
          children: [
            Text(
              "Deseja salvar as alterações?",
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  ModeloButao(
                    tituloButao: "Sim",
                    metodoChamadoNoClique: () {},
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  ModeloButao(
                    butaoHabilitado: true,
                    tituloButao: "Descartar",
                    metodoChamadoNoClique: () {
                      Get.back();
                    },
                  ),
                ],
              ),
            )
          ],
        ));
  }
}
