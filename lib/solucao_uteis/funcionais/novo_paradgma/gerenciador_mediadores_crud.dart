import 'package:oku_sanga_erp/solucao_uteis/funcionais/novo_paradgma/mediador_crud.dart';

class GerenciadorMediadoresCrud {
  List<MediadorCrudI> _listaMediadoresCrud = [];

  void adicionar(MediadorCrudI dado) {
    dado.indice = _listaMediadoresCrud.length;
    _listaMediadoresCrud.add(dado);
  }

  void remover(int indice) {
    _listaMediadoresCrud.remove(indice);
  }

  MediadorCrudI pegar(int indice) {
    return _listaMediadoresCrud[indice];
  }

  List<MediadorCrudI> pegarTodos(int indice) {
    return _listaMediadoresCrud;
  }
}
