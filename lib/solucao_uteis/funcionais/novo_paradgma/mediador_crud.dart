import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:oku_sanga_erp/aplicativo/solucaoes_uteis/visuais/mensagens_sistema.dart';

import 'capsula_accoes_mediador.dart';
import 'manipulacao_mensagem.dart';

class MediadorCrud implements MediadorCrudI {
  late String linkRepositorioWeb;
  InAppWebViewController? controladorMediador;
  HeadlessInAppWebView? _mediador;

  late CapsulaAccoesMediador capsulaAccoesMediador;
  @override
  int indice = -1;
  Function? accaoNaFinalizacaoPreparo;
  bool repositorioCriado = false;

  MediadorCrud(this.linkRepositorioWeb) {
    _gerarMediador();
  }

  void _gerarMediador() {
    _mediador = HeadlessInAppWebView(
        initialUrlRequest: URLRequest(url: Uri.parse(linkRepositorioWeb)),
        onLoadStop: (InAppWebViewController controladorMediador, Uri? uri) {
          // this.controladorMediador = controladorMediador;
          // capsulaAccoesMediador = CapsulaAccoesMediador(controladorMediador);
          // if (repositorioCriado == false) {
          //   accaoNaFinalizacaoPreparo!();
          //   repositorioCriado = true;
          //   mostrar("MEDIADOR_CRUD CRIADO");
          // }
          mostrar("/////////////////////");
        },
        onWebViewCreated: (InAppWebViewController controladorMediador) {
          this.controladorMediador = controladorMediador;
          // capsulaAccoesMediador = CapsulaAccoesMediador(controladorMediador);
          // if (repositorioCriado == false) {
          //   accaoNaFinalizacaoPreparo!();
          //   repositorioCriado = true;
          //   mostrar("MEDIADOR_CRUD CRIADO");
          // }
          mostrar("/////////////////////");
        });
  }

  @override
  Future<void> contruirMediador({Function? accaoNaFinalizacaoPreparo}) async {
    this.accaoNaFinalizacaoPreparo = accaoNaFinalizacaoPreparo;
    mostrar("»»»»»»»»»»» ${_mediador!.isRunning()}");
    await _mediador!.run();

    mostrar("»»»»»»»»»»» ${_mediador!.isRunning()}");
  }

  @override
  Future<Map> pegarInfoSubRepositorioUm() async {
    String? codigoFonte = await capsulaAccoesMediador.obterCodigoFonte();
    if (codigoFonte == null) {
      return {};
    }

    ManipulacaoMensagem manipulacaoMensagem = ManipulacaoMensagem(codigoFonte);
    return (await manipulacaoMensagem.pegarListaMapasDadosUteis())[0];
  }

  @override
  Future<Map> pegarInfoSubRepositorioDois() async {
    String? codigoFonte = await capsulaAccoesMediador.obterCodigoFonte();
    if (codigoFonte == null) {
      return {};
    }

    ManipulacaoMensagem manipulacaoMensagem = ManipulacaoMensagem(codigoFonte);
    return (await manipulacaoMensagem.pegarListaMapasDadosUteis())[1];
  }

  @override
  Future<Map> pegarInfoSubRepositorioTres() async {
    String? codigoFonte = await capsulaAccoesMediador.obterCodigoFonte();
    if (codigoFonte == null) {
      return {};
    }

    ManipulacaoMensagem manipulacaoMensagem = ManipulacaoMensagem(codigoFonte);
    return (await manipulacaoMensagem.pegarListaMapasDadosUteis())[2];
  }

  @override
  Future<Map> pegarInfoSubRepositorioQuatro() async {
    String? codigoFonte = await capsulaAccoesMediador.obterCodigoFonte();
    if (codigoFonte == null) {
      return {};
    }

    ManipulacaoMensagem manipulacaoMensagem = ManipulacaoMensagem(codigoFonte);
    return (await manipulacaoMensagem.pegarListaMapasDadosUteis())[3];
  }
}

abstract class MediadorCrudI {
  late int indice;
  Future<void> contruirMediador({Function? accaoNaFinalizacaoPreparo});
  Future<Map> pegarInfoSubRepositorioUm();
  Future<Map> pegarInfoSubRepositorioDois();
  Future<Map> pegarInfoSubRepositorioTres();
  Future<Map> pegarInfoSubRepositorioQuatro();
}
