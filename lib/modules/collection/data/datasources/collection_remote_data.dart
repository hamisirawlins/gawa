import 'dart:io';

import 'package:gawa/core/error/exceptions.dart';
import 'package:gawa/modules/collection/data/models/collection_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class CollectionRemoteDataSource {
  Future<CollectionModel> uploadCollection(CollectionModel collectionModel);
  Future<String> uploadCollectionImage(
      {required File image, required CollectionModel collection});
}

class CollectionRemoteDataSourceImpl implements CollectionRemoteDataSource {
  final SupabaseClient supabaseClient;
  CollectionRemoteDataSourceImpl(this.supabaseClient);

  @override
  Future<CollectionModel> uploadCollection(CollectionModel collection) async {
    try {
      final collectionData = await supabaseClient
          .from('collections')
          .insert(collection.toJSON())
          .select();
      return CollectionModel.fromJSON(collectionData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadCollectionImage(
      {required File image, required CollectionModel collection}) async {
    try {
      await supabaseClient.storage
          .from('collection_images')
          .upload(collection.id, image);

      return supabaseClient.storage
          .from('collection_images')
          .getPublicUrl(collection.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
