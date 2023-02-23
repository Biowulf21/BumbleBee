import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/core/models/property.dart';
import 'package:bumblebee/core/repositories/firestore_repository.dart';
import 'package:bumblebee/core/wrappers/firebase_singleton.dart';
import 'package:dartz/dartz.dart';

abstract class ICreatePropertyUseCase {
  Future<Either<Failure, Property>> createProperty(
      {required String name,
      required PropertyType type,
      Map<String, dynamic>? kwargs});
}

class CreatePropertyUseCase implements ICreatePropertyUseCase {
  @override
  Future<Either<Failure, Property>> createProperty(
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
      amenities}) async {
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
        amenities: amenities);

    final String uid = FirebaseSingleton().getAuth.currentUser!.uid;

    final result = await FirestoreRepository(FirebaseSingleton().getFirestore)
        .addDocument(
            collectionID: 'users/$uid/properties',
            successMessage: 'Successfully created new property named $name',
            dataMap: property.toJson(property));
  }
}
