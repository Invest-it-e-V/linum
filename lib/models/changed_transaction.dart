import 'package:cloud_firestore/cloud_firestore.dart';


// TODO: Make final
class ChangedTransaction {
  num? amount;
  String? category;
  String? currency;
  String? name;
  String? note;
  Timestamp? time;
  bool? deleted;

  ChangedTransaction({
    this.amount,
    this.category,
    this.currency,
    this.name,
    this.note,
    this.time,
    this.deleted,
  });

  factory ChangedTransaction.fromMap(Map<String, dynamic> map) {
    return ChangedTransaction(
      amount: map['amount'] as num?,
      category: map['category'] as String?,
      currency: map['currency'] as String?,
      name: map['name'] as String?,
      note: map['note'] as String?,
      time: map['time'] as Timestamp?,
      deleted: map['deleted'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'category': category,
      'currency': currency,
      'name': name,
      'note': note,
      'time': time,
      'deleted': deleted,
    };
  }
}
