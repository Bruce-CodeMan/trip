import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:trip/models/travel_tab_model.dart';
import 'package:trip/utils/navigator_util.dart';

import '../models/travel_category_model.dart';
import '../utils/cache_util.dart';

class TravelDao {

  // Reads the environment variables and provides a default empty string if not found.
  static String travelApi = dotenv.get("TRAVEL_API", fallback: "");
  static String authToken = dotenv.get("AUTH_TOKEN", fallback: "");
  static String token = dotenv.get("Token", fallback: "");
  static String travelHostName = dotenv.get("TRAVEL_HOST_NAME", fallback: "");
  static String travelPath = dotenv.get("TRAVEL_PATH", fallback: "");

  static Future<TravelCategoryModel?> getCategory() async {
    var url = Uri.parse(travelApi);
    final response = await http.get(
      url,
      headers: {
        "auth-token": authToken,
        "course-flag": "ft",
        "boarding-pass": getToken() ?? "",
      }
    );

    // Decodes the response body from the UTF-8 format.
    Utf8Decoder utf8 = const Utf8Decoder();
    String res = utf8.convert(response.bodyBytes);

    if(response.statusCode == 200) {
      var result = json.decode(res);
      return TravelCategoryModel.fromJson(result['data']);
    }else {
      if(response.statusCode == 401) {
        NavigatorUtil.goToLogin();
        return null;
      }
      throw Exception(res);
    }
  }

  static Future<TravelTabModel?> getTravels(
      String groupChannelCode,
      int pageIndex,
      int pageSize) async{
    Map<String, String> paramsMap = {};
    paramsMap['pageIndex'] = pageIndex.toString();
    paramsMap['pageSize'] = pageSize.toString();
    paramsMap['groupChannelCode'] = groupChannelCode;

    var uri = Uri.https(travelHostName, travelPath, paramsMap);
    final response = await http.get(
      uri,
      headers: {
        "auth-token": authToken,
        "course-flag": "ft",
        "boarding-pass": getToken() ?? "",
      }
    );

    // Decodes the response body from the UTF-8 format.
    Utf8Decoder utf8 = const Utf8Decoder();
    String bodyString = utf8.convert(response.bodyBytes);

    debugPrint("bodyString: $bodyString");

    if(response.statusCode == 200) {
      var result = json.decode(bodyString);
      return TravelTabModel.fromJson(result["data"]);
    }else {
      if(response.statusCode == 401){
        NavigatorUtil.goToLogin();
        return null;
      }
      throw Exception(bodyString);
    }

  }

  // Static method to get the auth_token from the cache.
  static getToken() {
    return Cache.getInstance().get<String>(token);
  }
}