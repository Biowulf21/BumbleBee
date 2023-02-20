import 'package:equatable/equatable.dart';

// enum FailureCodes { NoInternet }

class Failure extends Equatable {
  final String message;

  const Failure({
    required this.message,
  });

  @override
  String toString() => message;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
