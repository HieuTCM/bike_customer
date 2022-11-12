class TokenAuthenticate {
  late final tokenType;
  late final accessToken;
  late final userId;
  late final profileUpdated;

  TokenAuthenticate(
      {this.tokenType, this.accessToken, this.userId, this.profileUpdated});

  TokenAuthenticate.fromJson(Map<String, dynamic> json) {
    tokenType = json["tokenType"];
    accessToken = json["accessToken"];
    userId = json["userId"];
    profileUpdated = json["profileUpdated"];

    Map<String, dynamic> toJSon() {
      final Map<String, dynamic> data = new Map<String, dynamic>();

      data["tokenType"] = this.tokenType;
      data["accessToken"] = this.accessToken;
      data["userId"] = this.userId;
      data["profileUpdated"] = this.accessToken;

      return data;
    }
  }
}
