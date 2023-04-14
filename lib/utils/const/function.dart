import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../model/all_detail_model.dart';
import '../../model/chatting_info_model.dart';
import '../../model/date_time_model.dart';


String getImageName1(String path) {
  int first = path.lastIndexOf('/');
  String iname = path.substring(first + 1);
  return iname;
}

String getNum1(String num, int n) {
  bool a = num.contains('+91');
  String str = a ? num.substring(n) : num.substring(0);
  String str1 = str.replaceAll(' ', '');
  String Str2 = str1.replaceAll('(', '');
  String Str3 = Str2.replaceAll(')', '');
  String Str4 = Str3.replaceAll('-', '');
  return Str4;
}

Future<void> createAllDetail(AllDetail detail) async {
  final docCreateAllDetail =
      FirebaseFirestore.instance.collection('user').doc(detail.id);
  final json = detail.toJson();
  await docCreateAllDetail.set(json);
}

// Future<List<AllDetail>> fetchAllDetail() async {
//   List<AllDetail> main = [];
//   List<AllDetail> main1 = [];

//   // List<String> cont = [];
//   List<ContactList> cont1 = [];
//   final ref = FirebaseFirestore.instance.collection("user").withConverter(
//         fromFirestore: AllDetail.fromFirestore,
//         toFirestore: (AllDetail allDetail, _) => allDetail.toFirestore(),
//       );
//   log('1111');
//   QuerySnapshot<AllDetail> x = await ref.get();
//   List<AllDetail> xx = x.docs.map((e) => e.data()).toList();
//   if (await FlutterContacts.requestPermission()) {
//     List<Contact> contacts = await FlutterContacts.getContacts(withProperties: true, withPhoto: true);

//     if (contacts != null) {
//       cont1 = contacts.map((e) => ContactList(name: '${e.name.first} ${e.name.last}', number: e.phones.isNotEmpty ? getNum1(e.phones.first.number, 4) : 'empty')).toList();
//       // cont = contacts
//       //     .map((e) =>
//       //         e.phones.isNotEmpty ? getNum1(e.phones.first.number) : 'empty')
//       //     .toList();
//       // log('cont $cont');
//       //  check=await getData(cont);}
//       //  log('check $check');
//     }
//   }

//   User? currentUser = FirebaseAuth.instance.currentUser;
//   List<AllDetail> phoneNum = xx.map((AllDetail allDetail) => AllDetail(id: allDetail.id, name: allDetail.name, email: allDetail.email, imageUrl: allDetail.imageUrl, phoneNumber: allDetail.phoneNumber, fcmToken: allDetail.fcmToken)).toList();
//   phoneNum.forEach((element) {
//     List<ContactList> contact = cont1.where((contact) => contact.number == element.phoneNumber).toList();
//     if (contact.isNotEmpty) {
//       main.add(AllDetail(id: element.id, name: contact.first.name, email: element.email, imageUrl: element.imageUrl, phoneNumber: element.phoneNumber, fcmToken: element.fcmToken));
//     }
//   });

//   log('main ${main.length}');
//   return main;
// }

