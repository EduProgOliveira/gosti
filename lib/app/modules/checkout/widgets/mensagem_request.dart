import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/modules/checkout/checkout_controller.dart';
import 'package:gosti_mobile/app_msg_mp.dart';
import 'package:gosti_mobile/app_pages.dart';

class MensagemRequest {
  static Future<String> mensagemRequest(CheckoutController controller) async {
    Get.defaultDialog(
      onWillPop: () async {
        return Future.value(false);
      },
      barrierDismissible: false,
      title: controller.status.value == StatusCheck.success
          ? 'Pagamento Aprovado'
          : 'Erro no Pagamento',
      content: controller.status.value == StatusCheck.fail
          ? Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(AppMsgMP.currentStatus[0] + '\n'),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(AppMsgMP.currentStatus[1] +
                      '\n' +
                      AppMsgMP.currentStatus[2] +
                      '\n\n\n'),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(AppMsgMP.currentStatus[3] +
                      '  ' +
                      AppMsgMP.currentStatus[4] +
                      '(AmbTST)'),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async {
                      Get.offNamedUntil(AppPages.HOME, (route) => false);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      elevation: 2,
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: [
                Center(
                  child: TextButton(
                    onPressed: () async {
                      Get.offNamedUntil(AppPages.HOME, (route) => false);
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: TextButton.styleFrom(
                      elevation: 2,
                      backgroundColor: AppColors.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
    );
    return '';
  }

  static listMensagem(CheckoutController controller) {
    String msg = '';
    if (controller.status.value == StatusCheck.success) {
      return 'Suceso';
    }
    if (controller.status.value == StatusCheck.fail) {
      return 'Erro';
    }

    for (var i = 0; i < AppMsgMP.currentStatus.length; i++) {
      msg += AppMsgMP.currentStatus[i] + '\n';
    }

    return msg;
  }
}
