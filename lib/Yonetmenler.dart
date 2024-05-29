class Yonetmenler{
  String yonetmen_id;
  String yonetmen_ad;

  Yonetmenler(this.yonetmen_id, this.yonetmen_ad);
  factory Yonetmenler.fromJson(String key, Map<dynamic, dynamic> json){
    return Yonetmenler(key, json["yonetmen_ad"] as String);
  }
}