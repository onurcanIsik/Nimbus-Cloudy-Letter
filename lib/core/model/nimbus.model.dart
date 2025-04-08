class NimbusModel {
  bool? isRead;
  String? nimTitle;
  String? nimBody;
  Map<String, double>? nimLoc;
  String? nimSenderId;
  String? nimDate;
  String? nimId;

  NimbusModel({
    this.isRead,
    this.nimTitle,
    this.nimBody,
    this.nimLoc,
    this.nimSenderId,
    this.nimDate,
    this.nimId,
  });
  NimbusModel.fromMap(Map<String, dynamic> map) {
    isRead = map['isRead'];
    nimTitle = map['nimTitle'];
    nimBody = map['nimBody'];
    nimLoc =
        map['nimLoc'] != null ? Map<String, double>.from(map['nimLoc']) : null;
    nimSenderId = map['nimSenderId'];
    nimDate = map['nimDate'];
    nimId = map['nimId'];
  }

  factory NimbusModel.fromJson(Map<String, dynamic> json) {
    return NimbusModel(
      isRead: json['isRead'],
      nimTitle: json['nimTitle'],
      nimBody: json['nimBody'],
      nimLoc:
          json['nimLoc'] != null
              ? Map<String, double>.from(json['nimLoc'])
              : null,
      nimSenderId: json['nimSenderId'],
      nimDate: json['nimDate'],
      nimId: json['nimId'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'isRead': isRead,
      'nimTitle': nimTitle,
      'nimBody': nimBody,
      'nimLoc': nimLoc,
      'nimSenderId': nimSenderId,
      'nimDate': nimDate,
      'nimId': nimId,
    };
  }
}
