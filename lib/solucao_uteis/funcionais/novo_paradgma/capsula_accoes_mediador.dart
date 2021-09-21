import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class CapsulaAccoesMediador implements CapsulaAccoesMediadorI {
  @override
  late InAppWebViewController controladorMediador;

  CapsulaAccoesMediador(this.controladorMediador);

  @override
  Future<void> carregarPaginaDeLink(String link) async {
    await controladorMediador
        .loadUrl(urlRequest: URLRequest(url: Uri.parse(link)));
  }

  @override
  Future<dynamic> executarComandoJavaScrip(String codigo) async {
    return await controladorMediador.evaluateJavascript(source: codigo);
  }

  @override
  Future<String?> obterCodigoFonte() async {
    return await controladorMediador.getHtml();
  }

  @override
  Future<void> recarregar() async {
    await controladorMediador.reload();
  }
}

abstract class CapsulaAccoesMediadorI {
  late InAppWebViewController controladorMediador;

  Future<void> carregarPaginaDeLink(String link);

  Future<void> recarregar();

  Future<dynamic> executarComandoJavaScrip(String codigo);

  Future<String?> obterCodigoFonte();
}
