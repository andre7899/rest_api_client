import 'package:rest_api_client/rest_api_client.dart';

class Result<T> {
  T? data;
  Exception? exception;
  bool get hasData =>
      (data is List && (data as List).isNotEmpty) ||
      (data is! List && data != null);
  bool get isSuccess => !isError;
  bool get isLocalSuccess => this is LocalSuccessResult;
  bool get isError => exception != null;
  bool get isLocalError => this is LocalErrorResult;
  bool get isConnectionError =>
      (exception is DioException) &&
      (exception as DioException).type == DioExceptionType.connectionError;
  int? statusCode;
  String? statusMessage;

  Result({
    this.data,
    this.exception,
    this.statusCode = 200,
    this.statusMessage = '',
  });

  factory Result.network({
    T? data,
    Exception? exception,
    int? statusCode,
    String? statusMessage,
  }) =>
      NetworkResult(
        data: data,
        exception: exception,
        statusCode: statusCode,
        statusMessage: statusMessage,
      );

  factory Result.cache({
    T? data,
    Exception? exception,
  }) =>
      CacheResult(
        data: data,
        exception: exception,
      );

  factory Result.success({
    T? data,
  }) =>
      SuccessResult(
        data: data,
      );

  factory Result.localSuccess({
    T? data,
  }) =>
      LocalSuccessResult(
        data: data,
      );

  factory Result.error({
    Exception? exception,
  }) =>
      ErrorResult(
        exception: exception,
      );

  factory Result.localError({
    Exception? exception,
  }) =>
      LocalErrorResult(
        exception: exception,
      );
}

class SuccessResult<T> extends Result<T> {
  SuccessResult({
    T? data,
  }) : super(
          data: data,
        );
}

class LocalSuccessResult<T> extends Result<T> {
  LocalSuccessResult({
    T? data,
  }) : super(
          data: data,
        );
}

class ErrorResult<T> extends Result<T> {
  ErrorResult({
    Exception? exception,
  }) : super(
          exception: exception,
        );
}

class LocalErrorResult<T> extends Result<T> {
  LocalErrorResult({
    Exception? exception,
  }) : super(
          exception: exception,
        );
}

class NetworkResult<T> extends Result<T> {
  NetworkResult({
    T? data,
    Exception? exception,
    int? statusCode,
    String? statusMessage,
  }) : super(
          data: data,
          exception: exception,
          statusCode: statusCode,
          statusMessage: statusMessage,
        );
}

class CacheResult<T> extends Result<T> {
  CacheResult({
    T? data,
    Exception? exception,
  }) : super(
          data: data,
          exception: exception,
        );
}
