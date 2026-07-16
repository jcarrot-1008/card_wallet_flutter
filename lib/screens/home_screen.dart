import 'package:flutter/material.dart';
import '../models/card_model.dart';
import '../services/card_storage_service.dart';
import 'add_card_screen.dart';
import 'card_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CardModel> cards = [];

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  // 저장된 카드 불러오기
  Future<void> loadCards() async {
    final savedCards = await CardStorageService.loadCards();

    setState(() {
      cards = savedCards;
    });
  }

  // 카드 추가
  void addCard() async {
    final newCard = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddCardScreen(),
      ),
    );

    if (newCard != null) {
      setState(() {
        cards.add(newCard);
      });

      await CardStorageService.saveCards(cards);
    }
  }

  // 카드번호 마스킹
  String maskCardNumber(String number) {
    String cleanNumber = number.replaceAll('-', '');

    if (cleanNumber.length < 4) {
      return number;
    }

    String lastFour = cleanNumber.substring(cleanNumber.length - 4);

    return '****-****-****-$lastFour';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Wallet'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '내 카드',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: cards.isEmpty
                  ? const Center(
                child: Text(
                  '등록된 카드가 없습니다.',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              )
                  : ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) {
                  final card = cards[index];

                  return Card(
                    child: ListTile(
                      onTap: () async {
                        final result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CardDetailScreen(card: card),
                          ),
                        );

                        if (result == true) {
                          setState(() {
                            cards.removeAt(index);
                          });

                          await CardStorageService.saveCards(cards);
                        }
                      },

                      leading: const Icon(
                        Icons.credit_card,
                        size: 40,
                      ),

                      title: Text(
                        card.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      subtitle: Text(
                        '${card.company}\n${maskCardNumber(card.number)}',
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                onPressed: addCard,
                icon: const Icon(Icons.add),
                label: const Text(
                  '카드 추가',
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