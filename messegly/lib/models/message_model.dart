import 'package:firebase_auth/firebase_auth.dart';

class MessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  String? type;

  MessageModel(
      {this.senderId, this.receiverId, this.dateTime, this.text, this.type});

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    type = json['type'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'type': type
    };
  }
}
