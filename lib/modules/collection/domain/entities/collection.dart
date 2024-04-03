class Collection {
  final String id;
  final String userId;
  final String name;
  final String description;
  final num amount;
  final String imageUrl;
  final List<String> paymentMethods;
  final DateTime updatedAt;

  Collection(
      {required this.id,
      required this.userId,
      required this.name,
      required this.description,
      required this.amount,
      required this.imageUrl,
      required this.paymentMethods,
      required this.updatedAt});
}
