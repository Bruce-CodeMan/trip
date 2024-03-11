import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:trip/utils/navigator_util.dart';

import '../models/home_model.dart';
import '../utils/cache_util.dart';

// Home Data Access Object for home functionality.
class HomeDao{

  // Reads the environment variables and provides a default empty string if not found.
  static String homeApi = dotenv.get("HOME_API", fallback: "");
  static String authToken = dotenv.get("AUTH_TOKEN", fallback: "");
  static String token = dotenv.get("Token", fallback: "");

  static Future<HomeModel> fetch() async {
    var url = Uri.parse(homeApi);
    final response = await http.get(
      url,
      headers: {
        "auth-token": authToken,
        "course-flag": "ft",
        "boarding-pass": getToken() ?? "",
      }
    );

    // Decodes the response body from the UTF-8 format
    Utf8Decoder utf8 = const Utf8Decoder();
    String res = utf8.convert(response.bodyBytes);

    // Handles the response base on the statusCode.
    if(response.statusCode == 200) {
      var result = json.decode(res);
      return HomeModel.deserialization(result['data']);
    }else {
      if(response.statusCode == 401) {
        NavigatorUtil.goToLogin();
      }

      throw Exception(res);
    }
  }

  // Static method to get the auth_token from the cache.
  static getToken() {
    return Cache.getInstance().get<String>(token);
  }
}