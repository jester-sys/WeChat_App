class MessageModel {
  MessageModel({
    required this.told,
    required this.msg,
    required this.read,
    required this.type,
    required this.fromId,
    required this.sent,
  });

  late final String told;
  late final String msg;
  late final String read;
  late final Type type;
  late final String fromId;
  late final String sent;

  MessageModel.fromJson(Map<String, dynamic> json)
      : told = json['told'].toString(),
        msg = json['msg'].toString(),
        read = json['read'].toString(),
        type = json['type'].toString() == Type.image.name ? Type.image : Type.text,
        fromId = json['fromId'].toString(),
        sent = json['sent'].toString();

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['told'] = told;
    _data['msg'] = msg;
    _data['read'] = read;
    _data['type'] = type.name;
    _data['fromId'] = fromId;
    _data['sent'] = sent;
    return _data;
  }
}

enum Type { text, image }
