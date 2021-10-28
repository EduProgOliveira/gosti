import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';

class Amount extends StatelessWidget {
  final String text;
  final String total;

  const Amount({
    Key? key,
    required this.text,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Divider(
            color: AppColors.lighterGrey,
            height: 10,
            thickness: 6,
            indent: 0,
            endIndent: 0,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  width: 24.0,
                ),
                Text(
                  total,
                  style: AppTextStyles.priceFoodItemBold,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
