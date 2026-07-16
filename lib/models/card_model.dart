class CardModel {
  final String name;      // 카드 이름
  final String company;   // 카드사
  final String number;    // 카드 번호
  final String expiry;    // 유효기간

  CardModel({
    required this.name,
    required this.company,
    required this.number,
    required this.expiry,
  });
}