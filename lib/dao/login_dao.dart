import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:trip/utils/cache_util.dart';

class LoginDao{

  // Reads the environment variable.
  static String hostName = dotenv.get("HOST_NAME", fallback: "");
  static String loginApi = dotenv.get("LOGIN_API", fallback: "");
  static String authToken = dotenv.get("AUTH_TOKEN", fallback: "");
  static String token = dotenv.get("Token", fallback: "");

  static login({required String username, required String password}) async {
    Map<String, String> paramsMap = {};
    paramsMap['userName'] = username;
    paramsMap['password'] = password;

    var uri = Uri.https(hostName, loginApi, paramsMap);
    final response = await http.post(
      uri,
      headers: {
        "auth-token": authToken,
        "course-flag": "ft",
        "boarding-pass": getToken() ?? "",
      }
    );

    Utf8Decoder utf8 = const Utf8Decoder();
    String res = utf8.convert(response.bodyBytes);
    if(response.statusCode == 200) {
      var result = json.decode(res);
      if(result['code'] == 0 && result['data'] != null) {
        // save the token
        _saveToken(result['data']);
      }else {
        throw Exception(res);
      }
    }else {
      throw Exception(res);
    }
  }

  // Saves the auth_token method.
  static void _saveToken(String value) {
    Cache.getInstance().setString(token, value);
  }

  // Gets the auth_token method.
  static getToken() {
    return Cache.getInstance().get<String>(token);
  }
}