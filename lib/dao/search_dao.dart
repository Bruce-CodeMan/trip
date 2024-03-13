import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:trip/models/search_model.dart';
import 'package:trip/utils/navigator_util.dart';

import '../utils/cache_util.dart';

class SearchDao{

  static String searchApi = dotenv.get("SEARCH_API", fallback: "");
  static String authToken = dotenv.get("AUTH_TOKEN", fallback: "");
  static String token = dotenv.get("Token", fallback: "");

  static Future<SearchModel?> fetch(String text) async {
    var uri = Uri.parse('$searchApi?q=$text');
    final response = await http.get(
      uri,
      headers: {
        "auth-token": authToken,
        "course-flag": "ft",
        "boarding-pass": getToken() ?? ""
      }
    );

    /// Decodes the response body from the UTF-8 format
    Utf8Decoder utf8 = const Utf8Decoder();
    String res = utf8.convert(response.bodyBytes);


    if(response.statusCode == 200) {
      var result = json.decode(res);
      SearchModel model = SearchModel.deserialization(result);
      model.keyword = text;
      return model;
    }else {
      if(response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      }
      throw Exception(res);
    }
  }

  // Static method to get the auth_token from the cache.
  static getToken() {
    return Cache.getInstance().get<String>(token);
  }
}