part of 'collections_bloc.dart';

@immutable
sealed class CollectionsState {}

final class CollectionsInitial extends CollectionsState {}

final class CollectionsLoading extends CollectionsState {}

final class CollectionsSuccess extends CollectionsState {}

final class CollectionsFaulure extends CollectionsState {
  final String message;
  CollectionsFaulure(this.message);
}
