class SearchModel{
  String? keyword;
  int? code;
  List<SearchItem>? data;

  SearchModel({code, data});

  SearchModel.deserialization(Map<String, dynamic> json) {
    code = json["code"];
    if(json["data"] != null) {
      data = <SearchItem>[];
      json["data"].forEach((v){
        data!.add(SearchItem.deserialization(v));
      });
    }
  }

  Map<String, dynamic> serialization() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data ["code"] = code;
    if(this.data != null) {
      data['data'] = this.data!.map((v) => v.serialization()).toList();
    }
    return data;
  }
}


class SearchItem{
  String? code;
  String? word;
  String? type;
  String? price;
  String? zoneName;
  String? star;
  String? districtName;
  String? url;

  SearchItem({
    code,
    word,
    type,
    price,
    zoneName,
    star,
    districtName,
    url
  });

  SearchItem.deserialization(Map<String, dynamic> json) {
    code = json["code"];
    word = json["word"];
    type = json["type"];
    price = json["price"];
    zoneName = json["zonename"];
    star = json["star"];
    districtName = json["districtname"];
    url = json["url"];
  }

  Map<String, dynamic> serialization() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data["code"] = code;
    data["word"] = word;
    data["type"] = type;
    data["price"] = price;
    data["zonename"] = zoneName;
    data["star"] = star;
    data["districtname"] = districtName;
    data["url"] = url;
    return data;
  }
}