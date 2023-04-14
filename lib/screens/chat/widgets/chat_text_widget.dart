import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:swipe_to/swipe_to.dart';
import '../../../model/chatting_info_model.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/const/function.dart';

class ChatTextWidget extends StatefulWidget {
  ChatTextWidget({super.key, required this.receiverId, required this.isRead, required this.messageText, required this.sender, required this.name, required this.time, required this.index, required this.listOfChat});
  String sender;
  String messageText;
  int time;
  bool isRead;
  int index;
  String receiverId;
  List<ChattingInfo> listOfChat;
  String name;
  @override
  State<ChatTextWidget> createState() => _ChatTextWidgetState();
}

class _ChatTextWidgetState extends State<ChatTextWidget> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool isLongpress = false;
  // List<int> indexList = [];
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: () {
        if (currentUser!.uid == widget.sender) {
          isLongpress = true;
          setState(() {});
          showDialog(
              context: context,
              builder: (ct) {
                return AlertDialog(
                  contentPadding: EdgeInsets.all(10),
                  content: Container(
                    height: 180,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(child: Text('Delete message from ${widget.name}')),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                            onPressed: () {
                              Navigator.pop(ct);
                            },
                            child: Text('Cancel')),
                        MaterialButton(
                            onPressed: () async {
                              // print(widget.index);
                              Navigator.pop(ct);
                              final d1 = await FirebaseFirestore.instance.collection('conversation').doc("${currentUser!.uid}_${widget.receiverId}").get();
                              if (d1.exists) {
                                await FirebaseFirestore.instance.collection('conversation').doc("${currentUser!.uid}_${widget.receiverId}").collection('conversation').doc(widget.listOfChat[widget.index].id).delete();
                              } else {
                                await FirebaseFirestore.instance.collection('conversation').doc("${widget.receiverId}_${currentUser!.uid}").collection('conversation').doc(widget.listOfChat[widget.index].id).delete();
                              }
                              isLongpress = false;
                              setState(() {});
                              // log(message)
                            },
                            child: Text('delete for everyone')),
                        MaterialButton(
                            onPressed: () async {
                              // print(widget.index);
                              Navigator.pop(ct);
                              final d1 = await FirebaseFirestore.instance.collection('conversation').doc("${currentUser!.uid}_${widget.receiverId}").get();
                              if (d1.exists) {
                                await FirebaseFirestore.instance.collection('conversation').doc("${currentUser!.uid}_${widget.receiverId}").collection('conversation').doc(widget.listOfChat[widget.index].id).update({
                                  'deleteVisivility': [
                                    widget.receiverId
                                  ]
                                });
                              } else {
                                await FirebaseFirestore.instance.collection('conversation').doc("${widget.receiverId}_${currentUser!.uid}").collection('conversation').doc(widget.listOfChat[widget.index].id).update({
                                  'deleteVisivility': [
                                    widget.receiverId
                                  ]
                                });
                              }
                              // isLongpress = false;
                              // setState(() {});
                              // // log(message)
                            },
                            child: Text('delete for me'))
                      ],
                    ),
                  ),
                );
              });
        } else {
          isLongpress = true;
          setState(() {});
          showDialog(
              context: context,
              builder: (ct) {
                return AlertDialog(
                  contentPadding: EdgeInsets.all(10),
                  content: Container(
                    height: 130,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Center(child: Text('Delete message from ${widget.name}')),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                            onPressed: () {
                              Navigator.pop(ct);
                            },
                            child: Text('Cancel')),
                        MaterialButton(
                            onPressed: () async {
                              // print(widget.index);
                              Navigator.pop(ct);
                              final d1 = await FirebaseFirestore.instance.collection('conversation').doc("${currentUser!.uid}_${widget.receiverId}").get();
                              if (d1.exists) {
                                await FirebaseFirestore.instance.collection('conversation').doc("${currentUser!.uid}_${widget.receiverId}").collection('conversation').doc(widget.listOfChat[widget.index].id).update({
                                  'deleteVisivility': [
                                    widget.receiverId
                                  ]
                                });
                              } else {
                                await FirebaseFirestore.instance.collection('conversation').doc("${widget.receiverId}_${currentUser!.uid}").collection('conversation').doc(widget.listOfChat[widget.index].id).update({
                                  'deleteVisivility': [
                                    widget.receiverId
                                  ]
                                });
                              }
                              // isLongpress = false;
                              // setState(() {});
                              // // log(message)
                            },
                            child: Text('delete for me'))
                      ],
                    ),
                  ),
                );
              });
        }
        // indexList.add(widget.index);
        // print(widget.index);

        // log('on long pressed');
      },
      onTap: () {
        if (currentUser!.uid == widget.sender) {
          isLongpress = false;
          // indexList.remove(widget.index);
          setState(() {});
        } else {
          isLongpress = false;
          // indexList.remove(widget.index);
          setState(() {});
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 5),
        color: isLongpress ? Colors.blue.withOpacity(0.5) : null,
        child: Align(
          alignment: currentUser!.uid == widget.sender ? Alignment.topRight : Alignment.topLeft,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorUtils.primaryColor.withOpacity(0.9),
            ),
            padding: const EdgeInsets.all(0),
            child: Stack(children: [
              Padding(
                padding: EdgeInsets.only(left: 10, right: currentUser!.uid == widget.sender ? 70 : 55, top: 5, bottom: 10),
                child: Text(
                  widget.messageText,
                  style: const TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
              Positioned(
                bottom: 4,
                right: 5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatDate(widget.time),
                      style: const TextStyle(fontSize: 9, color: Colors.white),
                    ),
                    widget.sender == currentUser!.uid
                        ? widget.isRead
                            ? const Icon(
                                Icons.done_all,
                                color: Colors.blue,
                                size: 14,
                              )
                            : const Icon(
                                Icons.done_all,
                                size: 14,
                                color: Colors.white,
                              )
                        : Container()
                  ],
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
