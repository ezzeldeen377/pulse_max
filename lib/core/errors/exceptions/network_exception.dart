// ignore_for_file: public_member_api_docs, sort_constructors_first
class NetworkException implements Exception {
  final String error;
  NetworkException({
    required this.error,
  });
}
