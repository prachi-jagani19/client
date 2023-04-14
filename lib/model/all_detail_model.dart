import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AllDetail {
  String name;
  String phoneNumber;
  String email;
  String imageUrl;
  String id;
  bool inx;
  String fcmToken;

  AllDetail({
    required this.id,
    this.inx = false,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.phoneNumber,
    required this.fcmToken,
  });

  @override
  bool operator ==(Object other) {
    return other is AllDetail && other.phoneNumber == phoneNumber;
  }

  factory AllDetail.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    // print("code:::::11 ${data?['fcmToken']}");
    return AllDetail(
        id: data?['Uid'],
        fcmToken: data?['fcmToken'],
        name: data?['Name'],
        phoneNumber: data?['Phone'],
        email: data?['Email'],
        imageUrl: data?['ProfileImage']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "Name": name,
      if (phoneNumber != null) "Phone": phoneNumber,
      if (email != null) "Email": email,
      // if (imageUrl != null) "imageUrl": imageUrl,
      if (id != null) "Uid": id,
      if (fcmToken != null) "fcmToken": fcmToken,
    };
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'phoneNumber': phoneNumber,
        'email': email,
        'imageUrl': imageUrl,
        'id': id,
        'fcmToken': fcmToken
      };
  static AllDetail fromJson(Map<String, dynamic> json) => AllDetail(
      id: json['Uid'],
      fcmToken: json['fcmToken'],
      name: json['Name'],
      email: json['Email'],
      imageUrl: json['imageUrl'],
      phoneNumber: json['Phone']);

  @override
  // TODO: implement hashCode
  int get hashCode => phoneNumber.hashCode;
}
