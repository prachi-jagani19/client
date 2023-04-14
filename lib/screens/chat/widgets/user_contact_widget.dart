import 'dart:developer';
import 'dart:io';
import 'package:client/screens/chat/widgets/chat_reply_image_widget.dart';
import 'package:client/screens/chat/widgets/chat_reply_text_widget.dart';
import 'package:client/screens/chat/widgets/chat_video_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sizer/sizer.dart';
import 'package:swipe_to/swipe_to.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../model/all_detail_model.dart';
import '../../../model/chatting_info_model.dart';
import '../../../model/date_time_model.dart';
import '../../../utils/color_utils.dart';
import '../../../utils/const/function.dart';
import '../../../utils/const/function/Image_picker.dart';
import '../../../utils/const/function/get_download_url.dart';
import '../../../utils/const/function/local_notification_services.dart';
import '../../../utils/const/function/write_collection.dart';
import '../../../utils/font_style_utils.dart';
import '../../widgets/cache_network_image_widget.dart';
import 'chat_image_widget.dart';
import 'chat_reply_video_widget.dart';
import 'chat_text_widget.dart';

class UserContactWidget extends StatefulWidget {
  UserContactWidget(
      {super.key,
      required this.name,
      required this.imageUrl,
      required this.receiverId,
      required this.phoneNumber,
      required this.fcmToken});
  String name;
  String imageUrl;
  String phoneNumber;
  String receiverId;
  String fcmToken;
  // final String companyId;
  @override
  State<UserContactWidget> createState() => _UserContactWidgetState();
}

