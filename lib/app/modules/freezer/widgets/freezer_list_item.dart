import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/modules/freezer/models/freezer.dart';

class FreezerListItem extends StatelessWidget {
  const FreezerListItem({Key? key, required this.freezer}) : super(key: key);
  final Freezer freezer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.grey,
          ),
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                freezer.nome!,
                style: AppTextStyles.bodyBold.copyWith(fontSize: 12),
              ),
              Text(
                freezer.cidade!,
                style: AppTextStyles.body,
              ),
              Text(
                '${freezer.distancia!} Km',
                style: AppTextStyles.bodyBold.copyWith(fontSize: 12),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                '${freezer.endereco!} -',
                style: AppTextStyles.body,
              ),
              Text(
                '${freezer.bairro!} - ',
                style: AppTextStyles.body,
              ),
              Text(
                freezer.cep!,
                style: AppTextStyles.body,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
