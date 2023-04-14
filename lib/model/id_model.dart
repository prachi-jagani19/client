class Uid {
  String senderId;
  String receiverId;
  Uid({required this.senderId, required this.receiverId});
  Map<String, dynamic> toJson() =>
      {'senderId': senderId, 'receiverId': receiverId};
}
