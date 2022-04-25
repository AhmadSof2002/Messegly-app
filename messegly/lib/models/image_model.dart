import 'package:firebase_auth/firebase_auth.dart';

class ImageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? image;

  ImageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.image,
  });

  ImageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    image = json['image'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'image': image,
    };
  }
}
