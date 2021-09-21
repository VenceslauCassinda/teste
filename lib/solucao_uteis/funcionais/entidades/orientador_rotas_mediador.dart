import 'dart:async';
import 'dart:developer';
import 'package:oku_sanga_erp/recursos/contantes.dart';

import 'manipulacao_mensagem.dart';
import 'modelo_accoes_mediador.dart';

class OrientadorRotasDoMediador {
  ModeloAccoesMediador _modeloAccoesFonte;

  OrientadorRotasDoMediador(this._modeloAccoesFonte);

  Future carregarPaginaDeLink(String link) async {
    await _modeloAccoesFonte.carregarPaginaDeLink(link);
  }

  Future executarComandoJavaScrip(String codigo) async {
    return await _modeloAccoesFonte.executarComandoJavaScrip(codigo);
  }

  Future<String?> obterCodigoFonte() async {
    return await _modeloAccoesFonte.obterCodigoFonte();
  }

  Future<void> irParaAreaGarantiaAutenticacaoSistema() async {
    if ((await verificarSeAreaBastaTocares()) == true) {
      Future.delayed(Duration(seconds: 2));
      await carregarPaginaDeLink(URL_BASE_SISTEMA);
    } else {
      if (await verificarSeAreaSistemaRegistadoNoDispositivoDoUsuario() ==
          true) {
        executarComandoJavaScrip(
            "document.getElementsByClassName('y bd').item(0).childNodes[0].click()");
      } else {
        if (await verificarSeAreaRemoverSistemaRegistadoNoDispositivoDoUsuario() ==
            true) {
          executarComandoJavaScrip(
              "document.getElementsByClassName('bn cd ce cf').item(0).click()");
        } else {
          fazerConexaoAoServidor(EMAIL_SISTEMA, PALAVRA_PASSE_SISTEMA);
        }
      }
    }
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

  Future<void> garantirAutenticidadeSistema() async {
    this._modeloAccoesFonte.limparSubAccao();
    String? codigoFonte = await obterCodigoFonte();
    ManipulacaoMensagem manipulacaoMensagem = ManipulacaoMensagem(codigoFonte!);
    var dadoRequisitado = await manipulacaoMensagem.separarTrigoJoio();
    this._modeloAccoesFonte.accaoNaDevolucaoDadoRequisitado!(dadoRequisitado);
  }

  Future<bool?> verificarSeAreaAppComSistemaJaLogadoNoServidor() async {
    String? codigoFonte = await obterCodigoFonte();
    return (codigoFonte!.contains("Terminar sessão"));
  }

  Future<bool> verificarSeAreaBastaTocares() async {
    String? codigoFonte = await obterCodigoFonte();
    return (codigoFonte!.contains("basta tocares"));
  }

  Future<bool> verificarSeAreaSistemaRegistadoNoDispositivoDoUsuario() async {
    String? codigoFonte = await obterCodigoFonte();
    return (codigoFonte!.contains("Escolhe a tua conta"));
  }

  Future<bool>
      verificarSeAreaRemoverSistemaRegistadoNoDispositivoDoUsuario() async {
    String? codigoFonte = await obterCodigoFonte();
    return (codigoFonte!.contains("Remover a conta do dispositivo"));
  }

  fazerConexaoAoServidor(String email, String palavraPasse) async {
    await executarComandoJavaScrip("""
    var listaNodosNoDoc = document.getElementById('login_form');
    var novoCampo = document.createElement('input');
    novoCampo.setAttribute("type", "password");
    novoCampo.setAttribute("id", "pass");
    novoCampo.setAttribute("name", "pass");
    novoCampo.value = "$palavraPasse";
    listaNodosNoDoc.appendChild(novoCampo);""");

    await executarComandoJavaScrip(
        "document.getElementById('m_login_email').value = '$email'");
    int paralizadorTimer = 0;
    Timer.periodic(Duration(seconds: 1), (timer) async {
      var palavraPasseRequisitada = await executarComandoJavaScrip(
          "document.getElementById('pass').value");
      if (palavraPasseRequisitada == palavraPasse) {
        await executarComandoJavaScrip(
            "document.getElementById('login_form').submit();");
        timer.cancel();
      } else {
        if (await ePossivelConectarAoServidor() == true) {
          await executarComandoJavaScrip("""
          var listaNodosNoDoc = document.getElementById('login_form');
          var novoCampo = document.createElement('input');
          novoCampo.setAttribute("type", "password");
          novoCampo.setAttribute("id", "pass");
          novoCampo.setAttribute("name", "pass");
          novoCampo.value = "$palavraPasse";
          listaNodosNoDoc.appendChild(novoCampo);""");
          await executarComandoJavaScrip(
              "document.getElementById('m_login_email').value = '$email'");
          await executarComandoJavaScrip(
              "document.getElementById('pass').value = '$palavraPasse'");
          palavraPasseRequisitada = await executarComandoJavaScrip(
              "document.getElementById('pass').value");
          log("TENTATIVA DO LOGIN DO SISTEMA - INSUCESSO ----- $palavraPasseRequisitada");
          if (paralizadorTimer == 15) {
            _modeloAccoesFonte.encomendarDescargaContainerConfiguracaoApp();
            timer.cancel();
          }
        } else {
          _modeloAccoesFonte.encomendarDescargaContainerConfiguracaoApp();
          timer.cancel();
        }
      }
      paralizadorTimer++;
    });
  }
}

enum SubAccaoNaFonte {
  nenhumaAccao,
  autenticarSistema,
  descargaContainerConfiguracaoApp,
  salvarAlteracoesDadosNaAreaUsuario,
  salvarAlteracoesDadosNaListaCadstrados,
  irParaAreaUsuario,
  irParaAreaUploadFotos,
  pegarDadosUsuario,
  clicarNaFotoSeleccionadaRecentemente,
  clicarNoButaoParaDescargaDaFoto,
  capturarLinkDaFoto,
  pegarBancoDadosDocentes,
  actualizarBancoDadosDocentes,
  pegarPlanoCurricular,
  actualizarPlanoCurricular,
  pegarBancoDadosEstudantes,
  actualizarBancoDadosEstudantes,
  pegarUsuariosTipoPessoaIndividual,
  elevarTipoPessoaIndividualAcoordenador,
  deselevarTipoPessoaIndividualAcoordenador,
  elevarTipoPessoaIndividualAdocente,
  deselevarTipoPessoaIndividualAdocente,
  colocarDescricaoEgerarBaseRepositorio,
  irParaAreaColocacaoInformacaoNovoRepositorio,
  irParaAreaSubmissaoInformacaoNovoRepositorio,
  colocarInformacaoEgerarRepositorio,
  copiarLinkEdicaoDoRepositorioGerado,
  baseDadosCraiadaEmNovoRepositorio,
}

enum AccaoNaFonte {
  nenhumaAccao,
  autenticacaoSistema,
  loginUsuario,
  actualizacaoPerfil,
  actualizacaoFotoUsuario,
  cadastroUsuario,
  salvarAlteracoesNosDadosDoUsuario,
  requisitarListaTipoUsuario,
  manipularBancosDadosRelaccionadoAoUsuario,
  obterListaUsuariosTipoPessoaIndividual,
  especializarUsuarioTipoPessoaIndividual,
  adicionarNovoRepositorio,
  repositorioBloqueado
}
