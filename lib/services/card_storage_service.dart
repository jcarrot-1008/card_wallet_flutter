import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/card_model.dart';

class CardStorageService {

  static const String cardKey = 'saved_cards';


  // 카드 저장
  static Future<void> saveCards(List<CardModel> cards) async {

    final prefs = await SharedPreferences.getInstance();


    final List<String> cardList = cards.map((card) {

      return jsonEncode({

        'name': card.name,
        'company': card.company,
        'number': card.number,
        'expiry': card.expiry,

      });

    }).toList();


    await prefs.setStringList(
      cardKey,
      cardList,
    );
  }



  // 카드 불러오기
  static Future<List<CardModel>> loadCards() async {

    final prefs = await SharedPreferences.getInstance();


    final List<String>? savedCards =
    prefs.getStringList(cardKey);


    if (savedCards == null) {
      return [];
    }


    return savedCards.map((card) {

      final data = jsonDecode(card);


      return CardModel(

        name: data['name'],
        company: data['company'],
        number: data['number'],
        expiry: data['expiry'],

      );

    }).toList();

  }

}