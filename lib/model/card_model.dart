import 'dart:convert';

List<Cards> cardFromJson(String str) =>
    List<Cards>.from(json.decode(str).map((x) => Cards.fromJson(x)));

class Cards {
  int id;
  int row;
  int seq;
  String text;

  Cards({this.id, this.row, this.seq, this.text});

  factory Cards.fromJson(Map<String, dynamic> json) => Cards(
        id: json["id"],
        row: json["row"],
        seq: json["seq_num"],
        text: json["text"],
      );
}
