import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class Endpoints {
  static const String baseURL = "https://api.pokemontcg.io/v2/cards";

  static const String listURL = "$baseURL?page=1&pageSize=10";
  static const String searchURL = "$baseURL?q=set.name:";


  static Future<bool> hasConnectivity() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    bool hasNetwork = false;
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      // I am connected to a mobile network.
      hasNetwork = true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      // I am connected to a wifi network.
      hasNetwork = true;
    }

    return hasNetwork;
  }

  Dio doCertificateVerification() {
    Dio dio = Dio();
    (dio.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
      return client;
    };

    return dio;
  }

  static Map<String, dynamic> defaultResponse() {
    Map<String, dynamic> getAPIError = {"data": [], "page": 0, "pageSize": 0, "count": 0, "totalCount": 0};
    return getAPIError;
  }
}
