import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/upload_collection.dart';

part 'collections_event.dart';
part 'collections_state.dart';

class CollectionsBloc extends Bloc<CollectionsEvent, CollectionsState> {
  final UploadCollection uploadCollection;
  CollectionsBloc(this.uploadCollection) : super(CollectionsInitial()) {
    on<CollectionsEvent>((event, emit) => emit(CollectionsLoading()));
    on<CollectionUpload>(_onCollectionUpload);
  }

  void _onCollectionUpload(
      CollectionUpload event, Emitter<CollectionsState> emit) async {
    final res = await uploadCollection(uploadCollectionParams(
        userId: event.userId,
        name: event.name,
        description: event.description,
        amount: event.amount,
        paymentMethods: event.paymentMethods,
        image: event.image));
    res.fold((l) => emit(CollectionsFaulure(l.message)), (r) => emit(CollectionsSuccess()));
  }
}
