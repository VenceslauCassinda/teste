import 'package:oku_sanga_erp/aplicativo/vista/contratos/autenticar_sistema_cu_i.dart';
import 'contratos/provedor_autenticacao_sistema_i.dart';

class AutenticarSistemaCU implements AutenticarSistemaCUI {
  ProvedorAutenticacaoSistemaI fonteAutenticacaoSistemaI;

  AutenticarSistemaCU(this.fonteAutenticacaoSistemaI);

  @override
  Future<void> iniciarAutenticacao(
      {required Function? accaoNaDevolucaoDadoRequisitado(
          dynamic dadoRequisitado)}) async {
    await fonteAutenticacaoSistemaI.iniciarAutenticacao(
        accaoNaDevolucaoDadoRequisitado: accaoNaDevolucaoDadoRequisitado);
  }
}
