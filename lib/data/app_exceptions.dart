class AppException implements Exception{
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  String toString(){
    return '$_message$_prefix';
  }
}

class InternetExceptions extends AppException{
  InternetExceptions([String? message]) : super(message, 'No internet');
}

class RequestTimeOutExceptions extends AppException{
  RequestTimeOutExceptions([String? message]) : super(message, 'Request time out');
}

class ServerExceptions extends AppException{
  ServerExceptions([String? message]) : super(message, 'Internal server error');
}

class InvalidUrlException extends AppException{
  InvalidUrlException([String? message]): super(message, 'Invalid url');
}

class FetchDataException extends AppException{
  FetchDataException([String? messages]): super(messages, "");
}