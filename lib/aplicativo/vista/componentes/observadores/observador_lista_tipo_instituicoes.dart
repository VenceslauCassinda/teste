import 'package:get/get.dart';

class ObservadorListaTipoInstituicoes extends GetxController {
  RxList? listaTipoInstituicoes;

  alterarLista(RxList? novaLista) {
    listaTipoInstituicoes = novaLista!;
  }
}
