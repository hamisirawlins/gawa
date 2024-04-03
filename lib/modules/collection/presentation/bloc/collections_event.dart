part of 'collections_bloc.dart';

@immutable
sealed class CollectionsEvent {}

final class CollectionUpload extends CollectionsEvent {
  final String userId;
  final String name;
  final String description;
  final num amount;
  final List<String> paymentMethods;
  final File image;

  CollectionUpload(
      {required this.userId,
      required this.name,
      required this.description,
      required this.amount,
      required this.paymentMethods,
      required this.image});
}
