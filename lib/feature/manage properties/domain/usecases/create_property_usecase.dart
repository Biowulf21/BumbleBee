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
      {required name,
      required type,
      hasAdvance,
      rating,
      numberOfMonthsAdvance,
      id,
      costPerMonthsAdvance,
      hasDeposit,
      depositPrice,
      isFullyFurnished,
      amenities});
}

class CreatePropertyUseCase implements ICreatePropertyUseCase {
  @override
  Future<Either<Failure, String>> createProperty(
  {required name,
  required type,
  hasAdvance,
  rating,
  numberOfMonthsAdvance,
  id,
  costPerMonthsAdvance,
  hasDeposit,
  depositPrice,
  isFullyFurnished,
  amenities,
}) async {
  try {
    final String uid = FirebaseSingleton().getAuth.currentUser!.uid;

    final userDoc = await UserRepository(
      firestoreInstance: FirebaseSingleton().getFirestore,
      auth: FirebaseSingleton().getAuth,
    ).getUserInfo(userID: uid);

    return userDoc.fold(
      (failure) => Left(Failure(message: failure.message)),
      (user) async {
        if (user!.role == userRoles.Tenant) {
          return const Left(Failure(
            message: "User is not a landlord. Cannot create a new property with tenant credentials.",
          ));
        }
        Property property = Property(
          name: name,
          type: type,
          hasAdvance: hasAdvance,
          rating: rating,
          numberOfMonthsAdvance: numberOfMonthsAdvance,
          id: id,
          costPerMonthsAdvance: costPerMonthsAdvance,
          hasDeposit: hasDeposit,
          depositPrice: depositPrice,
          isFullyFurnished: isFullyFurnished,
          amenities: amenities,
        );

        final result = await FirestoreRepository(FirebaseSingleton().getFirestore).addDocument(
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