class _UserContactWidgetState extends State<UserContactWidget> {
  TextEditingController messageController = TextEditingController();
  ImagePicker imagePicker = ImagePicker();
  XFile? file;
  File? videoFile;
  bool isUploadVideo = true;
  String messagereply = '';
  String messageRepltText = '';
  String replyImageUrl = '';
  String replyPhoneNumber = '';
  bool isUploadImage = true;
  bool isRightSwipe = false;
  User? currentUser = FirebaseAuth.instance.currentUser;
  late AllDetail allDetailNotification;
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCurrentUserNotificationDetail().then((value) {
      log('Ero value Notification $value');
      allDetailNotification = value;
    });
  }

  Future<bool> getUid() async {
    final d1 = await FirebaseFirestore.instance
        .collection('conversation')
        .doc("${currentUser!.uid}_${widget.receiverId}")
        .get();
    return d1.exists;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          backgroundColor: ColorUtils.primaryColor,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              height: 30,
              width: 50,
              child: Row(
                children: [
                  const Icon(Icons.arrow_back),
                  Container(
                    height: 30,
                    width: 30,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CacheNetworkImageWidget(
                        imageUrl: widget.imageUrl,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          title: Text(
            widget.name,
            style: FontTextStyle.Proxima16Medium.copyWith(
                fontSize: 17.sp, color: ColorUtils.white),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(color: ColorUtils.white),
        ),
        // appBar: AppBar(
        //     leading: InkWell(
        //       onTap: () {
        //         Navigator.pop(context);
        //       },
        //       child: Container(
        //         height: 30,
        //         width: 50,
        //         child: Row(
        //           children: [
        //             const Icon(Icons.arrow_back),
        //             Container(
        //               height: 30,
        //               width: 30,
        //               child: ClipRRect(
        //                 borderRadius: BorderRadius.circular(50),
        //                 child: CacheNetworkImageWidget(
        //                   imageUrl: widget.imageUrl,
        //                 ),
        //               ),
        //             )
        //           ],
        //         ),
        //       ),
        //     ),
        //     title: Text(widget.name)),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: FutureBuilder<bool>(
                    future: getUid(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: StreamBuilder<List<ChattingInfo>>(
                                stream: fetchChatCurrentUser(snapshot.data!
                                    ? '${currentUser!.uid}_${widget.receiverId}'
                                    : '${widget.receiverId}_${currentUser!.uid}'),
                                builder: (context, snap) {
                                  log('datata ${snap.connectionState}');
                                  if (snap.hasData) {
                                    DateTime dateTime = DateTime.now();
                                    // log("current::::: ${snap.data}");
                                    List<DateTimeModel> dt =
                                        covertDatetimemodel(snap.data!, () {
                                      WidgetsBinding.instance
                                          .addPostFrameCallback((_) {
                                        if (scrollController.hasClients) {
                                          print("--------");
                                          final position = scrollController
                                              .position.maxScrollExtent;
                                          scrollController.jumpTo(position);
                                        }
                                      });
                                    });
                                    return GroupedListView<DateTimeModel,
                                        DateTime>(
                                      controller: scrollController,
                                      sort: false,
                                      elements: dt,
                                      groupBy: (element) => element.date,
                                      groupSeparatorBuilder: (groupByValue) =>
                                          Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(top: 5),
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 3),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: ColorUtils.purple,
                                                      spreadRadius: 0,
                                                      blurRadius: 1)
                                                ]),
                                            child: Text(
                                              '${dateTime.day}/${dateTime.month}/${dateTime.year}' ==
                                                      '${groupByValue.day}/${groupByValue.month}/${groupByValue.year}'
                                                  ? 'Today'
                                                  : '${dateTime.day - 1}/${dateTime.month}/${dateTime.year}' ==
                                                          '${groupByValue.day}/${groupByValue.month}/${groupByValue.year}'
                                                      ? 'Yesterday'
                                                      : '${groupByValue.day}/${groupByValue.month}/${groupByValue.year}',
                                              // textAlign: TextAlign.center,

                                              style: TextStyle(
                                                  color: ColorUtils.purple,
                                                  fontSize: 11.5),
                                            ),
                                          ),
                                        ],
                                      ),
                                      itemBuilder: (context,
                                              DateTimeModel element) =>
                                          ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  element.listOfChat.length,
                                              itemBuilder: (context, index) {
                                                if (element.listOfChat[index]
                                                            .type ==
                                                        'url' &&
                                                    element.listOfChat[index]
                                                        .replyId.isEmpty) {
                                                  if (element.listOfChat[index]
                                                      .deleteVisivility
                                                      .contains(
                                                          currentUser!.uid)) {
                                                    return SwipeTo(
                                                      onRightSwipe: () {
                                                        // log('hrhrhr ${getNum1(currentUser!.phoneNumber.toString(), 3)}');
                                                        if (currentUser!.uid !=
                                                            element
                                                                .listOfChat[
                                                                    index]
                                                                .sender) {
                                                          isRightSwipe = true;
                                                          messagereply = element
                                                              .listOfChat[index]
                                                              .id;
                                                          messageRepltText =
                                                              'image';
                                                          replyImageUrl =
                                                              element
                                                                  .listOfChat[
                                                                      index]
                                                                  .imageUrl;
                                                          replyPhoneNumber =
                                                              widget
                                                                  .phoneNumber;
                                                          setState(() {});
                                                        } else {
                                                          isRightSwipe = true;
                                                          messagereply = element
                                                              .listOfChat[index]
                                                              .id;
                                                          messageRepltText =
                                                              'image';
                                                          replyImageUrl =
                                                              element
                                                                  .listOfChat[
                                                                      index]
                                                                  .imageUrl;
                                                          replyPhoneNumber =
                                                              getNum1(
                                                                  currentUser!
                                                                      .phoneNumber
                                                                      .toString(),
                                                                  3);
                                                          setState(() {});
                                                        }
                                                      },
                                                      child: ChatImageWidget(
                                                        imageUrl: element
                                                            .listOfChat[index]
                                                            .imageUrl,
                                                        name: widget.name,
                                                        isRead: element
                                                            .listOfChat[index]
                                                            .isRead,
                                                        messageText: element
                                                            .listOfChat[index]
                                                            .messageText,
                                                        sender: element
                                                            .listOfChat[index]
                                                            .sender,
                                                        time: element
                                                            .listOfChat[index]
                                                            .time!,
                                                        index: index,
                                                        listOfChat:
                                                            element.listOfChat,
                                                        receiverId:
                                                            widget.receiverId,
                                                      ),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                } else if (element
                                                            .listOfChat[index]
                                                            .type ==
                                                        'video' &&
                                                    element.listOfChat[index]
                                                        .replyId.isEmpty) {
                                                  if (element.listOfChat[index]
                                                      .deleteVisivility
                                                      .contains(
                                                          currentUser!.uid)) {
                                                    return SwipeTo(
                                                      onRightSwipe: () {
                                                        // log('hrhrhr ${getNum1(currentUser!.phoneNumber.toString(), 3)}');
                                                        if (currentUser!.uid !=
                                                            element
                                                                .listOfChat[
                                                                    index]
                                                                .sender) {
                                                          isRightSwipe = true;
                                                          messagereply = element
                                                              .listOfChat[index]
                                                              .id;
                                                          messageRepltText =
                                                              'video';
                                                          replyImageUrl =
                                                              element
                                                                  .listOfChat[
                                                                      index]
                                                                  .imageUrl;
                                                          replyPhoneNumber =
                                                              widget
                                                                  .phoneNumber;
                                                          setState(() {});
                                                        } else {
                                                          isRightSwipe = true;
                                                          messagereply = element
                                                              .listOfChat[index]
                                                              .id;
                                                          messageRepltText =
                                                              'video';
                                                          replyImageUrl =
                                                              element
                                                                  .listOfChat[
                                                                      index]
                                                                  .imageUrl;
                                                          replyPhoneNumber =
                                                              getNum1(
                                                                  currentUser!
                                                                      .phoneNumber
                                                                      .toString(),
                                                                  3);
                                                          setState(() {});
                                                        }
                                                      },
                                                      child: ChatVideoWidget(
                                                        videoUrl: element
                                                            .listOfChat[index]
                                                            .videoUrl,
                                                        imageUrl: element
                                                            .listOfChat[index]
                                                            .imageUrl,
                                                        name: widget.name,
                                                        isRead: element
                                                            .listOfChat[index]
                                                            .isRead,
                                                        messageText: element
                                                            .listOfChat[index]
                                                            .messageText,
                                                        sender: element
                                                            .listOfChat[index]
                                                            .sender,
                                                        time: element
                                                            .listOfChat[index]
                                                            .time!,
                                                        index: index,
                                                        listOfChat:
                                                            element.listOfChat,
                                                        receiverId:
                                                            widget.receiverId,
                                                      ),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                } else if (element
                                                            .listOfChat[index]
                                                            .replyId !=
                                                        null &&
                                                    element.listOfChat[index]
                                                        .replyId.isNotEmpty &&
                                                    element.listOfChat[index]
                                                            .type ==
                                                        'text') {
                                                  if (element.listOfChat[index]
                                                      .deleteVisivility
                                                      .contains(
                                                          currentUser!.uid)) {
                                                    return ChatReplyTextWidget(
                                                      index: index,
                                                      name: widget.name,
                                                      receiverId:
                                                          widget.receiverId,
                                                      replyId: element
                                                          .listOfChat[index]
                                                          .replyId,
                                                      replyPhoneNumber: element
                                                          .listOfChat[index]
                                                          .replyPhoneNumber,
                                                      isRead: element
                                                          .listOfChat[index]
                                                          .isRead,
                                                      messageText: element
                                                          .listOfChat[index]
                                                          .messageText,
                                                      sender: element
                                                          .listOfChat[index]
                                                          .sender,
                                                      time: element
                                                          .listOfChat[index]
                                                          .time!,
                                                      listOfChat: snap.data!,
                                                      listOfChatDateDocument:
                                                          element.listOfChat,
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                } else if (element
                                                            .listOfChat[index]
                                                            .replyId !=
                                                        null &&
                                                    element.listOfChat[index]
                                                        .replyId.isNotEmpty &&
                                                    element.listOfChat[index]
                                                            .type ==
                                                        'url') {
                                                  if (element.listOfChat[index]
                                                      .deleteVisivility
                                                      .contains(
                                                          currentUser!.uid)) {
                                                    return ChatReplyImageWidget(
                                                      index: index,
                                                      receiverId:
                                                          widget.receiverId,
                                                      name: widget.name,
                                                      imageUrl: element
                                                          .listOfChat[index]
                                                          .imageUrl,
                                                      replyId: element
                                                          .listOfChat[index]
                                                          .replyId,
                                                      replyPhoneNumber: element
                                                          .listOfChat[index]
                                                          .replyPhoneNumber,
                                                      isRead: element
                                                          .listOfChat[index]
                                                          .isRead,
                                                      messageText: element
                                                          .listOfChat[index]
                                                          .messageText,
                                                      sender: element
                                                          .listOfChat[index]
                                                          .sender,
                                                      time: element
                                                          .listOfChat[index]
                                                          .time!,
                                                      listOfChat: snap.data!,
                                                      listOfChatDateDocument:
                                                          element.listOfChat,
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                } else if (element
                                                            .listOfChat[index]
                                                            .replyId !=
                                                        null &&
                                                    element.listOfChat[index]
                                                        .replyId.isNotEmpty &&
                                                    element.listOfChat[index]
                                                            .type ==
                                                        'video') {
                                                  if (element.listOfChat[index]
                                                      .deleteVisivility
                                                      .contains(
                                                          currentUser!.uid)) {
                                                    return ChatReplyVideoWidget(
                                                      index: index,
                                                      receiverId:
                                                          widget.receiverId,
                                                      name: widget.name,
                                                      videoUrl: element
                                                          .listOfChat[index]
                                                          .videoUrl,
                                                      imageUrl: element
                                                          .listOfChat[index]
                                                          .imageUrl,
                                                      replyId: element
                                                          .listOfChat[index]
                                                          .replyId,
                                                      replyPhoneNumber: element
                                                          .listOfChat[index]
                                                          .replyPhoneNumber,
                                                      isRead: element
                                                          .listOfChat[index]
                                                          .isRead,
                                                      messageText: element
                                                          .listOfChat[index]
                                                          .messageText,
                                                      sender: element
                                                          .listOfChat[index]
                                                          .sender,
                                                      time: element
                                                          .listOfChat[index]
                                                          .time!,
                                                      listOfChat: snap.data!,
                                                      listOfChatDateDocument:
                                                          element.listOfChat,
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                } else {
                                                  log('ddd');
                                                  if (element.listOfChat[index]
                                                      .deleteVisivility
                                                      .contains(
                                                          currentUser!.uid)) {
                                                    return SwipeTo(
                                                      onRightSwipe: () {
                                                        // log('hrhrhr ${getNum1(currentUser!.phoneNumber.toString(), 3)}');
                                                        if (currentUser!.uid !=
                                                            element
                                                                .listOfChat[
                                                                    index]
                                                                .sender) {
                                                          isRightSwipe = true;
                                                          messagereply = element
                                                              .listOfChat[index]
                                                              .id;
                                                          messageRepltText =
                                                              element
                                                                  .listOfChat[
                                                                      index]
                                                                  .messageText;
                                                          replyPhoneNumber =
                                                              widget
                                                                  .phoneNumber;
                                                          setState(() {});
                                                        } else {
                                                          isRightSwipe = true;
                                                          messagereply = element
                                                              .listOfChat[index]
                                                              .id;
                                                          messageRepltText =
                                                              element
                                                                  .listOfChat[
                                                                      index]
                                                                  .messageText;
                                                          replyPhoneNumber =
                                                              getNum1(
                                                                  currentUser!
                                                                      .phoneNumber
                                                                      .toString(),
                                                                  3);
                                                          setState(() {});
                                                        }
                                                      },
                                                      child: ChatTextWidget(
                                                        name: widget.name,
                                                        isRead: element
                                                            .listOfChat[index]
                                                            .isRead,
                                                        messageText: element
                                                            .listOfChat[index]
                                                            .messageText,
                                                        sender: element
                                                            .listOfChat[index]
                                                            .sender,
                                                        time: element
                                                            .listOfChat[index]
                                                            .time!,
                                                        index: index,
                                                        listOfChat:
                                                            element.listOfChat,
                                                        receiverId:
                                                            widget.receiverId,
                                                      ),
                                                    );
                                                  } else {
                                                    return Container();
                                                  }
                                                }
                                              }),

                                      useStickyGroupSeparators:
                                          true, // optional
                                      floatingHeader: true, // optional
                                      order: GroupedListOrder.ASC, // optional
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.green));
                                  }
                                },
                              ),
                            ),
                            Visibility(
                              visible: !isUploadVideo,
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                height: 150,
                                width: 250,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorUtils.primaryColor
                                        .withOpacity(0.9)),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                            ),
                            Visibility(
                              visible: !isUploadImage,
                              child: Container(
                                margin: EdgeInsets.only(right: 10),
                                height: 200,
                                width: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: ColorUtils.primaryColor
                                        .withOpacity(0.9)),
                                child:
                                    Center(child: CircularProgressIndicator()),
                              ),
                            )
                          ],
                        );
                      } else {
                        return const Center(
                            child: CircularProgressIndicator(
                          color: Colors.red,
                        ));
                      }
                    }),
              ),
              isRightSwipe
                  ? Container(
                      // height: 30,
                      // width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Container(
                            // height: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey),
                            padding: messageRepltText != 'image' &&
                                    messageRepltText != 'video'
                                ? EdgeInsets.all(5)
                                : EdgeInsets.only(left: 5),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        replyPhoneNumber ==
                                                getNum1(
                                                    currentUser!.phoneNumber
                                                        .toString(),
                                                    3)
                                            ? 'you'
                                            : widget.name,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15),
                                      ),
                                      Text(
                                        messageRepltText,
                                        style: TextStyle(fontSize: 13),
                                      )
                                    ],
                                  ),
                                ),
                                messageRepltText != 'image' &&
                                        messageRepltText != 'video'
                                    ? CircleAvatar(
                                        backgroundColor:
                                            Colors.white.withOpacity(0.2),
                                        radius: 8,
                                        child: InkWell(
                                            onTap: () {
                                              isRightSwipe = false;
                                              setState(() {});
                                            },
                                            child: Icon(
                                              Icons.close,
                                              size: 15,
                                            )),
                                      )
                                    : Stack(
                                        children: [
                                          Container(
                                            width: 45,
                                            height: 45,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(10),
                                                  bottomRight:
                                                      Radius.circular(10)),
                                              child: CacheNetworkImageWidget(
                                                imageUrl: replyImageUrl,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 2,
                                            right: 2,
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  Colors.white.withOpacity(0.2),
                                              radius: 8,
                                              child: InkWell(
                                                onTap: () {
                                                  isRightSwipe = false;
                                                  setState(() {});
                                                },
                                                child: Icon(
                                                  Icons.close,
                                                  size: 15,
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                              ],
                            ),
                          )),
                          SizedBox(
                            width: 60,
                          )
                        ],
                      ),
                    )
                  : Container(),
              Container(
                height: 50,
                margin: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          controller: messageController,
                          cursorColor: ColorUtils.primaryColor,
                          decoration: InputDecoration(
                              contentPadding: const EdgeInsets.only(left: 10),
                              suffixIcon: InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (ct) {
                                        return AlertDialog(
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                          content: Container(
                                            height: 200,
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    file =
                                                        await CustomImagePicker
                                                            .pickImagefromBoth(
                                                                source:
                                                                    ImageSource
                                                                        .camera);

                                                    Navigator.pop(ct);

                                                    if (file == null) return;
                                                    isUploadImage = false;
                                                    setState(() {});
                                                    String UniqueFileName =
                                                        DateTime.now()
                                                            .millisecondsSinceEpoch
                                                            .toString();
                                                    Reference referenceroot =
                                                        FirebaseStorage.instance
                                                            .ref();
                                                    Reference
                                                        referenceDirImages =
                                                        referenceroot
                                                            .child('images');
                                                    Reference
                                                        referenceImageToUpload =
                                                        referenceDirImages
                                                            .child(
                                                                UniqueFileName);
                                                    try {
                                                      await referenceImageToUpload
                                                          .putFile(
                                                              File(file!.path));
                                                      String imageUrl =
                                                          await referenceImageToUpload
                                                              .getDownloadURL();
                                                      isUploadImage = true;
                                                      if (isRightSwipe) {
                                                        isRightSwipe = false;
                                                      }
                                                      setState(() {});
                                                      User? currentUser =
                                                          FirebaseAuth.instance
                                                              .currentUser;
                                                      final d1 =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'conversation')
                                                              .doc(
                                                                  "${currentUser!.uid}_${widget.receiverId}")
                                                              .get();

                                                      if (d1.exists) {
                                                        WriteCollection
                                                            .d1WriteCollection(
                                                                replyPhoneNumber:
                                                                    replyPhoneNumber,
                                                                receiverId: widget
                                                                    .receiverId,
                                                                type: 'url',
                                                                imageUrl:
                                                                    imageUrl,
                                                                msgText: '',
                                                                replyId:
                                                                    messagereply);
                                                      } else {
                                                        WriteCollection
                                                            .d2WriteCollection(
                                                                replyPhoneNumber:
                                                                    replyPhoneNumber,
                                                                receiverId: widget
                                                                    .receiverId,
                                                                type: 'url',
                                                                imageUrl:
                                                                    imageUrl,
                                                                msgText: '',
                                                                replyId:
                                                                    messagereply);
                                                      }
                                                      messagereply = '';
                                                      setState(() {});
                                                      LocalNotificationServices
                                                          .sendNotification(
                                                        title:
                                                            allDetailNotification
                                                                .phoneNumber,
                                                        message: 'image',
                                                        token: widget.fcmToken,
                                                        receiverId:
                                                            currentUser.uid,
                                                        phoneNumber:
                                                            allDetailNotification
                                                                .phoneNumber,
                                                        name: widget.name,
                                                        imageUrl: '',
                                                        fcmToken:
                                                            allDetailNotification
                                                                .fcmToken,
                                                      );
                                                    } catch (e) {}
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Text(
                                                        'select image from camera'),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    file = await CustomImagePicker
                                                        .pickImagefromBoth(
                                                            source: ImageSource
                                                                .gallery);
                                                    // setState(() {});
                                                    Navigator.pop(ct);

                                                    if (file == null) return;
                                                    isUploadImage = false;
                                                    setState(() {});
                                                    String UniqueFileName =
                                                        DateTime.now()
                                                            .millisecondsSinceEpoch
                                                            .toString();
                                                    Reference referenceroot =
                                                        FirebaseStorage.instance
                                                            .ref();
                                                    Reference
                                                        referenceDirImages =
                                                        referenceroot
                                                            .child('images');
                                                    Reference
                                                        referenceImageToUpload =
                                                        referenceDirImages
                                                            .child(
                                                                UniqueFileName);
                                                    try {
                                                      await referenceImageToUpload
                                                          .putFile(
                                                              File(file!.path));
                                                      String imageUrl =
                                                          await referenceImageToUpload
                                                              .getDownloadURL();
                                                      isUploadImage = true;
                                                      if (isRightSwipe) {
                                                        isRightSwipe = false;
                                                      }
                                                      setState(() {});
                                                      User? currentUser =
                                                          FirebaseAuth.instance
                                                              .currentUser;
                                                      final d1 =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'conversation')
                                                              .doc(
                                                                  "${currentUser!.uid}_${widget.receiverId}")
                                                              .get();

                                                      if (d1.exists) {
                                                        WriteCollection
                                                            .d1WriteCollection(
                                                                replyPhoneNumber:
                                                                    replyPhoneNumber,
                                                                receiverId: widget
                                                                    .receiverId,
                                                                type: 'url',
                                                                imageUrl:
                                                                    imageUrl,
                                                                msgText: '',
                                                                replyId:
                                                                    messagereply);
                                                      } else {
                                                        WriteCollection
                                                            .d2WriteCollection(
                                                                replyPhoneNumber:
                                                                    replyPhoneNumber,
                                                                receiverId: widget
                                                                    .receiverId,
                                                                type: 'url',
                                                                imageUrl:
                                                                    imageUrl,
                                                                msgText: '',
                                                                replyId:
                                                                    messagereply);
                                                      }
                                                      messagereply = '';
                                                      setState(() {});
                                                      LocalNotificationServices
                                                          .sendNotification(
                                                        title:
                                                            allDetailNotification
                                                                .phoneNumber,
                                                        message: 'image',
                                                        token: widget.fcmToken,
                                                        receiverId:
                                                            currentUser.uid,
                                                        phoneNumber:
                                                            allDetailNotification
                                                                .phoneNumber,
                                                        name: widget.name,
                                                        imageUrl: '',
                                                        fcmToken:
                                                            allDetailNotification
                                                                .fcmToken,
                                                      );
                                                      // setState(() {});
                                                    } catch (e) {}
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Text(
                                                        'select image from gallary'),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    Navigator.pop(ct);
                                                    videoFile =
                                                        await CustomImagePicker
                                                            .pickVideoFromBoth(
                                                                source:
                                                                    ImageSource
                                                                        .camera);

                                                    log('vvvvvvim1 ${videoFile}');
                                                    // setState(() {});
                                                    log('vvvvvvim ${videoFile}');
                                                    if (videoFile == null)
                                                      return;
                                                    isUploadVideo = false;
                                                    if (isRightSwipe) {
                                                      isRightSwipe = false;
                                                    }
                                                    setState(() {});
                                                    String? videoUrl =
                                                        await GetDownloadUrl
                                                            .getGownloadVideoUrl(
                                                                videoFile!);
                                                    log('videoUrl $videoUrl');
                                                    if (videoUrl != null) {
                                                      final imageFileName =
                                                          await VideoThumbnail
                                                              .thumbnailFile(
                                                        video: videoUrl,
                                                        imageFormat:
                                                            ImageFormat.PNG,
                                                      );
                                                      log('unique');
                                                      String UniqueFileName =
                                                          DateTime.now()
                                                              .millisecondsSinceEpoch
                                                              .toString();
                                                      Reference referenceroot =
                                                          FirebaseStorage
                                                              .instance
                                                              .ref();
                                                      Reference
                                                          referenceDirImages =
                                                          referenceroot
                                                              .child('images');
                                                      Reference
                                                          referenceImageToUpload =
                                                          referenceDirImages
                                                              .child(
                                                                  UniqueFileName);
                                                      String? imageUrl;
                                                      log('imageFile $imageFileName');
                                                      if (imageFileName !=
                                                          null) {
                                                        try {
                                                          await referenceImageToUpload
                                                              .putFile(File(
                                                                  imageFileName));
                                                          imageUrl =
                                                              await referenceImageToUpload
                                                                  .getDownloadURL();
                                                          setState(() {
                                                            isUploadVideo =
                                                                true;
                                                          });
                                                          log('upload $isUploadVideo');
                                                        } catch (e) {
                                                          log('catch $e');
                                                        }
                                                      }

                                                      User? currentUser =
                                                          FirebaseAuth.instance
                                                              .currentUser;
                                                      final d1 =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'conversation')
                                                              .doc(
                                                                  "${currentUser!.uid}_${widget.receiverId}")
                                                              .get();

                                                      if (d1.exists) {
                                                        WriteCollection
                                                            .d1WriteCollection(
                                                                replyPhoneNumber:
                                                                    replyPhoneNumber,
                                                                receiverId: widget
                                                                    .receiverId,
                                                                replyId:
                                                                    messagereply,
                                                                type: 'video',
                                                                imageUrl:
                                                                    imageUrl ??
                                                                        '',
                                                                msgText: '',
                                                                videoUrl:
                                                                    videoUrl);
                                                      } else {
                                                        WriteCollection
                                                            .d2WriteCollection(
                                                                replyPhoneNumber:
                                                                    replyPhoneNumber,
                                                                receiverId: widget
                                                                    .receiverId,
                                                                type: 'video',
                                                                replyId:
                                                                    messagereply,
                                                                imageUrl:
                                                                    imageUrl ??
                                                                        '',
                                                                msgText: '',
                                                                videoUrl:
                                                                    videoUrl);
                                                      }
                                                      messagereply = '';
                                                      setState(() {});
                                                      LocalNotificationServices
                                                          .sendNotification(
                                                        title:
                                                            allDetailNotification
                                                                .phoneNumber,
                                                        message: 'video',
                                                        token: widget.fcmToken,
                                                        receiverId:
                                                            currentUser.uid,
                                                        phoneNumber:
                                                            allDetailNotification
                                                                .phoneNumber,
                                                        name: widget.name,
                                                        imageUrl: '',
                                                        fcmToken:
                                                            allDetailNotification
                                                                .fcmToken,
                                                      );
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Text(
                                                        'select Video from camera'),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    Navigator.pop(ct);
                                                    videoFile =
                                                        await CustomImagePicker
                                                            .pickVideoFromBoth(
                                                                source:
                                                                    ImageSource
                                                                        .gallery);
                                                    log('vvvvvv ${videoFile}');
                                                    if (videoFile == null)
                                                      return;
                                                    isUploadVideo = false;
                                                    if (isRightSwipe) {
                                                      isRightSwipe = false;
                                                    }
                                                    setState(() {});
                                                    String? videoUrl =
                                                        await GetDownloadUrl
                                                            .getGownloadVideoUrl(
                                                                videoFile!);
                                                    if (videoUrl != null) {
                                                      final imageFileName =
                                                          await VideoThumbnail
                                                              .thumbnailFile(
                                                        video: videoUrl,
                                                        // thumbnailPath: (await getTemporaryDirectory()).path,
                                                        imageFormat:
                                                            ImageFormat.PNG,
                                                        // maxHeight: 64, // specify the height of the thumbnail, let the width auto-scaled to keep the source aspect ratio
                                                        // quality: 75,
                                                      );
                                                      String UniqueFileName =
                                                          DateTime.now()
                                                              .millisecondsSinceEpoch
                                                              .toString();
                                                      Reference referenceroot =
                                                          FirebaseStorage
                                                              .instance
                                                              .ref();
                                                      Reference
                                                          referenceDirImages =
                                                          referenceroot
                                                              .child('images');
                                                      Reference
                                                          referenceImageToUpload =
                                                          referenceDirImages
                                                              .child(
                                                                  UniqueFileName);
                                                      String? imageUrl;
                                                      if (imageFileName !=
                                                          null) {
                                                        try {
                                                          await referenceImageToUpload
                                                              .putFile(File(
                                                                  imageFileName));
                                                          imageUrl =
                                                              await referenceImageToUpload
                                                                  .getDownloadURL();
                                                          isUploadVideo = true;
                                                          setState(() {});
                                                        } catch (e) {}
                                                      }
                                                      User? currentUser =
                                                          FirebaseAuth.instance
                                                              .currentUser;
                                                      final d1 =
                                                          await FirebaseFirestore
                                                              .instance
                                                              .collection(
                                                                  'conversation')
                                                              .doc(
                                                                  "${currentUser!.uid}_${widget.receiverId}")
                                                              .get();

                                                      if (d1.exists) {
                                                        WriteCollection
                                                            .d1WriteCollection(
                                                                replyPhoneNumber:
                                                                    replyPhoneNumber,
                                                                receiverId: widget
                                                                    .receiverId,
                                                                replyId:
                                                                    messagereply,
                                                                type: 'video',
                                                                imageUrl:
                                                                    imageUrl ??
                                                                        '',
                                                                msgText: '',
                                                                videoUrl:
                                                                    videoUrl);
                                                      } else {
                                                        WriteCollection
                                                            .d2WriteCollection(
                                                                replyPhoneNumber:
                                                                    replyPhoneNumber,
                                                                receiverId: widget
                                                                    .receiverId,
                                                                replyId:
                                                                    messagereply,
                                                                type: 'video',
                                                                imageUrl:
                                                                    imageUrl ??
                                                                        '',
                                                                msgText: '',
                                                                videoUrl:
                                                                    videoUrl);
                                                      }
                                                      messagereply = '';
                                                      setState(() {});
                                                      LocalNotificationServices
                                                          .sendNotification(
                                                        title:
                                                            allDetailNotification
                                                                .phoneNumber,
                                                        message: 'video',
                                                        token: widget.fcmToken,
                                                        receiverId:
                                                            currentUser.uid,
                                                        phoneNumber:
                                                            allDetailNotification
                                                                .phoneNumber,
                                                        name: widget.name,
                                                        imageUrl: '',
                                                        fcmToken:
                                                            allDetailNotification
                                                                .fcmToken,
                                                      );
                                                      // log('sudd message');
                                                    }
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    decoration: BoxDecoration(
                                                        color: Colors.blue[100],
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10)),
                                                    child: const Text(
                                                        'select Video from gallary'),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: const Icon(
                                  Icons.image,
                                  color: ColorUtils.primaryColor,
                                  size: 30,
                                ),
                              ),
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: ColorUtils.primaryColor,
                                      width: 1.5)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: ColorUtils.primaryColor,
                                      width: 1.5)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: ColorUtils.primaryColor))),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (messageController.text.isNotEmpty) {
                          User? currentUser = FirebaseAuth.instance.currentUser;
                          final d1 = await FirebaseFirestore.instance
                              .collection('conversation')
                              .doc("${currentUser!.uid}_${widget.receiverId}")
                              .get();
                          if (d1.exists) {
                            WriteCollection.d1WriteCollection(
                                type: 'text',
                                receiverId: widget.receiverId,
                                msgText: messageController.text,
                                imageUrl: '',
                                replyId: messagereply,
                                replyPhoneNumber: replyPhoneNumber);
                          } else {
                            WriteCollection.d2WriteCollection(
                                type: 'text',
                                receiverId: widget.receiverId,
                                msgText: messageController.text,
                                imageUrl: '',
                                replyId: messagereply,
                                replyPhoneNumber: replyPhoneNumber);
                          }

                          try {
                            await LocalNotificationServices.sendNotification(
                              title: allDetailNotification.name,
                              message: messageController.text,
                              token: widget.fcmToken,
                              receiverId: currentUser.uid,
                              phoneNumber: allDetailNotification.phoneNumber,
                              name: widget.name,
                              // imageUrl: allDetailNotification.imageUrl,
                              imageUrl: '',
                              fcmToken: allDetailNotification.fcmToken,
                            );
                          } catch (e) {
                            log('Eroorrr :$e');
                          }
                          log('seee');
                          if (isRightSwipe) {
                            isRightSwipe = false;
                            messagereply = '';
                            setState(() {});
                          }

                          messageController.clear();
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: ColorUtils.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Icon(
                            Icons.send_rounded,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ]));
  }
}
