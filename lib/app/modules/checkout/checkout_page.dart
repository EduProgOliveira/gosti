import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/core/common_widgets/button_default_payment.dart';
import 'package:gosti_mobile/app/core/utils/check_card.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/checkout/checkout_controller.dart';
import 'package:gosti_mobile/app/modules/checkout/widgets/app_bar_checkout.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';
import 'package:gosti_mobile/app/modules/verification_code/view/verification_code_page.dart';
import 'package:gosti_mobile/app_pages.dart';
import 'package:intl/intl.dart';

enum MethodPayment { credit, debit, pix }
enum TypePayment { card, pix }
List<String> ManyPayment = ['1x', '2x'];
List<String> TypeDoc = ['cpf', 'cnpj'];

class CheckoutPage extends StatefulWidget {
  CheckoutPage({Key? key}) : super(key: key);

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  FreezerController freezerController = Get.find<FreezerController>();

  CartController cartController = Get.find<CartController>();
  CheckoutController controller = Get.put(CheckoutController());

  String manyPayment = '1x';

  String typeDoc = 'cpf';

  String? card_band = '';

  TypePayment paymentType = TypePayment.card;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppBarCheckout(),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      freezerController.freezer().nome!,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      NumberFormat.currency(
                        name: 'TOTAL À PAGAR: R\$ ',
                        decimalDigits: 2,
                      ).format(cartController.total),
                      style: AppTextStyles.bodyBoldBlack.copyWith(fontSize: 18),
                    ),
                    const Divider(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Radio(
                          value: TypePayment.card,
                          groupValue: paymentType,
                          onChanged: (TypePayment? value) {},
                        ),
                        Text('Pague com cartões de cŕedito'),
                      ],
                    ),
                    const Text(
                      'Informe os dados do seu cartão',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: const [
                        Text('Número do cartão'),
                        Text(
                          ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    Container(
                      height: 35,
                      child: TextFormField(
                        controller: controller.cardNumber,
                        cursorHeight: 16,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        onChanged: (String text) {
                          if (text.length >= 6) {
                            card_band = CheckCard.card(text);
                            controller.cardBand = card_band!;
                            setState(() {});
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          suffixIcon: card_band!.isEmpty
                              ? const Icon(Icons.credit_card)
                              : Image.asset(
                                  'assets/logos/' + card_band! + '.png',
                                ),
                          suffixIconConstraints: const BoxConstraints(
                            maxWidth: 40,
                            maxHeight: 40,
                          ),
                        ),
                      ),
                    ),
                    Row(
                      children: const [
                        Text('Nome do titula como está no cartão'),
                        Text(
                          ' *',
                          style: TextStyle(color: Colors.red),
                        ),
                      ],
                    ),
                    Container(
                      height: 35,
                      child: TextFormField(
                        controller: controller.cardName,
                        cursorHeight: 16,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(),
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"[0-9]")),
                          UpperCaseTextFormatter(),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Text('Vencimento'),
                                  Text(
                                    ' *',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                              Container(
                                height: 30,
                                child: TextFormField(
                                  controller: controller.cardValid,
                                  cursorHeight: 16,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(),
                                  inputFormatters: [],
                                  onChanged: (String text) {
                                    if (text.length == 7) {}
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 2 - 20,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: const [
                                  Text('Código de segurança'),
                                  Text(
                                    ' *',
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ],
                              ),
                              Container(
                                height: 30,
                                child: TextFormField(
                                  controller: controller.cardCode,
                                  cursorHeight: 16,
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(),
                                  inputFormatters: [],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Útimos 3 digitos do verso',
                                style: TextStyle(
                                    fontSize: 10, color: Colors.grey[500]),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Text('Em quantas vezes quer pagar'),
                    Container(
                      width: double.infinity,
                      child: DropdownButton(
                        value: manyPayment,
                        isExpanded: true,
                        onChanged: (String? newValue) {
                          manyPayment = newValue!;
                        },
                        items: ManyPayment.map<DropdownMenuItem<String>>(
                            (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                    const Text(
                      'Informe seu número de documento',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Tipo'),
                            Container(
                              width: 100,
                              margin: EdgeInsets.only(bottom: 20),
                              child: DropdownButton(
                                value: typeDoc,
                                isExpanded: true,
                                onChanged: (String? newValue) {
                                  typeDoc = newValue!;
                                },
                                items: TypeDoc.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width / 2 + 30,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Text('Numero do documento'),
                                      Text(
                                        ' *',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 30,
                                    child: TextFormField(
                                      controller: controller.cardDocNumber,
                                      keyboardType: TextInputType.number,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Apenas Numeros',
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: Colors.grey[500]),
                                      ),
                                      Text(
                                        '* ',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.red),
                                      ),
                                      Text(
                                        'Campos obrigatórios',
                                        style: TextStyle(
                                            fontSize: 10, color: Colors.red),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Radio(
                          value: TypePayment.pix,
                          groupValue: paymentType,
                          onChanged: (TypePayment? value) {},
                        ),
                        Text('Pague com PIX'),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'Seus dados pessoais vão ser utilizados no processamento do seu pedido, não armazenamos dados financeiros,para mais detalhes veja nossa politica de privacidade.',
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Checkbox(value: true, onChanged: (value) {}),
                        Text('Li e concordo com o(s) termos e condições *')
                      ],
                    ),
                    Center(
                      child: ButtonDefaultPayment(
                        text: 'PAGAR PEDIDO',
                        onPressed: () async {
                          bool valid = false;
                          await Get.defaultDialog(
                            title: 'Validando Pagamento',
                            content: FutureBuilder<bool>(
                              future: controller.payment(),
                              builder: (context, snap) {
                                if (snap.hasData) {
                                  valid = snap.data!;
                                  Get.back();
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            ),
                          );
                          await Future.delayed(const Duration(seconds: 2));
                          valid
                              ? Get.toNamed(AppPages.HOME)
                              : Get.defaultDialog(
                                  title: 'Erro no pagamento',
                                  content: Center(
                                    child:
                                        Text('Verifique a forma de pagamento'),
                                  ),
                                );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
