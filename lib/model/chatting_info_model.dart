import 'package:cloud_firestore/cloud_firestore.dart';

class ChattingInfo {
  String messageText;
  int? time;
  String sender;
  String receiver;
  bool isRead;
  List<String> deleteVisivility;
  String type;
  String imageUrl;
  String videoUrl;
  String replyId;
  String id;
  String replyPhoneNumber;
  ChattingInfo({required this.deleteVisivility, required this.replyPhoneNumber, required this.replyId, required this.messageText, this.time, required this.id, this.isRead = false, this.imageUrl = '', this.videoUrl = '', required this.type, required this.receiver, required this.sender});
  factory ChattingInfo.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return ChattingInfo(
      deleteVisivility: (data?['deleteVisivility'] as Iterable).map((e) => e.toString()).toList(),
      sender: data?['sender'],
      id: data?['id'],
      replyId: data?['replyId'],
      replyPhoneNumber: data?['replyPhoneNumber'],
      isRead: data?['isRead'],
      imageUrl: data?['imageUrl'],
      videoUrl: data?['videoUrl'],
      type: data?['type'],
      receiver: data?['receiver'],
      messageText: data?['messageText'],
      time: data?['time'],
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (messageText != null) "messageText": messageText,
      if (time != null) "time": time,
      if (sender != null) "sender": sender,
      if (isRead != null) "isRead": isRead,
      if (deleteVisivility != null) "deleteVisivility": deleteVisivility,
      if (id != null) "id": id,
      if (replyId != null) "replyId": replyId,
      if (type != null) "type": type,
      if (imageUrl != null) "imageUrl": imageUrl,
      if (videoUrl != null) "videoUrl": videoUrl,
      if (receiver != null) "receiver": receiver,
      if (replyPhoneNumber != null) 'replyPhoneNumber': replyPhoneNumber
    };
  }

  Map<String, dynamic> toJson() => {
        'sender': sender,
        'receiver': receiver,
        'messageText': messageText,
        'id': id,
        'isRead': isRead,
        'deleteVisivility': deleteVisivility,
        'imageUrl': imageUrl,
        'videoUrl': videoUrl,
        'replyId': replyId,
        'replyPhoneNumber': replyPhoneNumber,
        'type': type,
        'time': FieldValue.serverTimestamp(),
      };
  static ChattingInfo fromJson(Map<String, dynamic> json) {
    print("----------------------$json fff ${FieldValue.serverTimestamp()} ${(json['time'] as Timestamp)}");
    return ChattingInfo(deleteVisivility: (json['deleteVisivility'] as Iterable).map((e) => e.toString()).toList(), replyPhoneNumber: json['replyPhoneNumber'], replyId: json['replyId'], sender: json['sender'], receiver: json['receiver'], videoUrl: json['videoUrl'], id: json['id'], isRead: json['isRead'], imageUrl: json['imageUrl'], type: json['type'], messageText: json['messageText'], time: (json['time']) != null ? (json['time'] as Timestamp).toDate().millisecondsSinceEpoch : DateTime.now().millisecondsSinceEpoch);
  }

  @override
  String toString() {
    // TODO: implement toString
    return this.toJson().toString();
  }
}
