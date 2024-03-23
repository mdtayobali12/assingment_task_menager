class ResponseObject {
  bool isSuccess;
  final int statusCode;
  final dynamic responseBody;
  final String? errorMassage;

  ResponseObject({
    required this.isSuccess,
    required this.statusCode,
    required this.responseBody,
    this.errorMassage = "",
  });
}
