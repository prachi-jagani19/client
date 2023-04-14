import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../model/all_detail_model.dart';
import '../../../model/chatting_info_model.dart';

class GroupCollection {
  // static Future<void> createAllDetail({required String groupName, required String groupImg, required List<String> groupMember}) async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;

  //   final docCreateAllDetail = FirebaseFirestore.instance.collection('group').doc();
  //   // log("id ddd ${docCreateAllDetail.id}");
  //   GroupDetail detail = GroupDetail(
  //       adminId: currentUser!.uid,
  //       groupname: groupName,
  //       groupImageUrl: groupImg,
  //       groupMember: [
  //         ...groupMember,
  //         currentUser.uid
  //       ],
  //       id: docCreateAllDetail.id);
  //   final json = detail.toJson();
  //   await docCreateAllDetail.set(json);
  // }

  // static void writeCollection({required List<String> groupMember,required String replyPhoneNumber, required String replyId, required String msgText, required String id, required String videoUrl, required String type, required imageUrl}) async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;

  //   final doc = FirebaseFirestore.instance.collection('group').doc(id).collection('messages').doc();

  //   GroupChattingInfo groupChattingInfo = type == 'url'
  //       ? GroupChattingInfo(
  //         deleteVisivility:groupMember ,
  //           replyId: replyId,
  //           replyPhoneNumber: replyPhoneNumber,
  //           phoneNumber: currentUser != null ? currentUser.phoneNumber! : '',
  //           sender: currentUser != null ? currentUser.uid : '',
  //           messageText: msgText,
  //           id: doc.id,
  //           type: type,
  //           imageUrl: imageUrl,
  //         )
  //       : type == 'video'
  //           ? GroupChattingInfo(
  //             deleteVisivility: groupMember,
  //               phoneNumber: currentUser != null ? currentUser.phoneNumber! : '',
  //               sender: currentUser != null ? currentUser.uid : '',
  //               messageText: msgText,
  //               id: doc.id,
  //               type: type,
  //               imageUrl: imageUrl,
  //               videoUrl: videoUrl,
  //               replyId: replyId,
  //               replyPhoneNumber: replyPhoneNumber,
  //             )
  //           : GroupChattingInfo(
  //             deleteVisivility: groupMember,
  //               replyId: replyId,
  //               replyPhoneNumber: replyPhoneNumber,
  //               phoneNumber: currentUser != null ? currentUser.phoneNumber! : '',
  //               sender: currentUser != null ? currentUser.uid : '',
  //               messageText: msgText,
  //               id: doc.id,
  //               type: type,
  //             );
  //   Map<String, dynamic> json = groupChattingInfo.toJson();
  //   await doc.set(json);
  // }

  // static Stream<List<GroupChattingInfo>> fetchChatGroupCurrent(String id) {
  //   Stream<QuerySnapshot<Map<String, dynamic>>> refeee = FirebaseFirestore.instance.collection("group").doc(id).collection('messages').orderBy('time', descending: true).snapshots();

  //   Stream<List<GroupChattingInfo>> listOfGroupChattingInfo = refeee.map((event) {
  //     List<GroupChattingInfo> groupChatInfo = event.docs.map((ep) => GroupChattingInfo.fromJson(ep.data())).toList();

  //     // chatInfo.sort((a, b) => a.time!.compareTo(b.time!));
  //     // log('chatInfo #####$chatInfo');
  //     return groupChatInfo;
  //   });
  //   return listOfGroupChattingInfo;
  // }

  // static Stream<GroupChattingInfo> fetchChalasttGroupCurrent(String id) {
  //   Stream<QuerySnapshot<Map<String, dynamic>>> refeee = FirebaseFirestore.instance.collection("group").doc(id).collection('messages').orderBy('time', descending: true).snapshots();

  //   Stream<GroupChattingInfo> listOfGroupChattingInfo = refeee.map((event) {
  //     GroupChattingInfo groupChatInfo = event.docs.map((ep) => GroupChattingInfo.fromJson(ep.data())).toList().reversed.last;

  //     // chatInfo.sort((a, b) => a.time!.compareTo(b.time!));
  //     // log('chatInfo #####$chatInfo');
  //     return groupChatInfo;
  //   });
  //   return listOfGroupChattingInfo;
  // }

