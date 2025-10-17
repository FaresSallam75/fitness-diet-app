class CardChatModel {
  String? chatId;
  String? sender;
  String? reciever;
  String? message;
  String? file;
  String? dateTime;
  String? id;
  String? name;
  String? email;
  String? password;

  CardChatModel({
    this.chatId,
    this.sender,
    this.reciever,
    this.message,
    this.file,
    this.dateTime,
    this.id,
    this.name,
    this.email,
    this.password,
  });

  CardChatModel.fromJson(Map<String, dynamic> json) {
    chatId = json['chatId'].toString();
    sender = json['sender'].toString();
    reciever = json['reciever'].toString();
    message = json['message'];
    file = json['file'];
    dateTime = json['dateTime'];
    id = json['id'].toString();
    name = json['name'];
    email = json['email'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['chatId'] = chatId;
    data['sender'] = sender;
    data['reciever'] = reciever;
    data['message'] = message;
    data['file'] = file;
    data['dateTime'] = dateTime;
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    return data;
  }
}
