import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

void fecharDialogoCasoAberto() {
  var teste = Get.isDialogOpen;
  bool avaliacao = teste == null ? false : Get.isDialogOpen!;
  if (avaliacao == true) {
    Get.back();
  }
}

mostrarToast(String sms) {
  Fluttertoast.showToast(msg: sms);
}
