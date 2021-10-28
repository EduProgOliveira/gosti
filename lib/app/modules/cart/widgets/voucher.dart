import 'package:flutter/material.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';

class Voucher extends StatelessWidget {
  const Voucher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                  'Cupom de desconto',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodyBoldBlack,
                ),
              ),
              const _VoucherInput(),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Desconto',
                ),
                SizedBox(
                  width: 20.0,
                ),
                Text(
                  "R\$ --.--",
                  style: AppTextStyles.priceFoodItemBold,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _VoucherInput extends StatelessWidget {
  const _VoucherInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Container(
        height: 50.0,
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.black),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.black),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: AppColors.black),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: ElevatedButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.buttonCupom,
                  ),
                  child: Text(
                    'OK',
                    style: AppTextStyles.bodyBoldWhite,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
