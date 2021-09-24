class User {
  final String userId;
  final String accountId;
  final String displayName;
  // final String? email;
  // final String? password;

  User(this.userId, this.accountId, this.displayName);

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'accountId': accountId,
        'userId': userId
      };
}