Future<List<AllDetail>> fetchHomeDetail({
  required BuildContext context,
  required String companyId,
}) async {
  List<AllDetail> main = [];
  List<AllDetail> main1 = [];
  final pref = await SharedPreferences.getInstance();
  String? cid = pref.getString("companyId");
  List<AllDetail> xx = [];
  // if (Provider.of<UserContactProvider>(context, listen: false)
  //     .userContact
  //     .isNotEmpty) {
  //   xx = Provider.of<UserContactProvider>(context, listen: false).userContact;
  // } else {
  // List<String> cont = [];
  // List<ContactList> cont1 = [];
  print('fetch home detail $cid');
  final ref = FirebaseFirestore.instance
      .collection(cid ?? '')
      .doc(cid ?? '')
      .collection('user')
      .withConverter(
        fromFirestore: AllDetail.fromFirestore,
        toFirestore: (AllDetail allDetail, _) => allDetail.toFirestore(),
      );

  QuerySnapshot<AllDetail> x = await ref.get();
  xx = x.docs.map((e) => e.data()).toList();
  // Provider.of<UserContactProvider>(context, listen: false)
  //     .setUserContactData(xx);
  print("alldetail ${xx} ${xx.length}");
  // }
  // return xx;
  // return xx;
  // // if (await FlutterContacts.requestPermission()) {
  // //   List<Contact> contacts = await FlutterContacts.getContacts(
  // //       withProperties: true, withPhoto: true);

  // //   if (contacts != null) {
  // //     cont1 = contacts
  // //         .map((e) => ContactList(
  // //             name: '${e.name.first} ${e.name.last}',
  // //             number: e.phones.isNotEmpty
  // //                 ? getNum1(e.phones.first.number, 4)
  // //                 : 'empty'))
  // //         .toList();
  // //     // cont = contacts
  // //     //     .map((e) =>
  // //     //         e.phones.isNotEmpty ? getNum1(e.phones.first.number) : 'empty')
  // //     //     .toList();
  // //     // log('cont $cont');
  // //     //  check=await getData(cont);}
  // //     //  log('check $check');
  // //   }

  // // }
  // cont1 = ci1;

  // // final state = BlocProvider.of<ContactBloc>(ctx).state;

  // // if (state is ContactLoaded && state.props.length > 0) {
  // //   print('contact');
  // //   // print(
  // //   //     "data:::: ${BlocProvider.of<GetDataBloc>(ctx).state.props.length}");
  // //   cont1 = state.contactList;
  // // } else {
  // //   BlocProvider.of<ContactBloc>(ctx).add(AddContact());
  // // }
  User? currentUser = FirebaseAuth.instance.currentUser;
  // List<AllDetail> phoneNum = xx
  //     .map((AllDetail allDetail) => AllDetail(
  //         id: allDetail.id,
  //         name: allDetail.name,
  //         email: allDetail.email,
  //         imageUrl: allDetail.imageUrl,
  //         phoneNumber: allDetail.phoneNumber,
  //         fcmToken: allDetail.fcmToken))
  //     .toList();
  // // phoneNum.forEach((element) {
  // List<ContactList> contact = cont1
  //     .where((contact) => contact.number == element.phoneNumber)
  //     .toList();
  //   if (contact.isNotEmpty) {
  //     main.add(AllDetail(
  //         id: element.id,
  //         name: contact.first.name,
  //         email: element.email,
  //         imageUrl: element.imageUrl,
  //         phoneNumber: element.phoneNumber,
  //         fcmToken: element.fcmToken));
  //   }
  // });
  await Future.forEach(xx, (AllDetail element) async {
    final d1 = await FirebaseFirestore.instance
        .collection('conversation')
        .doc("${currentUser!.uid}_${element.id}")
        .get();
    final d2 = await FirebaseFirestore.instance
        .collection('conversation')
        .doc("${element.id}_${currentUser.uid}")
        .get();

    if (d1.exists) {
      main1.add(AllDetail(
          id: element.id,
          name: element.name,
          email: element.email,
          imageUrl: element.imageUrl,
          phoneNumber: element.phoneNumber,
          fcmToken: element.fcmToken));
    } else if (d2.exists) {
      main1.add(AllDetail(
          id: element.id,
          name: element.name,
          email: element.email,
          imageUrl: element.imageUrl,
          phoneNumber: element.phoneNumber,
          fcmToken: element.fcmToken));
    } else {}
  });

  log('mainiiiiii11${main1.length}');
  return main1;
}

// Future<List<Map<String, dynamic>>> fetchChatAllDetail() async {
//   User? currentUser = FirebaseAuth.instance.currentUser;

//   final ref = FirebaseFirestore.instance
//       .collection("conversation")
//       .where('senderId', isEqualTo: '${currentUser!.uid}')
//       .where('receiverId', isEqualTo: '${currentUser.uid}');
//   //     .doc(getNum1(currentUser != null ? '${currentUser.phoneNumber}' : '', 3))
//   //     .collection('messages');
//   QuerySnapshot<Map<String, dynamic>> x = await ref.get();
//   List<Map<String, dynamic>> xx = x.docs.map((e) => e.data()).toList();

