import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/core/repositories/firestore_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class IUpdatePropertyUsecase {
  Future<Either<Failure, String>> updateProperty({
    required String propertyID,
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
    Map<String, dynamic>? dataMap,
    Property? propertyObj,
  });
}

class UpdatePropertyUsecase implements IUpdatePropertyUsecase {
  @override
  Future<Either<Failure, String>> updateProperty(
      {required String propertyID,
      required FirebaseAuth auth,
      required FirebaseFirestore firestore,
      Map<String, dynamic>? dataMap,
      Property? propertyObj}) async {
    if (auth.currentUser == null) {
      return const Left(Failure(
          message: 'No user is logged in. Cannot create a new property.'));
    }

    if (dataMap == null && propertyObj == null) {
      return const Left(
          Failure(message: 'Cannot update property. No data provided.'));
    }

    final result = await FirestoreRepository(firestore).updateDocument(
        collectionID: 'Properties/$propertyID',
        successMessage: "Successfully updated property.",
        dataMap: dataMap ?? propertyObj!.toJson(propertyObj),
        documentName: propertyID);

    return result.fold((failure) {
      return Left(failure);
    }, (successMessage) {
      return Right(successMessage);
    });
  }
}
