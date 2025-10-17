class ChatModel {
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
  String? phone;
  String? gender;
  String? age;
  String? twon;
  String? image;
  String? emailCreate;
  String? userId;
  String? userName;
  String? userEmail;
  String? userPassword;

  ChatModel({
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
    this.phone,
    this.gender,
    this.age,
    this.twon,
    this.image,
    this.emailCreate,
    this.userId,
    this.userName,
    this.userEmail,
    this.userPassword,
  });

  ChatModel.fromJson(Map<String, dynamic> json) {
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
    phone = json['phone'];
    gender = json['gender'];
    age = json['age'].toString();
    twon = json['twon'];
    image = json['image'];
    emailCreate = json['emailCreate'];
    userId = json['userId'].toString();
    userName = json['userName'];
    userEmail = json['userEmail'];
    userPassword = json['userPassword'];
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
    data['phone'] = phone;
    data['gender'] = gender;
    data['age'] = age;
    data['twon'] = twon;
    data['image'] = image;
    data['emailCreate'] = emailCreate;
    data['userId'] = userId;
    data['userName'] = userName;
    data['userEmail'] = userEmail;
    data['userPassword'] = userPassword;
    return data;
  }
}