//   // log('length${main.length}');
//   // log('maaaaa ${ma.length}');
//   return xx;
// }
Stream<AllDetail> fetchCurrentUserDetail() {
  User? currentUser = FirebaseAuth.instance.currentUser;
  // DocumentReference<Map<String, dynamic>> ref =
  //     FirebaseFirestore.instance.collection('user').doc(currentUser!.uid);
  Stream<DocumentSnapshot<Map<String, dynamic>>> ref = FirebaseFirestore
      .instance
      .collection('user')
      .doc(currentUser!.uid)
      .snapshots();
  // DocumentSnapshot<Map<String, dynamic>> r = await ref.get();
  Stream<AllDetail> allDetail =
      ref.map((event) => AllDetail.fromJson(event.data()!));
  // AllDetail allDetail = AllDetail.fromJson(r.data()!);
  return allDetail;
}

Future<AllDetail> fetchCurrentUserNotificationDetail() async {
  User? currentUser = FirebaseAuth.instance.currentUser;
  final pref = await SharedPreferences.getInstance();
  String? companyId = pref.getString("companyId");
  DocumentReference<Map<String, dynamic>> ref = FirebaseFirestore.instance
      .collection(companyId ?? '')
      .doc(companyId)
      .collection('user')
      .doc(currentUser?.uid);
  // Stream<DocumentSnapshot<Map<String, dynamic>>> ref = FirebaseFirestore.instance.collection('user').doc(currentUser!.uid).snapshots();
  DocumentSnapshot<Map<String, dynamic>> r = await ref.get();
  // Stream<AllDetail> allDetail = ref.map((event) => AllDetail.fromJson(event.data()!));
  AllDetail allDetail = AllDetail.fromJson(r.data()!);
  return allDetail;
}

Stream<List<ChattingInfo>> fetchChatCurrentUser(String currentUser) {
  User? currentUsr = FirebaseAuth.instance.currentUser;
  Stream<QuerySnapshot<Map<String, dynamic>>> refeee = FirebaseFirestore
      .instance
      .collection("conversation")
      .doc(currentUser)
      .collection('conversation')
      .orderBy('time', descending: true)
      .snapshots();
  log('dddffbgb');
  return refeee.map((event) {
    List<ChattingInfo> chatInfo = event.docs.map((ep) {
      return ChattingInfo.fromJson(ep.data());
    }).toList();
    log('datat ${chatInfo.length}');
    List<ChattingInfo> senderList = chatInfo
        .where((element) =>
            element.receiver == currentUsr!.uid && element.isRead == false)
        .toList();
    senderList.forEach((element) async {
      await FirebaseFirestore.instance
          .collection("conversation")
          .doc(currentUser)
          .collection('conversation')
          .doc(element.id)
          .update({'isRead': true});
    });
    log("list of chat ${chatInfo.length}");
    return chatInfo;
  });

  // refeee.map((event) {
  //   List<ChattingInfo> chatInfo =
  //       event.docs.map((ep) => ChattingInfo.fromJson(ep.data())).toList();
  //   List<ChattingInfo> senderList = chatInfo
  //       .where((element) =>
  //           element.receiver == currentUsr!.uid && element.isRead == false)
  //       .toList();
  //   senderList.forEach((element) async {
  //     await FirebaseFirestore.instance
  //         .collection("conversation")
  //         .doc(currentUser)
  //         .collection('conversation')
  //         .doc(element.id)
  //         .update({'isRead': true});
  //   });
  //   // chatInfo.sort((a, b) => a.time!.compareTo(b.time!));
  //   // log('chatInfo #####$chatInfo');
  //   yeid chatInfo;
  // });
}

Stream<ChattingInfo> fetchlastChatCurrentUser(String id) {
  // User? currentUsr = FirebaseAuth.instance.currentUser;
  // final d1 = await FirebaseFirestore.instance.collection('conversation').doc("${currentUsr!.uid}_${receiverId}").get();
  Query<Map<String, dynamic>> refeee = FirebaseFirestore.instance
      .collection("conversation")
      .doc(id)
      .collection('conversation')
      .orderBy('time', descending: true);
  Stream<QuerySnapshot<Map<String, dynamic>>> dd = refeee.snapshots();
  return dd.map((event) {
    return event.docs
        .map((ep) => ChattingInfo.fromJson(ep.data()))
        .toList()
        .reversed
        .last;
  });

  // ChattingInfo lastt = dd.docs.map((e) => ChattingInfo.fromJson(e.data())).toList().reversed.last;
  // return lastt;
  // return refeee.map((event) {
  //   List<ChattingInfo> chatInfo = event.docs.map((ep) => ChattingInfo.fromJson(ep.data())).toList();
  //   List<ChattingInfo> senderList = chatInfo.where((element) => element.receiver == currentUsr!.uid && element.isRead == false).toList();
  //   senderList.forEach((element) async {
  //     await FirebaseFirestore.instance.collection("conversation").doc(currentUser).collection('conversation').doc(element.id).update({
  //       'isRead': true
  //     });
  //   });

  //   return chatInfo;
  // });
}

