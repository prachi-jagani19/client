import 'dart:developer';
import 'package:client/screens/chat/user_contact_screen.dart';
import 'package:client/screens/chat/widgets/user_contact_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/all_detail_model.dart';
import '../../model/chatting_info_model.dart';
import '../../utils/color_utils.dart';
import '../../utils/const/function.dart';
import '../widgets/cache_network_image_widget.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);
//  final String id;

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    setData();
    super.initState();
  }

  String? cid;
  String? uid;
  setData() async {
    final pref = await SharedPreferences.getInstance();
    cid = pref.getString("companyId");
    uid = pref.getString("userId");
    log("""
    
   userid       ${pref.getString("userId")};
    company id -- ${pref.getString("companyId")};
    cid --$cid
    """);
  }

  User? currentUser = FirebaseAuth.instance.currentUser;
  Future<bool> getUid(String id) async {
    final d1 = await FirebaseFirestore.instance
        .collection('conversation')
        .doc(id)
        .get();
    return d1.exists;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => UserContactScreen(companyId: cid!)));
          },
          backgroundColor: ColorUtils.primaryColor,
          child: const Icon(
            Icons.message,
            color: ColorUtils.white,
          ),
        ),
        body: FutureBuilder<List<AllDetail>>(
            future: fetchHomeDetail(companyId: cid ?? "", context: context),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<AllDetail> data = snapshot.data!;
                log('============================${snapshot.data!}');
                if (data.isEmpty) {
                  return Center(
                      child: Text(
                    'Please Add Contact First.',
                    style: TextStyle(color: ColorUtils.primaryColor),
                  ));
                } else {
                  return ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (context, index) {
                        log('code:::222 ${data[index].email}');
                        return InkWell(
                          onTap: () async {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UserContactWidget(
                                          receiverId: data[index].id,
                                          phoneNumber: data[index].phoneNumber,
                                          name: data[index].name,
                                          imageUrl: "data[index].imageUrl",
                                          fcmToken: data[index].fcmToken,
                                          // companyId: cid ?? "",
                                        )));
                          },
                          child: ListTile(
                            leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(50)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: CacheNetworkImageWidget(
                                      imageUrl: "data[index].imageUrl",
                                    ))),
                            subtitle: FutureBuilder<bool>(
                                future: getUid(
                                    '${currentUser!.uid}_${data[index].id}'),
                                builder: (context, snp) {
                                  if (snp.hasData) {
                                    return StreamBuilder<ChattingInfo>(
                                        stream: fetchlastChatCurrentUser(snp
                                                .data!
                                            ? '${currentUser!.uid}_${data[index].id}'
                                            : '${data[index].id}_${currentUser!.uid}'),
                                        builder: (context, snapsot) {
                                          if (snapsot.hasData) {
                                            return Text(
                                              snapsot.data!.messageText
                                                      .isNotEmpty
                                                  ? snapsot.data!.messageText
                                                  : snapsot.data!.type,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            );
                                          } else {
                                            return Text('');
                                          }
                                        });
                                  } else {
                                    return Text('');
                                  }
                                }),
                            title: Text(data[index].name),
                          ),
                        );
                      });
                }
              } else {
                return Shimmer.fromColors(
                    baseColor: ColorUtils.purple.withOpacity(0.2),
                    highlightColor: ColorUtils.purple.withOpacity(0.4),
                    child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(50)),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Container())),
                            subtitle: Container(
                              width: 100,
                              color: Colors.grey,
                              child: Text(''),
                            ),
                            title: Container(
                              width: 100,
                              color: Colors.grey,
                              child: Text(''),
                            ),
                          );
                        }));
              }
            }));
  }
}
