import 'dart:io';
import 'package:fpdart/fpdart.dart';
import 'package:gawa/core/error/errors.dart';
import 'package:gawa/modules/collection/domain/entities/collection.dart';

abstract interface class CollectionRepository {
  Future<Either<Failure, Collection>> uploadCollection({
    required String userId,
    required String name,
    required String description,
    required num amount,
    required List<String> paymentMethods,
    required File image,
  });
}
