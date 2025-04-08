class UserModel {
  String? userId;
  String? email;
  DateTime? createdAt;
  Map<String, double>? userLoc;
  String? lastWrite;
  String? lastRead;

  UserModel({
    this.userId,
    this.email,
    this.createdAt,
    this.userLoc,
    this.lastWrite,
    this.lastRead,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    email = json['email'];
    createdAt = DateTime.tryParse(json['createdAt'] ?? '');

    final loc = json['userLoc'];
    if (loc != null && loc is Map) {
      userLoc = Map<String, double>.from(
        loc.map(
          (key, value) => MapEntry(key.toString(), (value as num).toDouble()),
        ),
      );
    } else {
      userLoc = null;
    }
    lastWrite = json['lastWrite'];
    lastRead = json['lastRead'];
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
      'userLoc': userLoc,
      'lastWrite': lastWrite,
      'lastRead': lastRead,
    };
  }
}
