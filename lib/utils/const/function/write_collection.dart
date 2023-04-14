import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../model/chatting_info_model.dart';
import '../../../model/id_model.dart';

class WriteCollection {
  static Future<void> d1WriteCollection(
      {required String replyPhoneNumber,
      required String replyId,
      required String receiverId,
      required String msgText,
      required String type,
      required String imageUrl,
      String videoUrl = ''}) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final docCreateAllDetail = FirebaseFirestore.instance
        .collection('conversation')
        .doc("${currentUser!.uid}_${receiverId}")
        .collection('conversation')
        .doc();
    final docCreateUid = FirebaseFirestore.instance
        .collection('conversation')
        .doc("${currentUser.uid}_${receiverId}");
    ChattingInfo chattingInfo = type == 'url'
        ? ChattingInfo(
            deleteVisivility: [currentUser.uid, receiverId],
            replyPhoneNumber: replyPhoneNumber,
            replyId: replyId,
            // time: FieldValue.serverTimestamp(),
            id: docCreateAllDetail.id,
            sender: currentUser != null ? currentUser.uid : '',
            receiver: receiverId,
            messageText: msgText,
            type: type,
            imageUrl: imageUrl)
        : type == 'video'
            ? ChattingInfo(
                deleteVisivility: [currentUser.uid, receiverId],
                replyPhoneNumber: replyPhoneNumber,
                replyId: replyId,
                // time: FieldValue.serverTimestamp(),
                videoUrl: videoUrl,
                id: docCreateAllDetail.id,
                sender: currentUser != null ? currentUser.uid : '',
                receiver: receiverId,
                messageText: msgText,
                type: type,
                imageUrl: imageUrl)
            : ChattingInfo(
                deleteVisivility: [currentUser.uid, receiverId],
                replyPhoneNumber: replyPhoneNumber,
                type: type,
                replyId: replyId,
                id: docCreateAllDetail.id,
                sender: currentUser != null ? currentUser.uid : '',
                receiver: receiverId,
                messageText: msgText,
              );
    Map<String, dynamic> json = chattingInfo.toJson();
    Uid uId = Uid(senderId: '${currentUser.uid}', receiverId: receiverId);
    Map<String, dynamic> uIdJson = uId.toJson();
    await docCreateUid.set(uIdJson);
    await docCreateAllDetail.set(json);
  }

  static Future<void> d2WriteCollection(
      {required String replyPhoneNumber,
      required String replyId,
      required String receiverId,
      required String msgText,
      required String type,
      required String imageUrl,
      String videoUrl = ''}) async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final docCreateAllDetail = FirebaseFirestore.instance
        .collection('conversation')
        .doc("${receiverId}_${currentUser!.uid}")
        .collection('conversation')
        .doc();

    final docCreateUid = FirebaseFirestore.instance
        .collection('conversation')
        .doc("${receiverId}_${currentUser.uid}");
    int time = DateTime.now().millisecondsSinceEpoch;
    ChattingInfo chattingInfo = type == 'url'
        ? ChattingInfo(
            deleteVisivility: [currentUser.uid, receiverId],
            replyPhoneNumber: replyPhoneNumber,
            replyId: replyId,
            id: docCreateAllDetail.id,
            sender: currentUser != null ? currentUser.uid : '',
            receiver: receiverId,
            messageText: msgText,
            type: type,
            imageUrl: imageUrl)
        : type == 'video'
            ? ChattingInfo(
                deleteVisivility: [currentUser.uid, receiverId],
                replyPhoneNumber: replyPhoneNumber,
                replyId: replyId,
                videoUrl: videoUrl,
                id: docCreateAllDetail.id,
                sender: currentUser != null ? currentUser.uid : '',
                receiver: receiverId,
                messageText: msgText,
                type: type,
                imageUrl: imageUrl)
            : ChattingInfo(
                deleteVisivility: [currentUser.uid, receiverId],
                replyPhoneNumber: replyPhoneNumber,
                replyId: replyId,
                type: type,
                id: docCreateAllDetail.id,
                sender: currentUser != null ? currentUser.uid : '',
                receiver: receiverId,
                messageText: msgText,
              );
    Map<String, dynamic> json = chattingInfo.toJson();
    Uid uId = Uid(senderId: '${currentUser.uid}', receiverId: receiverId);
    Map<String, dynamic> uIdJson = uId.toJson();
    await docCreateUid.set(uIdJson);
    await docCreateAllDetail.set(json);
  }
}
