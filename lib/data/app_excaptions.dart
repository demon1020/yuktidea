class AppException implements Exception {
  final int statusCode;
  final String message;

  AppException(this.statusCode, this.message);
}

class SessionExpiry extends AppException implements Exception {
  SessionExpiry({int? statusCode, String? message})
      : super(statusCode!, message = "Session Logged Out");
}

class AccessTokenExpiry extends AppException implements Exception {
  AccessTokenExpiry({int? statusCode, String? message})
      : super(statusCode!, message!);
}

class ServerValidation extends AppException {
  ServerValidation({int? statusCode, String? message})
      : super(statusCode!, message!);
}

class UserResigned extends AppException {
  UserResigned({int? statusCode, String? message})
      : super(statusCode!, message!);
}

class AppVersionUpdate extends AppException {
  AppVersionUpdate({int? statusCode, String? message})
      : super(statusCode!, message!);
}

class ServerError extends AppException {
  ServerError({int? statusCode, String? message})
      : super(statusCode!, message!);
}

class ForbiddenError extends AppException {
  ForbiddenError({int? statusCode, String? message})
      : super(statusCode = 401, message = "The access is forbidden.");
}

class TokenAuthenticationError extends AppException {
  TokenAuthenticationError({int? statusCode, String? message})
      : super(statusCode = 0,
            message = "Could not authenticate token. Please Retry");
}

class HandshakeError extends AppException {
  HandshakeError({int? statusCode, String? message})
      : super(statusCode = 525,
            message = "Unable to establish a secure connection.");
}

class UnAuthorizedError extends AppException {
  UnAuthorizedError({int? statusCode, String? message})
      : super(statusCode = 403, message = "The access is not authorized.");
}

class TimeoutError extends AppException {
  TimeoutError({int? statusCode, String? message})
      : super(statusCode = 0, message = "Request time out.");
}

class UnknownError extends AppException {
  UnknownError({int? statusCode, String? message})
      : super(statusCode = 0,
            message = "Something went wrong! Please try again.");
}

class InvalidResponse extends AppException {
  InvalidResponse({int? statusCode, String? message})
      : super(statusCode = 502, message = "Invalid Response.");
}

class NoInternetError extends AppException {
  NoInternetError({int? statusCode, String? message})
      : super(statusCode = 0, message = "Please check internet connection");
}
