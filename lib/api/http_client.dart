import 'package:gophermart/const/const.dart';
import 'package:gophermart/utils/preferences.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class BaseNetworkException implements Exception {
  String? method;
  String? url;

  BaseNetworkException([this.method, this.url]);
}

class NetworkExceptionTimeout extends BaseNetworkException {
  NetworkExceptionTimeout([method, url]) : super(method, url);
}

class NetworkExceptionNotFound extends BaseNetworkException {
  NetworkExceptionNotFound([method, url]) : super(method, url);
}

Future<Response> apiHttpGet(String url) async {
  return httpGetBase(ApiConstants.transportApiEndpoint, url);
}

Future<Response> apiHttpPost(String url, dynamic data) async {
  return httpPostBase(ApiConstants.transportApiEndpoint, url, data);
}

Future<Response> apiHttpPostOrdernumber(String url, dynamic data) async {
  return httpRegisterNumberBase(ApiConstants.transportApiEndpoint, url, data);
}

Future<Response> apiHttpPostWithdraw(String url, dynamic data) async {
  return httpRegisterNumberBase(ApiConstants.transportApiEndpoint, url, data);
}

Future<Response> httpGetBase(String baseUri, String url) async {
  final token = await Preferences.getToken();
  final response = await http
      .get(Uri.parse(baseUri + url), headers: <String, String>{
    'Authorization': token,
  }).timeout(const Duration(seconds: ApiConstants.apiRequestTimeout),
          onTimeout: () {
    // Time has run out, do what you wanted to do.
    throw NetworkExceptionTimeout('get', url);
  });

  return response;
}

Future<Response> httpPostBase(String baseUri, String url, dynamic data) async {
  final response = await http
      .post(Uri.parse(baseUri + url), body: data, headers: <String, String>{
    'Content-Type': 'application/json',
    'Authorization': await Preferences.getToken(),
  }).timeout(const Duration(seconds: ApiConstants.apiRequestTimeout),
          onTimeout: () {
    // Time has run out, do what you wanted to do.
    throw NetworkExceptionTimeout('post', url);
  });

  return response;
}

Future<Response> httpAuthBase(String baseUri, String url, dynamic data) async {
  final response = await http
      .post(Uri.parse(baseUri + url), body: data, headers: <String, String>{
    'Content-Type': 'application/json',
    //   'Authorization': await Preferences.getTokenl(),
  }).timeout(const Duration(seconds: ApiConstants.apiRequestTimeout),
          onTimeout: () {
    // Time has run out, do what you wanted to do.
    throw NetworkExceptionTimeout('post', url);
  });

  return response;
}

Future<Response> httpRegisterNumberBase(
    String baseUri, String url, dynamic data) async {
  final response = await http
      .post(Uri.parse(baseUri + url), body: data, headers: <String, String>{
    'Content-Type': 'text/plain',
    'Authorization': await Preferences.getToken(),
    'Accept-Encoding': '7z'
  }).timeout(const Duration(seconds: ApiConstants.apiRequestTimeout),
          onTimeout: () {
    // Time has run out, do what you wanted to do.
    throw NetworkExceptionTimeout('post', url);
  });

  return response;
}

Future<Response> httpWithdrawBase(
    String baseUri, String url, dynamic data) async {
  final response = await http
      .post(Uri.parse(baseUri + url), body: data, headers: <String, String>{
    'Content-Type': 'application/json',
    'Authorization': await Preferences.getToken(),
    'Accept-Encoding': '7z'
  }).timeout(const Duration(seconds: ApiConstants.apiRequestTimeout),
          onTimeout: () {
    // Time has run out, do what you wanted to do.
    throw NetworkExceptionTimeout('post', url);
  });
  return response;
}
