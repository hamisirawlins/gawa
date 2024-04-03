import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:gawa/core/error/errors.dart';
import 'package:gawa/core/usecase/usecase.dart';
import 'package:gawa/modules/collection/domain/entities/collection.dart';
import 'package:gawa/modules/collection/domain/repositories/blog_repository.dart';

class UploadCollection implements UseCase<Collection, uploadCollectionParams> {
  final CollectionRepository collectionRepository;
  UploadCollection(this.collectionRepository);
  @override
  Future<Either<Failure, Collection>> call(
      uploadCollectionParams params) async {
    return await collectionRepository.uploadCollection(
        userId: params.userId,
        name: params.name,
        description: params.description,
        amount: params.amount,
        paymentMethods: params.paymentMethods,
        image: params.image);
  }
}

class uploadCollectionParams {
  final String userId;
  final String name;
  final String description;
  final num amount;
  final List<String> paymentMethods;
  final File image;

  uploadCollectionParams(
      {required this.userId,
      required this.name,
      required this.description,
      required this.amount,
      required this.paymentMethods,
      required this.image});
}
