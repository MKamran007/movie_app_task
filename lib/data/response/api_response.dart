import 'package:movie_app_task/data/response/status.dart';

class ApiResponse<T>{

  Status? status;
  T? data;
  String? messages;

  ApiResponse([this.status, this.data, this.messages]);

  ApiResponse.loading() : status = Status.LOADING;
  ApiResponse.complete(this.data) : status = Status.COMPLETE;
  ApiResponse.error(this.messages) : status = Status.ERROR;

  @override
  String toString() {
    return "Status: $status \n Message: $messages \n Data: $data";
  }

}