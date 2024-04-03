import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:gawa/core/error/errors.dart';
import 'package:gawa/core/error/exceptions.dart';
import 'package:gawa/modules/collection/data/models/collection_model.dart';
import 'package:gawa/modules/collection/domain/entities/collection.dart';
import 'package:uuid/uuid.dart';
import '../../domain/repositories/blog_repository.dart';
import '../datasources/collection_remote_data.dart';

class CollectionRepoImpl implements CollectionRepository {
  final CollectionRemoteDataSource collectionRemoteDataSource;
  CollectionRepoImpl(this.collectionRemoteDataSource);

  @override
  Future<Either<Failure, Collection>> uploadCollection(
      {required String userId,
      required String name,
      required String description,
      required num amount,
      required List<String> paymentMethods,
      required File image}) async {
    try {
      CollectionModel collection = CollectionModel(
          id: const Uuid().v1(),
          userId: userId,
          name: name,
          description: description,
          amount: amount,
          paymentMethods: paymentMethods,
          imageUrl: '',
          updatedAt: DateTime.now());

      final imageUrl = await collectionRemoteDataSource.uploadCollectionImage(
          image: image, collection: collection);

      collection = collection.copyWith(imageUrl: imageUrl);

      final result =
          await collectionRemoteDataSource.uploadCollection(collection);
      return right(result);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }
}
