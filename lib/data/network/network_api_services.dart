import 'dart:convert';
import 'dart:io';

import 'package:movie_app_task/data/app_exceptions.dart';
import 'package:movie_app_task/data/network/base_api_services.dart';
import 'package:http/http.dart' as http;

class NetworkApiServices extends BaseApiServices{
  @override
  Future getGetApiResponse(String url) async{
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException{
      throw InternetExceptions('No Internet Connection');
    }
    return responseJson;
  }

  @override
  Future getPostApiResponse(String url, data) async{
    dynamic responseJson;
    try{
      final response = await http.post(Uri.parse(url),
      body: jsonEncode(data)
      ).timeout(const Duration(seconds: 10));
      responseJson = returnResponse(response);
    }on SocketException{
      throw InternetExceptions('No Internet Connection');
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw InvalidUrlException(response.body.toString());
      default:
        throw FetchDataException('Error occurred with communicating with server' + 'with status code' + response.statusCode.toString());
    }
  }
  
}
