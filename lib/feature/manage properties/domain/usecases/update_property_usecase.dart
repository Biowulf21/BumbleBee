import 'package:bumblebee/core/exceptions/failure.dart';
import 'package:bumblebee/core/models/property.dart';
import 'package:dartz/dartz.dart';

abstract class IUpdatePropertyUsecase {
  Future<Either<Failure, String>> updateProperty(
      {required String propertyID,
      Map<String, dynamic>? dataMap,
      Property? propertyObj});
}

class UpdatePropertyUsecase implements IUpdatePropertyUsecase {
  @override
  Future<Either<Failure, String>> updateProperty(
      {required String propertyID,
      Map<String, dynamic>? dataMap,
      Property? propertyObj}) async {
    if (dataMap == null && propertyObj == null) {
      return const Left(
          Failure(message: 'Cannot update property. No data provided.'));
    }
  }
}
