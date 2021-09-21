import 'package:flutter/material.dart';
import 'package:oku_sanga_erp/recursos/contantes.dart';

class ItemDaGaveta extends StatelessWidget {
  IconData? icone;
  String? titulo;
  Function? metodoQuandoItemClicado;
  ItemDaGaveta({
    this.metodoQuandoItemClicado,
    this.icone,
    this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: COR_ACCENT.withOpacity(.5),
      padding: EdgeInsets.all(20),
      onPressed: () {
        metodoQuandoItemClicado!();
      },
      child: Row(
        children: [
          SizedBox(
            width: 20,
          ),
          Icon(icone),
          SizedBox(
            width: 20,
          ),
          Text("$titulo"),
          SizedBox(
            width: 20,
          )
        ],
      ),
    );
  }
}
