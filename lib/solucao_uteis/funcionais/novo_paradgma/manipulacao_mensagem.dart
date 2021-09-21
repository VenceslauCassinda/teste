import 'dart:convert';

import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart';

class ManipulacaoMensagem {
  final String codigoFonte;
  ManipulacaoMensagem(this.codigoFonte);

  Future<List<Map>> pegarListaMapasDadosUteis() async {
    return await separarTrigoJoio();
  }

  Future<List<Map>> separarTrigoJoio() async {
    List<Map> listaMensagensUteis = [];

    var documentoHtml = parser.parse(codigoFonte);
    var contentorPai = documentoHtml.getElementById("messageGroup");

    int c = 0;
    for (Element cadaContentorSMSsingular
        in contentorPai!.children[1].children) {
      // mostrar(c);
      cadaContentorSMSsingular.children[0].children.removeAt(0);
      String mensagemUtil = gerarMensagemLapidadaCaptura(
          cadaContentorSMSsingular.children[0].text.toString());

      mensagemUtil = eliminarCaracteresIndesejadosDaMensagem(mensagemUtil);

      Map mapaDaSMS = converterStringParaMapa(mensagemUtil);
      listaMensagensUteis.add(mapaDaSMS);
      c++;
    }

    return listaMensagensUteis;
  }

  String eliminarCaracteresIndesejadosDaMensagem(String mensagem) {
    String caractereIndesejado = "­";
    return mensagem.replaceAll(caractereIndesejado, "");
  }

  bool verificarSeMensagemJuntavel(String mensagem) {
    // CONSIDERA-SE UMA SMS COMO JUNTAVEL QUANDO AO SER POSTADA NO SERVIDOR NAO E JUNTADA A ANTERIOR
    return mensagem.length < 1883;
  }

  bool verificarSeMensagemFoiTransformada(String mensagem) {
    return mensagem.contains("£§@");
  }

  String pegarMensagemUtilDaTransformada(String mensagem) {
    return mensagem.split("£§@")[0];
  }

  String transformarEmMensagemNaoJuntavel(String mensagem) {
    int c = 0;
    while (mensagem.length < 1883) {
      if (c == 0) {
        mensagem += "£§@_";
      } else {
        mensagem += "_";
      }
      c++;
    }
    return mensagem;
  }

  String gerarMensagemLapidadaCaptura(String mensagem) {
    if (verificarSeMensagemFoiTransformada(mensagem)) {
      return pegarMensagemUtilDaTransformada(mensagem);
    }
    return mensagem;
  }

  String gerarMensagemLapidadaParaPostagem(String mensagem) {
    if (verificarSeMensagemJuntavel(mensagem)) {
      mensagem = transformarEmMensagemNaoJuntavel(mensagem);
    }
    return mensagem;
  }

  Map converterStringParaMapa(String stringAserConvertido) {
    return json.decode("""$stringAserConvertido""");
  }

  String converterMapaParaString(Map mapa) {
    return json.encode(mapa);
  }
}
