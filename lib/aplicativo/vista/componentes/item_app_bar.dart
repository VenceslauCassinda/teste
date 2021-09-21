import 'package:flutter/material.dart';
import 'package:oku_sanga_erp/recursos/contantes.dart';

class ItemDaAppBar extends StatelessWidget {
  IconData? icone;
  Function? metodoQuandoItemClicado;
  ItemDaAppBar({
    this.metodoQuandoItemClicado,
    this.icone,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: COR_BRANCA.withOpacity(.5),
      onTap: () {
        metodoQuandoItemClicado!();
      },
      child: Icon(
        icone,
        color: COR_BRANCA,
      ),
    );
  }
}
