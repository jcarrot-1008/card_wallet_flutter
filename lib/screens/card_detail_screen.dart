import 'package:flutter/material.dart';
import '../models/card_model.dart';

class CardDetailScreen extends StatelessWidget {
  final CardModel card;

  const CardDetailScreen({
    super.key,
    required this.card,
  });

  Future<void> showDeleteDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('카드 삭제'),
          content: const Text('정말 삭제하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () {

                Navigator.pop(context); // 확인창 닫기

                Navigator.pop(context, true); // Home으로 true 전달

              },
              child: const Text('삭제'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('카드 상세'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.credit_card,
              size: 80,
              color: Colors.indigo,
            ),

            const SizedBox(height: 30),

            Text(
              card.name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    buildInfoRow('카드사', card.company),
                    const Divider(),
                    buildInfoRow('카드번호', card.number),
                    const Divider(),
                    buildInfoRow('유효기간', card.expiry),
                  ],
                ),
              ),
            ),

            const Spacer(),

            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text('수정'),
            ),

            const SizedBox(height: 10),

            ElevatedButton.icon(
              onPressed: () {
                showDeleteDialog(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.delete),
              label: const Text('삭제'),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value),
          ),
        ],
      ),
    );
  }
}