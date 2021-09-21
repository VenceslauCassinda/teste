import 'package:oku_sanga_erp/aplicativo/dominio/casos_uso/contratos/provedor_autenticacao_sistema_i.dart';
import 'package:oku_sanga_erp/recursos/contantes.dart';
import '../../../../aplicativo/solucaoes_uteis/visuais/mensagens_sistema.dart';
import 'orientador_rotas_mediador.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class ModeloAccoesMediador {
  OrientadorRotasDoMediador? _orientadorRotas;
  InAppWebView? mediador;
  ProvedorAutenticacaoSistemaI? _provedorAutenticacaoSistemaI;
  InAppWebViewController? controladorDados;
  int? quantidadePaginasCarregadas = 0;

  Function? accaoNaDevolucaoDadoRequisitado;

  ModeloAccoesMediador(ProvedorAutenticacaoSistemaI? provedorAutenticacaoSistemaI) {
    this._orientadorRotas = OrientadorRotasDoMediador(this);
    this._provedorAutenticacaoSistemaI = provedorAutenticacaoSistemaI;
  }

  void construirMediador() {
    mediador = InAppWebView(
      initialUrlRequest:
          URLRequest(url: Uri.parse("http://free.facebook.com/")),
      onWebViewCreated: (InAppWebViewController controladorDados) {
        this.controladorDados = controladorDados;
        mostrar("FONTE CRIADA COM SUCESSO");
      },
      onLoadStop: (controlador, linkActual) async {
        if (quantidadePaginasCarregadas == 0) {
          mostrar("FONTE PREPARADA COM SUCESSO");
        }
        mostrar("TITULO ACTUAL ---> ${await controlador.getTitle()}");
        mostrar("LINK ACTUAL ---> ${linkActual!.host}");
        mostrar("ACCAO ACTUAL ---> $accaoNaFonte");
        mostrar("SUB_ACCAO ACTUAL ---> $subAccaoNaFonte");

        await executarQuandoForAuteticacaoSistema();
        quantidadePaginasCarregadas = quantidadePaginasCarregadas! + 1;
      },
    );
  }

  Map? CONFIGURACOES_PREVIAS = {
    NomeLinkRequisicao.baseApp: "https://free.facebook.com/",
    NomeLinkRequisicao.containerConfiguracaoApp:
        "https://free.facebook.com/messages/read/?fbid=102984381906371",
  };

  AccaoNaFonte? accaoNaFonte;
  SubAccaoNaFonte? subAccaoNaFonte;


  Future<void> executarQuandoForAuteticacaoSistema() async {
    if (AccaoNaFonte.autenticacaoSistema == accaoNaFonte) {
      if (subAccaoNaFonte == SubAccaoNaFonte.autenticarSistema) {
        _orientadorRotas!.irParaAreaGarantiaAutenticacaoSistema();
      }

      if (subAccaoNaFonte == SubAccaoNaFonte.descargaContainerConfiguracaoApp) {
        _orientadorRotas!.garantirAutenticidadeSistema();
      }
    }
  }

  void orientarIniciacaoAutenticacaoSistema(Function? accaoNaDevolucaoDadoRequisitado(dynamic dadoRequisitado)) async {
    definirAccaoNaDevolucaoDadoRequisitado(accaoNaDevolucaoDadoRequisitado);
    mudarAccaoNaFontePara(AccaoNaFonte.autenticacaoSistema);
    mudarSubAccaoNaFontePara(SubAccaoNaFonte.autenticarSistema);
  }

  void definirAccaoNaDevolucaoDadoRequisitado(
      Function? accaoNaDevolucaoDadoRequisitado(dynamic? dadoRequisitado)) {
    this.accaoNaDevolucaoDadoRequisitado = accaoNaDevolucaoDadoRequisitado;
  }

  void limparTotasAccoes() async {
    mudarAccaoNaFontePara(AccaoNaFonte.nenhumaAccao);
    mudarSubAccaoNaFontePara(SubAccaoNaFonte.nenhumaAccao);
  }

  void limparAccao() async {
    mudarAccaoNaFontePara(AccaoNaFonte.nenhumaAccao);
    mostrar("ACCOES DE FONTE LIMPAS");
  }

  void limparSubAccao() async {
    mudarSubAccaoNaFontePara(SubAccaoNaFonte.nenhumaAccao);
  }

  Future<void> irParaAreaConfiguracoesApp() async {
    await carregarPaginaDeLink(
        CONFIGURACOES_PREVIAS![NomeLinkRequisicao.containerConfiguracaoApp]);
  }

  Future<void> irParaAreaBaseApp() async {
    await carregarPaginaDeLink(
        CONFIGURACOES_PREVIAS![NomeLinkRequisicao.baseApp]);
  }

  Future<void> encomendarDescargaContainerConfiguracaoApp() async {
    mudarSubAccaoNaFontePara(SubAccaoNaFonte.descargaContainerConfiguracaoApp);
    await irParaAreaConfiguracoesApp();
  }

  mudarAccaoNaFontePara(AccaoNaFonte accaoNaFonte) {
    this.accaoNaFonte = accaoNaFonte;
  }

  mudarSubAccaoNaFontePara(SubAccaoNaFonte subAccaoNaFonte) {
    this.subAccaoNaFonte = subAccaoNaFonte;
  }

  // ===================================
  Future<void> carregarPaginaDeLink(String? link) async {
    await controladorDados!
        .loadUrl(urlRequest: URLRequest(url: Uri.parse(link!)));
  }

  Future<void> recarregar() async {
    await controladorDados!.reload();
  }

  Future<dynamic> executarComandoJavaScrip(String codigo) async {
    return await controladorDados!.evaluateJavascript(source: codigo);
  }

  Future<String?> obterCodigoFonte() async {
    return await controladorDados!.getHtml();
  }
}
