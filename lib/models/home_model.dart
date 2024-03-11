class HomeModel{
  Config? config;
  List<CommonModel>? bannerList;
  List<CommonModel>? localNavList;
  GridNav? gridNav;
  List<CommonModel>? subNavList;
  SalesBox? salesBox;

  HomeModel({
    config,
    bannerList,
    localNavList,
    gridNav,
    subNavList,
    salesBox
  });

  HomeModel.deserialization(Map<String, dynamic> json) {
    config = json["config"] != null
        ? Config.deserialization(json["config"])
        : null;
    if(json['bannerList'] != null) {
      bannerList = <CommonModel>[];
      json['bannerList'].forEach((v){
        bannerList!.add(CommonModel.deserialization(v));
      });
    }
    if(json["localNavList"] != null) {
      localNavList = <CommonModel>[];
      json["localNavList"].forEach((v){
        localNavList!.add(CommonModel.deserialization(v));
      });
    }
    gridNav = json["gridNav"] != null
        ? GridNav.deserialization(json["gridNav"])
        : null;
    if(json["subNavList"] != null) {
      subNavList = <CommonModel>[];
      json["subNavList"].forEach((v){
        subNavList!.add(CommonModel.deserialization(v));
      });
    }
    salesBox = json["salesBox"] != null
        ? SalesBox.deserialization(json["salesBox"])
        : null;
  }

  Map<String, dynamic> serialization(){
    final Map<String, dynamic> data = <String, dynamic>{};
    if(config != null) {
      data['config'] = config!.serialization();
    }
    if(bannerList != null) {
      data['bannerList'] = bannerList!.map((v) => v.serialization()).toList();
    }
    if(localNavList != null) {
      data['localNavList'] = bannerList!.map((v) => v.serialization()).toList();
    }
    if(gridNav != null) {
      data['gridNav'] = gridNav!.serialization();
    }
    if(subNavList != null) {
      data['subNavList'] = subNavList!.map((v) => v.serialization()).toList();
    }
    if(salesBox != null) {
      data['salesBox'] = salesBox!.serialization();
    }
    return data;
  }
}

class Config {
  String? searchUrl;

  Config({searchUrl});

  Config.deserialization(Map<String, dynamic> json) {
    searchUrl = json["searchUrl"];
  }

  Map<String, dynamic> serialization() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data["searchUrl"] = searchUrl;
    return data;
  }
}

class BannerList{
  String? icon;
  String? url;

  BannerList({icon, url});

  BannerList.deserialization(Map<String, dynamic> json) {
    icon = json['icon'];
    url = json['url'];
  }

  Map<String, dynamic> serialization() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["icon"] = icon;
    data["url"] = url;
    return data;
  }
}

class GridNav{
  Hotel? hotel;
  Hotel? flight;
  Hotel? travel;

  GridNav({hotel, flight, travel});

  GridNav.deserialization(Map<String, dynamic> json) {
    hotel = json["hotel"] != null
        ? Hotel.deserialization(json["hotel"])
        : null;
    flight = json["flight"] != null
        ? Hotel.deserialization(json["flight"])
        : null;
    travel = json["travel"] != null
        ? Hotel.deserialization(json["travel"])
        : null;
  }

  Map<String, dynamic> serialization() {
    final Map<String, dynamic> data = <String, dynamic> {};
    if(hotel != null) {
      data["hotel"] = hotel!. serialization();
    }

    if(flight != null) {
      data["flight"] = flight!.serialization();
    }
    if(travel != null){
      data["travel"] = travel!.serialization();
    }
    return data;
  }
}

class Hotel{
  String? startColor;
  String? endColor;
  CommonModel? mainItem;
  CommonModel? item1;
  CommonModel? item2;
  CommonModel? item3;
  CommonModel? item4;

  Hotel({startColor, endColor, item1, item2, item3, item4});

  Hotel.deserialization(Map<String, dynamic> json) {
    startColor = json["startColor"];
    endColor = json["endColor"];
    mainItem = json["mainItem"] != null
        ? CommonModel.deserialization(json["mainItem"])
        : null;
    item1 = json["item1"] != null
        ? CommonModel.deserialization(json["item1"])
        : null;
    item2 = json["item2"] != null
        ? CommonModel.deserialization(json["item2"])
        : null;
    item3 = json["item3"] != null
        ? CommonModel.deserialization(json["item3"])
        : null;
    item4 = json["item4"] != null
        ? CommonModel.deserialization(json["item4"])
        : null;
  }

