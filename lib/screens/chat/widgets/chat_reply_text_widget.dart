import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../model/chatting_info_model.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/const/function.dart';
import '../../../utils/const/function/group_collection.dart';
import '../../widgets/cache_network_image_widget.dart';

class ChatReplyTextWidget extends StatefulWidget {
  ChatReplyTextWidget({super.key, required this.listOfChatDateDocument, required this.index, required this.name, required this.receiverId, required this.replyId, required this.replyPhoneNumber, required this.isRead, required this.messageText, required this.sender, required this.time, required this.listOfChat});
  String sender;
  String messageText;
  int time;
  bool isRead;
  String replyId;
  String receiverId;
  String name;
  String replyPhoneNumber;
  List<ChattingInfo> listOfChat;
  List<ChattingInfo> listOfChatDateDocument;

  int index;

  @override
  State<ChatReplyTextWidget> createState() => _ChatReplyTextWidgetState();
}

class _ChatReplyTextWidgetState extends State<ChatReplyTextWidget> {
  User? currentUser = FirebaseAuth.instance.currentUser;
  bool isLongpress = false;

  GlobalKey _containerKey = GlobalKey();
  GlobalKey _textKey = GlobalKey();
  Size? textSize;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => getSizeAndPosition());
  }

  getSizeAndPosition() {
    RenderBox? _cardBox = _containerKey.currentContext?.findRenderObject() as RenderBox?;
    RenderBox? _textBox = _textKey.currentContext?.findRenderObject() as RenderBox?;
    if (_cardBox == null || _textBox == null) return;
    textSize = Size(_cardBox.size.width, _textBox.size.height);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // print("::::::::::::::: $textSize");
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
                                await FirebaseFirestore.instance.collection('conversation').doc("${currentUser!.uid}_${widget.receiverId}").collection('conversation').doc(widget.listOfChatDateDocument[widget.index].id).delete();
                              } else {
                                await FirebaseFirestore.instance.collection('conversation').doc("${widget.receiverId}_${currentUser!.uid}").collection('conversation').doc(widget.listOfChatDateDocument[widget.index].id).delete();
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
                                await FirebaseFirestore.instance.collection('conversation').doc("${currentUser!.uid}_${widget.receiverId}").collection('conversation').doc(widget.listOfChatDateDocument[widget.index].id).update({
                                  'deleteVisivility': [
                                    widget.receiverId
                                  ]
                                });
                              } else {
                                await FirebaseFirestore.instance.collection('conversation').doc("${widget.receiverId}_${currentUser!.uid}").collection('conversation').doc(widget.listOfChatDateDocument[widget.index].id).update({
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
                                await FirebaseFirestore.instance.collection('conversation').doc("${currentUser!.uid}_${widget.receiverId}").collection('conversation').doc(widget.listOfChatDateDocument[widget.index].id).update({
                                  'deleteVisivility': [
                                    widget.receiverId
                                  ]
                                });
                              } else {
                                await FirebaseFirestore.instance.collection('conversation').doc("${widget.receiverId}_${currentUser!.uid}").collection('conversation').doc(widget.listOfChatDateDocument[widget.index].id).update({
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
        color: isLongpress ? ColorUtils.purple.withOpacity(0.5) : null,
        child: Align(
          alignment: currentUser!.uid == widget.sender ? Alignment.topRight : Alignment.topLeft,
          child: Container(
              key: _containerKey,
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: ColorUtils.primaryColor.withOpacity(0.9),
              ),
              padding: const EdgeInsets.all(0),
              child:
                  // LayoutBuilder(builder: (context, constraints) {
                  //   log(constraints.toString());
                  //   return
                  Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox.fromSize(
                    size: textSize,
                    child: Container(
                      key: _textKey,
                      margin: EdgeInsets.only(top: 5, left: 5, right: 5),
                      padding: EdgeInsets.all(3),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorUtils.white.withOpacity(0.15)),
                      child: GroupCollection.fetchOneMessage(widget.listOfChat, widget.replyId).isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.replyPhoneNumber == getNum1(currentUser!.phoneNumber.toString(), 3) ? 'you' : widget.name,
                                  // widget.replyPhoneNumber == getNum1(currentUser!.phoneNumber.toString(), 3) ? 'you' : GroupCollection.numberToName(widget.replyPhoneNumber, context),
                                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.5),
                                ),
                                Text(
                                  GroupCollection.fetchOneMessage(widget.listOfChat, widget.replyId),
                                  style: TextStyle(color: Colors.grey.shade300, fontSize: 13),
                                )
                              ],
                            )
                          : Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.replyPhoneNumber == getNum1(currentUser!.phoneNumber.toString(), 3) ? 'you' : widget.name,
                                      // widget.replyPhoneNumber == getNum1(currentUser!.phoneNumber.toString(), 3) ? 'you' : GroupCollection.numberToName(widget.replyPhoneNumber, context),
                                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 14.5),
                                    ),
                                    Text(
                                      GroupCollection.fetchType(widget.listOfChat, widget.replyId) == 'url' ? 'photo' : 'Video',
                                      style: TextStyle(color: Colors.grey.shade300, fontSize: 13),
                                    )
                                  ],
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
                                  child: SizedBox(
                                    height: 45,
                                    width: 45,
                                    child: CacheNetworkImageWidget(
                                      imageUrl: GroupCollection.fetchOneImageUrl(widget.listOfChat, widget.replyId),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ),
                  ),
                  Stack(children: [
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
                ],
              )
              // }),
              ),
        ),
      ),
    );
  }
}
