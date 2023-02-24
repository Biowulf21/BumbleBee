import 'dart:io';

import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/core/repositories/firestore_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class IGetAllPropertiesUseCase {
  Future<Either<Failure, List<Property>>> getAllPropertiesByID({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  });
}

class GetAllPropertiesUseCase implements IGetAllPropertiesUseCase {
  @override
  Future<Either<Failure, List<Property>>> getAllPropertiesByID({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  }) async {
    try {
      if (auth.currentUser == null) {
        return const Left(Failure(
            message: 'No user currently logged in. Cannot get properties.'));
      }

      final userID = auth.currentUser!.uid;
      final result = await FirestoreRepository(firestore).ge
      
      
      // firestore
      //     .collection('properties')
      //     .where('ownerID', isEqualTo: userID)
      //     .get();

      
    } on FirebaseException catch (e) {
      return Left(Failure(message: e.message!));
    } on SocketException catch (e) {
      return Left(Failure(message: e.message));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
