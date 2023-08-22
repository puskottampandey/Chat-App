class Messages {
  String? fromId;
  String? msg;
  String? read;
  String? sent;
  String? told;
  Type? type;

  Messages({this.fromId, this.msg, this.read, this.sent, this.told, this.type});

  Messages.fromJson(Map<String, dynamic> json) {
    fromId = json['fromId'];
    msg = json['msg'];
    read = json['read'];
    sent = json['sent'];
    told = json['told'];
    type = json['type'] == Type.image.name ? Type.image : Type.text;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromId'] = this.fromId;
    data['msg'] = this.msg;
    data['read'] = this.read;
    data['sent'] = this.sent;
    data['told'] = this.told;
    data['type'] = this.type?.name;
    return data;
  }
}

enum Type { text, image }
