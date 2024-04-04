import 'package:gawa/modules/collection/domain/entities/collection.dart';

class CollectionModel extends Collection {
  CollectionModel(
      {required super.id,
      required super.userId,
      required super.name,
      required super.description,
      required super.amount,
      required super.imageUrl,
      required super.paymentMethods,
      required super.updatedAt});

  Map<String, dynamic> toJSON() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'name': name,
      'description': description,
      'amount': amount,
      'image_url': imageUrl,
      'payment_methods': paymentMethods,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory CollectionModel.fromJSON(Map<String, dynamic> map) {
    return CollectionModel(
      id: map['id'] as String,
      userId: map['user_id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      amount: map['amount'] as num,
      imageUrl: map['image_url'] as String,
      paymentMethods: List<String>.from((map['payment_methods'] ?? [])),
      updatedAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }

  CollectionModel copyWith({
    String? id,
    String? userId,
    String? name,
    String? description,
    num? amount,
    String? imageUrl,
    List<String>? paymentMethods,
    DateTime? updatedAt,
  }) {
    return CollectionModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      imageUrl: imageUrl ?? this.imageUrl,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      updatedAt: updatedAt ?? this.updatedAt
    );
  }
}
