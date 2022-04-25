import 'package:firebase_auth/firebase_auth.dart';

class CommentModel {
  String? name;
  String? uId;
  String? image;
  String? dateTime;
  String? text;
  String? postId;

  CommentModel(
      {this.name, this.uId, this.image, this.dateTime, this.text, this.postId});

  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];

    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'];
    text = json['text'];
    postId = json['postId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postId': postId,
    };
  }
}
