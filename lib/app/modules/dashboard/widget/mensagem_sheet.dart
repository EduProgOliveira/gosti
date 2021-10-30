import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';

class MensagemSheet {
  static Future<bool> productBack() async {
    bool back = false;
    await Get.bottomSheet(
      Container(
        height: 200,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Ao voltar para tela Inicial perderá os dados do carrinho pois precisará escolher novamente o Freezer.Deseja voltar?',
                style: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Row(
              children: [
                Center(
                  child: TextButton(
                    onPressed: () {
                      back = true;
                      Get.back();
                      return;
                    },
                    child: const Text(
                      'Sim',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      elevation: 2,
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Center(
                  child: TextButton(
                    onPressed: () {
                      back = false;
                      Get.back();
                      return;
                    },
                    child: const Text(
                      'Não',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      elevation: 2,
                      backgroundColor: AppColors.buttonCupom,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
    return back;
  }
}
