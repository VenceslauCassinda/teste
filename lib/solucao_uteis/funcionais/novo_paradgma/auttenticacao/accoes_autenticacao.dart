import 'dart:async';

import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:oku_sanga_erp/aplicativo/solucaoes_uteis/funcionais/execucao_funcoes.dart';
import 'package:oku_sanga_erp/aplicativo/solucaoes_uteis/visuais/mensagens_sistema.dart';
import 'package:oku_sanga_erp/recursos/contantes.dart';
import 'package:oku_sanga_erp/solucao_uteis/funcionais/novo_paradgma/capsula_accoes_mediador.dart';

import '../manipulacao_mensagem.dart';

class AccoesAutenticacao {
  HeadlessInAppWebView? _mediador;
  late InAppWebViewController _controladorMediador;
  late CapsulaAccoesMediadorI _capsulaAccoesMediador;
  Accao _accao = Accao.nenhuma;
  SubAccao _subAccao = SubAccao.nenhuma;
  late Function accaoNaDevolucaoDadoRequisitado;

  Map CONFIGURACOES_PREVIAS = {
    NomeLinkRequisicao.baseApp: "https://free.facebook.com/",
    NomeLinkRequisicao.containerConfiguracaoApp:
        "https://free.facebook.com/messages/read/?fbid=102984381906371",
  };

  AccoesAutenticacao() {
    executarAccaoNoTempoEmMilissegundos(900, () {
      _gerar();
    });
  }

  void _gerar() {
    _mediador = HeadlessInAppWebView(
      initialUrlRequest:
          URLRequest(url: Uri.parse("http://free.facebook.com/")),
      onWebViewCreated: (InAppWebViewController controladorMediador) {
        this._controladorMediador = controladorMediador;
        _capsulaAccoesMediador = CapsulaAccoesMediador(_controladorMediador);
        mostrar("REPOSITORIO AUTH CRIADO");
      },
      onLoadStop: (controlador, linkActual) async {
        mostrar("TITULO ACTUAL ---> ${await controlador.getTitle()}");
        mostrar("LINK ACTUAL ---> ${linkActual!.host}");
        mostrar(
            "ACCAO ACTUAL ---> ${_accao.toString().replaceAll("Accao.", "")}");
        mostrar(
            "SUB_ACCAO ACTUAL ---> ${_subAccao.toString().replaceAll("SubAccao.", "")}");

        await _definirEscopoAccoes();
      },
    );
  }

  void _executarAccaoQuandoMediaqdorNaoNulo(Function accao) {
    Timer.periodic(Duration(milliseconds: 10), (timer) {
      if (_mediador != null) {
        accao();
        timer.cancel();
      }
      mostrar("MEDAIDOR AUTH AINDA NULO");
    });
  }

  Future<void> prepararMediador(
      {Function? accaoNaDevolucaoDadoRequisitado}) async {
    _executarAccaoQuandoMediaqdorNaoNulo(() async {
      iniciarAutenticacaoSistema();
      await _mediador!.run();
      this.accaoNaDevolucaoDadoRequisitado = accaoNaDevolucaoDadoRequisitado!;
    });
  }

  Future<void> _definirEscopoAccoes() async {
    if (Accao.autenticacaoSistema == _accao) {
      if (_subAccao == SubAccao.autenticarSistema) {
        await irParaAreaGarantiaAutenticacaoSistema();
      }

      if (_subAccao == SubAccao.descargaContainerConfiguracaoApp) {
        await garantirAutenticidadeSistema();
      }
    }
  }

  void iniciarAutenticacaoSistema() {
    mudarAccao(Accao.autenticacaoSistema);
    mudarSubAccao(SubAccao.autenticarSistema);
  }

  Future<void> irParaAreaGarantiaAutenticacaoSistema() async {
    if ((await verificarSeAreaBastaTocares()) == true) {
      mostrar("REPOSITORIOS AUTH EM AREA BASTA TOCARES");
      Future.delayed(Duration(seconds: 2));
      await _capsulaAccoesMediador.carregarPaginaDeLink(URL_BASE_SISTEMA);
    } else {
      if (await verificarSeAreaSistemaRegistadoNoDispositivoDoUsuario() ==
          true) {
            mostrar("REPOSITORIOS AUTH EM AREA SISTEMA REGISTADO NO DESPOSITIVO");
        await _capsulaAccoesMediador.executarComandoJavaScrip(
            "document.getElementsByClassName('y bd').item(0).childNodes[0].click()");
      } else {
        if (await verificarSeAreaRemoverSistemaRegistadoNoDispositivoDoUsuario() ==
            true) {
              mostrar("REPOSITORIOS AUTH EM AREA REMOVER USUARI DO DESPOSITIVO");
          await _capsulaAccoesMediador.executarComandoJavaScrip(
              "document.getElementsByClassName('bn cd ce cf').item(0).click()");
        } else {
          mostrar("REPOSITORIOS AUTH EM AREA PARA LOGIN NO SERVIDOR");
          fazerConexaoAoServidor(EMAIL_SISTEMA, PALAVRA_PASSE_SISTEMA);
        }
      }
    }
  }

  Future<void> garantirAutenticidadeSistema() async {
    limparSubAccao();
    String? codigoFonte = await _capsulaAccoesMediador.obterCodigoFonte();
    ManipulacaoMensagem manipulacaoMensagem = ManipulacaoMensagem(codigoFonte!);
    var dadoRequisitado = await manipulacaoMensagem.separarTrigoJoio();
    accaoNaDevolucaoDadoRequisitado(dadoRequisitado);
  }