List<DateTimeModel> covertDatetimemodel(
    List<ChattingInfo> chatInfo, Function onDataChange) {
  List<DateTimeModel> c1 = [];
  chatInfo.forEach((e) {
    //27/9/2022

    List<DateTimeModel> c2 = c1
        .where((element) =>
            element.date.day ==
                DateTime.fromMillisecondsSinceEpoch(e.time!).day &&
            element.date.month ==
                DateTime.fromMillisecondsSinceEpoch(e.time!).month &&
            element.date.year ==
                DateTime.fromMillisecondsSinceEpoch(e.time!).year)
        // '${DateTime.fromMillisecondsSinceEpoch(e.time!).day}/${DateTime.fromMillisecondsSinceEpoch(e.time!).month}/${DateTime.fromMillisecondsSinceEpoch(e.time!).year}')
        .toList();
    if (c2.isEmpty) {
      c1.add(DateTimeModel(
          date: DateTime.fromMillisecondsSinceEpoch(e.time!),
          // '${DateTime.fromMillisecondsSinceEpoch(e.time!).day}/${DateTime.fromMillisecondsSinceEpoch(e.time!).month}/${DateTime.fromMillisecondsSinceEpoch(e.time!).year}',
          listOfChat: [e]));
    } else {
      c1 = c1.map((ele) {
        // log('same ${c2.first.date} ${'${DateTime.fromMillisecondsSinceEpoch(e.time!).day}/${DateTime.fromMillisecondsSinceEpoch(e.time!).month}/${DateTime.fromMillisecondsSinceEpoch(e.time!).year}'}');
        if (ele.date.day == DateTime.fromMillisecondsSinceEpoch(e.time!).day &&
            ele.date.month ==
                DateTime.fromMillisecondsSinceEpoch(e.time!).month &&
            ele.date.year ==
                DateTime.fromMillisecondsSinceEpoch(e.time!).year) {
          // '${DateTime.fromMillisecondsSinceEpoch(e.time!).day}/${DateTime.fromMillisecondsSinceEpoch(e.time!).month}/${DateTime.fromMillisecondsSinceEpoch(e.time!).year}') {
          return DateTimeModel(
              date: ele.date,
              listOfChat: [...ele.listOfChat.reversed, e].reversed.toList());
        }
        return ele;
      }).toList();
    }
  });
  onDataChange();
  // log('c1 is ${c1.toString()}');
  return c1.reversed.toList();
}

// Stream<List<ChattingInfo>> fetchChatOtherUser(String phoneNum) {
//   User? currentUser = FirebaseAuth.instance.currentUser;

//   Stream<QuerySnapshot<Map<String, dynamic>>> refeee = FirebaseFirestore
//       .instance
//       .collection("allDetails")
//       .doc(phoneNum)
//       .collection('messages')
//       .doc(getNum1(currentUser != null ? '${currentUser.phoneNumber}' : '', 3))
//       .collection('messages')
//       .orderBy("time")
//       .snapshots();
//   Stream<List<ChattingInfo>> listOfChattingInfo = refeee.map((event) =>
//       event.docs.map((e) => ChattingInfo.fromJson(e.data())).toList());
//   listOfChattingInfo.first.then((value) => log('other chatting ingo ${value}'));

//   return listOfChattingInfo;
// }

// String getUid(String num) async {
//   QuerySnapshot<Map<String, dynamic>> response = await FirebaseFirestore
//       .instance
//       .collection('user')
//       .where('phoneNumber', isEqualTo: num)
//       .get();
//   List<Map<String, dynamic>> res = response.docs.map((e) => e.data()).toList();
//   print('res res ${res[0]['id']}');
//   String id = res.isNotEmpty ? res[0]['id'] : '';
//   return id;
// }
String formatDate(int milliseconds) {
  final template = DateFormat('h:mm a');
  return template.format(DateTime.fromMillisecondsSinceEpoch(milliseconds));
}
