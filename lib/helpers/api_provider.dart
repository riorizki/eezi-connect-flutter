import 'dart:convert';
import 'dart:io';

import 'package:eezi_connect/helpers/api_error.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  final baseUrl = 'http://54.169.252.1:90/api/v1/auth';
  // final baseUrl = 'http://13c888600a4f.ngrok.io/api/v1/auth';

  Future<dynamic> get(String url, {dynamic headers}) async {
    print('Api Get, url $url');
    var responseJson;

    try {
      var uri = baseUrl + url;
      final response = await http.get(uri, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }

    print('api get recieved!');
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic body, {dynamic headers}) async {
    print('Api Post, url $url');
    var responseJson;
    print(body);

    try {
      var uri = baseUrl + url;
      print(uri);
      final response = await http.post(uri, body: body, headers: headers);
      responseJson = _returnResponse(response);
    } on SocketException {
      print('No net');
      throw FetchDataException('No Internet connection');
    }
    print('api post.');
    return responseJson;
  }
  //
  // Future<dynamic> postWithData(String url,
  //     {String userId, String filePath, dynamic headers}) async {
  //   print('Api Post With Data, url $url');
  //   var responseJson;
  //   try {
  //     var uri = Uri.parse('$BaseUrlImage$url');
  //     var request = http.MultipartRequest('POST', uri)
  //       ..fields['userId'] = userId
  //       ..files.add(
  //         await http.MultipartFile.fromPath('file', filePath),
  //       );
  //     print(uri);
  //
  //     final responseStream = await request.send();
  //     final response = await http.Response.fromStream(responseStream);
  //
  //     responseJson = _returnResponse(response);
  //   } on SocketException {
  //     print('No net');
  //     throw FetchDataException('No Internet connection');
  //   }
  //   print('api Post With Data.');
  //   return responseJson;
  // }

  dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = response.body;
        print(responseJson);
        return responseJson;
      case 400:
        var responseJson = json.decode(response.body.toString());
        var message = responseJson['message'];
        throw BadRequestException(message.toString());
      case 401:
        var responseJson = json.decode(response.body.toString());
        var message = responseJson['message'];
        throw UnauthorisedException(message.toString());
      case 403:
        var responseJson = json.decode(response.body.toString());
        var message = responseJson['message'];
        throw UnauthorisedException(message.toString());
      case 500:
      default:
        var responseJson = response.body;
        print(responseJson);
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