  // static Stream<List<GroupDetail>> fetchGroupDetail() async* {
  //   User? currentUser = FirebaseAuth.instance.currentUser;
  //   try {
  //     final ref = FirebaseFirestore.instance
  //         .collection("group")
  //         .withConverter(
  //           fromFirestore: GroupDetail.fromFirestore,
  //           toFirestore: (GroupDetail groupDetail, _) => groupDetail.toFirestore(),
  //         )
  //         .where('groupMember', arrayContains: currentUser!.uid)
  //         .snapshots();
  //     Stream<List<GroupDetail>> xx = ref.map((event) => event.docs.map((e) => e.data()).toList());
  //     // QuerySnapshot<GroupDetail> x = await ref.get();
  //     // log('lllll');

  //     // List<GroupDetail> xx = x.docs.map((e) => e.data()).toList();
  //     // log('lllll${xx.length}');
  //     yield* xx;
  //   } catch (e) {
  //     log('$e');
  //     yield [];
  //   }
  // }

  // static Future<GroupDetail> fetchDetail(String id) async {
  //   User? currentUser = FirebaseAuth.instance.currentUser;
  //   // try {
  //   final ref = FirebaseFirestore.instance.collection("group").doc(id).withConverter(
  //         fromFirestore: GroupDetail.fromFirestore,
  //         toFirestore: (GroupDetail groupDetail, _) => groupDetail.toFirestore(),
  //       );
  //   // Stream<List<GroupDetail>> xx =  ref
  //   //       .map((event) => event.docs.map((e) => e.data()).toList())
  //   //       ;
  //   DocumentSnapshot<GroupDetail> x = await ref.get();
  //   // log('lllll');

  //   GroupDetail xx = x.data()!;
  //   // log('lllll${xx.length}');
  //   return xx;
  //   // } catch (e) {
  //   //   log('$e');
  //   //   return [];
  //   // }
  // }

  // static Future<GroupDetail> fetchOneGroup(String id) async {
  //   final ref = FirebaseFirestore.instance.collection('group').doc(id).withConverter(
  //         fromFirestore: GroupDetail.fromFirestore,
  //         toFirestore: (GroupDetail groupDetail, _) => groupDetail.toFirestore(),
  //       );
  //   DocumentSnapshot<GroupDetail> x = await ref.get();
  //   return x.data()!;
  // }

  // static List<GroupDateTimeModel> covertGroupDatetimemodel(List<GroupChattingInfo> chatInfo, Function onDataChange) {
  //   List<GroupDateTimeModel> c1 = [];
  //   chatInfo.forEach((e) {
  //     //27/9/2022

  //     List<GroupDateTimeModel> c2 = c1
  //         .where((element) => element.date.day == DateTime.fromMillisecondsSinceEpoch(e.time!).day && element.date.month == DateTime.fromMillisecondsSinceEpoch(e.time!).month && element.date.year == DateTime.fromMillisecondsSinceEpoch(e.time!).year)
  //         // '${DateTime.fromMillisecondsSinceEpoch(e.time!).day}/${DateTime.fromMillisecondsSinceEpoch(e.time!).month}/${DateTime.fromMillisecondsSinceEpoch(e.time!).year}')
  //         .toList();
  //     if (c2.isEmpty) {
  //       c1.add(GroupDateTimeModel(date: DateTime.fromMillisecondsSinceEpoch(e.time!),
  //           // '${DateTime.fromMillisecondsSinceEpoch(e.time!).day}/${DateTime.fromMillisecondsSinceEpoch(e.time!).month}/${DateTime.fromMillisecondsSinceEpoch(e.time!).year}',
  //           listOfGroupChat: [
  //             e
  //           ]));
  //     } else {
  //       c1 = c1.map((ele) {
  //         // log('same ${c2.first.date} ${'${DateTime.fromMillisecondsSinceEpoch(e.time!).day}/${DateTime.fromMillisecondsSinceEpoch(e.time!).month}/${DateTime.fromMillisecondsSinceEpoch(e.time!).year}'}');
  //         if (ele.date.day == DateTime.fromMillisecondsSinceEpoch(e.time!).day && ele.date.month == DateTime.fromMillisecondsSinceEpoch(e.time!).month && ele.date.year == DateTime.fromMillisecondsSinceEpoch(e.time!).year) {
  //           // '${DateTime.fromMillisecondsSinceEpoch(e.time!).day}/${DateTime.fromMillisecondsSinceEpoch(e.time!).month}/${DateTime.fromMillisecondsSinceEpoch(e.time!).year}') {
  //           return GroupDateTimeModel(
  //               date: ele.date,
  //               listOfGroupChat: [
  //                 ...ele.listOfGroupChat.reversed,
  //                 e
  //               ].reversed.toList());
  //         }
  //         return ele;
  //       }).toList();
  //     }
  //   });
  //   onDataChange();

