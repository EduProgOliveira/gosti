import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:get/get.dart';
import 'package:gosti_mobile/app/core/app_colors.dart';
import 'package:gosti_mobile/app/core/app_text_styles.dart';
import 'package:gosti_mobile/app/core/common_widgets/button_default_payment.dart';
import 'package:gosti_mobile/app/core/utils/check_card.dart';
import 'package:gosti_mobile/app/modules/cart/cart_controller.dart';
import 'package:gosti_mobile/app/modules/checkout/checkout_controller.dart';
import 'package:gosti_mobile/app/modules/checkout/widgets/app_bar_checkout.dart';
import 'package:gosti_mobile/app/modules/checkout/widgets/mensagem_request.dart';
import 'package:gosti_mobile/app/modules/freezer/freezer_controller.dart';
import 'package:gosti_mobile/app/modules/verification_code/view/verification_code_page.dart';
import 'package:gosti_mobile/app_msg_mp.dart';
import 'package:gosti_mobile/app_pages.dart';
import 'package:intl/intl.dart';

enum MethodPayment { credit, debit, pix }
enum TypePayment { card, pix }
List<String> ManyPayment = ['1x', '2x'];
enum TypeDoc { CPF, CNPJ }
enum AmbTST { prod, test }

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

  TypeDoc typeDoc = TypeDoc.CPF;

  String? card_band = '';

  TypePayment paymentType = TypePayment.card;

  AmbTST amb = AmbTST.test;

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
                    Row(
                      children: [
                        Text(
                          NumberFormat.currency(
                            name: 'TOTAL ?? PAGAR: R\$ ',
                            decimalDigits: 2,
                          ).format(cartController.total),
                          style: AppTextStyles.bodyBoldBlack
                              .copyWith(fontSize: 16),
                        ),
                        SizedBox(
                          width: 18,
                        ),
                        Text('TSF'),
                        Container(
                          width: 20,
                          height: 20,
                          child: Radio(
                            value: AmbTST.test,
                            groupValue: amb,
                            onChanged: (val) {
                              amb = AmbTST.test;
                              setState(() {});
                            },
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('PRD'),
                        Container(
                          width: 20,
                          height: 20,
                          child: Radio(
                            value: AmbTST.prod,
                            groupValue: amb,
                            onChanged: (val) {
                              amb = AmbTST.prod;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
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
                        Text('Pague com cart??es'),
                      ],
                    ),
                    const Text(
                      'Informe os dados do seu cart??o',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                        fontSize: 14,
                      ),
                    ),
                    Row(
                      children: const [
                        Text('N??mero do cart??o'),
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
                        Text('Nome do titular como est?? no cart??o'),
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
                                  Text('Validade'),
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
                                  Text('C??digo de seguran??a'),
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
                                '??timos 3 digitos do verso',
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
                      'Informe seu n??mero de documento',
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
                              child: DropdownButton<TypeDoc>(
                                value: typeDoc,
                                isExpanded: true,
                                items: [],
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
                                      Row(
                                        children: const [
                                          Text(
                                            '* ',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.red),
                                          ),
                                          Text(
                                            'Campos obrigat??rios',
                                            style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.red),
                                          ),
                                        ],
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
                        'Seus dados pessoais v??o ser utilizados no processamento do seu pedido, n??o armazenamos dados financeiros,para mais detalhes veja nossa politica de privacidade.',
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
                        Text('Li e concordo com o(s) termos e condi????es *')
                      ],
                    ),
                    Center(
                      child: ButtonDefaultPayment(
                        text: 'PAGAR PEDIDO',
                        onPressed: () async {
                          bool valid = false;
                          controller.payment();
                          await Get.defaultDialog(
                            barrierDismissible: false,
                            title:
                                'Aguarde...processando o seu pagamento junto a operadora...',
                            content: CircularProgressIndicator(),
                          );
                          await Future.delayed(
                              const Duration(milliseconds: 500));
                          await MensagemRequest.mensagemRequest(controller);
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
