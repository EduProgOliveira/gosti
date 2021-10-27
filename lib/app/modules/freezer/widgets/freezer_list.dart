import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/modules/freezer/models/freezer.dart';
import 'package:gosti_mobile/app/modules/freezer/widgets/freezer_list_item.dart';
import 'package:gosti_mobile/app/modules/freezer_pages/freezer_pages_controller.dart';

class FreezerList extends StatelessWidget {
  FreezerList({Key? key}) : super(key: key);

  List<Freezer> listFreezer = [
    Freezer(
      id: 0,
      nome: 'Totalitté',
      cidade: 'São José do Rio Preto- SP',
      distancia: 0.1,
      endereco: 'Av. Romeu Strazzi, 325',
      bairro: 'Sinildi',
      cep: '15.085-350',
    ),
    Freezer(
      id: 0,
      nome: 'Shopping Iguatemi SP',
      cidade: 'São José do Rio Preto- SP',
      distancia: 0.1,
      endereco: 'Av. Romeu Strazzi, 325',
      bairro: 'Sinildi',
      cep: '15.085-350',
    ),
    Freezer(
      id: 0,
      nome: 'Totalitté',
      cidade: 'São José do Rio Preto- SP',
      distancia: 0.1,
      endereco: 'Av. Romeu Strazzi, 325',
      bairro: 'Sinildi',
      cep: '15.085-350',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: listFreezer
            .map((freezer) => freezerItem(freezer: freezer))
            .toList(),
      ),
    );
  }
}

Widget freezerItem({required Freezer freezer}) {
  FreezerPagesController pages = Get.find<FreezerPagesController>();
  return GestureDetector(
    onTap: () {
      pages.pageController.jumpToPage(1);
    },
    child: FreezerListItem(
      freezer: freezer,
    ),
  );
}