  Future<bool?> verificarSeAreaAppComSistemaJaLogadoNoServidor() async {
    String? codigoFonte = await _capsulaAccoesMediador.obterCodigoFonte();
    return (codigoFonte!.contains("Terminar sessão"));
  }

  Future<bool> verificarSeAreaBastaTocares() async {
    String? codigoFonte = await _capsulaAccoesMediador.obterCodigoFonte();
    return (codigoFonte!.contains("basta tocares"));
    
  }

  Future<bool> verificarSeAreaSistemaRegistadoNoDispositivoDoUsuario() async {
    String? codigoFonte = await _capsulaAccoesMediador.obterCodigoFonte();
    return (codigoFonte!.contains("Escolhe a tua conta"));
  }

  Future<bool>
      verificarSeAreaRemoverSistemaRegistadoNoDispositivoDoUsuario() async {
    String? codigoFonte = await _capsulaAccoesMediador.obterCodigoFonte();
    return (codigoFonte!.contains("Remover a conta do dispositivo"));
  }

  fazerConexaoAoServidor(String email, String palavraPasse) async {
    await _capsulaAccoesMediador.executarComandoJavaScrip("""
    var listaNodosNoDoc = document.getElementById('login_form');
    var novoCampo = document.createElement('input');
    novoCampo.setAttribute("type", "password");
    novoCampo.setAttribute("id", "pass");
    novoCampo.setAttribute("name", "pass");
    novoCampo.value = "$palavraPasse";
    listaNodosNoDoc.appendChild(novoCampo);""");

    await _capsulaAccoesMediador.executarComandoJavaScrip(
        "document.getElementById('m_login_email').value = '$email'");
    int paralizadorTimer = 0;
    Timer.periodic(Duration(seconds: 1), (timer) async {
      var palavraPasseRequisitada = await _capsulaAccoesMediador
          .executarComandoJavaScrip("document.getElementById('pass').value");
      if (palavraPasseRequisitada == palavraPasse) {
        await _capsulaAccoesMediador.executarComandoJavaScrip(
            "document.getElementById('login_form').submit();");
        timer.cancel();
      } else {
        if (await ePossivelConectarAoServidor() == true) {
          await _capsulaAccoesMediador.executarComandoJavaScrip("""
          var listaNodosNoDoc = document.getElementById('login_form');
          var novoCampo = document.createElement('input');
          novoCampo.setAttribute("type", "password");
          novoCampo.setAttribute("id", "pass");
          novoCampo.setAttribute("name", "pass");
          novoCampo.value = "$palavraPasse";
          listaNodosNoDoc.appendChild(novoCampo);""");
          await _capsulaAccoesMediador.executarComandoJavaScrip(
              "document.getElementById('m_login_email').value = '$email'");
          await _capsulaAccoesMediador.executarComandoJavaScrip(
              "document.getElementById('pass').value = '$palavraPasse'");
          palavraPasseRequisitada =
              await _capsulaAccoesMediador.executarComandoJavaScrip(
                  "document.getElementById('pass').value");
          mostrar(
              "TENTATIVA DO LOGIN DO SISTEMA - INSUCESSO ----- $palavraPasseRequisitada");
          if (paralizadorTimer == 15) {
            await encomendarDescargaContainerConfiguracaoApp();
            timer.cancel();
            mostrar("REPOSITORIOS AUTH EM AREA DE DESCARGA DE METADADOS BASE DA APP");
          }
        } else {
          await encomendarDescargaContainerConfiguracaoApp();
          timer.cancel();
          mostrar("REPOSITORIOS AUTH EM AREA DE DESCARGA DE METADADOS BASE DA APP");
        }
      }
      paralizadorTimer++;
    });
  }

  Future<void> encomendarDescargaContainerConfiguracaoApp() async {
    mudarSubAccao(SubAccao.descargaContainerConfiguracaoApp);
    await irParaAreaConfiguracoesApp();
  }

  Future<void> irParaAreaConfiguracoesApp() async {
    await _capsulaAccoesMediador.carregarPaginaDeLink(
        CONFIGURACOES_PREVIAS[NomeLinkRequisicao.containerConfiguracaoApp]);
  }

  Future<bool> ePossivelConectarAoServidor() async {
    bool controlo = false;
    if ((await verificarSeAreaBastaTocares() == false) &&
        (await verificarSeAreaSistemaRegistadoNoDispositivoDoUsuario() ==
            false) &&
        (await verificarSeAreaRemoverSistemaRegistadoNoDispositivoDoUsuario() ==
            false) &&
        (await verificarSeAreaAppComSistemaJaLogadoNoServidor() == false)) {
      controlo = true;
    }
    return controlo;
  }

  void limparAccao() {
    this._accao = Accao.nenhuma;
  }

  void limparSubAccao() {
    this._subAccao = SubAccao.nenhuma;
  }

  void mudarSubAccao(SubAccao subAccao) {
    this._subAccao = subAccao;
  }

  void mudarAccao(Accao accao) {
    this._accao = accao;
  }
}

enum Accao { nenhuma, autenticacaoSistema }

enum SubAccao { nenhuma, autenticarSistema, descargaContainerConfiguracaoApp }
