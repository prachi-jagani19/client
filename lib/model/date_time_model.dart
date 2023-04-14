

import 'package:client/model/chatting_info_model.dart';

class DateTimeModel {
  DateTime date;
  List<ChattingInfo> listOfChat;
  DateTimeModel({required this.date, required this.listOfChat});
  @override
  String toString() {
    // TODO: implement toString
    return this.listOfChat.toString();
  }
}