  Map<String, dynamic> serialization() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["startColor"] = startColor;
    data["endColor"] = endColor;
    if(mainItem != null) {
      data["mainItem"] = mainItem!.serialization();
    }
    if(item1 != null) {
      data["item1"] = item1!.serialization();
    }
    if(item2 != null) {
      data["item2"] = item2!.serialization();
    }
    if(item3 != null) {
      data["item3"] = item3!.serialization();
    }
    if(item4 != null) {
      data["item4"] = item4!.serialization();
    }
    return data;
  }
}

class SalesBox{
  String? icon;
  String? moreUrl;
  CommonModel? bigCard1;
  CommonModel? bigCard2;
  CommonModel? smallCard1;
  CommonModel? smallCard2;
  CommonModel? smallCard3;
  CommonModel? smallCard4;

  SalesBox({
    icon,
    moreUrl,
    bigCard1,
    bigCard2,
    smallCard1,
    smallCard2,
    smallCard3,
    smallCard4
  });

  SalesBox.deserialization(Map<String, dynamic> json) {
    icon = json["icon"];
    moreUrl = json["moreUrl"];
    bigCard1 = json["bigCard1"] != null
        ? CommonModel.deserialization(json["bigCard1"])
        : null;
    bigCard2 = json["bigCard2"] != null
        ? CommonModel.deserialization(json["bigCard2"])
        : null;
    smallCard1 = json["smallCard1"] != null
        ? CommonModel.deserialization(json["smallCard1"])
        : null;
    smallCard2 = json["smallCard2"] != null
        ? CommonModel.deserialization(json["smallCard2"])
        : null;
    smallCard3 = json["smallCard3"] != null
        ? CommonModel.deserialization(json["smallCard3"])
        : null;
    smallCard4 = json["smallCard4"] != null
        ? CommonModel.deserialization(json["smallCard4"])
        : null;
  }

  Map<String, dynamic> serialization() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data["icon"] = icon;
    data["moreUrl"] = moreUrl;
    if(bigCard1 != null) {
      data["bigCard1"] = bigCard1!.serialization();
    }
    if(bigCard2 != null) {
      data["bigCard2"] = bigCard2!.serialization();
    }
    if(smallCard1 != null) {
      data["smallCard1"] = smallCard1!.serialization();
    }
    if(smallCard2 != null) {
      data["smallCard2"] = smallCard2!.serialization();
    }
    if(smallCard3 != null) {
      data["smallCard3"] = smallCard3!.serialization();
    }
    if(smallCard4 != null) {
      data["smallCard4"] = smallCard4!.serialization();
    }
    return data;
  }
}

/// CommonClass is a class which represents a common data structure in the application
/// It holds information which can be used throughout various parts of the app
/// such as icon, title, url, statusBarColor and hideAppBar.
class CommonModel {
  String? icon;
  String? title;
  String? url;
  String? statusBarColor;
  bool? hideAppBar;

  // Constructor for the CommonModel class.
  // This can be used to create an instance of CommonModel with named parameters.
  CommonModel({icon, title, url, statusBarColor, hideAppBar});

  /// Creates an instance for the CommonModel from a JSON object.
  /// This constructor is used to deserialize a JSON object into a CommonModel instance.
  /// @param json a Map<String, dynamic> representing the JSON object.
  CommonModel.deserialization(Map<String, dynamic> json) {
    icon = json["icon"];
    title = json["title"];
    url = json["url"];
    statusBarColor = json["statusBarColor"];
    hideAppBar = json["hideAppBar"];
  }

  /// Converts a CommonModel instance into a JSON object.
  /// This method is used to serialize the CommonModel instance a JSON representation.
  /// which can be used for storing or transmitting data.
  ///
  /// @return a Map<String, dynamic> representing the JSON object.
  Map<String, dynamic> serialization() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data["icon"] = icon;
    data["title"] = title;
    data["url"] = url;
    data["statusBarColor"] = statusBarColor;
    data["hideAppBar"] = hideAppBar;
    return data;
  }
}