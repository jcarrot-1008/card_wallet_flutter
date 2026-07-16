import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/card_model.dart';

class AddCardScreen extends StatefulWidget {
  const AddCardScreen({super.key});

  @override
  State<AddCardScreen> createState() => _AddCardScreenState();
}

class _AddCardScreenState extends State<AddCardScreen> {

  final nameController = TextEditingController();
  final companyController = TextEditingController();
  final numberController = TextEditingController();
  final expiryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카드 추가'),
        centerTitle: true,
      ),

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [

            TextField(
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: '카드 이름',
                hintText: '예: 삼성 iD 카드',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.credit_card),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: companyController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: '카드사',
                hintText: '예: 삼성카드',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.business),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: numberController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                CardNumberFormatter(),
              ],
              decoration: InputDecoration(
                labelText: '카드 번호',
                hintText: '0000-0000-0000-0000',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.numbers),
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: expiryController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '유효기간',
                hintText: 'MM/YY',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.date_range),
              ),
            ),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {

                  final newCard = CardModel(
                    name: nameController.text,
                    company: companyController.text,
                    number: numberController.text,
                    expiry: expiryController.text,
                  );

                  Navigator.pop(
                    context,
                    newCard,
                  );
                },
                child: const Text(
                  '저장하기',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class CardNumberFormatter extends TextInputFormatter {

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {

    String text = newValue.text.replaceAll('-', '');

    if (text.length > 16) {
      text = text.substring(0, 16);
    }

    String formatted = '';

    for (int i = 0; i < text.length; i++) {

      if (i > 0 && i % 4 == 0) {
        formatted += '-';
      }

      formatted += text[i];
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}