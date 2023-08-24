class MessageModel {
  String? date;
  String? receiverUserUrl;
  String? senderUserUrl;
  String? message;

  MessageModel({
    this.date,
    this.receiverUserUrl,
    this.senderUserUrl,
    this.message,
  });

  MessageModel.fromjson(Map<String, dynamic> json) {
    this.date = json['date'];
    this.receiverUserUrl = json['receiver_user'];
    this.senderUserUrl = json['sender_user'];
    this.message = json['message'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': this.date,
      "receiver_user": this.receiverUserUrl,
      'sender_user': this.senderUserUrl,
      'message': this.message,
    };
  }
}
