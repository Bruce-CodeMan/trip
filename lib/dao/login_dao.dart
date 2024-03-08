import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:trip/utils/cache_util.dart';
import 'package:trip/utils/navigator_util.dart';

// Login Data Access Object for handling login functionality
class LoginDao{

  // Reads the environment variables and provides a default empty string if not found.
  static String hostName = dotenv.get("HOST_NAME", fallback: "");
  static String loginApi = dotenv.get("LOGIN_API", fallback: "");
  static String authToken = dotenv.get("AUTH_TOKEN", fallback: "");
  static String token = dotenv.get("Token", fallback: "");

  // Static method to perform login using username & password
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

    // Decodes the response body from UTF-8 format.
    Utf8Decoder utf8 = const Utf8Decoder();
    String res = utf8.convert(response.bodyBytes);

    // Handles the response based on the status code.
    if(response.statusCode == 200) {
      var result = json.decode(res);
      // If the response contains a successful code & data, save the token.
      if(result['code'] == 0 && result['data'] != null) {
        _saveToken(result['data']);
      }else {
        // If the response code is not successful, throw an exception.
        throw Exception(res);
      }
    }else {
      throw Exception(res);
    }
  }

  // Private method to save the auth_token method.
  static void _saveToken(String value) {
    Cache.getInstance().setString(token, value);
  }

  // Static method to get the auth_token from the cache.
  static getToken() {
    return Cache.getInstance().get<String>(token);
  }

  // Static method to remove the auth_token from the cache.
  // Navigator the LoginPage.
  static void logout() {
    Cache.getInstance().remove(token);
    NavigatorUtil.goToLogin();
  }
}