  //   // log('c1 is ${c1.toString()}');
  //   return c1.reversed.toList();
  // }

  // static String numberToName(String num, BuildContext contx) {
  //   String nme = '';
  //   // if (await FlutterContacts.requestPermission()) {
  //   //   List<Contact> contacts = await FlutterContacts.getContacts(
  //   //       withProperties: true, withPhoto: true);
  //   // List<QueryDocumentSnapshot<Object?>> cont1 = [];

  //   //   if (contacts != null) {
  //   //     cont1 = contacts
  //   //         .map((e) => ContactList(
  //   //             name: '${e.name.first} ${e.name.last}',
  //   //             number: e.phones.isNotEmpty
  //   //                 ? getNum1(e.phones.first.number, 4)
  //   //                 : 'empty'))
  //   //         .toList();
  //   //   }
  //   // final state = BlocProvider.of<ContactBloc>(contx).state;

  //   // if (state is ContactLoaded && state.props.length > 0) {
  //   //   print('contact');
  //   //   // print(
  //   //   //     "data:::: ${BlocProvider.of<GetDataBloc>(ctx).state.props.length}");
  //   //   cont1 = state.contactList;
  //   // } else {
  //   //   BlocProvider.of<ContactBloc>(contx).add(AddContact());
  //   // }
  //   // List<AllDetail> number =
  //   //     Provider.of<UserContactProvider>(contx, listen: false)
  //   //         .userContact
  //   //         .where((element) => element.phoneNumber.contains(num))
  //   //         .toList();
  //   List<QueryDocumentSnapshot<Object?>> number = Provider.of<UserContactProvider>(contx, listen: false).userContact.where((element) => element['Phone'].contains(num)).toList();

  //   if (number.isNotEmpty) {
  //     log('1');
  //     nme = number.first['Name'];
  //   } else {
  //     log('2');
  //     nme = num;
  //   }
  //   log('name to number $nme');
  //   return nme;
  // }

  static Future<AllDetail> fetchData(String id) async {
    final ref =
        FirebaseFirestore.instance.collection("user").doc(id).withConverter(
              fromFirestore: AllDetail.fromFirestore,
              toFirestore: (AllDetail allDetail, _) => allDetail.toFirestore(),
            );
    log('1111');
    DocumentSnapshot<AllDetail> x = await ref.get();
    return x.data() != null
        ? x.data()!
        : AllDetail(
            id: '',
            name: '',
            email: '',
            imageUrl: '',
            phoneNumber: '',
            fcmToken: '');
  }

  static String fetchOneMessage(List<ChattingInfo> listOfChat, String id) {
    List<ChattingInfo> info = listOfChat.where((e) {
      // print("hhhhh ${listOfChat.length} ${id} ${e.id}");
      return e.id == id;
    }).toList();
    return info.first.messageText;
  }

  static String fetchOneImageUrl(List<ChattingInfo> listOfChat, String id) {
    List<ChattingInfo> info = listOfChat.where((e) {
      // print("hhhhh ${listOfChat.length} ${id} ${e.id}");
      return e.id == id;
    }).toList();
    return info.first.imageUrl;
  }

  static String fetchType(List<ChattingInfo> listOfChat, String id) {
    List<ChattingInfo> info = listOfChat.where((e) {
      // print("hhhhh ${listOfChat.length} ${id} ${e.id}");
      return e.id == id;
    }).toList();
    return info.first.type;
  }

  // static String fetchGroupOneMessage(List<GroupChattingInfo> listOfGroupChat, String id) {
  //   List<GroupChattingInfo> info = listOfGroupChat.where((e) {
  //     // print("hhhhh ${listOfChat.length} ${id} ${e.id}");
  //     return e.id == id;
  //   }).toList();
  //   return info.first.messageText;
  // }

  // static String fetchGroupOneImageUrl(List<GroupChattingInfo> listOfGroupChat, String id) {
  //   List<GroupChattingInfo> info = listOfGroupChat.where((e) {
  //     // print("hhhhh ${listOfChat.length} ${id} ${e.id}");
  //     return e.id == id;
  //   }).toList();
  //   return info.first.imageUrl;
  // }

  // static String fetchGroupType(List<GroupChattingInfo> listOfGroupChat, String id) {
  //   List<GroupChattingInfo> info = listOfGroupChat.where((e) {
  //     // print("hhhhh ${listOfChat.length} ${id} ${e.id}");
  //     return e.id == id;
  //   }).toList();
  //   return info.first.type;
  // }
}
