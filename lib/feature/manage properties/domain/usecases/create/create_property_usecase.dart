import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/core/repositories/firestore_repository.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ICreatePropertyUseCase {
  Future<Either<Failure, String>> createProperty(
      {required String name,
      required PropertyType type,
      required String address,
      required userRoles userRole,
      required FirebaseAuth auth,
      required FirebaseFirestore firestore,
      bool hasAdvance,
      double rating,
      int numberOfMonthsAdvance,
      String ownerID,
      double costPerMonthsAdvance,
      bool hasDeposit,
      double depositPrice,
      bool isFullyFurnished,
      List<Amenity> amenities});
}

class CreatePropertyUseCase implements ICreatePropertyUseCase {
  @override
  Future<Either<Failure, String>> createProperty(
      {required String name,
      required PropertyType type,
      required String address,
      required userRoles userRole,
      required FirebaseAuth auth,
      required FirebaseFirestore firestore,
      bool? hasAdvance,
      double? rating,
      int? numberOfMonthsAdvance,
      String? ownerID,
      double? costPerMonthsAdvance,
      bool? hasDeposit,
      double? depositPrice,
      bool? isFullyFurnished,
      List<Amenity>? amenities}) async {
    try {
      if (auth.currentUser == null) {
        return const Left(Failure(message: 'No current user present.'));
      }

      final String uid = auth.currentUser!.uid;

      if (userRole == userRoles.Tenant) {
        throw const Failure(
          message: 'permission_denied',
        );
      }

      Property property = Property(
        name: name,
        type: type,
        address: address,
        hasAdvance: hasAdvance,
        rating: rating,
        numberOfMonthsAdvance: numberOfMonthsAdvance,
        ownerID: auth.currentUser!.uid,
        costPerMonthsAdvance: costPerMonthsAdvance,
        hasDeposit: hasDeposit,
        depositPrice: depositPrice,
        isFullyFurnished: isFullyFurnished,
        amenities: amenities,
      );

      final result = await FirestoreRepository(firestore).addDocument(
        collectionID: 'properties',
        successMessage: 'Successfully created new property named $name',
        dataMap: property.toJson(property),
      );

      return result.fold(
        (failure) => Left(Failure(message: failure.message)),
        (SuccessMessage) => Right(SuccessMessage),
      );
    } on FirebaseException catch (e) {
      return Left(Failure(message: e.message!));
    } on Failure catch (e) {
      if (e.message == 'permission_denied') {
        return const Left(Failure(
            message:
                "User is not a landlord. Cannot create a new property with tenant credentials."));
      } else {
        return const Left(Failure(message: 'Something went wrong.'));
      }
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
