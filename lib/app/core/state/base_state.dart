abstract class BaseState {}

class InitialState implements BaseState {}

class LoadingState implements BaseState {}

class SuccessState<R> implements BaseState {
  const SuccessState({
    required this.data,
    this.message,
  });

  final R data;
  final String? message;
}

class ErrorState<T extends Exception> implements BaseState {
  ErrorState({
    required this.exception,
    this.message,
  });

  final T exception;
  final String? message;
}
