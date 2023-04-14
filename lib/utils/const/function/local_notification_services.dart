import 'dart:convert';
import 'dart:developer';
import 'dart:math' as m;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../../../main.dart';
import '../../../screens/chat/widgets/user_contact_widget.dart';

class LocalNotificationServices {
  static Future<void> requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user granted Permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('user granted provisional Permission');
    } else {
      print('user declined or has not accepted Permission');
    }
  }

  static FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    InitializationSettings initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (x) {
        var message = jsonDecode(x.payload ?? '');
        print(
            "onMessageOpenedApp:::: onDidReceiveNotificationResponse $message $x ${x.payload}");

        if (message["click_action"] == "FLUTTER_NOTIFICATION_CLICK") {
          // Map<String, dynamic> receiverData = message.data["receiverData"];
          // print("dbdbdbdbdbdb${message.data["receiverData"][0]}");
          if (navigatorKey.currentContext != null) {
            Navigator.push(
                navigatorKey.currentState!.context,
                MaterialPageRoute(
                    builder: (context) => UserContactWidget(
                          fcmToken: message["fcmToken"],
                          imageUrl: message["imageUrl"],
                          name: message['Name'],
                          phoneNumber: message["Phone"],
                          receiverId: message["receiverId"],
                        )));
          }
        } else {
          // Map<String, dynamic> receiverData = message.data["receiverData"];
          // print("dbdbdbdbdbdb${message.data["receiverData"][0]}");
          // if (navigatorKey.currentContext != null) {
          //   Navigator.push(
          //       navigatorKey.currentState!.context,
          //       MaterialPageRoute(
          //           builder: (context) => GroupChatWidget(
          //                 adminId: message['adminId'],
          //                 name: message['name'],
          //                 groupMember: (jsonDecode(message['groupMember']) as Iterable).map((e) => e.toString()).toList(),
          //                 id: message['groupId'],
          //                 imageUrl: message['imageUrl'],
          //               )));
          // }
        }
      },
      // onDidReceiveBackgroundNotificationResponse: (x) {
      //   print("onMessageOpenedApp:::: onDidReceiveBackgroundNotificationResponse $x");
      // },
    );
  }

  static Future<String?> getFCMToken() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      String? token = await FirebaseMessaging.instance.getToken();
      log("FCM token:::: $token");
      return token;
      // if (currentUser != null) {
      //   await FirebaseFirestore.instance.collection('user').doc(currentUser.uid).update({
      //     'fcmToken': token
      //   });
      // }
    } catch (e) {
      print('store token exception ERRROR::: $e');
    }
  }

  static Future<void> display(RemoteMessage message) async {
    try {
      log('display notification $message');
      m.Random random = new m.Random();
      int id = random.nextInt(100000);
      NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails('mychannel', 'my channel',
            importance: Importance.max, priority: Priority.high),
      );
      await _flutterLocalNotificationsPlugin.show(
          id,
          message.notification!.title,
          message.notification!.body,
          notificationDetails,
          payload: jsonEncode(message.data));
    } catch (e) {
      print('ERROR::::: $e');
    }
  }

  static Future<void> sendNotification({
    String? title,
    String? message,
    String? token,
    String? receiverId,
    String? phoneNumber,
    String? name,
    String? imageUrl,
    String? fcmToken,
  }) async {
    final data = {
      'click_action': "FLUTTER_NOTIFICATION_CLICK",
      'id': '1',
      'status': 'done',
      'message': message,
      'receiverId': receiverId,
      'phoneNumber': phoneNumber,
      'imageUrl': imageUrl,
      'fcmToken': fcmToken,
      'name': name
    };
    try {
      String serverKey =
          "AAAAo1eFVts:APA91bH324koTmWLvemO9ygU6M-SU9-w_VMIUCdyMh4YIcXZLsimxe2f2d8dDlEp4VIQNGKTkJlT9yF347jPthqhCipc_4Rlrm1zv775O19NHRtcIYSb8La2VHD9TQIUXyrTa5urwYbX";
      http.Response r =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization': 'key=$serverKey',
              },
              body: jsonEncode(<String, dynamic>{
                "notification": <String, dynamic>{
                  'body': message,
                  'title': title
                },
                "priority": "high",
                "data": data,
                "to": "$token"
              }));
      if (r.statusCode == 200) {
        print('done ${r.body}');
      } else {
        print('code ${r.statusCode}');
      }
    } catch (e) {
      print('Exception $e');
    }
  }

  static Future<void> sendNotificationGroup({
    String? title,
    String? message,
    List<String>? userToken,
    String? adminId,
    String? groupId,
    List<String>? groupMember,
    String? imageUrl,
  }) async {
    final data = {
      'click_action': "FLUTTER_NOTIFICATION_GROUP",
      'id': '1',
      'status': 'done',
      'message': message,
      'adminId': adminId,
      'groupId': groupId,
      'groupMember': groupMember,
      'imageUrl': imageUrl,
      'name': title
    };
    try {
      http.Response r =
          await http.post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
              headers: <String, String>{
                'Content-Type': 'application/json',
                'Authorization':
                    'key=AAAAnPP-sGw:APA91bG6SZCGicrlUZPDPyLkq_OSTCefgqu7vFf-QnNXAsxzADCgyylgyG92zWcWnywnizHwBr61wpuT2fYJZB4DRFLw3Gfl5prd_DikrgVq8eMnkCXWHLNSSiNva7rSsa4UQzZQBqzQ',
              },
              body: jsonEncode(<String, dynamic>{
                "notification": <String, dynamic>{
                  'body': message,
                  'title': title
                },
                "priority": "high",
                "data": data,
                "registration_ids": userToken
              }));
      if (r.statusCode == 200) {
        print('done $userToken');
      } else {
        print('code s ${r.statusCode} ${r.body}');
      }
    } catch (e) {
      print('Exception $e');
    }
  }
}
