import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/core/repositories/firestore_repository.dart';
import 'package:bumblebee/core/repositories/user-repository.dart';
import 'package:bumblebee/core/wrappers/firebase_singleton.dart';
import 'package:bumblebee/feature/authentication/data/models/user.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class ICreatePropertyUseCase {
  Future<Either<Failure, String>> createProperty(
      {required String name,
      required PropertyType type,
      required String address,
      required UserRepository auth,
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
      required UserRepository auth,
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
      final String uid = FirebaseSingleton().getAuth.currentUser!.uid;

      final userDoc = await auth.getUserInfo(userID: uid);

      return userDoc.fold(
        (failure) => Left(Failure(message: failure.message)),
        (user) async {
          if (user!.role == userRoles.Tenant) {
            return const Left(Failure(
              message:
                  "User is not a landlord. Cannot create a new property with tenant credentials.",
            ));
          }

          Property property = Property(
            name: name,
            type: type,
            address: address,
            hasAdvance: hasAdvance,
            rating: rating,
            numberOfMonthsAdvance: numberOfMonthsAdvance,
            ownerID: FirebaseSingleton().getAuth.currentUser!.uid,
            costPerMonthsAdvance: costPerMonthsAdvance,
            hasDeposit: hasDeposit,
            depositPrice: depositPrice,
            isFullyFurnished: isFullyFurnished,
            amenities: amenities,
          );

          final result =
              await FirestoreRepository(FirebaseSingleton().getFirestore)
                  .addDocument(
            collectionID: 'users/$uid/properties',
            successMessage: 'Successfully created new property named $name',
            dataMap: property.toJson(property),
          );

          return result.fold(
            (failure) => Left(Failure(message: failure.message)),
            (SuccessMessage) => Right(SuccessMessage),
          );
        },
      );
    } on FirebaseException catch (e) {
      return Left(Failure(message: e.message!));
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
