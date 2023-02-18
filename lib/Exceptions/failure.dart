enum FailureCodes { NoInternet }

class Failure {
  final String message;
  final FailureCodes failureCode;

  Failure({required this.message, required this.failureCode});

  @override
  String toString() => message;
}
