class MessagesTemp {
  String? id;
  String? name;
  String? lastMessage;
  int? unreadCount;
  String? time;
  String? profileUrl;
  bool? isRead;

  MessagesTemp({this.id, this.name, this.lastMessage, this.unreadCount, this.time, this.profileUrl, this.isRead});

  MessagesTemp.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    lastMessage = json['lastMessage'];
    unreadCount = json['unreadCount'];
    time = json['time'];
    profileUrl = json['profileUrl'];
    isRead = json['isRead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['lastMessage'] = lastMessage;
    data['unreadCount'] = unreadCount;
    data['time'] = time;
    data['profileUrl'] = profileUrl;
    data['isRead'] = isRead;
    return data;
  }
}
