class UserModel {
  int? id;
  String? fullname;
  String? email;
  String? phone;
  String? loginOTP;
  String? loginOTPExp;
  String? lastLogin;
  String? profileImage;
  String? profileBanner;
  String? active;

  UserModel(
      {this.id,
      this.fullname,
      this.email,
      this.phone,
      this.loginOTP,
      this.loginOTPExp,
      this.lastLogin,
      this.profileImage,
      this.profileBanner,
      this.active});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullname = json['fullname'];
    email = json['email'];
    phone = json['phone'];
    loginOTP = json['loginOTP'];
    loginOTPExp = json['loginOTPExp'];
    lastLogin = json['lastLogin'];
    profileImage = json['profileImage'];
    profileBanner = json['profileBanner'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullname'] = fullname;
    data['email'] = email;
    data['phone'] = phone;
    data['loginOTP'] = loginOTP;
    data['loginOTPExp'] = loginOTPExp;
    data['lastLogin'] = lastLogin;
    data['profileImage'] = profileImage;
    data['profileBanner'] = profileBanner;
    data['active'] = active;
    return data;
  }
}
