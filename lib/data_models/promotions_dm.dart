import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class PromotionDM {
  String id,title,imageUrl,description;

  PromotionDM({this.id, this.title, this.imageUrl, this.description});

  factory PromotionDM.fromJson(Map<String, dynamic> json) {
    return PromotionDM(
      id: json['id'] as String,
      title: json['title'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
    );
  }

  @override
  String toString() {
    return 'PromotionDM{id: $id, title: $title, imageUrl: $imageUrl, description: $description}';
  }


}