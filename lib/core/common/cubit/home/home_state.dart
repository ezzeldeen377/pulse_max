// ignore_for_file: public_member_api_docs, sort_constructors_first
enum HomeScreenStatus { initial, loading, success, error }

extension HomeScreenStatusExtension on HomeScreenStatus {
  bool get isInitial => this == HomeScreenStatus.initial;
  bool get isLoading => this == HomeScreenStatus.loading;
  bool get isSuccess => this == HomeScreenStatus.success;
  bool get isError => this == HomeScreenStatus.error;
}

class HomeScreenState {
  final HomeScreenStatus status;
  final String? errorMessage;
  HomeScreenState({
    required this.status,
     this.errorMessage,
  });

  HomeScreenState copyWith({
    HomeScreenStatus? status,
    String? errorMessage,
  }) {
    return HomeScreenState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  String toString() => 'HomeScreenState(status: $status, errorMessage: $errorMessage)';
}
