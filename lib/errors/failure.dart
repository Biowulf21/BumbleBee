class Failure {
  final String message;
  final int code;

  Failure({required this.message, required this.code});

  @override
  String toString() => message;
}
